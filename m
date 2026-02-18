Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2560123ABBE
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439794; cv=none; b=d5OnSCGOCdf54gDhj3Rr4qSdiAZ88oipowij/52QBXUVcnDHzeGuu8t3vw7QrXz1froPs9OC4QKykR/ohCXQT/An571dJwzF365LlAOs0RUa2hevWleAufrgl07CLjpDA6vY00D4ar5Z9wYyBQs3D9JfUK72sYOG9BNvyIEnWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439794; c=relaxed/simple;
	bh=OYb1E8Mp24jUib50TRdpP5cmAgumVvOXT3LevI9GFFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgFJSjq8epnwRwdNYgUqCIFsDh4ITgY6qK/n025DvtIfPUfHiDXbxdHJXibjAWQuUz7LdA74G4+aYEJy6oVEcTZWd3c7r4W4efTsJ8PQUGMitclUOu0XWUfdvokyxd7aeFl6YCGNrQaATcibzYZWTfeWt9IO77G3gB+JbJeHurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LAngKWwT; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LAngKWwT"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb39f64348so11339585a.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771439792; x=1772044592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72cmCzf4PEANDdtu107P8Gr4QF7LYSiGlbLbH8jSEBU=;
        b=LAngKWwTJ7lwOo0j67CWzwoyW2vDbSnrd6FJLbq8Re9Yu5sSfh7xkVNA6aKwAOsQIB
         GBuhGNG4xJgsTkpX+OlZLDyktob/anaVEJvZ6rR47t1iNZcMcCLwPD/SQAnuTdk+7Bcv
         lyZVz+Jk4WsGdJvlhJ68KP4DOMs8c5HOnT4NyO7u2/L49CKS5A5RRxFJSfYoHb5wkCr+
         2CcC1+ycOECEYWryJYbjfVpVxtpQrcEJ4hZGlxMEqCy5e96NKx58EL4wOU6EuPJGosow
         aBpB/UaU8caY4FOl27gqAOyyMes9QmBYiG9iF/uJIbtVZsQ6K/0pr6WKLhqNUk2km6A3
         vjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439792; x=1772044592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72cmCzf4PEANDdtu107P8Gr4QF7LYSiGlbLbH8jSEBU=;
        b=DzuKb5EN9yGp6ekhdHKkndeTns+JrIJpZNRGLwzM+uarXAsQJu81SiTraJb3Ch7Sso
         eeCZJTxrLiFDzBrZ1wY9Ne1fyKG9Ln/hexfruSBQduTrgeTfmmoX2KSA7//TjajRWoB7
         DabXWIDQLG/zVGfv+GCPf3LzQvcNIC/3F5W6V3nLxVs+B0T8QDnM3gN9oL1YeMK1wQyW
         bvY3PyogBs9KfeEN5kIvh58+VjepbLGmtL5a7qmaTbfMrHA1Pz0uXAgwAQVvYdRFrDhp
         Y0VeazFr5Yy9C5b+dvQH++m0QzY72Tah5ncvRL70dLxDglUXZgtBQZ6D8Il+sFGfEXAD
         tA6A==
X-Gm-Message-State: AOJu0YyJ4zI8y2L3PtsImn9+cBPpoOmPPZbFiXJddv0xBYmkxLImgdym
	pW7p9AlFELm3VdKuwPlWcKTo1SS0EgKuHa0dRnXRU1DlQPmV70ciXquwW/QzBQYJXGs=
X-Gm-Gg: AZuq6aIujrP7Vy2A3w+qvkdyVZTDku0Wqqska7QHMNLtPgfakzwpJZTqOTkcIk5K0IV
	6cRuB4WcP/w820eUn1qwGivsxw/lt1N0eleDuXX823KJ2oifj3nD68GaVofz//2XW8/fgi09ANz
	XQpgQVdzPb1b9ywTbJhwz2qI8Do6+CAGTcdPK2QOdD1dCQPWdC4pC/DM+zSYetFKB3feCRCOS1e
	fRdQmDgoJu6fwHo0aaDJ5DXSqWtfv8Sjwi3wvUP2DoZyPsz+GEs57yRS8RS3ZXV4nT4/ZFToM4R
	eA/AeWEuU7//jwVRoNWKhAQcgAulbo9V60wFwoEhmhbBdBFuwLR/szmu3NuOCLcZrZumrlnPCzA
	JE8yPzjeF4PaCrsJEFJWfkfqstPAYtnltfpq7asuFoxojFsDbOCE1B4mDHK94N3rfHoGtDjerGW
	Upeipvvm02/oWVgD2OXTdIIXa8F4CLlfg5pNGFHk4J1gQj6oxxToGhGDMUXS2XS2uCYUrTSu9r3
	oTevSj9jBtDH515GS690XsM9PxhBw==
X-Received: by 2002:ac8:450e:0:b0:506:b77e:5431 with SMTP id d75a77b69052e-506b77e56ddmr119873511cf.55.1771439792082;
        Wed, 18 Feb 2026 10:36:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb3916f4d7sm1849211885a.6.2026.02.18.10.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:36:31 -0800 (PST)
Date: Wed, 18 Feb 2026 13:36:30 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Fix misuse of `refs_for_each_ref_in()`
Message-ID: <aZYGrmktI6vwp8Ow@nand.local>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
 <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>

Hi Patrick,

On Fri, Feb 06, 2026 at 08:49:55AM +0100, Patrick Steinhardt wrote:
> Jeff King (1):
>       bisect: simplify string_list memory handling
>
> Patrick Steinhardt (3):
>       pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
>       pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
>       bisect: fix misuse of `refs_for_each_ref_in()`

Thanks, this version looks good to me.

Thanks,
Taylor
