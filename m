Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF4A17B50A
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006105; cv=none; b=R7zJunuqrmuu13qr9pE5bp/SRA87d8Db06mPJWap9bjCZ45GVvz2aofSCFf46UtwGGh+fyOnolkGUG/m6xW0qx+SVzIx4o8n9/W9pGNrJgvV70KUIrVkmXPAA0VfGdxpYyYYhUWTuLdcolvceYjl7t25mPFdxHJAM1FKSGXSzMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006105; c=relaxed/simple;
	bh=rE/K2+PIt4kBa6lvS9f8+jMssAECCHF1XNCgDNrQV+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuUcGdWq0WOE3sZvNCZdRH8X05Svw3snV6YiUvxxasraRrZwWPQeD9hffVEPbYHrcEhqZdFj5hLzSwY8sMLh8mb8eTZzn4Bd0DA2SLr+fWI/7S/2k5MMnSMdk5AoVgtUWW3abukDnAHBftwuCG/441zX5IvfW1obfWXmKTWwFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIAnNn2B; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIAnNn2B"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2adc2b6837eso1373789fac.1
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 11:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738006103; x=1738610903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=klA8cElq+qZm+FPWWVi4Etr0DsIg6a9dc7ooHMF7ssg=;
        b=QIAnNn2BUggl4KdXFy8SzHDny1cKcdXjrQHWA9pL7Pl3mqhMOrdiPn5swMi8kVraWz
         us4CBW0KWIEEmtzjwVZfYMrWEynN14PPEEgRh3vPqyKoWIC9b+Lsx1KOcigZBHQ0Z4Pt
         oJ1GyvOvtUI0pCPSgzZVQU63e4uGmYY81VtMgLfgw6n6W79xoLJyE4BTED/SmhDTm2Ju
         pn44p/kcfP+FCiP7aOj/Add0Ue67TXr1wvw3uv6UXotXg5vWq8JMDeLk+F7uubP75CTu
         zY0JWVnlDC50eNCqoQwmiS/Ihr2rnQ4Ha0KJffPBjmeRfoinCYr5f88b0kDj8TyLlpWu
         /Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006103; x=1738610903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klA8cElq+qZm+FPWWVi4Etr0DsIg6a9dc7ooHMF7ssg=;
        b=MLv2uSLhNwdHFXxB+u5UMlFUmGVlBQuxmc5Wtw/Hy4PHO8NlO3xVksql3kTXGLR8t5
         V6yXgZpWoQK3JlK1/tZQxCsRwDerXJgPmxqAAK+guuRmf1upPpUOJ6NPy379wMV5rcWn
         C1AoERKlhejOsSebDQkeZmJhhTjQxo/MA/lE3Y4D+qWv7atD0SBbGSS78CtoLLaAKemi
         WwE/Ba1P4LslxbMAod0V+RJEk/FK6ZxABAwGtw3eFGmEpiul0Vwci7PTlU2ngJczHfxO
         B7eiqhBBthRAo6Rp4tw15Bv9VDfJXzT98maj/1vJkUNiRdhaz8PTzBpGmRCFrSI7N9HB
         5mmA==
X-Gm-Message-State: AOJu0YxRpHYtXmwavwwWC0o1A15Is7VLIxUcgAHjKVnE+PegeXuU9t2I
	8NDfnbgWSc4r0OyOqdbT0HX5buoQOr6cBfSZ5y+H1QNbXJeMkmOV
X-Gm-Gg: ASbGncsJqdmV2zDQ7V/wFF41urV/ltHmrFjKpY3yHpJrRNAVt5QsARu3P6u5Nll81Yy
	vv7Qep5VQ+8Ocf0q0Be68+G6tlHC4Vu9x6MhXmhMKZFPIcP6KpDIDfmM2dZTsFi1xX/f7ViGCh8
	G6i/opDWVh7hOwQlfeHAmwemYd5UTVN1iOu0PPXE0EBSkAxBC6YuRLXOHLS8zVM6gtKgvaxIcg+
	0OmTEuNwOvTXeXKfNccamj2ORd0kuLV+1MnquTiBNqRk6veWJkpiHYlyKPKFWq+enXrJfVM9Q==
X-Google-Smtp-Source: AGHT+IEzFpTehvnSPW9vXH/RQqpE73WkNirhVpCcS3BS0rqYUak2uA1u3G5m0QYAlYqVPytv3lhZQg==
X-Received: by 2002:a05:6871:5e15:b0:29e:5c94:5afd with SMTP id 586e51a60fabf-2b1c099e645mr21059625fac.1.1738006103341;
        Mon, 27 Jan 2025 11:28:23 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f0facaesm2845818fac.1.2025.01.27.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:28:22 -0800 (PST)
Date: Mon, 27 Jan 2025 13:25:31 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 17/19] git-compat-util.h: split out POSIX-emulating bits
Message-ID: <qpwuo3av2zvopiip75lxuntugfekym7tncdv4e3aww2n74ivbo@imsgukjwneu6>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <20250127-pks-reftable-drop-git-compat-util-v1-17-6e280a564877@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-17-6e280a564877@pks.im>

On 25/01/27 02:04PM, Patrick Steinhardt wrote:
> The "git-compat-util.h" header is a treasure trove of various bits and
> pieces used throughout the project. It basically mixes two different
> things into one:
> 
>   - Providing a POSIX-like interface even on platforms that aren't
>     POSIX-compliant.
> 
>   - Providing low-level functionality that is specific to Git.
> 
> This intermixing is a bit of a problem for the reftable library as we
> don't want to recreate the POSIX-like interface there. But neither do we
> want to pull in the Git-specific functionality, as it is otherwise quite
> easy to start depedning on the Git codebase again.

s/depedning/depending/

> Split out a new header "compat/posix.h" that only contains the bits and
> pieces relevant for the emulation of POSIX, which we will start using in
> the next commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
