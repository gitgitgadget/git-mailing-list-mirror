Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D1255E24
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169979; cv=none; b=cxYMrcl4g9mgKdtfIAgdLLlRH6luFWM5O9aG+fFqjjdYuZIHXH4Nxe9DOWa0bLOy58ddXUVb5Ld94sbmX4JWtGlCr+Qt5xokWxq9e29c+ANFAPzymV6OR0Lc7OaQLVVT5jm+SZHgvXdbFpspRw1oxEa/tLrZw5UsxAvnFnL28kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169979; c=relaxed/simple;
	bh=F7ustgMWH46sLYrF+OogQKkcevOAlhOfRfHeVZUNhI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiWu7yFLLgcUQU6z04+lDnHTnqvP6XlYF+T0VHLywE2D2jIIDnRwYi5DlmLb0+ko45HeRJpXB5u1aKtygMIEjAsFn7VtsFx4GdR2c7kkSAtk04+zFlYU1DzUrg5A+wDoMRQ/hMHSpKH8cgjkqvmtzSPEoN9L41hgweYKJcYXMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkbGstGp; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkbGstGp"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2bcf9d9b60aso520498fac.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 12:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169976; x=1740774776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XmzeqxoW5ydLQR/MXNdecrx0+CUPTSDDT4r723hbYcI=;
        b=RkbGstGpDn/4e5z+AuB6MJ3ERo2NKvYQBZNFS2yJa1tbCnSjqf/GRdQF6wKvmBdVt8
         EP8+1DogjYH24HXvCgZxQd8KKtr9lCLWjKBUbUHpga1T0AwVw7iYiKvRqzjH4T2ksPnH
         xrCICqYizag0D9Z8d/n4zsj4aC6cHiqvgV0/09W2r9djrV1l4wifkdP9ZRew5bnQMJwZ
         4QcVoSJ12Yv3qpDFGqBhc3Fvho8hqWc2s35R1I9k9XejY+xkAw8PGrnrVr8o3s9Zx9RM
         Up8O5YaCXi/E7v7XmCMmfBUsWW3SgB4mpZ0wcm6DxC4+cft236ln5aNvYrbB+DYyqsIo
         cRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169976; x=1740774776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmzeqxoW5ydLQR/MXNdecrx0+CUPTSDDT4r723hbYcI=;
        b=HPbRr7NK5wp9n/ngz0ZMo0wzQi+68hmOPPFpE+O4vJAz9+yYKN37v6Se77EAQ0/0Dp
         kcVv4yyic6ycqAUn+g4Sgz+YXk9qPnH4eUlpFkPoDwijvDkHsC62okZjn5Zqk72kVKxh
         FclnM99JcT9cL1sPaQ7T2E1VI8AFf4LvvXc5WHSDb6aVA1ShgHQCzi90JHTX5mnsW1gL
         DcmKm/oVp/mnkqoV7dTSrskVlyKD3fd2GCi7f3bDIkgLmUaPfiNBi5GdcjmliLEXVDBM
         3tA0gPMso0DRSUOmO5xDoMMW7ZMwmlF3olIoWgzP7dsAXU1LqC76B2nE5LddNFWOSnA6
         0+gg==
X-Gm-Message-State: AOJu0YzKv5vhm9bYVgeTBS+PzScPbmq+W8WLLkQ8FHKcTz4fW4pc15XD
	18KxBWWr4kbnZg9teofVhuhOZeJoTy314etKW0DN+sVVcmeE7q1w6CFIkA==
X-Gm-Gg: ASbGncuslLz+JAZRGDxGW925jQphK1PxLDKcSeU1Dbu3mxo6pEwqJjV7OHhEB9/l7Er
	1IDXkcYjI5OiADgfIOe0A6GGHVCaygNrKkZ0iYffl7jMf0N5gn/KJDfBSZ6QGQSW6O433xNTxNM
	k6Pcq5HTm3sTa0IPIynluO3Q3iCfup4tssY6Li86T4iKaktFtTnLtC9BGDNV0oQn6CfHS+Xgmt0
	VQP3qWsm5M0q/EQwRGZZU43X1wn+5VAR5rUzzy5SP1lLAWd2tOgZC1m2VK/Yco8RDAUIAyo8MN6
	kAefs4Hzw930N4ODUAE=
X-Google-Smtp-Source: AGHT+IGGzEq+nyPDi9TH4451YdxCqFNDSUYPB189l6bOUsmLq3r2VJcYOkJuE1uEVfG6hMjHIUiP0g==
X-Received: by 2002:a05:6870:e0cc:b0:2b8:3b8d:31f9 with SMTP id 586e51a60fabf-2bd5187a084mr3528162fac.33.1740169976271;
        Fri, 21 Feb 2025 12:32:56 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2b9548e762csm7002959fac.28.2025.02.21.12.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:32:55 -0800 (PST)
Date: Fri, 21 Feb 2025 14:29:45 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] add-patch: update hunk splitability after editing
Message-ID: <ev52edk7wgoyb7jirte72mni2pj2m64snngd5kevgoypejuikn@hpcitzemataw>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
 <35ef0ee2b9925748ae3b6b6ac68e79c71782e5cf.1740149837.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ef0ee2b9925748ae3b6b6ac68e79c71782e5cf.1740149837.git.gitgitgadget@gmail.com>

On 25/02/21 02:57PM, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When the users edits a hunk if they change deletion lines to context
> lines or vice versa then the number of hunks that the edited hunk can be
> split into may differ from the unedited hunk and so we need to update
> hunk->splittable_into. In practice users are unlikely to hit this bug as
> it is doubtful that a user who has edited a hunk will split it
> afterwards.

If I'm understanding this correctly, the issue here is that, when a patch
is editted, the number of hunks in can be split into may change, but is
not reevaluated. This could lead to issue if the editted hunk is
subsequently split.

This issue would also apply to addition lines being changed to context
lines as well correct?

> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  add-patch.c                | 12 +++++++++++-
>  t/t3701-add-interactive.sh | 21 +++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index f44f98275cc..982745373df 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1182,19 +1182,29 @@ static ssize_t recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
>  {
>  	struct hunk_header *header = &hunk->header;
>  	size_t i;
> +	char ch, marker = ' ';
>  
> +	hunk->splittable_into = 0;
>  	header->old_count = header->new_count = 0;
>  	for (i = hunk->start; i < hunk->end; ) {
> -		switch(normalize_marker(&s->plain.buf[i])) {
> +		ch = normalize_marker(&s->plain.buf[i]);
> +		switch (ch) {
>  		case '-':
>  			header->old_count++;
> +			if (marker == ' ')
> +				hunk->splittable_into++;
> +			marker = ch;
>  			break;
>  		case '+':
>  			header->new_count++;
> +			if (marker == ' ')
> +				hunk->splittable_into++;
> +			marker = ch;
>  			break;
>  		case ' ':
>  			header->old_count++;
>  			header->new_count++;
> +			marker = ch;
>  			break;
>  		}

Ok with this we now recount the potential number of hunks a hunk can be
split into. Whenever there is a change from a context line to a
addition or deletion line, a separate hunk could be formed.

-Justin
