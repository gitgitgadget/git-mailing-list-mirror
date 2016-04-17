From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Mon, 18 Apr 2016 02:00:39 +0530
Message-ID: <CAOLa=ZSvCdwV9fzvEHVUbX4=sAAWsO3UK-h1b3hXVvUgqFHujQ@mail.gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
 <1460227515-28437-16-git-send-email-Karthik.188@gmail.com> <CAGZ79kYUGue5r773BMjPALSAN0U2MRnq8kpDpfn_o9npfBDxLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 22:31:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1artLv-0003CL-K1
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 22:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbcDQUbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 16:31:11 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33695 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcDQUbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 16:31:10 -0400
Received: by mail-qk0-f172.google.com with SMTP id n63so40235029qkf.0
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2s9EQRnjHAJuvDiqbi/1nrFpBErlpJD8Tq37Ccw/4mU=;
        b=y/jRuFLmvaFNIyIBiC/Ke/veBCxGcMhw9vlj10Zt3I+WNXK7aHBV+iDA6LI6XWXb3r
         2lmXCWeZszOfmAmuDQE4W80oizJkEVL1uQmxNgu2sU+j14xkw5eH4dzFcoXAZi9IfAgz
         jw2CvUNSMeDjsD6x71XamxjUzbZNNVKj5rUIp5J3Vz0vTxoWQqiP4/L73499d5115Vb5
         9NZBvvVYG9Y+8xZR7jMe2dNZJmBpYNJk4iRYr8nqnnFQYgO7aeDw3m6FBv17ZAOkaQ4I
         HALQt8Uvm9WKK6kj+NK06q5tfKztd1JZI/Q9kiLSBSJGWu4jnqfMAj1eFlNH6PTzW/Zi
         BNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2s9EQRnjHAJuvDiqbi/1nrFpBErlpJD8Tq37Ccw/4mU=;
        b=PLqgfT9ToaCGwlQMn7NqGXGojIT0Ud4vBxS3BDbCMwt6oovx2UXBUtju9/hYxLMcT7
         KHwMbuxG8Ow0hRXjFXgzLlkgS2g4XK0jiH57ZK2joIgqAkYAlnPYVvRZH2GRCTXYIQtX
         f5o1VtwtM+ph/y9w8YXcQ9A4SVZU75spappJcW6ukoX6hQmObCYuz/zIGAbCsm7+v246
         fzJ4To3/uGSOH0DSQgmpkVCaei1+GTJbd4f3yP5QVXp1L9+k0HckQJv6guATcJAl0leW
         QmxpKaMgmTu/xFQfoFgUet8ffkkXAG4XiAls54DSDcs8j+xal2EO8D8AXGsim3iiOw4z
         bvTg==
X-Gm-Message-State: AOPr4FWAgQnqVZBf1ZB2EjMiIS9+HTVubxRyzHnkFGzH7fNDKKYNtKxd7k/uOlsjgAVdSZAwW5fNpCKGohiS/A==
X-Received: by 10.55.72.196 with SMTP id v187mr10519801qka.97.1460925068822;
 Sun, 17 Apr 2016 13:31:08 -0700 (PDT)
Received: by 10.140.92.238 with HTTP; Sun, 17 Apr 2016 13:30:39 -0700 (PDT)
In-Reply-To: <CAGZ79kYUGue5r773BMjPALSAN0U2MRnq8kpDpfn_o9npfBDxLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291774>

On Sat, Apr 16, 2016 at 5:41 AM, Stefan Beller <sbeller@google.com> wrote:
>>  static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
>>  {
>>         int i, max = 0;
>> @@ -432,7 +281,10 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
>>
>>                 skip_prefix(it->refname, "refs/heads/", &desc);
>>                 skip_prefix(it->refname, "refs/remotes/", &desc);
>> -               w = utf8_strwidth(desc);
>> +               if (it->kind == FILTER_REFS_DETACHED_HEAD)
>> +                       w = strlen(get_head_description());
>
> get_head_description returns memory, which needs to be free'd.
> (found by catching up on reading the coverity scan log. I see
> you deleted get_head_description in another part of the patch;
> nevertheless would you like to take care of this memleak?)

Seems like an easy fix. Will take care of it, Thanks :)

-- 
Regards,
Karthik Nayak
