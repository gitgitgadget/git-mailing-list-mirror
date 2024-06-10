Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092B142E62
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052772; cv=none; b=JO/AYq0VzjCupVjP49saTjRKHjzV40+B8Xx85IAHfaEJEjPKd0ufimUV55sSzK1ax9OoCYm03L0BoLKyHFwox10E+Qgbv1/8cB9ejTIVVsdAAKl8P4yrpWP2GQen+C+X+wvboWps1Lp6H1aUZb5a6I6/74hSOl3kX2CutO8+U2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052772; c=relaxed/simple;
	bh=uJUV1BGKeC6x43rQKKBhK9USr5t2JMQdU+nUo+3MPGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB/PLB4nC9aRxSUgFgxWKx23/p5bohPGnP40+6Lzi8qPbqCclRATl1aZVjK4+mYf/uO7wujVKP27FJgNFdZbd4BFRKP5eQhR1PjO4atvQhslJJLcenEpz6sH/dKCOyA2d7H68tP0SJVnkPjDhm2I2lLRu71Bwe/Q37UQmTtZEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNRVg5AH; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNRVg5AH"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6ce533b6409so282418a12.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718052771; x=1718657571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUJoGwUkWjomDlXVvQGbN9CycDLSyw8GQ/2SR32U2I0=;
        b=WNRVg5AHzrEV7FF5A4uYfKa/eCcqZCpaRZt3VmLqwHpHqb4i2cqvUEiLXG8Eg7qoBb
         73wiAkA+80ALEFUhd9YWEqmsj0s3mlLDg7meA8bzZP2YniSuGC3fcJk/nDLoguVHLCaq
         tocdghzuIxKxEg33hnw/FH7Bbge00tY5ks2/hCmK5kOmF12DuAps6efIUcfnlLti3j5c
         B7ojRzGiPVObFgJFuUCeqnJORxz3C9PRfXpxPCcmWad5K0o1NH63oEn3hK7TMt1urc0u
         C0ugtHc5nyZ7peltvTXrF2cfuamAYor6PDuEL2Ne00ZGadcV1BOR8jlERB6Jsfmg6F1F
         pc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718052771; x=1718657571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUJoGwUkWjomDlXVvQGbN9CycDLSyw8GQ/2SR32U2I0=;
        b=UTfvqYVRs/6xFvLiNc/+LD2dvxwpxxiM0DH92EIrMaq0Dim0YJyfWecNyM1D2QPmon
         GmbZzlWjg/2ECi6lOFrNp/rredRuHZLseSkxqhNowk0ge0Jlbb+QQElWclMxHBQ9TPKD
         74km9skEevJsSaOViRqxRvGBakcrOgQLTszrw6QqQyYGHRi9l2H8rnxjfxaNLcXL+0PV
         DYGP2L4+Owes8mI7xp4gLnFScUZrhU8KM+tgAckTiLOzKtol88Lr9aPZF/RiWkAq7Xhb
         iY3+/CrPXZYnVZWoEU+wwji8Mcl8ecHU5sL1ibcQ3Rsn48G/2JrlnLYGZGAYXaYMUn3O
         TueQ==
X-Gm-Message-State: AOJu0Yz0Ex8+D/2XzkQXJzc5w9QAnT5oe64WvdjBxQjaAwexrv1764W/
	NwTW9tOdkLTIzi3HEB9Itvjo61B5QFw25b/HbZHnl821jOEo/idGJB9dj/kl
X-Google-Smtp-Source: AGHT+IFiFFFm4N14eTFmgiF3ExBMSp2/pt2A+hXF1jQO/GZYuUwsVn+KfQB99vqcm7uqquKuIYrDUg==
X-Received: by 2002:a05:6a20:a10c:b0:1b5:9248:d223 with SMTP id adf61e73a8af0-1b592581f37mr9124348637.46.1718052770536;
        Mon, 10 Jun 2024 13:52:50 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7042b54a6d4sm4080551b3a.82.2024.06.10.13.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:52:50 -0700 (PDT)
Date: Tue, 11 Jun 2024 02:22:47 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t/: migrate helper/test-oidtree.c to
 unit-tests/t-oidtree.c
Message-ID: <72dncmhj2qt6ufh67gbj3ctnwnssnlc3w22x77chcigzxou36f@mnwnrwg4oo5r>
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
 <20240608165731.29467-1-shyamthakkar001@gmail.com>
 <xmqqed944uq7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed944uq7.fsf@gitster.g>

On Mon, 10 Jun 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> 
> > helper/test-oidtree.c along with t0069-oidtree.sh test the oidtree.h
> > library, which is a wrapper around crit-bit tree. Migrate them to
> > the unit testing framework for better debugging and runtime
> > performance. Along with the migration, add an extra check for
> > oidtree_each() test, which showcases how multiple expected matches can
> > be given to check_each() helper.
> > ...
> 
> Use "LAST_ARG_MUST_BE_NULL" here, probably.
> > +static void check_each(struct oidtree *ot, char *query, ...)

I see that you already made this change in merge-fix/gt/unit-test-oidtree.
Thanks for that.

