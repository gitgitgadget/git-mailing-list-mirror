Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92C5CE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 22:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjISW7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 18:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjISW7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 18:59:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D361C4
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 15:59:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so6698958276.1
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 15:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695164368; x=1695769168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fEUOifDaHuMxeqQKtr9g0z2GTtz5EeTtKXmf1UEBuro=;
        b=14Hd4NPy02oQha9TF5b2guxWTfx2r4EWAbK1g3soswcjLmtzaBm7Em3+5QTQhwyayK
         aIyn7xP+UjZ/284KKFp41/NMGsncymf3nohKwVfKvl3zNoYpc2vgOFXrx3J8Zx8GOJ6x
         BBJLJ/abm37LEELU0pdDFtuY6WwhPfbwcg2qZ75y6TN0YhW7KYXMsy/TOAZnJWutiXIj
         WJBaP5j50fRkUlMvejLyhxB5olplpelI9Wm6kBgPtuwpUb2VoxmEtInVIy/iqdXSjIvc
         K2idpqmto3gUr+O5mcS4Rr8+gp31gNakPgKAepNDU71ZmNukeSrgks6ZVsycxW9s7WEZ
         IAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695164368; x=1695769168;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEUOifDaHuMxeqQKtr9g0z2GTtz5EeTtKXmf1UEBuro=;
        b=qRdqk39oVj2laFoFY2fgKJIQU1LFtYVkJ//9P95NBY3GjgKy7znxuNZVSUMfYHATuN
         YVyHyxmJvILYCF4HPeJlKvZyY+Rm1I2bWtxpergyTUEToo+DcxMi1LPEs0qbNlrWseEc
         2ozQcPzELHhZrvHUD1E7IBBTiq/HGFEfPfGHqaYUtrBsLhb4MeuaLa2k54Uqj2SXBhPB
         oTFO8i7cxuGIMIgvQrF2cGgCY8QRttQZcTD1Lq2whzNJYPIgOrdQYm1JSYHy0yVMDXDs
         ffODi8pej0tIgT5Rgt51RMezpVHl4O1rqZQO7ED3bnCMvpKBnV73Z4wb9SMirfzy0lDK
         bKTw==
X-Gm-Message-State: AOJu0YyjZVLi7/nLU++M1jgerrPcjhJ/fSlWLTMdI55aWsS6VrVIGxBB
        J8BemuTsc/gd/fzSSUPN1Fcv/x0F2Xo/W2BUIy1W
X-Google-Smtp-Source: AGHT+IFUN9uJ8kVwyJPaI1sSglWhNKiZDKNGP163eYoiNWZBW9nmPxDBgBRhaYimQricfeSzswoKM6f+VF/kGtp+kHt0
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:def5:f709:d6a:7375])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:140e:b0:d81:9903:9dec with
 SMTP id z14-20020a056902140e00b00d8199039decmr13696ybu.7.1695164368403; Tue,
 19 Sep 2023 15:59:28 -0700 (PDT)
Date:   Tue, 19 Sep 2023 15:59:26 -0700
In-Reply-To: <0b9525db5a0787fdc71834abad9151aa03acc497.1694125210.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919225926.2189091-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 13/13] trailer doc: <token> is a <key> or <keyAlias>,
 not both
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -248,34 +258,40 @@ With `add`, a new trailer will be added.
>  +
>  With `doNothing`, nothing will be done.
>  
> -trailer.<token>.key::
> -	This `key` will be used instead of <token> in the trailer. At
> -	the end of this key, a separator can appear and then some
> -	space characters. By default the only valid separator is ':',
> -	but this can be changed using the `trailer.separators` config
> -	variable.
> +trailer.<keyAlias>.key::
> +	Defines a <keyAlias> for the <key>. The <keyAlias> must be a
> +	prefix (case does not matter) of the <key>. For example, in `git
> +	config trailer.ack.key "Acked-by"` the "Acked-by" is the <key> and
> +	the "ack" is the <keyAlias>. This configuration allows the shorter
> +	`--trailer "ack:..."` invocation on the command line using the "ack"
> +	<keyAlias> instead of the longer `--trailer "Acked-by:..."`.
> ++
> +At the end of the <key>, a separator can appear and then some
> +space characters. By default the only valid separator is ':',
> +but this can be changed using the `trailer.separators` config
> +variable.

I think all the other patches will be a great help to the user, but I'm
on the fence about this one. Someone who knows these trailer components
by their old names might be confused upon seeing tne new ones, so I'm
inclined to minimize such changes. I do think that the new names make
more sense, though.

The documentation doesn't seem to say what happens when trailer.ack.cmd
and trailer.Acked-by.cmd (replace "cmd" with whatever) are defined, but
that was true previously too (and knowing this does not really enable
the user to be able to do something they previously couldn't, so this
is fine).
