Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88977C7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 22:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbjFLWVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 18:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjFLWVg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 18:21:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4D102
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 15:21:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3a6469623so15822645ad.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686608495; x=1689200495;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyJ7UM7gG704PANKWEcHQs/5Qple45FFY/FnEOuMr6U=;
        b=fCfoQ1bbtUueD6Q7qTkOEwErAqmHQR83f4uX5XQ3Z4G0iqwAPCVsq28/nbgDVljAO5
         dcNqNe9cxFS3/o53CKXoNoQdHjUhY/FgIbohNxMcmL3+gbBgklZF1CEUoGukNQ8Rokyy
         ORjGdWpmiIz8z8fmmMr40snCdI7LFoiuM9ht8e8UIo2oYb09mmjZwr2p6YdJEw0paRWC
         27n7wBc1T40n3bgtWz8dSs2apDLOetWNwoLexGH35lVRJZYnYpGBEOae7xuXUiJp22vE
         nk/jdyIX7KMcNPUhPTdG6Y/wQQwnQVf2UaknmH9CmkVHN8VVDuSb5jncZ6AuCJ040lyr
         UUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686608495; x=1689200495;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jyJ7UM7gG704PANKWEcHQs/5Qple45FFY/FnEOuMr6U=;
        b=MLPVlfIHvd50KDqruO5Cz7sp6v+3cJtOI4lIR1+p0LIkLZmKeqvgU93eBiPPGkNFUD
         mI+0bTNQbZO4bbmmyKlylfn7up2I+ZM7CSxnxuCVS08t8lPbEcm2EvuzB+8dzDfNT1wJ
         3R+vKW8lfTdyCseb5e/k/cmp32Zmln20bbFcUsxFIfZLe5GmC0mCVGNTMH8rjRWZX4oN
         il+OdIFcB54+mNF45nF8KIVYigjvorpWXvz87Pcr3hjeve2OztHBsBlIF+Y9v3JME2iT
         Gyhked1hUPIo7I9n1sRel6okWCE4Tb8D1/icx2bmSE8RTKwGJOd6N2QY+Uh4hQ5Vr+z4
         GZzw==
X-Gm-Message-State: AC+VfDxGP3IY1HPuN9YrxK4zpuiVIlySM1U+NqwrCJfIqEJjKG/+GCsP
        /ZVap4kDwtevudhxg2USWjM=
X-Google-Smtp-Source: ACHHUZ4ZLJkWtcv5Ktmq/BjiTCd1aKiQPxW+67V/+T1u+SnnNpK4LKsFaaymsrPxddsZfDsnS3phUQ==
X-Received: by 2002:a17:902:da87:b0:1b3:bd67:9a92 with SMTP id j7-20020a170902da8700b001b3bd679a92mr6649836plx.5.1686608494939;
        Mon, 12 Jun 2023 15:21:34 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001ab01598f40sm8714662plx.173.2023.06.12.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 15:21:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 3/3] revision: comment `--no-standard-notes` as
 deprecated
References: <cover.1685441207.git.code@khaugsbakk.name>
        <cover.1686505920.git.code@khaugsbakk.name>
        <9141f5a86e66276b672fc54783afe3b48b6227cf.1686505920.git.code@khaugsbakk.name>
Date:   Mon, 12 Jun 2023 15:21:34 -0700
In-Reply-To: <9141f5a86e66276b672fc54783afe3b48b6227cf.1686505920.git.code@khaugsbakk.name>
        (Kristoffer Haugsbakk's message of "Sun, 11 Jun 2023 20:15:56 +0200")
Message-ID: <xmqqbkhk724x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> We still use `--standard-notes` but this option has no use and is no
> longer documented anywhere.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  revision.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/revision.c b/revision.c
> index a0ab7fb784..24219c741a 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2529,6 +2529,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		enable_default_display_notes(&revs->notes_opt,
>  					     &revs->show_notes);
>  		revs->notes_opt.use_default_notes = -1;
> +		/* Deprecated */
>  	} else if (!strcmp(arg, "--no-standard-notes")) {
>  		revs->notes_opt.use_default_notes = 0;
>  	} else if (!strcmp(arg, "--oneline")) {

With the placement of this new comment, it is unclear which one
between "--standard-notes" and "--no-standard-notes" is getting
deprecated (actually, the comment is placed inside the block for the
former, so it may be more natural to interpret that the comment
marks the former as deprecated).

	} else if (!strcmp(arg, "--no-standard-notes")) {
+		/* Deprecated */
		revs->notes_opt.use_default_notes = 0;
	}

I am not commenting if it makes sense to declare that the option is
deprecated here---I'll leave it to others to argue for/against it.
The usual reasoning to add/maintain "--no-foo" is so that we can get
"cmd --foo --no-foo" to naturally work, but it does not apply here?



