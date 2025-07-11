Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71824BE4E
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265366; cv=none; b=EwTKHX+QEYBxkYP+ffjwLoZtzTKKA/01Fk/gzQNmQhvcX6PHS++oI/QgZ8ebgHQ59f8fko+euE4oFcmPCfYSnuRvoz7bzp6HRlvvsbgESw8ZLVZbneKnOkViFkiyToRPn64zL/+RXM4BkDbHsx+3AIEIDYlcuqynbtAUetvKGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265366; c=relaxed/simple;
	bh=BAOgde8muN1vuo/vAmBxzD9ru1d/OMUfs0SNZd41M+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMJORJtH6JrYwKDu7tbzXbKvWMBAoL9mkpRWa973n+YFqLezaMw4sEhEY+ocrZYQ45MbJGhThMJFxng4mWsiEpIblYurhVL7ACYu5THXt12XK7mAGpGDYkqsyR7SnXAfdXYA/C4yhcU4fPZSULKOsKA4KlJ5rJEdSfahgF2VRo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkwettuS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkwettuS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235a3dd4f0dso17143375ad.0
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752265365; x=1752870165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Scdg47ttjiL7cKfxA+kFB3wHKL096sZtx53UwctQyA=;
        b=jkwettuSbaVRkIkHgcJRWMOZz+NjCIK+aGx8BKoWUnjV2ILtlDEkwcBWMDd8BWsEBR
         R8BOvyBj6rypUYRuBmCf6BHMvY8eHyRrDyz2uNjvsuo+3mnCfjw5AjfRz0ZgzDxBUFLZ
         VZZfMxzkfrtjowXQKdCUJQ59jWbaJyucql40GHfcFwJxOUhhkllpq56QTYbJv12SR5Qd
         ag1kLIp6YdnangMO+TPBCqUewoslAuanMZNjLxF1w+iRWedMBCN/mcsMrSeKxPj9GI77
         /yvDncXWOl6KecJq4Chul4XJnluXf2KE1yUxzYh/P/PF5XBJSeMy2VSFK73zwARiBaMl
         Hm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752265365; x=1752870165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Scdg47ttjiL7cKfxA+kFB3wHKL096sZtx53UwctQyA=;
        b=wqztGYIZZwpatL4XUJCYDaFbKYVdg4pMi4d/ro7BpgK6bFw0ZL4V2MzJcGGOQy9t3a
         70e2Awvo45JQvc7oxBhpYwZqP1pOK/01hI4+GOv7Wh9NuUXa0JGo1R3SXRWYWhMw3JZG
         Ycnb0TIMK4PDnZb35U0XXGjnjMCOilmN57xRIkSbF07QGym9zwQGL3WQydnfxGKYQzDJ
         +1dXk8ro0wtWnE8Uusvduxf36wcvhTYjdTLEQd39YjiOMh276OzBj0AWajYTRxuFgcCq
         XBjVRElK4ZbXLkobzGE6vTB5uv6Et3PESXoofrjAL3Ll1cnPwnfSolv2wP5M31tyoL6N
         TC0w==
X-Forwarded-Encrypted: i=1; AJvYcCXBVyPUnjlskVPJy2WEJqsxP8c8M21iYkf4gWT/nP9BCRURv51WhPaJ0GPEXLG10h0Npcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8CQK2iad4CBGvNIo+s0QI84mPtJOAERzWyeMILiqMfacpeCD
	VTqYkcilTJXVTzjYuKY022eQBKYFu2GpH6/EzTeZmdLrDBfYPrI90Ex++YIb4g==
X-Gm-Gg: ASbGncs31ti8jyra4p8+1nzH5VFhMyIkyBg0wKLKGpPnXYgYIP3G5cht1/BISzgSBws
	bjUL/XoTTo1i3lBPiCo/fUgKbaqxR99GoEIq2r3uUI9yfQKgjmSD5nNUakXb/hgsnOy7bl9bumQ
	id7Z17X0ngbmom5CmJmTv/J3Sevq2bxCy+xazPlX6KcbisJ09vh4pWM/Sj3A/tLiVCxM01K6+Vt
	2OhAAftT6lrdrAE0JShVI4YlbigtJiqc5yxDoRX4Oi173m5LfmUofjEF269kYXVXYJqcwROxsyn
	GQsULf/BQCjsfgrzlEwYUS4MX61tv2aJSXCLM3fLE4HEzMMTjQjhjgB/wletWAXdFY+lKfNENRL
	V83HetNAJ/e4wdpYevEL5y5WjJRJcCLny7u+MCPjT3RC1/6d4re4cGp/oiOIBYS6bG8syjg==
X-Google-Smtp-Source: AGHT+IEAD3jHhKUZ0Dx62JG+onUmat4U8dlXxM9N6C85MWG6JdCvuhkXSIG2SSsd6iWd7ob0B5jk5g==
X-Received: by 2002:a17:902:f542:b0:220:ea90:191e with SMTP id d9443c01a7336-23dede2d29dmr65999745ad.4.1752265364508;
        Fri, 11 Jul 2025 13:22:44 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:b052:91b3:8fe0:c52d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4323cd5sm51663405ad.126.2025.07.11.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:22:44 -0700 (PDT)
Date: Fri, 11 Jul 2025 13:22:42 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Yi EungJun <eungjun.yi@navercorp.com>
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
Message-ID: <owlvoi7beap4mx2tejuny26xo4jpzzpxkz7243erlhpgu7oa2u@q7fuycw32ds6>
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
 <20250710221641.857081-2-sandals@crustytoothpaste.net>
 <r34i7fhxwbxhppc4ia7lpyr3xqj4tgusaeikaaonpwtywlywxw@ygfmv3f3q67u>
 <xmqqldou1suk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldou1suk.fsf@gitster.g>

On Fri, Jul 11, 2025 at 11:32:19AM -0800, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Looking at `get_preferred_languages()` when NO_GETTEXT is defined, we
> > already filter out "C" and "POSIX". So doing this for the LANGUAGE
> > environment variable when writing the header also makes sense.
> 
> True.  I wonder if it makes sense to do the check in that helper
> function, though.  I.e. something like

Definitely, and might also fix another bug, as IMHO the current logic have
a couple of issues:

* LANGUAGE is not meant to be relevant unless LANG is set to a valid locale
  as per the SPEC[1], allthough for our use case it might be better to still
  do, specially if there are users in the wild setting C and POSIX there.
* it might make more sense to use the union of LANGUAGE and LC_MESSAGES
  instead.

Carlo
