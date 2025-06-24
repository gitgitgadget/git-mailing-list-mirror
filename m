Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97D3074AB
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781293; cv=none; b=S2qpnOhwJk1r46AlWWmF5YLe7sHzpUoqmbLNWS3r9btDB4aibt3JhDlzvHTIJeI+MaWvd7M7oynycHZCw3XiaeHWN8J75ASWPqBRuA2dkf72i3flhmJCFpDNQIGc7M2x/U5tyc9A31gXdR5f+fB/fXoF+rLOgfriOuHlAkOmWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781293; c=relaxed/simple;
	bh=yQiZy1O/NrQOmf0ErtOQPpP3LZwjW/C28sxQyJk7Bh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mA+WseyxH/H/xf31hyXGw1ymWLQ4ubeom1pM4yehtY/hQnIQ5A0CzTQt7iIwW1CDoNZLWRMnE7Jbg8+wDhCyI1F7EJ01lL2fVs1ZkeKRPA0sAOOiGbo+kSGcZVqFH+AlxfYH/XOl+ppKZWbFJ19NNsT/KAn9Se0Oi1GWO9mIxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=AWHPrb8Q; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="AWHPrb8Q"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8276224c65so624513276.0
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750781291; x=1751386091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9GC4iz3IBltaAL2Iljfj3HhZkg+yyrv8EZY/WdZvFGA=;
        b=AWHPrb8QuZA3+i6+xBhnUy2VrkihOcJNAgZHNDQoSsWDZ0si+i6VjD5u4ppFe8q/Wj
         Z7uZoszDkp+gIcfPXwD88U6LAeQCnUfoQbug0wTUVHEOtDQD4vgAJF6PJPKzpHJAOcw8
         nfbGBpzvlEqGLj2sE06DlJYRiuZEvsfhuyLbdt9+xVKPsd4Ox5MFC6ReOH7NI5zgiDTh
         zJrXEx8WR4gU+CX5h+a6qymPAhdY/Sa75Tw+pMbrw+LYWoRIWZhcmcYF+XiZDwM75BkR
         MNVJFApBmj9tBxfOjFAKPSn0ct7NdJrVQQMWCuXuSaf75fYwMDV1KPP8ZjLgNXPgvmWI
         52jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781291; x=1751386091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GC4iz3IBltaAL2Iljfj3HhZkg+yyrv8EZY/WdZvFGA=;
        b=A2UWZ+2/YKnFEOw3xZ2Kj/NZvr/nHK33rpR0mbbjlwpI67uJo8DxgdFYGzhY3QxNnn
         QbR2SZBChTLLzL5kbiOG0nbnDKtUmhg45ApONCW1GVtrF4KMj37VnMcvp97L45dWMq2t
         UPNOlEK4/dgAHe0BTlnOadjb2IwZolQrHXPqGTh+ML66Ug6hP9eKH1PcwnEbJOUr0LAk
         5xfPy5XfxHxUdm8rEPwWt485kqaWRhNUE/6lHCYukEemddcplh8CXlczDVoS8YKEhWrc
         516minPARmRjJMeeRsUt0HT8Fd8iar9367XBUUz/z7xLPAzgKu4UqG7PwvyC5cGNoPst
         2Ldg==
X-Gm-Message-State: AOJu0YxL0PO1sscJ3yuKsDOWmliY/j+vWZiALAeuPZXB3PNpN54zwBve
	o/JbR7UHPZ/VHvm8FNenthbuRcsURQV+i02i8zcjSICu8FZ3E4i18mvCzGYyEh0HeDE=
X-Gm-Gg: ASbGncuDxtcVmckYb3fSw8okYL7yjFJCLMvI0PFBd1Ds8d0whB1pmxx0yqeJE1ZmYR5
	hbLNg9dv1+/mNcUfxp8buQnKKBWVi/9NOys6fp+Vuz0oMWNw41eYoq6/d5J6Kv8rZfYevAHoJ4o
	rARqXEXRZguXXS441kJQ0mpLQBBYFM8bti3V+0WCfc91E+Ehr3wHdLSWhoF6gUPJSRwOCF6kX87
	HuaOf57rlkAjj+uuDoT2Gf8IKEBmC2oMEg9spo44Tkll12Hd7v7OzixiK3iYQoI9YsX2LbHgTC4
	WpHhpx/f43Vh91/ZQsHd9RPQmc5dq20hRBilRaW1+uff1f+fbUQB9KMGJSaW/zyBmyfnrONSDDS
	1AUXSP4qW8W7a6f0q5kQYHA4L2Bxq2IwgtdZuNdIIlc+D
X-Google-Smtp-Source: AGHT+IGiY4A4c3+j53LoCyqBuk7gvZqXfCtzt9zk9i5DRgRavdPi8/NWHw/8qoDdEOaQzUFoz+mfzw==
X-Received: by 2002:a05:690c:fc5:b0:70d:ed5d:b4bf with SMTP id 00721157ae682-712c6517874mr243524927b3.24.1750781291218;
        Tue, 24 Jun 2025 09:08:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c49d3ad8sm20513477b3.10.2025.06.24.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:08:10 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:08:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 5/9] pack-objects: perform name-hash traversal for
 unpacked objects
Message-ID: <aFrNauEk9vRq27+t@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750717921.git.me@ttaylorr.com>
 <6b0149a32d300268d4ad870c7cb6597a95e0410b.1750717921.git.me@ttaylorr.com>
 <xmqqikkm3vki.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikkm3vki.fsf@gitster.g>

On Mon, Jun 23, 2025 at 04:08:29PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Now that the 'rev_info' struct is declared outside of
> > `read_packs_list_from_stdin()`, we can pass it to
> > `add_objects_in_unpacked_packs()` and add any loose objects as tips to
> > the above-mentioned traversal, in theory producing slightly tighter
> > packs as a result.
>
> So the idea is to pretend any and all loose commits as if they are
> at the tip of branches?  By doing so, we ensure each of the tree and
> blob objects contained in them has a reasonable path-from-the-root?

That's right. We had previously only considered commit objects in the
pack(s) being combined as possible traversal tips, but this change
causes us to do the same for loose commit objects as well.

I do kind of wonder how much of a difference this makes on delta quality
overall, and suspect that it is highly workflow-specific and likely very
difficult to measure in general.

Thanks,
Taylor
