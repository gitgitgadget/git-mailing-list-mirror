From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/9] submodule update: expose parallelism to the user
Date: Wed, 28 Oct 2015 14:40:09 -0700
Message-ID: <CAGZ79kbm_aucoEADLFt3VjShP5Kgi0Wwyb6m1dRJtQWu9_ZtBA@mail.gmail.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
	<1445969753-418-6-git-send-email-sbeller@google.com>
	<xmqqk2q8ni2i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 22:40:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrYSA-0002vU-6L
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 22:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbbJ1VkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 17:40:11 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34125 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbJ1VkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 17:40:10 -0400
Received: by ykdr3 with SMTP id r3so22979294ykd.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HaJvV5wTV9IVncHYFDlZoZCweZ7nlecee4Til8cB8cI=;
        b=kQc/C+MIuN5FWwLLGBGWd4uwfH9kxYEunNHq4qTsAo3JG+rSlSSAQbGwqZcBVz2nJJ
         IkZj41eMnHUqAbKu8qdKzrMPPYRdar7FfdOpYmwuwUuxCIKvmZuYezjSQMEa9Qn92C2d
         ix2WeVD8EphYT2apzNVi5nA94ki7JXTY/yaHbLxghgvLCer7fJ8Dd+iB7U+k2pFsa9AL
         debm1OH5PlBUKZ9IQkTqWk5gH8nWZ+ijWFGzCATs1kL3PSqvl25IebuvVOSLmAdh47Tu
         5Sugr4m+JPByGfQo1WMU0ZfvIFEAkU9eZDd0CzfYHrNfKrA8Lh2yCydE2BrH8FIrdrO9
         bnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HaJvV5wTV9IVncHYFDlZoZCweZ7nlecee4Til8cB8cI=;
        b=co1Z+jIMbCKcXxwKBIGnm7cs7gadTjYFjma9nPj1u3nrzNG+sdcgZEkDuvhxo2O+05
         2CGNhJa2nqB/Zz9XeK3qUzQLjDHZl7lDEqvZPayD4vFcdE2sN8S9iq8qhs3mtuzgY4NZ
         iE5HXRWSCOm//R22XffaluJG9pD2ZmuU0O/ipjWtsQ/KXRPQA9o3SZtrmEbHDFlPoHHW
         rfma0cTr+JYqw+nhSLaf6Zi6wz0GITWpHa+bNaR2pMDRhLNESsWVCmQ3cmaQveQ5a+GJ
         mujCu7mlHOv0l0R/0OheprWm//jBEf8iVsWXlBXRFi9NwBKYXUUrY/VHaGIgKP6q8r9Q
         KBwg==
X-Gm-Message-State: ALoCoQlaYG1NOwmZnJ/hURWxk+ToJkgoq/5Odr1SwtFa6HIye+GSigIQFS5NtJT4rTMNDtM/f+uB
X-Received: by 10.129.29.8 with SMTP id d8mr24336755ywd.63.1446068409435; Wed,
 28 Oct 2015 14:40:09 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 28 Oct 2015 14:40:09 -0700 (PDT)
In-Reply-To: <xmqqk2q8ni2i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280397>

On Tue, Oct 27, 2015 at 1:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> And when 0 starts to meaning something special, we would need to
> describe that here (and/or submodule.jobs entry in config.txt).
> As I already said, I do not think "0 means num_cpus" is a useful
> default, and I would prefer if we reserved 0 to mean something more
> useful we would figure out later.

Ok I'll add that, too.

I am just debating with myself where the best place is.
In run-command.c in pp_init we have:

    if (n < 1)
        n = online_cpus();
    pp->max_processes = n;

we would need to change only that one place to insert an

    die("We haven't found the right default yet for 0");

However I think for most loads online_cpus makes sense as that
is ususally the bottleneck for local operations (if being excessive
memory may become an issue, but unlikely IMHO).
So instead I think it makes more sense to add it in the fetch/clone/update
to come up with a treatment for 0.

Maybe we want to make the explicit decision for the default value
for any user of the parallel processing, such that this code above
is misguided as it leads to bad defaults if reviewers are inattentive.

So having spelled out that, we may just want to bark in the pp_init
for having a number n < 1.
