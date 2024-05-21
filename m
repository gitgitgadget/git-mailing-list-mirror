Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36869DF7
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318370; cv=none; b=rLIv7Osa1pYCtNTAAb+40Rkg24ku4zn+YJfaFtY+c9kjcZX0TiHWncOe/AzFIj78SkHJPbHVfTIUFFnKwt+EDF5VWzLdZ2juc/BTEpCQ/tiOLxJjvQZ8vYtgbpU7sWbbtC+vLf9BaDzWAMvU/200VjTaf63we9sAN6xs2qng5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318370; c=relaxed/simple;
	bh=M0wJ/i8z8/aMheRyOwnSOfPVwGwJNjU2UZAS37LEC/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC6vTOtzKcsMpgsQdvhpU0NqweDFv2OvDM3iluapsvUD1+PpjB5RSK725yMhyeCmCZgy+pN6YfXLZ5Rs+By0N25yZtf8myHurb8Z3f83PZ6cDJMl6Q/OL+WE7KDKhx1kcdzf5rSmkYNPhDj4s/tE+ei7kYgX+u+/VN/SoyjIwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1xGqXOUX; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1xGqXOUX"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b59c10720so2781666d6.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318367; x=1716923167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M0wJ/i8z8/aMheRyOwnSOfPVwGwJNjU2UZAS37LEC/Q=;
        b=1xGqXOUX9xh1AKj4OWgspr2jz1O2PCTqrA4Y3kIITr8UZm0y8nNAjvwKMaIz2bK5CN
         egyEIVx93O27APSPksUD4oGnBCH+PUo/IlBnswGZytdwT8KMvUcDCuO98Aw4tcmUBYmn
         fNlDRnLd1gWrr2fKnMNJZIMoRCDtwkIOyE6MP/fI+aQssPUZXsmbuhfK1dI+Yfl4vsF5
         3lut97c0l7+K4QewCVAPE0RnD/8TnXOu04i9LHtI3YFH32wVFNXa/vOzHtnF/rwCkJPB
         d/Uub8WMVK+bVRx6FkiEszEKD9oxqrfgJSgdqPVbsqi965Md16VXzG8Q5m038/hILIzy
         DdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318367; x=1716923167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0wJ/i8z8/aMheRyOwnSOfPVwGwJNjU2UZAS37LEC/Q=;
        b=AtJWb6heCm4nbcET0COE07GTY1pv7Z9M9xw6iofKBb78sOGTnsHJUGb4IzVy3+SnVg
         qUBZzlDxsMZa5T82iR+w3diRvm3kRnBFoBrGXFqV42LAjLkKnRAvPYZeEZy18zBI/uV/
         XZGrJDSlZdsdVXvRVrRRi5WkhEycDt8Mr3hAx+Uyy8YNdtHcOIyUJ7VkCITMD2Hkd8sp
         OrN0sr5k0/2PEcAsn4Pp4N1ptWzDVpXZkwYMnJLXgHhhcC824Anw/5vbl2zts+p+W6ys
         zIiUEAam95GSZCDIaAKRYvkva5kA8LI+18FTK7b2UNuZSf0z7/ETtGp+Q4/rIjAjSIQ1
         RnJg==
X-Gm-Message-State: AOJu0Yxihr6UAEgejhzeKv/2Zv4QPe5NmkTHmnrV44K2+eIzkmYT/d4a
	TaJKnT5+NXKHQEEHxXX5meKTrl010n++ywLAuh7RRdGfjXhE3ZyUR3ZyH1Bt2E3R6SPorvohQnI
	z
X-Google-Smtp-Source: AGHT+IH0GTQBEtiQhijXfUTvmnjYfENj4FG5cyNGURIHlVCjV89WYbNpD0lHaz8487OoExi3mkvVyQ==
X-Received: by 2002:a05:6214:554a:b0:6a9:702e:a52b with SMTP id 6a1803df08f44-6a9702ea610mr96823296d6.52.1716318366911;
        Tue, 21 May 2024 12:06:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6aae9de98d6sm20588846d6.4.2024.05.21.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:06:06 -0700 (PDT)
Date: Tue, 21 May 2024 15:06:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/30] object.h: add flags allocated by pack-bitmap.h
Message-ID: <ZkzwnJQRZqFGNBr9@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <38c96fc1909162a4d9c188f55b7c708cfc1b14b9.1716318089.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38c96fc1909162a4d9c188f55b7c708cfc1b14b9.1716318089.git.me@ttaylorr.com>

On Tue, May 21, 2024 at 03:01:48PM -0400, Taylor Blau wrote:
> In commit 7cc8f971085 (pack-objects: implement bitmap writing,
> 2013-12-21) the NEEDS_BITMAP flag was introduced into pack-bitmap.h, but
> no object flags allocation table existed at the time.

Oops. When I prepared these patches for the list, I told format-patch
that the base was origin/master, not @{u}. The correct upstream on which
patch 7 and onwards is based is 'tb/pack-bitmap-write-cleanups' as I
wrote in the cover letter.

Junio: please ignore this patch and apply patches 7-30 on top of your
'tb/pack-bitmap-write-cleanups'.

Thanks,
Taylor
