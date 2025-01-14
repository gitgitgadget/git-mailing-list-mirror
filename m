Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740D212D70
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818760; cv=none; b=GeDjlGscpmg29v3a43C8Mxii9uviQHuB/Gz+CaQNSUX/a7DPYa/9Pif0cKTSxWsqYm+80pYh6zOgxs5nCjfdQJR/f6InJgcDfAMzkN9jXPaeEsgDRmezgMbp8hNtxu55yr6gipRCWEFYBMLtpq6DmaRF49LEW2IsImGQROdoqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818760; c=relaxed/simple;
	bh=cqMpfrf74rQ7rPwFAFF4ggvIs6t/GQUD8sc5P3107bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkmHMmOl2T21tnIWYxVovzX/4pi/R/T59tnQtEeHcX+BDyiHUtRU1j6rigbL9nu+Ci26KYbrrMi1j8qHRByWuaZw6NM2ufCUlaaSjNzd8fJ/IfUBwwp7t+VuWqsrkpYGQXzNqz5GIh2amRawc+4Qcj14hPj/lT1iPd0UOQzxqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioF6QzSE; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioF6QzSE"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso6672135276.2
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736818758; x=1737423558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWiifOHs3F19vVOTu8R5UXvr1gnJiEQ13yXN10Z/xlg=;
        b=ioF6QzSE2IzgQt7lRyNG1o898gUshxzuAwIwVsk3h3Q0ZyNOFs1wHktp4qq7eMV/Ja
         QoZdaHPL7RQsIVolx7kl6id5FyC84f6P56pUKgJBuzcIqhNl7hxp2FsS0oEzKDf8Rt8f
         MLdnzugwLlJMQJvZWv4RFiezv4qn54ZN7JrdgsSicE+sdazF20NIAGyMfIQqpYt+9L7I
         7+h+NZhPkfB9f16IbzV8CvWQiGJnJltVZ7U3QSrCVkYot1CkQGGZP8w8b/Yo+VJBjKi8
         lIpyz+446O8STljxNmNzxZw3Lz1UP7GFGq75LbJbUCIi5OEU79gYf25CkCQU5Vrsffuo
         vrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736818758; x=1737423558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWiifOHs3F19vVOTu8R5UXvr1gnJiEQ13yXN10Z/xlg=;
        b=fTiR8G8kBMRSWfjpKdG1xBFjm1cOI9knuublGVDbR53WI5DlbB+WNOM1N9vf/a8wXK
         b6QWow1XCq7M3pSbwhtvd1eVhD3RcfkL7HuFv0T66mqt2Cm+wVHvWNWQJAjtkPQKgc6u
         oNers4MysoPu/e6R5O+ShKwcOFMwYM7gJMR4al2haFGaLnYXCuLzgPNwJ0Pz/8b5+mbr
         648Bq4REugyVfFga6SRwxk2uaigveVdiYprQyMVfV1WpFKiqV+xR502TM1E1DhafOSg9
         YSzXCen6QJr/V8DeIbPwHQWylaiwA5VCbnRTF9XIYvudq/L3MuspNs0cvK7Qmp451FoU
         0FZQ==
X-Gm-Message-State: AOJu0YxUepHS2GqNVARlJmvXNzXt/vOBnmE3ivOZBKrG6aowrOWXbXme
	k0x+ctAl+Jycwr7QtchuI8FSEdGJ5dPpliNYyCpO/ii0GysY/bqwQO8lfFQjvHVEJyjnU271KX4
	eZXWcJEs8bUQk5YLrg++3UDKUiik=
X-Gm-Gg: ASbGncs/l6rSylBUWGg4Wcut+jee4vCMVao0dyJ1jvEiWB8SQYjjpKEHd5AIw/dQX4h
	YsrQtIDh1X/DoLRCSP1AghoCz4dWmUldF7iu3/Q==
X-Google-Smtp-Source: AGHT+IFRlhICA7izJpiHwEo39eUnxggkHCTDj8GEqFiM3rGPVQY5gswB+xVFTigR3Z4QvRMVupuD8WfefeZrGr5GyV8=
X-Received: by 2002:a25:58c3:0:b0:e53:d870:76f6 with SMTP id
 3f1490d57ef6-e54ee212c3dmr12288018276.43.1736818757935; Mon, 13 Jan 2025
 17:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com> <20250108183740.67022-2-eric.peijian@gmail.com>
 <CAP8UFD1CoaEzqoCN+_6_qPk_5scf3mhvpCRrsuxc1K=ZObUgiA@mail.gmail.com>
In-Reply-To: <CAP8UFD1CoaEzqoCN+_6_qPk_5scf3mhvpCRrsuxc1K=ZObUgiA@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 13 Jan 2025 20:39:07 -0500
X-Gm-Features: AbW1kvbNqNTGMPoBGz0YLSZ8u6Yh5BFUSE2stI6qaCRXJR9SY-ptus_4SN9D8G8
Message-ID: <CAN2LT1CSbdptV_y7iyWeWrBRNM-ToDm=aHDha1Hc7FHa12bSZg@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] git-compat-util: add strtoul_ul() with error handling
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you. Fixed in v10.

On Fri, Jan 10, 2025 at 6:33=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Jan 8, 2025 at 7:38=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> w=
rote:
>
> > +// Converts a string to an unsigned long using the standard library's =
strtoul,
> > +// with additional error handling to ensure robustness.
>
> We use comments like this:
>
> /*
>  * Converts a string to an unsigned long using the standard library's str=
toul,
>  * with additional error handling to ensure robustness.
>  */
>
> Also we use the imperative mood in comments before a function, so:
>
> s/Converts/Convert/
