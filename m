Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5C0C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 01:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbjELBCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 21:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjELBCP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 21:02:15 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F6C1FE0
        for <git@vger.kernel.org>; Thu, 11 May 2023 18:02:14 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6434336147cso5392472b3a.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 18:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683853334; x=1686445334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xX2cagl3ArlAd6Q7ge1UpOXUfwdPTbkN+uBq12m+8c4=;
        b=LmtkI+iyJLk/JCew5udteUWryiBfZaZI3Hsv/PVurmsvcsdE3OlvOE6iNKzSklH62X
         YmaMzj1tRBEMcTXcNDJmQbGfLOXviMD2HolO2ahD3uEalO0+sLz2cgLx/v1HSMTMGLLg
         9yFGJxDgSJ1m+kvfVS/Ig5WHmPuKkiqdtgia8uOPzd/eDI1pl+fQhrMfoOz8nkdP2z5W
         guRMQ685dWNTwkOyQzmihjpqlDi34gEZD3ftEKvTvJ1yjwXN+KTPAwPR+eZU54+j+Gsi
         WCOGs+hLRWwVdLCBUzdnX9VSf0DoA6U2xTSj03QjzTTXblDHV1YJXBghORtzbPMUb3Rl
         f8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683853334; x=1686445334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xX2cagl3ArlAd6Q7ge1UpOXUfwdPTbkN+uBq12m+8c4=;
        b=OkxXTxpTU/hqEuVWbZp2XRmJRSTBVS9Fg7E5SqyfVsmsWeGT8AhUISjE2Tk5hdGZxn
         TXJstsxDPXB4nFCZCLN99qesYkzaDhiUcJH9AwaEa3JIif4Fe0i8R+n2Uz7T9CLihFbJ
         9r18z4YHf2w+pUm+CnJj96sGjhAswx2bzp5vWkYu468NUnWjxGCZKDRpRet0OsXBa0hB
         NFduuI7t/OHS82RsCSkivTbQNBYCKbr+gvkA0GTXfQezBNW4AJVErv43fo7rPMNgGNLb
         kAevkyMLbEFpNj1mMdkFjhNpSPqmA0/YNMEwh224rvR39kVYF+S1VI2PueZ1y7+0WC4l
         R2rg==
X-Gm-Message-State: AC+VfDyyR/IQIEFQEpjn/kkbw/BwmI42AWDTjjFve+aocSIKeA6HKSFH
        8gZycLhBuzgIFPmH2Zzt/5KwBSnZ6CaM0Q==
X-Google-Smtp-Source: ACHHUZ4CQRlojVhv9iL+R2T8FlIM9KwRg8jGXeZcnzuKPD+nBfTj6YMldMeOKVFhHd9ibjFJQpJyzbK/Zd2eSw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2c8:b0:63d:a0d:6fb2 with SMTP id
 b8-20020a056a0002c800b0063d0a0d6fb2mr5826143pft.5.1683853334336; Thu, 11 May
 2023 18:02:14 -0700 (PDT)
Date:   Thu, 11 May 2023 18:02:11 -0700
In-Reply-To: <d49152c22068d18cf9f8a2f1e5fe92a3b1f13e37.1683721293.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1683721293.git.ps@pks.im> <d49152c22068d18cf9f8a2f1e5fe92a3b1f13e37.1683721293.git.ps@pks.im>
Message-ID: <kl6lfs82z7jg.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 9/9] fetch: introduce machine-parseable "porcelain"
 output format
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +test_expect_success 'fetch --no-porcelain overrides previous --porcelain' '
> +	test_when_finished "rm -rf no-porcelain" &&
> +
> +	git switch --create no-porcelain &&
> +	git clone . no-porcelain &&
> +	test_commit --no-tag no-porcelain &&
> +	old_commit=$(git rev-parse --short HEAD~) &&
> +	new_commit=$(git rev-parse --short HEAD) &&
> +
> +	cat >expect <<-EOF &&
> +	From $(test-tool path-utils real_path .)/.
> +	   $old_commit..$new_commit  no-porcelain -> origin/no-porcelain
> +	EOF
> +
> +	git -C no-porcelain fetch --porcelain --no-porcelain >stdout 2>stderr &&
> +	test_cmp expect stderr &&
> +	test_must_be_empty stdout
> +'

(This shouldn't block the series) As a matter of taste, it feels like
overkill to construct the whole output to check if --no-porcelain wins.
Maybe in a future cleanup, we would go through the tests in this file
and see where it is really important that we have the exact output and
where it is not.
