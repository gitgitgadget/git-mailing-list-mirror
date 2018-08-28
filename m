Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED281F428
	for <e@80x24.org>; Tue, 28 Aug 2018 19:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeH1Xlb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:41:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41374 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1Xlb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 19:41:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so2644153wrb.8
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Na/XLfuhAaSs1UvF0Oo9Uqrcg8KmeGATeDA40zIhSnk=;
        b=qaPGotP7iaX9fQkPLFqQ1Wf3XjUikQJ9RUF02IND7SMTl3Yl6I1JRqZdyz3tJAj2XQ
         K5cjrwhknt1xNnfmkB2UzF6tbPT+mVy8hBEvWpdkIy7ZXXsyzm4i+e2C1l4VZTFy1Llb
         yYqBKSh8uEyQVwiG3GmF9FQUAVHaJZQaP7qA8i1MjW+3XV1FXuUdEUZ8UHFGLDTNnQvs
         uwN5zowr1BH47IQ8QX1PwynZkJcsP2quDG42fNmfKMWyoFTRr/dMsUQ1U7LX84KRq1uY
         Vp7YGrAnHtP2g1uKeT/bbNxbS1Mvlt02R8++yF65yKYzYSLUnr8HC5NxU3anhwzMUlvi
         LRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Na/XLfuhAaSs1UvF0Oo9Uqrcg8KmeGATeDA40zIhSnk=;
        b=FnUUQfI58EeB8/6jGDmw1/x1KvrpEgdlpX30Y1xN8SCSeExtAbj3hTLJhLHuWYj4i+
         ugNmgr/rh9BOiPKBEth+vHCiKMMvhUIdBde0ZR5Rf0eLB4wS3B3VcjWh17P9ZDcLwglC
         rxkPMCam/ooHasi4nV5B3y/Y31dlfTEseuAjLmefm3y3RRRZezF7SOLP/PscJ9sMDL9e
         kIZ4MOhtoIT8X6gKlk9W0CmG0ZxpciZ9UvpgBjWf8woK37DIS9JIBTOokDDuZdW+Vo+j
         jJJtsqn4v2eR7auLfRoZZiyKH9i6qJceJ808o18OPxhkorhNQwpd36inTFNgEfOmR7Nj
         fvOQ==
X-Gm-Message-State: APzg51BlNauNLIHciSGEGM96EDkP7JmqvnqVXIiGmExe8ufkTGHQ3BSl
        q8iAs5oySeEfHDsFhxA8+Zk=
X-Google-Smtp-Source: ANB0VdaHy1CMlC4xuAqpLn5y/ptj3QRn3FRhlHJYRMIBrX4tvYxstug8Pk7mINH62XsHuMgZnQ36nA==
X-Received: by 2002:adf:9227:: with SMTP id 36-v6mr2195291wrj.275.1535485699871;
        Tue, 28 Aug 2018 12:48:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l18-v6sm2883058wru.75.2018.08.28.12.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 12:48:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH 1/2] tests: fix non-portable "${var:-"str"}" construct
References: <20180828193827.8648-1-avarab@gmail.com>
        <20180828193827.8648-2-avarab@gmail.com>
Date:   Tue, 28 Aug 2018 12:48:19 -0700
In-Reply-To: <20180828193827.8648-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 28 Aug 2018 19:38:26 +0000")
Message-ID: <xmqqlg8qff24.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> On both AIX 7200-00-01-1543 and FreeBSD 11.2-RELEASE-p2 the
> "${var:-"str"}" syntax means something different than what it does
> under the bash or dash shells.
>
> Both will consider the start of the new unescaped quotes to be a new
> argument to test_expect_success, resulting in the following error:
>
>     error: bug in the test script: 'git diff-tree initial # magic
>     is (not' does not look like a prereq
>
> Fix this by removing the redundant quotes. There's no need for them,
> and the resulting code works under all the aforementioned shells.

Yup, there is no need for that inner dq pair in this particular case.

I was more worried about scripted Porcelains, like 

   : "${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}"

which I think can safely lose the outer dq pair.  In t/ directory,
there is this one in test-lib-functions.sh which I do not offhand
know how these problematic shells would handle.

	echo "#!${2-"$SHELL_PATH"}" &&

Other than the presence of these two that are not covered by this
patch, the patch itself looks good.  Thanks.

> fixes a regression in c2f1d3989 ("t4013: test new output from diff
> --abbrev --raw", 2017-12-03) first released with Git v2.16.0.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t4013-diff-various.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index f8d853595b..73f7038253 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -140,7 +140,7 @@ do
>  	expect="$TEST_DIRECTORY/t4013/diff.$test"
>  	actual="$pfx-diff.$test"
>  
> -	test_expect_success "git $cmd # magic is ${magic:-"(not used)"}" '
> +	test_expect_success "git $cmd # magic is ${magic:-(not used)}" '
>  		{
>  			echo "$ git $cmd"
>  			case "$magic" in
