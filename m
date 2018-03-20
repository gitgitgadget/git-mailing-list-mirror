Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9A91F404
	for <e@80x24.org>; Tue, 20 Mar 2018 18:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeCTSWF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 14:22:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35024 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeCTSWE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 14:22:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id r82so5398688wme.0
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fFWuSIfdSyoN2nqSpiV/YlPuTULrGouhL/xJ4v+mAyQ=;
        b=DSwRu5qhX1aMeG1x1luS8/iRmT7CKQ0bNzZkU9USjqARrgBxNezI+BohNk93ihd0jL
         2nQPgV+X6y5wg/kQcHkgmhVnbpm269CBG2+BNGcvs+ecsb6cy/HF8ATfbbvF/3Q0pmcW
         +3nKuvET6DMF6PYSWaNAWuMTz44tsIS4OmdS98bMETipD9uipq3JkoGljCssxuNj+ev0
         IMUwAD0eKmb16FBk0xJ687KaKj3LpW5YIUarv974aNDRdPeRtgRdLEAtJYtH2D+K5ziN
         AtfQuE1iRIZwq9jH3DOP5Ilri9i+YrorOV655UQbaJp8Rj9IwXi0KuDwO2FZDqv69std
         fEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fFWuSIfdSyoN2nqSpiV/YlPuTULrGouhL/xJ4v+mAyQ=;
        b=LNZr2xr6y+a7185LpvewtLT16pDnMIEhjvTGAX+YXgy68mJc4mvbeyGPnXO4robj+9
         mmMd/C4ddtqTmZIOLt8LrbybucUk0wMcVIEPnkbG1EZhuLA4SkY7aPENbW1rSXez8isn
         wns3qwPwEI6Ojr8VN3szY2JT51L083dLC1pFMtvLQE+sZlXKXEJNQuRaB/vezwAorWmI
         BxG5uEK6539vQgGXM1DAaixplZO+0B11hLBMlEIRw7F7PWLaLNBGNI5Wep8XamLX0liO
         exaAjnKuwUa5vHXTTw1l8sRz0kHabfMA8XCTbjGlej3Y7fPVwkOT9tGVDkeuEb6zUEDy
         M2Rg==
X-Gm-Message-State: AElRT7G4AJHXhpbFiCuwRrODWqjLM8lX9tekzfpKbc7cyCnwXTVuXUHI
        VwN/SUPYc/gH08tLH7aCD8A=
X-Google-Smtp-Source: AG47ELsRB44uMKoE11uzI/hwMNztuLHyK/6i5KtS26OfMdBhiwJU/n0FjMlXN9EGjMOFAve/m9T0YA==
X-Received: by 10.28.171.193 with SMTP id u184mr489131wme.32.1521570122778;
        Tue, 20 Mar 2018 11:22:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d48sm4344166wrd.12.2018.03.20.11.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Mar 2018 11:22:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
References: <20180317141033.21545-1-pclouds@gmail.com>
        <20180318142526.9378-1-pclouds@gmail.com>
        <20180318142526.9378-10-pclouds@gmail.com>
        <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AkJJQ4XNszxBsESN_WGOSZ+ExWdcCtn6NA+gW9+-mAqQ@mail.gmail.com>
        <xmqqlgenvs07.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AbkaSLBYqtFiCwFoqRXguy1hTs=XriefZ3WQJjo_sy8Q@mail.gmail.com>
        <xmqqy3inu8qe.fsf@gitster-ct.c.googlers.com>
        <20180320180806.GA16521@duynguyen.home>
Date:   Tue, 20 Mar 2018 11:22:01 -0700
In-Reply-To: <20180320180806.GA16521@duynguyen.home> (Duy Nguyen's message of
        "Tue, 20 Mar 2018 19:08:07 +0100")
Message-ID: <xmqq370usj3q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> This "size" field contains the delta size if the in-pack object is a
> delta. So blindly falling back to object_sha1_info() which returns the
> canonical object size is definitely wrong.

Yup.  Also we need to be careful when going back to the packfile to
read the size in question.  A different packfile that has the same
object may have delta that was constructed differently and of wrong
size.

> Please eject the series
> from 'pu' until I fix this. The bug won't likely affect anyone (since
> they must have 4GB+ objects to trigger it) but better safe than sorry.

> BTW can you apply this patch? This broken && chain made me think the
> problem was in the next test. It would have saved me lots of time if I
> saw this "BUG" line coming from the previous test.

Thanks, will do.

>
> -- 8< --
> Subject: [PATCH] t9300: fix broken && chain
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/t9300-fast-import.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index e4d06accc4..e2a0ae4075 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -348,7 +348,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
>  	INPUT_END
>  
>  	test_when_finished "rm -f .git/TEMP_TAG
> -		git gc
> +		git gc &&
>  		git prune" &&
>  	git fast-import <input &&
>  	test -f .git/TEMP_TAG &&
> @@ -365,7 +365,7 @@ test_expect_success 'B: accept empty committer' '
>  	INPUT_END
>  
>  	test_when_finished "git update-ref -d refs/heads/empty-committer-1
> -		git gc
> +		git gc &&
>  		git prune" &&
>  	git fast-import <input &&
>  	out=$(git fsck) &&
