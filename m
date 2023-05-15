Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CE5C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 07:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjEOHAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 03:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbjEOG7v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 02:59:51 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99BB9
        for <git@vger.kernel.org>; Sun, 14 May 2023 23:59:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52c30fa5271so6513458a12.0
        for <git@vger.kernel.org>; Sun, 14 May 2023 23:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684133990; x=1686725990;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fPyYB2w6q7P+Tx5VXhPcgJdRzRMBSKp6Lo/Y1/YvLVA=;
        b=Pd/LtKs1Ehuf0L0uvuNmOTLgDUL5XqcNqZxLSrAsgNbCTTTsyn2aT4e6GsMUUootiU
         EY4/9EFvtouKS6Qbsji3E4cZP3uQQWFJNVAeIClAdI8RfieduG+yFHBrohU0KmgsTCxM
         xC9ywLk1vkl0LB8dQGifgSA/cVsjaPoQbXWNgFmZNK9EQIiy7xuWCy/Odpxy9ZyTGFXp
         0LcS4awvyoIcIHhfVHwIMZqMKDBhBxw/wXGex6KNYaRYrjWTCs90KMLLuSXxqj3EkULH
         Pwp8NGyly/tf0waf5RFEV6fFdmNq6hmaADONcBMq18jnvJT/iNqB0vN+Q0gnqNdthHxh
         GByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684133990; x=1686725990;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPyYB2w6q7P+Tx5VXhPcgJdRzRMBSKp6Lo/Y1/YvLVA=;
        b=GOAKyqLHKZh5gDpHsnReZlHUAcjVpy7kJlXUQcJ+mA/d81ZY4miV2oXwC78QqCWpIv
         X2SlKSkPtw/IlPNrIwxl9oA8zo/RZ0F00fWbs0Bs4yiyJ5aVH6uOfOYp6N2ZCb3La4xO
         tx2UWWP0VxKNj9j5fv+bPS2Ck1iJ/7GMZh+SJ18AV5HOCglXyf3z4uhziKnOJYRk87uv
         me+f0JTBKae5+dupujaAslES9n4IebjyyYxpRXQxc9rCBc13KJTc3AfYErMGPMbYBm83
         9+wQC1L4cJImQpZWodl4YQrp4aGcgCUZyqkcfFdL9Qodnr/JtozjdSigvBH8KYEs0iRa
         bmzQ==
X-Gm-Message-State: AC+VfDzZp6VmFNGxu5GzsDL3D9mOoyQVP3PVqCOlWb771WM37GJagHgy
        ltITg9nkd4SdNoyqqsG8AjK30MY2/4w=
X-Google-Smtp-Source: ACHHUZ7L7+wI26II85rkqp36cD1MPyspUJb1hH3toU86AWSgq1vKHTi9Iym2dxTmW5kEckq9XbhwiA==
X-Received: by 2002:a17:90a:fa85:b0:24d:eb38:bfa0 with SMTP id cu5-20020a17090afa8500b0024deb38bfa0mr33574251pjb.11.1684133989840;
        Sun, 14 May 2023 23:59:49 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w10-20020a1709029a8a00b001a95c7742bbsm12717439plp.9.2023.05.14.23.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:59:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/3] t/t7004-tag: add regression test for existing behavior
References: <cover.1684067644.git.code@khaugsbakk.name>
        <87b709d856d8f788a2a50a2804ac508d5775f324.1684067644.git.code@khaugsbakk.name>
Date:   Sun, 14 May 2023 23:59:48 -0700
Message-ID: <xmqqy1lqaxln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> The standard tag message file is unlinked if the tag is created.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     `test_when_finished` because this test interferes with the next one
>     without it.

Use of when-finished to remove a tag makes sense.

Unlike COMMIT_EDITMSG that is documented in "git commit --help", we
do not promise the users that the temporary file that is used for
preparing a tag message is "$GIT_DIR/TAG_EDITMSG" in any of our
documentation.  That needs to be done at the same time, or before,
this new test makes such a promise.

>  t/t7004-tag.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 9aa1660651..550b5b1cce 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -2127,4 +2127,13 @@ test_expect_success 'Does --[no-]contains stop at commits? Yes!' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'If tag is created then tag message file is unlinked' '
> +	test_when_finished "git tag -d foo" &&
> +	write_script fakeeditor <<-\EOF &&
> +	echo Message >.git/TAG_EDITMSG
> +	EOF
> +	GIT_EDITOR=./fakeeditor git tag -a foo &&
> +	! test -e .git/TAG_EDITMSG

I'd recommend using "test_path_is_missing" instead for better
test-debugging experience.

Thanks.
