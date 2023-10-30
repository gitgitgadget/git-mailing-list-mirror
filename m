Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24805199AC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lQECiK+S"
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D02BD
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:22:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77386822cfbso320857285a.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698686520; x=1699291320; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ge/1AsTo3rJ1dpfaGrjqk4oY9cRrtSeBmALzwywC0Ds=;
        b=lQECiK+SoGrYUb9ABHN4eXqEU+tzfCheIzOUyhb2ahDUu5gTw6SeyucubIP+4rTPwH
         tRxw5Zv5Ee5GbhlOea1Ws5DbnX1cX3aPeisF7ZuKxxL/F5BKFYsCMB4naDSV89Z4o3xX
         51Hm7kXlEQ0vF3bGbiCBropSVp/DqSWWiSI0380V9Mxv3CIJWC6yowlYK2UyWt/SZZut
         SwGkttwfWm+zBAJWilA18r2mGjmWi4zuhVLg44M719cYazbh7BJsvUmuUdKBoh8EJoMA
         mPvpOl4YiPu9DRkTFELGaxjW7qw1n60YeOtKEvS2xg8z3ovKTquhooh7CumscgdvmpHg
         e16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686520; x=1699291320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge/1AsTo3rJ1dpfaGrjqk4oY9cRrtSeBmALzwywC0Ds=;
        b=j7PDRxPaWJw3lwgDhxBm3gPNF6pK7kiXGc3hfONd8QzatXmkW6rOQmiQKeeaSa64rg
         KXoZkgOiaXCsRDBXDPp9aJuNjerTBOdbuH9GQVFS7TUW8+Hz1yjnTvhQJBntepq0qDLD
         qSWm7TbiE9cZKj4X/FzE9+CBC/LTpqAgHriwKzUhXKGDzbW6MQtq6CSPOR4IuME4kg2k
         2N/StIVL1Vn/NuNENUf7nv15oHeaP8KBHh4MEfVFvL7Z8CNyBlDa0NW32P36E8JvdUzw
         Pt2t4eCUXoRuubmwZREkh0vi/alUtJh+WD3M46MtOk5aMYI9oUxOaAOoJoGRzZSG9Imq
         zWRg==
X-Gm-Message-State: AOJu0YwhUba1TAEtZbg05JNJikdW0r//7150P+O4J1wBecdjS4nM8cij
	fQp/lQTRfhk881nIYF9dRt55PyGptSvEe1UyQcMvBA==
X-Google-Smtp-Source: AGHT+IETGVGkDqAxNS9JcyEK717tsMS2Yk8/iOx8QzGBAB6LwuS840cYp9ayEZnMxgPzOYnZ+Y+55A==
X-Received: by 2002:a05:6214:20e8:b0:671:d2a5:316c with SMTP id 8-20020a05621420e800b00671d2a5316cmr5222539qvk.42.1698686520394;
        Mon, 30 Oct 2023 10:22:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o19-20020a0ccb13000000b0065afcf19e23sm3539737qvk.62.2023.10.30.10.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:22:00 -0700 (PDT)
Date: Mon, 30 Oct 2023 13:21:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reflog: fix expire --single-worktree
Message-ID: <ZT/mN9RouiqzL9aT@nand.local>
References: <63eade0e-bf2c-4906-8b4c-689797cff737@web.de>
 <xmqqa5s1hxhh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa5s1hxhh.fsf@gitster.g>

On Mon, Oct 30, 2023 at 07:31:22AM +0900, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
>
> > ... and added a non-printable short flag for it, presumably by
> > accident.
>
> Very well spotted.
>
> FWIW, with the following patch on top of this patch, all tests pass
> (and without your fix, of course this notices the "\001" and breaks
> numerous tests that use "git reflog").  So you seem to have found
> the only one broken instance (among those that are tested, anyway).

This makes sense to me, but obviously won't catch non-tested cases.  I
thought that a new Cocinelle rule might be appropriate here, but it is
frustratingly difficult to specify a constraint like:

    OPT_BOOL(e1, e2, e3, ...)

with

    !(e1 == 0 || (33 <= e1 && e1 <= 127))

I'll think on it a little bit, but this seems low priority enough that I
don't feel compelled to urgently deal with adding a new Coccinelle rule.

Thanks,
Taylor
