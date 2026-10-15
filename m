Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D253C109C
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079284; cv=none; b=Nv2Fz2nsXJehcmxmgt2Qs+iaHiMPrHXNvnqpSMiXLNgsKpSNZQLwAk4wvsm3MAjvzIvzaXL/sea6If5jjFO45GBMktxxhMhcCVIPSI03hBRMRBnRyC/HBK2kr9YFLRi55SOePx4Dcc+DiUcLNVB36B9wLUh8IJHPRcD74tTjc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079284; c=relaxed/simple;
	bh=YQD6EFSB68ItxQk5WwqS3xopn1XCxc7axAE1JMlr4GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQIY40oS2p0uZ671KxccmblkVRGPpa7sgLGP7j53MoT/KjGkH7CdYcOCjAW6WylW+s5VzbEA6OwNwtV2luT90/JJ6dvLhQDGzcJFuUVJVyPQM6iB66d0iKiNPdsEiV+tjETnB6YzuyzIxKvcMLeQUzWYLySYMoNPuQ6/VfxehN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qv/X+KP+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv/X+KP+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so101692f8f.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792079272; x=1792684072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jVtf4vVX509yLPYnCRgOWD171v2/ub+reH1QRfxESeg=;
        b=Qv/X+KP+nPvLamAbpNtTiomIKom4GlIkJNHrIJV4Urb1j4ULZq7z8L6BK0oD5aSjJ0
         kDfbNrdBt1UA2ICP083a8888hE26V8knfHV304b1LlWHpISIlUD7HpSj9nWd0EMKSoHl
         hHpeHUiUxdzTuvNnAjGd85zd47HG7HlKJqRpwheflPY/KTnjDeJGzVMKXlwDCjgnYQ0W
         tVE6RxzcH+mRlFlWchonBlyrpLY+Xek3Hj/PIQykH2uVfniD6kO9qWi6kmLNpGV1hPJo
         XOLI5BHFM2y9mIoGKhGnTjuAzWEFajpgIKF6b0hmRVgQvOKjrV9sz4EdRcN3JrY99g0C
         PfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792079272; x=1792684072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jVtf4vVX509yLPYnCRgOWD171v2/ub+reH1QRfxESeg=;
        b=EyiRcCMNO4mQ+R8TzC6GZEqcik2OtyjV5MzUB1mZwWV9IDqn4pfpmdDSdd+BApZGx9
         qvoSeD0gg+ktc8Jh7bT7ogNYcOuMlOY5sN+pIW3seoimd6BMnAZl8zklWwAT7vmIRHTy
         WyJMwBFG6ru+8tBwoY0tx/4EPI8f2t6U4Yp8QKo0IBXOk9APxGEfeO0v4HFFAnCVYWNd
         FVXq6CgW63VfAIoWtpBJsmyGxUKCdqgEPi8QNy2rqUx+dxpYI1+5gUeDAL5a6vrg7PNl
         J4vEua4fH2CUOD87Zg4GwXexCXeccnbxNDX9XewJa6tcQlmYRF6w0ll9ilVyEZmXY9hV
         Zegw==
X-Gm-Message-State: AFq9FYIyn2hq1CmDk9ZK5/XYKF9ugDa+eC+EvOtzsKiCYd1npkpzRDc5
	Tm2nM95IAnTaZ5DbcgEC9RsWLeHDB0OXIze7UJ+OfnyI9KRkn4LLqaV8HbG7pw==
X-Gm-Gg: AYBFou0W/CCg+GewiZShbQCD2cN5Yk1FD4R/+TI8zehS0e1bw/v8jxqPPf5XE9GOGt2
	Mxm24fZoLWcnh1RRMHzSDwqiSt+AgZBkdi/wA5TRnbBrFjs9vP588wBcXFer11/WJ/QVsUAkUI8
	29jgQ2zX+q4OQtNraSqTqGzFCM24PKu1KCTCbTcmjwvXpYzhqjykRgqcpZ/KwaNAjPS2UFII6wV
	gOjKLK16JhTTIUfY2ajojgqLLN00A4kZtq75q5EG05TX07GLntwlxGXfwE6bNHD1MT/Ptnwgwyd
	ltAa9R/sKK2OOF92u5rOeu9TQWWslnukmXbTNKuuplg+0BacdSa3938Swsj5d8c1vIWpsQ0hisn
	zRcUDwYuhJqlJJQ+KWMYY23ndaIYef2d8UX/bi0yT8LyG5HPliCaWBL/5sL/adgIRQGmaDVTLR4
	7NM3hS8L5vHIVWaECKlqr70MAg7FAvOtwda0Ko5zz7zuo6FrJlVboAI5/mbzWFkoBTTN2N70I+V
	KYG7C3NxZG8WYQ608THQsqBh0wm/g==
X-Received: by 2002:adf:f0cc:0:b0:48c:58b9:f17c with SMTP id ffacd0b85a97d-48dfae645admr781602f8f.12.1792079272373;
        Thu, 15 Oct 2026 08:47:52 -0700 (PDT)
Received: from Stealth ([197.237.143.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7773d02sm13923019f8f.13.2026.10.15.08.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:47:51 -0700 (PDT)
Date: Thu, 15 Oct 2026 18:47:44 +0300
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com, siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH 1/2] t0410: use rev-parse to get the subtree OID
Message-ID: <atD1oFyLb0k4oFWN@Stealth>
References: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
 <20261014134504.1152225-2-dorine.a.tipo@gmail.com>
 <xmqqcxtcqcfa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxtcqcfa.fsf@gitster.g>

On Wed, Oct 14, 2026 at 01:01:29PM -0700, Junio C Hamano wrote:
> 
> [devil's advocate hat on]
> 
> That may avoid piping, but are they chekcing the same thing?  If
> HEAD had a tree that sorts before a_dir due to a bug, the original
> test would have used that tree instead of the tree of a_dir.  Later
> tests may have noticed that the tree object is not what is expected
> for a_dir and led to the discovery of such a bug.  The new test goes
> directly to a_dir so it wouldn't catch such a bug.
> 
> [devil's advoicate hat off]
> 
> Arguably, the use of "head -1" in the original pipeline is
> unnecessary as 'repo' prepared there only has a_dir/something and
> nothing else, and if the extra tree that was added by a bug sorted
> after a_dir, it would have hidden such a bug, instead of catching
> it.  So in the sense, it would be better to assume that the tree
> would be created in a shape that we expect and explicitly name the
> directory we are interested in i.e., "HEAD:a_dir".
> 
> So, one thing we may want to add to the second paragraph of the
> proposed log message is that the original assumed silently that the
> first tree object in ls-tree output is the tree we are intrerested
> in, without even validating what path the tree was stored at, and it
> would be an improvement to name 'a_dir' explicitly in the test.
> 
> 
Thank you, that makes sense. I'll add that to the second paragraph in v2.
I'll wait a little to see if any changes are needed on patch 2/2, then
send v2 with everything together.
