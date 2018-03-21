Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51BD41F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeCUV4p (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:56:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52072 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753749AbeCUV4o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:56:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id v21so1200299wmc.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3B8/eB9oBhCgzp145JHi0Qpy2N2HYm2aeBAHqo5DrTc=;
        b=q8uMkm12ilQ5hEc7Q8urA/k/LltFSVDw47rT6X0Dqy3H9b9fhTkhwnEszXlrDVxIxy
         MaIA027xXwEh3wgkDbUzdkRqv/fP+qiM6AaLNqjOj7I67WpmS9wX6vJLWjP8uXOiicCP
         18CxLCvmd0Yk92/V9WLSLU3S/YxrEH40rLEhun2mu3trhwi/4xuWcfzvizkBYeL1/RSM
         3HcaRAzjdEd7p3yI3gYN8EaB0Uv874qL10lD5lCsdgT8rR5d2sq067i3Yfh7wBZM7xjJ
         nV4n2xH+R/NHGBaFuTCmKfm3Y1FY5iQz3XKO8opNVh2VBR9uZazBP7ksBMfGH2ZrLDjV
         fbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3B8/eB9oBhCgzp145JHi0Qpy2N2HYm2aeBAHqo5DrTc=;
        b=AhgItgPLJqKy4k4f2e9rmGgMeATk1iAVXWBurFJa4PMCwJDGsUtYnmHwynjoaPwSdd
         OpOw8p7YXCuVCE/WzM0EBw5SjxvQ45amVdfrZKWGA6SX6zh7s2L9NBjiQ1ioZa+EMG4Z
         oV/l4ruqYossz0ALwgWLzRrJPqh31nrgiUZGsXEIIk9IpvPQb4icimFxZeLXltKukj7G
         H2slwXW1pGuRN4AO5+gNQk6GJ7CM4kSUEDihJ1TbAmI/9wbidCQDEXJURsxLaxmq7Xes
         zyJi85ZX4D8W+1QPBowTkiIFLfnaqzkqTC01ofmeIgLdzn8dD3vgCtWHvqcFHhUMgtQh
         mM2g==
X-Gm-Message-State: AElRT7FwBsSe+UGwxKEr8RGfaZDHPd4Cc7hnFgBpv2ZsK7wD8ilxVRzI
        vYqs5b2zFs6zHgv9yIQDjb8=
X-Google-Smtp-Source: AG47ELtdqe8shMKSIwn2t1inCJ+WDQEGmirdMWmZhBrFSJpVX1VsyUhBwy+BSFCyUoZ4YERVEguX1A==
X-Received: by 10.28.37.134 with SMTP id l128mr2448442wml.10.1521669402755;
        Wed, 21 Mar 2018 14:56:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q8sm197114wrd.69.2018.03.21.14.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 14:56:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v5 2/3] stash push: avoid printing errors
References: <20180316223715.108044-1-gitster@pobox.com>
        <20180319232156.30916-1-t.gummerer@gmail.com>
        <20180319232156.30916-3-t.gummerer@gmail.com>
        <xmqqzi32sn5u.fsf@gitster-ct.c.googlers.com>
        <20180321213626.GG2224@hank>
Date:   Wed, 21 Mar 2018 14:56:41 -0700
In-Reply-To: <20180321213626.GG2224@hank> (Thomas Gummerer's message of "Wed,
        21 Mar 2018 21:36:26 +0000")
Message-ID: <xmqq4ll9nld2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> > diff --git a/git-stash.sh b/git-stash.sh
>> > index 4c92ec931f..5e06f96da5 100755
>> > --- a/git-stash.sh
>> > +++ b/git-stash.sh
>> > @@ -308,14 +308,16 @@ push_stash () {
>> >  	if test -z "$patch_mode"
>> >  	then
>> >  		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
>> > -		if test -n "$untracked"
>> > +		if test -n "$untracked" && test $# = 0
>> >  		then
>> >  			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
>
> Argh I just noticed we could drop the "$@" here, as this is no longer
> the pathspec case.  It doesn't hurt anything, except it may be a bit
> confusing when reading the code.

Yes, we could, but we do not have to.  I think it is fine to leave
it in especially if we envision that the codepaths for two cases
will be unified in the future.
