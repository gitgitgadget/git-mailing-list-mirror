Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7648633F
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186112; cv=none; b=hjnIIIqaHzuBB25HfqHIyaLqRHj+b3SHl3/yG4NEqsNzhOXZk+pJ6rUnDwpJM+JiahvreEu01Xxd7dTOotyWGxwIL5L/B+7tAUrtx1KvMOJam5cvCkVixbtlcEZ6NEE8xcPuiDXJzBLuUQnojKIX+I4Iin+DvnrD/JYZGtFYvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186112; c=relaxed/simple;
	bh=0WLcAuh47X/Sbak05Ek9wZfC1xlvg9dFbZ4Dcv9n52E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZcNfz9LneTPI4I1FecA0JVBzXBA3fEyx7SuJ79I6tqHvpKOhoKLKEEoSwxBSy3dGjXI33+M/ArFmbg3WdJcIo1tAB1YTMZY8MYPjVIXCcR/DhN2mLj62Q2UMJrLlIgAj75aam4cQHGM6Xl8zz4U5yXhLEZR3O05TYmCF+XmP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKEJPPFc; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKEJPPFc"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-612033bb26cso629742eaf.3
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752186110; x=1752790910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TQTwupbSC6X73QETxzsIy/TVxk6bcJq7bDL4WEBT/k=;
        b=QKEJPPFcdguemBEI4LFFzXmP7k0MrJT40S/AYccHlZPcgY4UXdfg1S7xfXK3qahpVZ
         FGdEr9z8WPya6MPjLbO0QoKim9lYZ2c9NXtacLPzNSE+P7KczKGJLJjgmzNwoNmEP/05
         BM5JJJskg+p1HhvJTBdO9DM5WteJAoFWSQYqHczRmk1NQmXAW6k4XxoVejYXonqFyTYx
         YY4hcOqVmo0p1mXcxExqLCN78SevY+6Sqqa9WIXob/N4fmYe8EaN2wHQu+HrfaOU+pbx
         hIkKGyr3zNmxcWfaw9RzcrFE0nfrkZxTon8qqp5DVnmV6Sb6EUEEcdiRZhf0g9eZ+27J
         Z3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752186110; x=1752790910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TQTwupbSC6X73QETxzsIy/TVxk6bcJq7bDL4WEBT/k=;
        b=wEVzQuM0DjFAue4TxfsyGPxOTjjZmUrPsoRHm7NJ7lpssbhpAdxcxdddtPYz1A1L3Y
         2BIWb9bumaH2DSnKsb0IElbyx4v5CcuxmWKtngzzUMEgXAC9arMXJ1l6rMEsk1gqIvH9
         6s0PTc2OAlvzw7Z8PSF5jJtN06LSvViqbI0f4y1U0i8SJ4LAEa9WLnk22IRgHyVXKpKE
         nGExrNodXR48PrFY1VLO9s1PcHwXYeR2bYN9jy3FSUlYPYX1AoTIfo1gCsvHBpd5Q1Ar
         ZXWcz22Nrp6Lnme6kvW3F0YpKQyxjEWanOcFK5fDihMJOYUXKNMOlsLiIiEBtfZzBAOJ
         3i7w==
X-Gm-Message-State: AOJu0YzkTHU+wS8Ldg0+Gu0OiHWJyaTuTA4gSUQPz71/YPDkmtGxFtLv
	CRPw4zyfIVFnKeGaSChfq8HW9xmp8LEVaYA8Wtuu/VqJt19dIEUGQcHO+HwdlQ==
X-Gm-Gg: ASbGncsjZq2MVI+te1nBLOhFfIFJO83WvTDhXsCeW874U9m//2AV5Sc99QRA5M/dQmr
	2PsKK1qISIojRN/Z88S3ykN4E0hk8eYEPv2Cm5OPCKCcwZh0kWfaf/pgM6UCWtvnoiAVNO4Asdx
	zE/hgraGoqh4BnG+FUYz/HbMQTB4PlmwFy6nEsbMt/VqOBx7MjosMT56kUTNnGjOXN06rEO/fvp
	iYLNiMzzhn3HEjFYt+VL4JcOLBARhc0nVAfUMf/DhGRc+uZpZGVSzPpzVXJVLXuZ3nzTYb8zHy2
	VyWVA5JfEQh+uEBm4opS1Vm3oV5M6YLt1fcfuWMV257LQDz+ODP0Wt0MQrn/ISEUA2Gvl2DlBAD
	8LF/PYo3Z29DuktM=
X-Google-Smtp-Source: AGHT+IGNkWinFfJrwdPbr0T7HOA4QsyFkDDS9FH0mF7OeYC05+mENzpQH0+TTdeku78OvqgxmTHvdg==
X-Received: by 2002:a05:6808:4f5e:b0:406:45ae:b0 with SMTP id 5614622812f47-41511df506amr1047063b6e.35.1752186110286;
        Thu, 10 Jul 2025 15:21:50 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-414191e561esm355110b6e.11.2025.07.10.15.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:21:49 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:16:12 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/8] midx: track whether we have loaded the MIDX
Message-ID: <kmprav735ntlgo3x47ptxyhqc6c5n7tyyub5c545gw2g4achng@sst72rcazce4>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-4-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-4-f31150d21331@pks.im>

On 25/07/09 09:54AM, Patrick Steinhardt wrote:
> When calling `prepare_multi_pack_index_one()` we know to skip loading a
> multi-pack index that we have already loaded beforehand. While this
> works well in case there actually is a multi-pack index, it doesn't work
> when we already tried to load a nonexistent one.
> 
> This doesn't cause problems with the current layout, where users
> typically iterate through MIDXs via the linked list stored in the object
> database. But that linked list is going away, and those users will
> instead have to call `get_multi_pack_index()` for each object source. So
> if one of those sources doesn't have an MIDX, we may end up trying to
> repeatedly load it even though we know it doesn't exist.

IIUC, in its current form `get_multi_pack_index()` returns the global
list of MIDXs. The MIDXs are loaded when calling `prepare_packed_git()`
into both the global `r->objects->multi_pack_index` and
`source->multi_pack_index` for each source as appropriate.

Looking at `prepare_packed_git()`, it checks
`r->objects->packed_git_initialized` to see if it has already been
initialized. If the intent is to start calling `get_multi_pack_index()`
for each source individually, doesn't `prepare_packed_git()` still only
execute once regardless already?

> Address this issue by introducing a new variable that tracks whether we
> have tried to load multi-pack index of a given source.

The contents of the patch look good, but I'm not entirely sure
introducing a separate variable to track if the source has attempted to
load a MIDX is useful.

-Justin
