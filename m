From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] bisect--helper: `bisect_reset` shell function in C
Date: Wed, 8 Jun 2016 13:53:11 -0400
Message-ID: <CAPig+cQpBcy+Sdhv7EXorJFZsYvH=ikh0PqGF1YShQEcPjMn_Q@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-4-pranit.bauva@gmail.com> <CAPig+cSsMg5HznWGiUsngpHskSDMNhauvVw5jvaJTtEtJBw+ew@mail.gmail.com>
 <CAFZEwPPC3WZR4dMphgZWK7UomAXEok-J8ZXvFR22+xDrFP=hEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:13:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhfJ-0000Wf-EL
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 19:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbcFHRxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 13:53:13 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34926 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbcFHRxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 13:53:12 -0400
Received: by mail-it0-f65.google.com with SMTP id z123so2220050itg.2
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=q0IQm1Ow89J/KzsNhrdOCSHnTzsuYjn5ShvCw0dbNtg=;
        b=RyYK5VX3oji7csGF4Refeaji3Row5tQHFGanq0KxB6oaBT+zrujDEZAuFktHc895zO
         ogmVXY/SgBSGXygZiLIpbtKiJasjll2eANtgKHutnVuxCgvegakJ9s8L94gmLyFzTUqz
         wxkXNAV7BS8+2ULepdQ+DvNeZ/E9aAxZf9NKWSF1jmYP06kP0TUh8dEKwDmZv5r9JeVT
         QGG4Ukn0AouR+6eBFsWibDuF9e0uaw0+IIGB2dzZKJFaWeHlCD+KTnoplYATCZIgSKyb
         XL4kJ7+yNv5bq+xgfSkt4eXUMr69Ri1nQ8s2YzTkDfxnohd4QWrP82JlFufdloaZdW7p
         Tc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=q0IQm1Ow89J/KzsNhrdOCSHnTzsuYjn5ShvCw0dbNtg=;
        b=iU89yhxVOG+y1vDfa5PYLRmBGMMAUfbAZso19fUIbZq217uAr1BvqwzEMCi5y545Sx
         pABiwDYv6cW1NfvCsy94G7qPyG+qoKcibqHGCKd1F2gRiOSMo8McAmo2iZRPUu6VPfCu
         KBAEGoEe4/tY7pgGdneyoOq6w3OPMHu0XzR4fkgEdNGf0fFlcZ7Psu9W5fGj6wmen1s7
         ohtotm1OdPs/oUH5OO947kVAZ71EftYna6+zKOh+JyJFBYnoUGVDgc0u1NT0aBNOTUHP
         GOX1QVw/p8JssJBNws4fYbimVB25FKSNJTmtkHGvBJyhBt9h47AqK4PBAf3hpu7QNl+i
         Xi4g==
X-Gm-Message-State: ALyK8tJ77qH7FcTHIJevofALdyFCFmrN6ljgiDYCXJE5FlakDyyRxT/qHJZnigzKCx36chWC0Zi9aIDgrtJ9yw==
X-Received: by 10.36.207.137 with SMTP id y131mr15421453itf.32.1465408391851;
 Wed, 08 Jun 2016 10:53:11 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 10:53:11 -0700 (PDT)
In-Reply-To: <CAFZEwPPC3WZR4dMphgZWK7UomAXEok-J8ZXvFR22+xDrFP=hEg@mail.gmail.com>
X-Google-Sender-Auth: 2017_EAxagyPoYB5Xs2i-KcAUf4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296823>

On Wed, Jun 8, 2016 at 9:20 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, Jun 8, 2016 at 1:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> +       if (!file_exists(git_path_bisect_head())) {
>>> +               struct argv_array argv = ARGV_ARRAY_INIT;
>>> +               argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
>>> +               status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
>>> +               argv_array_clear(&argv);
>>> +       }
>>> +
>>> +       if (status) {
>>
>> What's the purpose of having this 'status' conditional outside of the
>> above !file_exists() conditional, which is the only place that
>> 'status' gets assigned. Likewise, 'status' itself could be declared
>> within the scope of that conditional block.
>
> I wanted to avoid nesting. In a few other parts of the code also,
> nesting is avoided as much as possible.

I figured as much, but I'm not sure that that is such a good idea in
this case since it makes the code more difficult to reason about. To
wit: as a reader of the code, I spent extra time trying to figure why
it was structured this way and if 'status' is assigned or accessed in
some other non-obvious way.
