Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB3720248
	for <e@80x24.org>; Mon, 18 Mar 2019 08:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfCRIZK (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 04:25:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54809 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCRIZK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 04:25:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so12097561wmj.4
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 01:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jqlcMf7FgW2qCZ+MCJJoJQ+xW/tuDmd+yXBvvKxqDVQ=;
        b=qD/AQO+OULhcsKb2J53QNy++OR1VAe29iYuOQi40H0YuTuqMHEeGIFxIP7fOY/e3D/
         uJqsk9AbtKdxYnybWPW67ooRsZbp3VxFxdII+0wXmzCpdK7J8/XYIeWD5fzFH2j0iL9W
         kJ5cZbThOCMOuc7SQ7VCuT1dg/Y/ES9ClwItLIKBiqdj1hKreyzp/qsP0O3yo1N/YLSX
         Dr2XmB+PckmFpjDxCHKDhqe4FJXWiip5LR8qUrPFkvdk2JPWoAJbgmzql2nmks1n3/2j
         H0Jh/5aU3knjlFePqDTVv+pV0E68p9ST6LYHim6BFE224/AiYHYNcXoB5p6/cF74PIYP
         9m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jqlcMf7FgW2qCZ+MCJJoJQ+xW/tuDmd+yXBvvKxqDVQ=;
        b=Fq887u1ez8JFo5CpaWssrxZjE3rvQK8BmYI/jqbwwKXDumpSatUvhDuxkl5dRRgp7Z
         YrsXSjyDvdhl5TDB0mSJAsmpqAfEzSkvDKAhbHCIvr+rExaELsOypOGTVpDttlz0urAs
         S/jJESi6/rOY8Ho4w7eiTh/j7Mbf1yEsA0vn+dBj3VaJhx8FvJQvVLOBHWqJHVyXF6IE
         o9XH7td3cFxVqqqZtlbywdcdH7uMd0V1HyECSlDM9+8zCKSVnryqX6uB7AtTvPmY+bN3
         lTlQdfteByR3wvVMeEdvGlrkgMbxCTT/hKhluHPDdXz0fuAPdAJC9rVRT9Dz6QMeqDdl
         452Q==
X-Gm-Message-State: APjAAAW3+Ko89w6JZJHv/KUjZr7xX3oUlC51rYxPjAzaq8S6KuBM1bB3
        89E42V1RoqzICrJj3UJwWC8=
X-Google-Smtp-Source: APXvYqxp5WdvFlBz774YoQJlR4VSCbsIkg5IVdcoZyv+mCR/tS8s1R0LY7ai87q8Ejz61m9cXh0Y4g==
X-Received: by 2002:a7b:c044:: with SMTP id u4mr10598554wmc.88.1552897508526;
        Mon, 18 Mar 2019 01:25:08 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id e16sm5115647wrs.0.2019.03.18.01.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 01:25:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 00/11] Fix scissors bug during conflict
References: <cover.1552275703.git.liu.denton@gmail.com>
        <cover.1552817044.git.liu.denton@gmail.com>
        <20190317130539.GA23160@szeder.dev>
        <xmqqa7hs3d0z.fsf@gitster-ct.c.googlers.com>
        <20190318080306.GA28784@archbookpro.localdomain>
Date:   Mon, 18 Mar 2019 17:25:07 +0900
In-Reply-To: <20190318080306.GA28784@archbookpro.localdomain> (Denton Liu's
        message of "Mon, 18 Mar 2019 01:03:06 -0700")
Message-ID: <xmqqlg1czj18.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> > Here you could swap the order of when you write to 'act' and 'tmp',
>> > and thus make the 'mv' unnecessary, like this:
>> >
>> >   git commit [...] >tmp &&
>> >   head -1 act >tmp &&
>> >   [...rest of the test...]
>> >
>> > Note also that 'head' (or 'sed' in later tests) can open its input
>> > file on its own, there's no need to redirect its standard input.
>> 
>> Yup, that is better with a slight fix
>> 
>> 	git testing-output-from-this-command ... >tmp &&
>> 	head -n 1 tmp >actual &&
>> 
>> to actually read from the output kept in the temporary file.
>> 
>> Especially I think bare -<num> is a BSDism that has been
>> removed from POSIX some time ago.
>
> You mentioned in an earlier email that,
>
>> The intermediary file may want a name better than 'tmp', if it is to
>> be left behind, but this will do for now.
>
> so I wrote it in a way temporary files wouldn't be produced, similar to
> how 'set up mod-256 conflict scenario' in t7600 does it.

I didn't mean to say that the name of the final file should be
garbage, though ;-) I was hinting, by mentioning "if it is to be
left behind", to remove it when you are done with the temporary.

If we were to give more meaningful name, then perhaps just get rid
of the name "tmp", like so.

	echo what is expected >expect &&
	git testing-output-from-this-command ... >output.raw &&
	sed-or-something-to-extract-what-matters output.raw >actual &&
	test_cmp expect actual

which is also good (and when the test fails, looking at the trash
directory and finding the raw output named *.raw may be easier from
the output of "ls trash*" while debugging).

