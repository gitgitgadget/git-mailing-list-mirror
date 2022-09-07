Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B429CC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 20:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIGUtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiIGUtL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 16:49:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D9BD4DF
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 13:49:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c198so5924481pfc.13
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=lYnpO49n4Di7o4368XKixM63txtF+PAhrDkTvuS6QHU=;
        b=ehmyL+cyp8R1WUT/TpXazcIrob10+H179HWkKpx69GFBm2xr/S/I0Q+u+B2rLSEHhA
         v74tK/p2AABcQTd/lonmCr1rGr2AuVmk2ZylPmGWLh5DWhQPQfw6LuYs/AurVO+M20sy
         LC8S5lO/iSGHUTl+Z+wywbR2vX2qvMMda/tB71W9GmRqF4FqYKB2xyQ/NaRV5Gqblbrn
         Yxn392B9wa6xhdtTM+rlT5R/6m4o0blXECLpNDOA8atBrcqDTVIJvskEdHdQPz6zUt7y
         eB5uBI0jaiOnsdTaZm8AOfpBU6100NJ28IKeoagNOqx9g8m8NdxQP61hfQq1DfQ8RawE
         xAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lYnpO49n4Di7o4368XKixM63txtF+PAhrDkTvuS6QHU=;
        b=xGURA/Rc3Pu9/rfaxRFen7D7IKyQUD39Bh/rjr6W3JmArhS9uUElhKMHkf6/8DzJJ4
         aZQ4k1RiZC8j0+S/DzpeR+MhXKWwXzOXAzmTj7nzovr8FvTcM6EjgrwRa6gIBskOZNOA
         JsxQYy9lejCYc/0bYrJKa450k+ZbkAPsEEMHrQQltsyqfg22MG0aoT+Lt6tFnvfOKQgC
         i25+Szta7uk06vd5a5AxTRkA2NZCDINk8SQ3E+yVwn8sJKRFU3mNSnUBU/AwuQRAQcVy
         ok23S9UyZRRd2tvcOhRTR3rGFXXR99VvVY1O+sGYuDHDeebujSYqkYBzp6dVrqee5jeP
         2zVQ==
X-Gm-Message-State: ACgBeo0adQdbwxFoLx3PWkay5cHPqfW9tN4KaIsUur/duW4+WZOtpFdM
        dS+fJAntWFoB8+0KzVf10AM=
X-Google-Smtp-Source: AA6agR7IwdDIH2pYcjRyZzd4nh607E2MXEuXmtogjqso/d9D0c1CrH2tHVnpx/9S+hFn4KN0WkVbWA==
X-Received: by 2002:a65:590b:0:b0:434:2b0a:c30 with SMTP id f11-20020a65590b000000b004342b0a0c30mr4727493pgu.588.1662583749764;
        Wed, 07 Sep 2022 13:49:09 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i67-20020a626d46000000b0053e7d3b8d6dsm1998307pfc.1.2022.09.07.13.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:49:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] t1800: correct test to handle Cygwin
References: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>
        <4s7o04s9-3052-rqq6-584n-978p9758p580@tzk.qr>
Date:   Wed, 07 Sep 2022 13:49:08 -0700
In-Reply-To: <4s7o04s9-3052-rqq6-584n-978p9758p580@tzk.qr> (Johannes
        Schindelin's message of "Fri, 2 Sep 2022 14:22:41 +0200 (CEST)")
Message-ID: <xmqqy1uusyez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> @@ -159,7 +159,7 @@ test_expect_success 'git hook run a hook with a bad shebang' '
>>  	# TODO: We should emit the same (or at least a more similar)
>>  	# error on Windows and !Windows. See the OS-specific code in
>>  	# start_command()
>> -	if test_have_prereq !WINDOWS
>> +	if test_have_prereq !MINGW
>
> ... this to be `test_have_prereq !WINDOWS || test_have_prereq CYGWIN`
> instead.

My understanding is that there are CYGWIN and MINGW prereqs that are
mutually exclusive (if you are on MINGW you cannot be on CYGWIN and
vice versa), and WINDOWS is a short-hand for "we are either on MINGW
or CYGWIN", and I am not sure if it clarifies anything to rewrite
"we do not want to be on MINGW to run these tests" to "anything non
Windows is fine, by the way, CYGWIN is also OK".

If we are planning to add another variant that falls into umbrella
WINDOWS that is not CYGWIN, and that new variant falls short of the
requirement of the tests in this script just like MINGW does, then
the suggested rewrite does make quite a lot of sense.  There would
be not just two but more variants in Windows family, and if Cygwin
is the odd man out, then the rewritten one would convey that more
clearly.  But with only two, as long as everybody understands what
MINGW is, I think "this part does not work on MINGW" is more concise
and clear.

As Đoàn Trần Công Danh pointed out, the TODO: comment may need to be
updated.  For future-proofing, perhaps "a more similar) error on all
platforms." would be appropriate.

Thanks.
