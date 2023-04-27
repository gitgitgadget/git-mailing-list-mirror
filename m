Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51816C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 22:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjD0WBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjD0WBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 18:01:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3F430EA
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:01:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a6762fd23cso74435225ad.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682632879; x=1685224879;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nt7tCbvQcgNA59X5owCUwCoMpagphhn/uwXoMYg1V88=;
        b=FCESthKkPHV0VMJsuAeC+bWaybh4qWcaTkB8jIbrIlaNS3rZ0vAJXhdSamspTPdTc5
         UKMhJr3X4f6A9zMNYjPLFWkYQvpkwE1w81y1FiWK+92nkZ8plQMXV+0j3K1ji+Mp96tY
         3m6RLK9DlIhN4PdviA548GPNxdsTor7LvItQqQ/obRnUUv6iWXwODbnoXx/pfRHkDzaI
         3algzSj6W0eVNpd//WEK+fQcIOBWSKR321WRyqIrzFeoRKImBLmGNBk7Go0j8AcDa4LC
         1G2TmqO93Avi41rzedXk/dtDgCYzFUoY7BPvj5oj220jOaT2YJUAoxJ3sfF9ymxZl1QS
         FKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682632879; x=1685224879;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nt7tCbvQcgNA59X5owCUwCoMpagphhn/uwXoMYg1V88=;
        b=ShPygSuaNV/FtAPBxRasAI1K/ARzZFDvsIbI35AkW/OMRUBFErswQFafs/e2MOlnVN
         1Py+KSOsg9YPSmqNZ3bt1lIAYDKTJ00QiVQYBYvqoLCRTqvUwbWP134qJrvr9TJa+fgU
         OHp/lwIhTfGNMuU5GPB29qaM6QzxMTqogsAD5i0Z6vozdgtGwG++DoccM3Q59UXDDFSG
         p0fERQvuL8WtvSuCEJwiifS3gVEUkLQRl9u+QhPLG7Au9TfQ1NseBs9MWZo9oG6QyDFM
         iR3yuR5eDjPlou9hBloOBomhoL6uvirT33m7h9ST9WXXIq8l9v3AosBwaEXVpJmtr1bi
         eqAQ==
X-Gm-Message-State: AC+VfDxYt7AbMpZgLg16KkoyPukCnaBwiwxljj4bPwbm9osm+Q8Beovw
        4/tSSSRLRmwDXcJC1scbMp8=
X-Google-Smtp-Source: ACHHUZ76b7BceLWi3eFAZF4GkTDsA4RHlinMEp73+yMseic81+D3nlJFmT0Go2vGtM46sTCZlXx6PA==
X-Received: by 2002:a17:902:c94d:b0:1a6:61ad:9d03 with SMTP id i13-20020a170902c94d00b001a661ad9d03mr3466501pla.65.1682632878743;
        Thu, 27 Apr 2023 15:01:18 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jw4-20020a170903278400b001a975b64c38sm7405051plb.68.2023.04.27.15.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:01:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 7/8] fetch: introduce new `--output-format` option
References: <cover.1681906948.git.ps@pks.im> <cover.1682593865.git.ps@pks.im>
        <0335e5eeb4ded336c5ff7c8888c8aab9dfed2505.1682593865.git.ps@pks.im>
Date:   Thu, 27 Apr 2023 15:01:17 -0700
In-Reply-To: <0335e5eeb4ded336c5ff7c8888c8aab9dfed2505.1682593865.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 27 Apr 2023 13:13:33 +0200")
Message-ID: <xmqq8redhtn6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 97a510649c..30099b2ac3 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -52,6 +52,13 @@ enum display_format {
>  	DISPLAY_FORMAT_UNKNOWN = 0,
>  	DISPLAY_FORMAT_FULL,
>  	DISPLAY_FORMAT_COMPACT,
> +	DISPLAY_FORMAT_MAX,
> +};
> +
> +static const char * const display_formats[DISPLAY_FORMAT_MAX] = {
> +	NULL,
> +	"full",
> +	"compact",
>  };

Hmph, the _MAX thing that is only needed to size the array and never
used elsewhere (i.e. parse_display_format() uses ARRAY_SIZE() of the
thing, instead of the constant, and that is just fine) is an eyesore.

I wonder if

	static const char *const display_format[] = {
		[DISPLAY_FORMAT_UNKNOWN] = NULL,
		[DISPLAY_FORMAT_FULL] = "full",
		[DISPLAY_FORMAT_COMPACT] = "compact",
	};

would be easier to maintain?

I'll omit my usual "name your array in singular" lecture, as I think
you've heard it already.

Thanks.


