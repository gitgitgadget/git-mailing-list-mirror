Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D3BC7EE23
	for <git@archiver.kernel.org>; Fri,  5 May 2023 01:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjEEBQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 21:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEBQE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 21:16:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806AC9ECC
        for <git@vger.kernel.org>; Thu,  4 May 2023 18:16:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5208be24dcbso809018a12.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 18:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683249360; x=1685841360;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFbTupniC2mHDg/Hhj/+c+hkVCpqXHHp2DtZ3MkVDuY=;
        b=c6EqKBX+G/jRrCoWEBgf4H2yWfDMOeg2Me6xXjzv0LHOgmjPwY5iiVJ6PqDCnyd7u5
         9NBq3yfEG1ZhH09rNwCRA1VafuZtRhOc3rYYkFtytGcbYraAEG4jTG0olAgK8CpgH3IG
         qnQuexJQFdJk2neV3YaNCXnlzR/gQ+F4B13nSgIX+OC3bc7cCmg42/O2FsjOn7ChE4r2
         +JpbB2TQwPu0qlqXkgSlNS0q5FILtcUmCwDjAs/00XPS34PXGqgzOxutt2EhDlIifCe8
         kuse/aCsRG1UJeYJRL64E0aACTHG5/LMdwP6fHZjPjjxVfZvekTdmSmpe/84xMiRKYJH
         AHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683249360; x=1685841360;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sFbTupniC2mHDg/Hhj/+c+hkVCpqXHHp2DtZ3MkVDuY=;
        b=HCVmJFsxRo/tRu5DWvpSgtoSKLTNglIKYH6QTvHbke9khmlVVKBz8nWiL61qjaYehA
         fc8t+B8VDBAzHA69XalJ1ZCmdtagvnql9uwYSt8ENFDGr0XSSesy8uWKYoDNNR5aIJhP
         bCaOvBhy2HcJn/N1BstlKbXYCGut+kahI4LpD3+YzCDmP+iufkaLMjCDEydNhig/nytw
         ELs6gN+TukEpToYIWkK6dDhonzMSoCKBVusKcUQkjZEYJTjASKn6fb8jD0GYjq4GDSoq
         SLXDOCYOkj2625FgWebEtTOVXbhfDD2QAdd2+JLJ4lk1yxzKFE4PonJJKtPdwdu5o4u1
         L5DQ==
X-Gm-Message-State: AC+VfDzQ+y1a4QIO3MjgAaONKAliwhXt/qk0Nk/k82WHGnwLcRMZmx5q
        I7eaVLsaQd+UZQ+1ll3xsJg=
X-Google-Smtp-Source: ACHHUZ69nJ0tT6F0NhxnJuTv8jJEO5S1dJLRAdfsZVJVgyDn8uNhTAElatNi9LgJM7KuSIlf+RxT6Q==
X-Received: by 2002:a05:6a20:9145:b0:f2:c2a3:39a with SMTP id x5-20020a056a20914500b000f2c2a3039amr4915138pzc.61.1683249360232;
        Thu, 04 May 2023 18:16:00 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c6-20020a63d146000000b0051b595b26adsm303076pgj.91.2023.05.04.18.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 18:15:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: doc-diff: specify date
References: <20230503232349.59997-1-felipe.contreras@gmail.com>
Date:   Thu, 04 May 2023 18:15:59 -0700
In-Reply-To: <20230503232349.59997-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Wed, 3 May 2023 17:23:49 -0600")
Message-ID: <xmqq8re3inn4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise comparing the output of commits with different dates generates
> unnecessary diffs.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/doc-diff | 1 +
>  1 file changed, 1 insertion(+)

Ahh, it is a fix for a fallout from 28fde3a1 (doc: set actual
revdate for manpages, 2023-04-13); when it is shown in the patch
form like this, it is kind of obvious why we need to compensate for
that change this way, but apparently "doc-diff" slipped everybody's
mind back then when we were looking at the change.

Looking at the patch text of 28fde3a1, we pass GIT_VERSION and
GIT_DATE to AsciiDoc since that version.  We were already covering
GIT_VERSION by hardcoded "omitted" string, and now we compensate for
the other one here, which means this change and the other changes
complement each other, and there shouldn't be a need to further
adjustment for that change around this area.  Looking good.

> diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> index 1694300e50..554a78a12d 100755
> --- a/Documentation/doc-diff
> +++ b/Documentation/doc-diff
> @@ -153,6 +153,7 @@ render_tree () {
>  		make -j$parallel -C "$tmp/worktree" \
>  			$makemanflags \
>  			GIT_VERSION=omitted \
> +			GIT_DATE=1970-01-01 \
>  			SOURCE_DATE_EPOCH=0 \
>  			DESTDIR="$tmp/installed/$dname+" \
>  			install-man &&

I wonder what the existing SOURCE_DATE_EPOCH was trying to do there,
though.

Will queue.  Thanks.
