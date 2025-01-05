Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB28528E
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736058644; cv=none; b=oSaAeIGllRyHOKtT2h+jmLVlTaDMNlJ2H8ogQhhni5Q9znovJ+Si46NY/R4L4OiMA6aqvMhIJBNhvtLlE3GB1WbzXZbEDvrosj/OHYC4SfPe6pFigwKzoG0EiOp0DDCTaONPZmPENeqGwElHCK0ubMQeenCzDyRH6DO7z9Oh8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736058644; c=relaxed/simple;
	bh=c5vlgkZU/EUpLcQYgOWZcc3teB96Tppw3ZER55ZZW48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIyyBSabiJ20/8jVj/YbMxTzISpkzP3GOnbIB2Krs5M+isyJUMLZsBNhdzr6Abvf8GUxyZqbeDM+t8RgxNQ+0ofBIZKAFRX5vpVmUfYceSvMBKvcRQ1mKl0eb0F+zMy7B6+jwuPk+x1wNbEECzeGucYwXxxhEFb9tpSzKJJK8lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTxMpPQ8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTxMpPQ8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21628b3fe7dso183825685ad.3
        for <git@vger.kernel.org>; Sat, 04 Jan 2025 22:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736058640; x=1736663440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9OIGadweMVknPSgftA01LI9njLqH0q1a3x41OmGIHU=;
        b=bTxMpPQ8wiRE9D4J2xcddnGO9RliMOSOoiH9Btjgub+EZGgCj1yFc5VRYjRsMq0fXs
         Xy+p9U0v0Qnt+uufY+JpFMPnHzcoZVqi7a0ZcaHzFHv+FJNOLKBAvnPCdXXfg4aDB56p
         zWmuFmko5bJAjcdGm58/sacOHWEX52rkjc4oyANL3JU6vLIfrNjfrRVHQFtZip10iXvt
         56fbrlNcfzFTuAHhAfF8gHVj1vat6MwOMI2c85aQChDWj98GmuHTe7GEFFv/ltH8OYOK
         Pl7/0KMoc1/O2j/39VY+zYUn2ceBWDsP1UJyaOa67brgj56c54iZri3riXMqNql5uSB7
         h2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736058640; x=1736663440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9OIGadweMVknPSgftA01LI9njLqH0q1a3x41OmGIHU=;
        b=H7Fp0DcQT15uUIl1Ej2F7hAjr1NS9mEi7vhoTDt94I1fQ6Nc8ZtOaaO8ztlmjOCH7z
         CH7DGqCYd7ixOP2NIF1am8JLJanHOkqqMKzoFjMEl5mZZsUg44tYc/1eYVnP6f3qUHSZ
         ffD/8GrqOTIhvOq000720hRFRBvmGXf/9NWgI3rCvxwFJq4a+d2ClMVkkFvhstQ2GtgO
         8chl5GvjadKoNzjVfwTBatdXC0FvyfQ1EoZ+WbOF4F2JK7qwzaKY3vM6sKqHYmjzti6H
         9LB2+GqT+hvTxtU2jkRSEEjmBVXmZ4bShONV8vE63Li4NcVz3FXpoyJyX0Vs5rhnmtQz
         9JoA==
X-Gm-Message-State: AOJu0YyUbFSOtgEfDyQWleQPzyKjtMr1wRsMcjTUXuqEXzlkeNHqEUBD
	QiPoxi3qK56arak+arLqnYd6DOpajc3GoFmJUsQ2LjVgvC6U3xO2L6hACw==
X-Gm-Gg: ASbGncssMQzW2k+yWBJSr8p4xQPpKRIvFfd/oTGuUSxTSxokZpBPddBxh5+MwlznJ60
	GYAdYyl81f8TghmQTkMg6VuJ7qx4ILs+q4GuI63g3WulMWROwSxDlPLrLYud9Mw781UFh9J/TIz
	KB0heG/TdfwyqNmZ5JMWzUejdUvN6KXEkS10p6ikuaYcnzAfZ9HbUauH1uYgtJevIF336I06qSX
	YBYPjX9F4Ttb58XaIBHSsnEezTNZGhX26M=
X-Google-Smtp-Source: AGHT+IHbR6TyYkESGWQs+8xrLctsfUkpJUNJ9N23i4AlOJqN/7c5F6qg4VswTBHHKzJHHs3MrdbAWA==
X-Received: by 2002:a05:6a20:d43:b0:1e0:dcc5:164d with SMTP id adf61e73a8af0-1e5e045824emr98442705637.8.1736058639783;
        Sat, 04 Jan 2025 22:30:39 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c1c7sm29809260b3a.182.2025.01.04.22.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 22:30:39 -0800 (PST)
Date: Sun, 5 Jan 2025 14:30:35 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] ref: add object check for regular ref
Message-ID: <Z3onCyH1ZUoY3Ukg@ArchLinux>
References: <Z26uXy31q83dyxvD@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z26uXy31q83dyxvD@ArchLinux>

On Fri, Dec 27, 2024 at 09:40:47PM +0800, shejialuo wrote:
> Hi All:
> 
> When I implement the code for packed ref content checks, I somehow
> notice that I ignore checks for the object. In the first glance, I think
> I could make this patch in the first of my packed ref content check
> series. However, this is not a good idea which may cause the reviewers
> more overhead.
> 
> And this patch aims at checking whether the object exists and whether
> the type of the object is correct.
> 
> Thanks,
> Jialuo
> 
> shejialuo (1):
>   ref: add object check for regular ref
> 
>  refs/files-backend.c     | 50 ++++++++++++++++++++++++++++--------
>  t/t0602-reffiles-fsck.sh | 55 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 10 deletions(-)
> 
> -- 
> 2.47.1
> 

Please ignore this patch, I will send it together within the packed-ref
consistency implementation.

Thanks,
