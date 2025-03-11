Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4C14F117
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735395; cv=none; b=dsDam7O/2qRglxJAfvOrSQgS/zk7MGShWSpqNNkWNzMWovRiOu2sNkgP+vdQ7BvlXNotRYhGBfxjn6l7yl9Jfw2N7FfSZU2C7alxZHlaEP80LAuQrWZq4gU3PFgbmkMD8UZK3WqswjjIG9ihCjF499l445F9TRHnliw8B0YiwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735395; c=relaxed/simple;
	bh=zSCncc2oDA/Vhum7bKke3ZoZ+3H+226wAKqzOzAbfNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKe/fYSyc1LPrgCMaLoDnTbxVoqDcqdw7YJhvtbFbT/VHlaoWkk/cbUP8Snb4xZsB11GdBt2B6IJDjiFylyFsy2NTDlCtT6IBhegajN01UooVWBNkkxlJF286I85s6PFLq+0ItyYgXUmDy8/1Tc6UVavszEkR7/vmoKC75ZUZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3DLG+rE; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3DLG+rE"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f6dccdcadaso2043592b6e.2
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741735393; x=1742340193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/k/PwpLPSvX8S2WdEIZL1buvlMnhCjN8+oCchuCynI8=;
        b=d3DLG+rEXyeTxptHGokIfDYDi7DjKKa01/B/NEJJMjfI7DWIo8djsSOKW/efTAJl1r
         0k7DzT8n/3cXMTyxLkH8HHjZ9OmVm4tmtW70b/MbQmKJAeCUDCxBXQQVXO0gc10UaOHu
         EYxmHrFFT1KeyO2V4u9PdwbbQFQyqdeAg3AqZTyMURpwUOl7uPnkZANfED6ZmNY5sJyA
         CEtXBhdSmMp2QkaV1MQcmhQKgpo+QcGGQ4QRGnV4NB7QWFkeZUyAySMM2SGiqYpSrZRC
         YUrhpIJQf+c9MFKvCbKKyNzyeSZ1NiMJa+3oLd+lcT2FMMlC4FAcOknmysZw23zXvSkt
         JCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741735393; x=1742340193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k/PwpLPSvX8S2WdEIZL1buvlMnhCjN8+oCchuCynI8=;
        b=DBWr7wxpLMGWRHr6I4SH4jbarUC47x8Br3ivwQgetEiW+V1tU43GY/iEu6krqCQvoo
         +6a3DgRvXJkx+j2A2T9PF8Mca4xQxoZEVBwq/6pB6ojV1qwk3TMcyL5wIpnR7siXhqk1
         2754synZ+pYOpeyiEC8K8bx+FP/GggPWI70zL+YfRngbLiaGQXf3+O56sKN2XVBNa3eb
         j1dVIEDIXZUpsMHeW7UiGTFnc93vPvZTFGJVsEqRlekfMEYc+UR3V38d+8qwJgBZh+xA
         xGl5wUHHIkDPgEaZfr7m8dQc1yfrtkzeiHEn287ifLWd27Cc3xHGh0BiZmxDLo/71UE1
         +z0Q==
X-Gm-Message-State: AOJu0YwsKgmeRCpLaotzh7D2wyFpXWP5kOqJjFumM4Tcjbo8g7kHg1Ng
	9VuBPxMNBLAO7YddLL/5sHEqrC/GIY82TcofpYOq74H8d4xlGWWYFLs/6Q==
X-Gm-Gg: ASbGnctMCxjH2yt/zq7LtSE3Z3qHSsIMwaOUxXMzydAgTMmvcq1K7tXxZfue4LXThax
	jseiu8T85ooGrkKeEjoUAks/HTS3I3MOFyZo4rKLRE+vAeVtKrQ2k6M9BUOVCJXcm9vQuocyBkN
	OlXQyIC8x+0V21nU1nCb0cozUNBZyQA5txBX00oo7CHhlY2XJRpMPg1w3gv/8yzUa9ctNR9Zal/
	YpoHDBNdQhsDi91TXiDPNE9sofhavVXs56VZ9I/PkzH/wbnUiLRsIR1EURvZrI1J5OmP4NXaP4k
	L37r408HnjYGuAx6IAA6YmM3XPcFDgDhDZtXoQ==
