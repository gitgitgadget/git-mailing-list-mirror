Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4787E125B9
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116579; cv=none; b=L5rBcg5BnNjDcexCqPbZiMBtH1oirSVqiV0a2gtw87FpGERi7tSkYJPmeYmFFauARwxMfV7UplwRJfgP3x72oPLWjw8Y9B2aCGfBs3LvHrP5oPvtX18uQOszVZn48xDp1MSle5aiVrlqWLZdXqFCsxTxk17pxl+ZxgZnmE0jamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116579; c=relaxed/simple;
	bh=Wc6A6D6+ZFOT+XDydoYzMGJKGfn5BQYUvXRa5370Qdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXB7J4AoKdpLDRifDGQbHHwbFOoMksJBYTe1aNhl6i7vM+jSBkMXTav0m1AlOZepzVE4KtH6Ya393yDq8xpBzaXYRB/s59cWsw8ksNxdV4hWuld0epj7UGbuHa1hzyt7Uns2I5K/Kb4IFSieTrjd/2FQdP95Ql0tjwyyunk0yoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=r8uLEmJI; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="r8uLEmJI"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e330b7752cso10766937b3.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729116577; x=1729721377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ovV2Rsh7/x+lL0vyLgK6AQnv+24wVzVhPJubcIq30GI=;
        b=r8uLEmJIXInrUcU16ifV0r8Dd5wh9X3Lex0shIKIhClbm4uwZYhZX3Wd7Y13wza0K5
         +uFNoQtX+2mxvGtgRgvIoX8wkgJ7z5/VIwN6gQ5b9IKtk2HfsLQkpwtjYVOWSVWKfhg8
         zemmjBT4TrdyOq7l7zXVZ1I8WbUxGnJFHhzfbKjFKD89CTs7E7FffdUigjhlAtbz2WYt
         5WKeoM36rqjmLnzQm6tqK24Mnsq+d+I/Lvncy54gqu2HrUgCro0zWt+6pOR9BOFifYQ0
         T4YPfwIUCF145YMo+psiPCLkKSx4i/QhwEnc2YI1NT7SRNqWi4MHG8a1478Odg5cu1NT
         r8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116577; x=1729721377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovV2Rsh7/x+lL0vyLgK6AQnv+24wVzVhPJubcIq30GI=;
        b=E3Vi6twiMuHbaHgtaZjbCM74iRCvwLUwhNiy2d/ytAMaVZs+Kv38QB6dftPiSAT7VL
         X3KH++mpCQU8XT6SAmUKpi7NLf2LvmDpYyhL1MVjW9qW8nctouZ+LpoaZCnXBidzL9ic
         FcOTNX/N/BfgVDk+0Peh70nVKxJ64ReHM8ffGLOM7Cj2fnPoTO1EdYd7/vKL4ImQ/6NQ
         4sbbVLupwaPFt6HrH/q1rKaFXKBy5uoQ2WYJ16HEMk5YqrL+6hdIG3jDCJYcwkGXbZ51
         0MQSc+LV/iEpf53OOABCVWcxhpdccj2W42ME3ubSlhLQ6bblMC/zGDrJdDC2d5hItNs3
         K/KA==
X-Forwarded-Encrypted: i=1; AJvYcCVE9NfcEM3RIRDyQc6AsH5fciOKEN7302udciCIczdBg4kjfw74JxEooaEHzO+79rl2Qhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1BX3KeoNfAeuRrbpJ4yunNdYSP3sxV0D0x1awDBytUGW0GdY
	mMXIVEtK+YuX84aDM7DVAa+Em7nZlO+4z9AzMUV6b25AwrQcl7Fy3KFPWQsYqu3bWAq44CBHCMX
	r
X-Google-Smtp-Source: AGHT+IFE3VIiP8NazMVY5miHC1YJPR0Oisho1dRoe2icFATBOf9u3MdVf/7kObyGahrGNTsRfQiTyw==
X-Received: by 2002:a05:690c:25c5:b0:64b:b7e:3313 with SMTP id 00721157ae682-6e5a3da0885mr11602057b3.13.1729116577250;
        Wed, 16 Oct 2024 15:09:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d26551sm8775107b3.125.2024.10.16.15.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:09:36 -0700 (PDT)
Date: Wed, 16 Oct 2024 18:09:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk, gitster@pobox.com, bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 1/6] doc: =?utf-8?Q?update-ref?=
 =?utf-8?B?OiBkcm9wIOKAnGZsYWfigJ0=?=
Message-ID: <ZxA5ni7McD1c1yuf@nand.local>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
 <ad9ee00a2a971522968f95dd413deae24839ef71.1729017728.git.code@khaugsbakk.name>
 <ZxAmBsZzwBuEGN3N@nand.local>
 <CAPig+cSuQwu4YeZ5cs-g0oAnhCf1LMS1SSywyPc_vBExh85ahw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSuQwu4YeZ5cs-g0oAnhCf1LMS1SSywyPc_vBExh85ahw@mail.gmail.com>

On Wed, Oct 16, 2024 at 06:08:05PM -0400, Eric Sunshine wrote:
> On Wed, Oct 16, 2024 at 4:46 PM Taylor Blau <me@ttaylorr.com> wrote:
> > On Tue, Oct 15, 2024 at 09:03:10PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> > > -With `-d` flag, it deletes the named <ref> after verifying it
> > > +With `-d`, it deletes the named <ref> after verifying it
> > >  still contains <old-oid>.
> >
> > It looks like we may want to re-wrap this paragraph after tweaking the
> > wording on the first line.
>
> I think we typically avoid rewrapping after minor edits like this
> since rewrapping introduces unnecessary noise which makes it more
> difficult for reviewers to identify the important (actual) change.

I have done it in the past myself, since I often find the result of
re-wrapping much nicer to read. But I see what you are saying, and
certainly don't feel strongly.

Thanks,
Taylor
