Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0DFC433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F162A61001
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhDATTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhDATTC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 15:19:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C58C0465FE
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 11:08:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so3517262pjb.0
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ObDVJ3ViHaFI+6aoti8oMCiLLfJhIcWy67hV+HKjTJg=;
        b=f9F8/FBK+xZCP8MPQ3IvPHEf63gWYV8onVdrC3arJIMHmkC5bXSaNlWzUevLw2CS/K
         OwvCoctRr0s26KFIxwYzS8AxqvSMihnbbaNfrH1VrwgSFXSjrYQ/YCgNMTsCn/y3dS2z
         +LUTZF9jOTyzughVuvINe+aYN81p0raMYlZ8CUHq381xG1uHTNlNYupjut/ATPg1L8LT
         HIlQsY2IExdMFqcS8vRwI1s2bMNt6qK7dqHTnMqb1pFxgTde1umJgl24PpKSl+E2aWkW
         b4Jda2668X3cg4zukR+V9g1EeNfm5s7A0Ss2eWOTyBVtl+Uh0AGHGCVI+1a8TgmHQv9Q
         5QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ObDVJ3ViHaFI+6aoti8oMCiLLfJhIcWy67hV+HKjTJg=;
        b=mLJjA5nF/JuA636EwO1byHb8iNzkAvKWV80yHyX1CYMYZgbNKukLUGzolqz+3R1QSt
         mL6BV0zT72GAcomFoLXBvh1YkMFYeU/7d3wbS6+mtRMkATPyieumrR+4NUgydQzBR/+q
         LCI0SYWZdC1UL757Ia1DPWomhEXWDjSuFdm3nV/rT9eMSmkxqKwz7L9V/9boqhBSZHcC
         8qxxueGU8szVfQMvqIbV3H/e/JkxTxX7nF0hrF0h++aNy85WfDcimO2uqwKfcdNhtpdl
         lY2m1+J6CODvBbjNO6HR6Dfm5ORacXu8G5LDYqthCSKwfApKcyaXFm2/rv7F22l76TUY
         dtFw==
X-Gm-Message-State: AOAM530h8D0Ohk0HsEC59zFplRFFcOmFM6Opkpv/VI5t7QZQlQMsw0hU
        UG6O1d2Hkewy4U5O8n7xSQPPWQ==
X-Google-Smtp-Source: ABdhPJxmnP1wDB8WintI1k8SPiaHk1++9Eg3ClSW1tnjXHbAJ+BTGvLsMa9OQ4vBQHsZbUC08rMrUw==
X-Received: by 2002:a17:902:b494:b029:e7:36be:9ce7 with SMTP id y20-20020a170902b494b02900e736be9ce7mr9022030plr.43.1617300513955;
        Thu, 01 Apr 2021 11:08:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:49f0:58b5:b117:7f54])
        by smtp.gmail.com with ESMTPSA id j92sm6066646pja.29.2021.04.01.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 11:08:33 -0700 (PDT)
Date:   Thu, 1 Apr 2021 11:08:27 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v8 35/37] git-send-email: use 'git hook run' for
 'sendemail-validate'
Message-ID: <YGYMG3mArYSeMr9D@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-36-emilyshaffer@google.com>
 <87y2esg22j.fsf@evledraar.gmail.com>
 <YGTt2cNwq3BlpB7n@google.com>
 <xmqqy2e3567f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy2e3567f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 03:06:12PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > On Fri, Mar 12, 2021 at 10:21:08AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> > +	my $target = abs_path($fn);
> >> > +	return "rejected by sendemail-validate hook"
> >> > +		if system(("git", "hook", "run", "sendemail-validate", "-a",
> >> > +				$target));
> >> 
> >> I see it's just moving code around, but since we're touching this:
> >> 
> >> This conflates the hook exit code with a general failure to invoke it,
> >> Perl's system().
> >
> > Ah, at first I thought you meant "hook exit code vs. failure in 'git
> > hook run'" - but I think you are saying "system() can also exit
> > unhappily".
> >
> > I had a look in 'perldoc -f system' like you suggested and saw that in
> > addition to $? & 127, it seems like I also should check $? == -1
> > ("system() couldn't start the child process") and ($? >> 8) (the rc
> > from the child hangs out in the top byte). So then it seems like I want
> > something like so:
> >
> >   system("git", "hook", "run", "sendemail-validate",
> >           "-j1", "-a", $target);
> >
> >   return "git-send-email failed to launch hook process: $!"
> >           if ($? == -1) || ($? & 127))
> >   return "git-send-email invoked git-hook run incorrectly"
> >           if (($? >> 8) == 129);
> >   return "Rejected by 'sendemail-validate' hook"
> >           if ($? >> 8);
> >
> 
> The example in "perldoc -f system" distinguishes these two like so:
> 
>         if ($? == -1) {
>                 print "failed to execute: $!\n";
>         }
>         elsif ($? & 127) {
>                 printf "child died with signal %d, %s coredump\n",
>                     ($? & 127), ($? & 128) ? 'with' : 'without';
>         }
>         else {
>                 printf "child exited with value %d\n", $? >> 8;
>         }
> 
> > That seems really verbose, though. I guess ($? >> 8) includes -1 as well (since
> > 0xFF... will meet that conditional), but do we care about the difference between
> > "system() couldn't run my thing" and "my thing returned upset"?
> 
> If we classify the failure cases into three using the sample code in
> the doc, I think the last one is the only case that we know the
> logic in the hook is making a decision for us.  In the first case,
> the hook did not even have a chance to decide for us, and in the
> second case, the hook died with signal, most likely before it had a
> chance to make a decision.  If we want to be conservative (sending
> a message out is something you cannot easily undo), then it may make
> sense to take the first two failure cases, even though the hook may
> have said it is OK to send it out if it ran successfully, as a denial
> to be safe, I would think.

Yeah, I tend to agree. In that case I think you are saying: "Please
split the first case into two and differentiate launch failure from
signal, but otherwise continue to return all these cases as errors and
halt the email."

 - Emily
