Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4110A03
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504785; cv=none; b=fBH8XLU9MNObzymPPoxKvssmoA4GY4n7jq9H5FQbK8IqMI5h/xjzIFJUUHCk0ay+qvaSOyxk9y63ApRXdnlB0L0s61tt7Q5O086LPFo0mDuPjkCRbcvYz2y/7njbtB4hJPJUhHk7Gn8FQKh5sQdSWIiXmUKehmE/xLlcMQjeouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504785; c=relaxed/simple;
	bh=7iYs1Spfqu/34TNF4eNbUdPyGs/COvi1oVuoQBhsLNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ckT1XdPOY3q7+hm/iy4xo/zE+y2vZazjobMJXwoC9szeTf9leyQm2/0ro04Vn0u/SHHAUlenVZxA5MOtQeSoRQcmYrO/zbPq/TaBLjoU+qngAK28lGo9dio1LFs0gcmGpC6/3OZ4N8HUu79WBPY9UDtpHYgGTMb+lUG5nw5NFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=25zhPMSY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="25zhPMSY"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed25e9b34aso1435604b3a.3
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713504782; x=1714109582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ2he/GcZvTqzkyrW5ha10sh4uAen6NC4sWpgEbFsos=;
        b=25zhPMSY/hj6o5iWB/FX5gb4VBcDLlC9Om+nYNfcIjCFa7x0YvDAv0GyqFYMNpshQr
         E7xL3XdCLoPQpTULFbVtwNhXryqv6Onyfw8y/6igSU0IIYZFkBzyZE5Rwne0k0ASxveI
         OD8ptRDAr9hGz5T0elE0vfUzqCbMdZ0VTSoyHdMreLwsWZ+FPlZQa6VXUshKSf4kJEfo
         Nc2Tdzi9G3oJ0qaq6Ugc+h/zb1tSfPfFBpEW78u/Q0KZs3/ZevrP1xIsmg+xtxvz+2fr
         suQMTZMnFFQSwyyatxZTjDFesMOmGmYgeuv5eS4+1aqIlLQObV2xgqfHkJnDrYQXa93C
         +sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713504782; x=1714109582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ2he/GcZvTqzkyrW5ha10sh4uAen6NC4sWpgEbFsos=;
        b=fWPDh3jOwhCGIFXSEZszHa7z2/fFWQjVzfpD6syfkv74pVfC3EBQbuktRxpuArpsIb
         WOv/ine6fZeTEptl45raE0XM15p0kapXnKJgHVLc8G/YTMz+TnpJiCzRSg/IGzU170Cr
         xNGprB97iGXR++KIkfVlSZjLlEvspg+/Ld9Ln5Kj4XMWQrEo2hH4BInXgmZiEVex0La+
         79BgZj0aSYIKof+A5AeRWsVmbmYDOynoXFEvP66gCyg1h7yJqiJKqjdnQXiMIfDOvUOD
         y3YIshTSzaLpf+vGY2yREzOgjfpb3JDz1i5LT8u+Gcxq478Dc5Z8cdE4HTSkLCMaSNKP
         F1hA==
X-Forwarded-Encrypted: i=1; AJvYcCUyhQqKVbJY1FCNCPIi7lzRYW8C9ZXdoMDEIMQyzzZkARHe3FHyCUahZQVeiOZoX700UXHWdTeFkahywSrxV1ecXWZe
X-Gm-Message-State: AOJu0Yy3Q0wOGfLiDgmVhUwjpRHvnsvwgbqd7pemxadtKTt8ZulkUhKZ
	7D/gPLbqzVhlTUciCYbMttpttAT6VhikGgq0hyXXkDd2SNWtmQ0lzIgFr7xW4tK6a1QKgLsth/B
	VoQ==
X-Google-Smtp-Source: AGHT+IGxvljh4q35REOY9ntY4r8dNpzcwf5BVI5w+CnVDx33zpKlyY58xkSddCv1w+Ivok/yYE14/l5GyMw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:2d0e:b0:6ea:f424:85ce with SMTP id
 fa14-20020a056a002d0e00b006eaf42485cemr130339pfb.0.1713504782334; Thu, 18 Apr
 2024 22:33:02 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:33:00 -0700
In-Reply-To: <e1fa05143ac63e8fe8dbc8ccb76a89b7a008c412.1713504153.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
 <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com> <e1fa05143ac63e8fe8dbc8ccb76a89b7a008c412.1713504153.git.gitgitgadget@gmail.com>
Message-ID: <owly8r19or1v.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 2/8] trailer: add unit tests for trailer iterator
From: Linus Arver <linusa@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
> [...]
> +		{
> +			"with non-trailer lines in trailer block",
> +			"subject: foo bar\n"
> +			"\n"
> +			/*
> +			 * Even though this trailer block has a non-trailer line
> +			 * in it, it's still a valid trailer block because it's
> +			 * at least 25% trailers and is Git-generated.
> +			 */
 
In the next reroll (sometime next week?), I should put the

    ... (see git_generated_prefixes[] in trailer.c).

comment up here (where we first mention "Git-generated" trailers)
instead of down in the last test case below.

> +			"not a trailer line\n"
> +			"not a trailer line\n"
> +			"not a trailer line\n"
> +			"Signed-off-by: x\n",
> +			1
> +		},
> +		{
> +			"with non-trailer lines (one too many) in trailer block",
> +			"subject: foo bar\n"
> +			"\n"
> +			/*
> +			 * This block has only 20% trailers, so it's below the
> +			 * 25% threshold.
> +			 */
> +			"not a trailer line\n"
> +			"not a trailer line\n"
> +			"not a trailer line\n"
> +			"not a trailer line\n"
> +			"Signed-off-by: x\n",
> +			0
> +		},
> +		{
> +			"with non-trailer lines (only 1) in trailer block, but no Git-generated trailers",
> +			"subject: foo bar\n"
> +			"\n"
> +			/*
> +			 * This block has only 1 non-trailer out of 10 (IOW, 90%
> +			 * trailers) but is not considered a trailer because the
> +			 * 25% threshold only applies to cases where there was a
> +			 * Git-generated trailer (see git_generated_prefixes[]
> +			 * in trailer.c).
> +			 */
> +			"Reviewed-by: x\n"
> +			"Reviewed-by: x\n"
> +			"Reviewed-by: x\n"
> +			"Helped-by: x\n"
> +			"Helped-by: x\n"
> +			"Helped-by: x\n"
> +			"Acked-by: x\n"
> +			"Acked-by: x\n"
> +			"Acked-by: x\n"
> +			"not a trailer line\n",
> +			0
> +		},
> +	};