X-Google-Smtp-Source: AGHT+IFcXe6O98V1V2Sv0cjnj8YxZS2ItIdJT4cv+kLVzYmPIXIExrTR/sREkzSRnmkCnFT43pejuQ==
X-Received: by 2002:a05:6808:18a5:b0:3f7:de07:6e1c with SMTP id 5614622812f47-3f7de0771c9mr6786844b6e.35.1741735393194;
        Tue, 11 Mar 2025 16:23:13 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f7f8a283f5sm1421429b6e.33.2025.03.11.16.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 16:23:12 -0700 (PDT)
Date: Tue, 11 Mar 2025 18:19:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <nfrfyg56nq7m2bcko4v4tsfdklrafpkybc6uhqgo25swdeebh3@a7aneoylg46u>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <xmqq34fk7hb7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34fk7hb7.fsf@gitster.g>

On 25/03/10 01:37PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> > To make machine parsing easier, this series introduces a NUL-delimited
> > output mode for git-rev-list(1) via a `-z` option following a suggestion
> > from Junio in a previous thread[1]. In this mode, instead of LF, each
> > object is delimited with two NUL bytes and any object metadata is
> > separated with a single NUL byte. Examples:
> >
> >         <oid> NUL NUL
> >         <oid> [NUL <path>] NUL NUL
> 
> Why do we need double-NUL in the above two cases?

In the `<oid> [NUL <path>] NUL NUL` case, it would technically be
possible for an object path to match an OID. The use of two NUL bytes
signals when the object record ends.

Without someother mechanism to know when a record starts/stops, even the
`<oid> NUL NUL` case would need the two trailing NUL bytes to avoid
being considered a potential path.

If the output format would not result in any additional object metadata
being appended, we could use a single NUL byte to delimit between
objects in this case, but always using two NUL bytes allowed for a more
consistent format.

> 
> >         ?<oid> [NUL <token>=<value>]... NUL NUL
> 
> This one I understand; we could do without double-NUL and take the
> lack of "=" in the token after NUL termination as the sign that the
> previous record ended, though, to avoid double-NUL while keeping the
> format extensible.
> 
> As this topic is designing essentially a new and machine parseable
> format, we could even unify all three formats into one.  For example,
> the format could be like this:
> 
> 	<oid> NUL [<attr>=<value> NUL]...

I was also considering something similar. This format could allow other
object metadata like `--timestamp` to be supported in the future with a
more flexible format. In the next version I'll implement a unified
format here.

> 
> where
> 
>  (1) A record ends when a new record begins.
> 
>  (2) The beginning of a new record is signaled by <oid> that is all
>      hexadecimal and does not have any '=' in it.

I think this is a good idea. By always appending printed object metadata
in the form `<token>=<value>`, we know that any entry without '=' must
be the start of a new record. This removes the need for the two NUL
bytes to indicate the end of a record.

I'll use only a single NUL byte to delimit in the next version.

> 
>  (3) The traditional "rev-list --objects" output that gives path in
>      addition to the object name uses "path" as the <attr> name,
>      i.e. such a record looks like "<oid> NUL path=<path> NUL".
> 
>  (4) The traditional "rev-list --missing" output loses the leading
>      "?"; it is replaced by "missing" as the <attr> name, i.e. such
>      a record may look like "<oid> NUL missing=yes NUL..." together
>      with other "<token>=<value> NUL" pairs appended as needed at
>      the end.

I think this is good. Instead of prefixing missing OIDs with '?', we can
just append another token/value pair `missing=yes`.

Thanks,
-Justin
