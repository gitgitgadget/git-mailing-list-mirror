Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE81F80CC
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020393; cv=none; b=fQOu3YRi48GdJrMu6R5q5S6plWtsO+wXQ0kgyGJAs9kNuQqrG2n0bI7VCHpw8/GWPg3kXn1/37hv52VZUXqcpkPbTJU7t9xs2wnyqehC1v0AY3cQLhS8rcb49QeISYj2vdb+WmKe4VapKPV//Jx/26Pz5wG7/FK2bAJ139tXJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020393; c=relaxed/simple;
	bh=LBxfJdWoac7fXIAC4JqXie6o62k2osZUf+PqbOnwfso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Huysdr4MI0HLykmHCbbv0krMRuw63tJ1plShD3Cp5QYucyq+ykqxOFwWbL3RQ2wzkUx3nPSZRA6wLiTa9JIkPQUsBxwIjrn3eMrveetxLS3xvciNkGO8PS/aZKW1JhiqGGvCdFWL89x9EnJKlyer+VkbcGveXZAq3PH5O5OMtrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TyRcUyUI; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TyRcUyUI"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso5018745276.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729020390; x=1729625190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LBxfJdWoac7fXIAC4JqXie6o62k2osZUf+PqbOnwfso=;
        b=TyRcUyUIS2eh+fZ8QIiF9XjgWz4fEWznq8LhbIJI0p2GQeV/UJ30h9AhaYOv14nEIM
         4O7oO+pcjov4MsB1W/GthF0vYX+zKVvwOE+U8f2J/PXGZTIgKnRb5tpHVLlS0OiaBg6s
         WQKgZUbMYL05N3UtntWvpkwP5SmfEY9it4b4O1XszWoSZ4bUr2023po7XXMyzoaE0IL4
         GUoE5D+LmymInr/3aSaHW2zeh81WEN83wiN9griAtByTBy2QArYUtKPpKDLIURtdOyie
         0+Hign8o9pw6yEuREfo0qb0U8AXppL1otj+6IYnkQbPD4nez4cKIgXqCXcJtStUXeGR3
         bdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729020390; x=1729625190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBxfJdWoac7fXIAC4JqXie6o62k2osZUf+PqbOnwfso=;
        b=k/DD8yajjuNbom4wYYKhDAlD2HENmocgBw9MbNP+SBhxO8D0oXRnsL+2KxWpEHbTe+
         A+/AppJ8cynyFcGlMZvtrXq30s891SNYPiKn2/JDfbPzncavTYFAwwJBYXQJ4eXaRmc/
         YuVa0ra25bfc6yEYYQ3QqdippB+nDj56RlTbLC5koutr2+vIMMULtGa7GH0mb4gZ6U65
         PBLAxtJ1p/N1vPglbobtqBEhFRWVb2YCwFhW3rb6/C9HpsTsep2aC/99WlsbYXyKlftR
         dwNQvy1hXeAIXoFdump/OpgGaVJK9gGgMFNkKka4Kl4e3ikJl1h8U39c2LBc0JHPTSje
         0WRw==
X-Gm-Message-State: AOJu0YzNVOrEUtQxfFY3ciOotkf20ZcRZd2Xsl5wdEh6JrIDE1/yYxRJ
	f8TPbz7quAUpVOSWTQSLpmn9u9eiq4AORA0veL5ArujActtG9YELZIGBND16F7fvOorV5awpsAj
	K
X-Google-Smtp-Source: AGHT+IFt/B5n1/Ho8nBnbGiSHhqSeXPFYF1/qMm7XQh8uEsFtlpdeS+5Dml5Niu3DuF9NnitE3LCRA==
X-Received: by 2002:a05:6902:990:b0:e29:10fe:1fc3 with SMTP id 3f1490d57ef6-e29782ca013mr1808059276.2.1729020390631;
        Tue, 15 Oct 2024 12:26:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfb079sm335567276.2.2024.10.15.12.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:26:30 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:26:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 02/10] reftable: stop using `strbuf_addf()`
Message-ID: <Zw7B5Y1yUu0rt8zM@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <6a7333b275e9f7eab81568a8de939011d292a31a.1728910727.git.ps@pks.im>
 <Zw2b5+8Lw83ywhzk@nand.local>
 <Zw3xnFN_c7WSz1u8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw3xnFN_c7WSz1u8@pks.im>

On Tue, Oct 15, 2024 at 06:37:48AM +0200, Patrick Steinhardt wrote:
> > Part of me wishes that we didn't have to write our own `reftable_buf` in
> > the first place. Could we use `strbuf` as-is and expose it through a
> > generic reftable-specific interface that users of reftable fill in with
> > a vtable or something?
>
> I tried that, and it felt way worse. The amount of code you have to
> write is roughly in the same ballpark, you don't have pluggable
> allocators, you don't have allocation error handling and every consumer
> would have to implement their own type.
>
> So overall it's only losses from my point of view.

Makes sense, although the end result is somewhat unsatisfying.

Thanks,
Taylor
