Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024D15689A
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 03:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738640359; cv=none; b=SwiGMH/JtDZuuHTvmGOqQcqVRoW2D1xerX4xtQQWDkXJW9R7gLJMJfQ8AlaQu+wXmRu9EtvTrKUzD0sbDZdVHMVk4ua35Q7PQgKQcuXwvaZndSLxtlq/G52F/dW7EKbuvUsb64TXt/xbWJ96nHC+xJSk6aOFGV3mHe4p/CWQ/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738640359; c=relaxed/simple;
	bh=JAw7RLvNr7a94QCMSJX7J14WSzln7Gnga2vzwFD0rRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/qURZPyps4JQ+oa1fI0v93jeRLj76CoSsMBg2InCeB3Liia8A4IZPr3v6BIOIp8c8BYBS4rB1JWOZbvzGhAzd9+p+/FH3/57/aGPajX4jgOp6AChrCmvRR4k+uKVQ4UrbhdW27TKO43jVgLb29ER3i8DHdeK+dmexzP2CKPZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo51tQmE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo51tQmE"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3043e84c687so44034691fa.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 19:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738640355; x=1739245155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wOsjfbVLGkJlXwWW982m6p0U06ttMDdqjAx8RHfkiX8=;
        b=Qo51tQmEwN1PNGomuleB0nW+a2sj440scJdl+IMxv/W2q+z0bFbhXvHJlSRD48N+XD
         1q9JG+/nMRhLOTM/6zu5lvQ2GaMjFKaVpByNi91VI86QzPZ4vE9EatlDhQegk12edJjE
         K84Ai/wZB6C30EHQCwP2ln+LCni9YS8exrzEfmQsJYZCHPpXcXf7oUDUvnde3JdAJVRI
         BVDmw+eK7Gz7VO0OwxzvhzdvJCNaozJ4NAoz5JCTrtustspvOPgknpd9JlnD/psywk/H
         a3wmhdp6BNDrE0b9RuBC7wrYuKxq5FEu/YprXfjwp3cpH7z2YNX9dXbKGlH67Gh/+/3D
         /Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738640355; x=1739245155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOsjfbVLGkJlXwWW982m6p0U06ttMDdqjAx8RHfkiX8=;
        b=p6EHk3uu7NNxnJJjvWhz/HzIYuVejE/GagN0ZvVCK23kokiYMCAifUXpNDb5Q+yYBu
         FcefAlpPegHbb4AO1egzNeG3h4nhis5FNKRXh+A070wbSV8pOW+7HteTqMJaV2VWeu7B
         9K2HUs/Y/AKrGShnjxqJHUIvz0Thb/CnMQZ6FS4gBcmfA7Jh+EHqxM3h/RcuTrmLQwBt
         qSnFOEWqAmSfoDs7U3kcV9PM58XVwyzoOfit0HoLAfFa1aqsNrVDzYLqBO0XXjMibb9V
         r9hqRvsFZD7N1n2P7wOIlGO9OZHjLOt/S/lmH+6gbyIdOdZ78hbtxHVdAgi9JWd5+NUb
         bpyQ==
X-Gm-Message-State: AOJu0Yz8+nbmi9k8Ssq/L336lhPSBLJcJ5d8lmXkah8Oa+NRKQRHNfQw
	IIRy9C+CX8AuiK2R7s8cQ7Rd6c4vLJhUVNM8g0N97dafPUpl7j+7s8PhDCgmb56zukTCWxLlpYj
	5W5uWWS2IIc2OJLTh4yEEs8CUDx0=
X-Gm-Gg: ASbGncvOboAYzLy+hmppF1PTmLYIDgWUgKJNh6D35QFfeOjdF2o6jhRII9NyFviWPfQ
	Rp1kPRyyvGYAr6EbO8vNO44QWE/NwUCkmqe/xRO3sKM5FkW99AuDY4hEw9TJadwxgR7pBMuGSwh
	w=
X-Google-Smtp-Source: AGHT+IHcbVTsU51EkO521nF6B+i3hPil/PQ7mTbYUTSs2167alKnaF/vulMCvdamXPQoag5nl9NfbT+iwVOhjm/8Owc=
X-Received: by 2002:a05:651c:1993:b0:302:3ff6:c8c6 with SMTP id
 38308e7fff4ca-307968fca8dmr83119711fa.33.1738640354825; Mon, 03 Feb 2025
 19:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
 <20250201064202.76116-1-meetsoni3017@gmail.com> <20250201064202.76116-4-meetsoni3017@gmail.com>
 <Z6BmKO-034bqOCjS@pks.im>
In-Reply-To: <Z6BmKO-034bqOCjS@pks.im>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Tue, 4 Feb 2025 09:09:03 +0530
X-Gm-Features: AWEUYZlaeqdntvyG9ijIIQf6oT2ZT_5Czi95WLj87LYFE38rUgzYJ4YBZSR8ywk
Message-ID: <CAPhwyn0-Hq5WHWvGzhqwafrJqmDic5+_S7hRxShk53d++hfw8A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] refactor(remote): rename query_refspecs functions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com, 
	Junio C Hamano <gitster@pobox.com>, Matthew Rogers <mattr94@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Jacob Keller <jacob.keller@gmail.com>, Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Feb 2025 at 12:16, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Sat, Feb 01, 2025 at 12:12:00PM +0530, Meet Soni wrote:
> > Rename `query_refspecs()` to `find_refspec_match` for clarity, as it
> > finds a single matching refspec.
> >
> > Rename `query_refspecs_multiple()` to `find_all_refspec_matches` to
> > better reflect that it collects all matching refspecs instead of
> > returning just the first match.
> >
> > Rename `query_matches_negative_refspec()` to
> > `find_negative_refspec_match` for consistency with the updated naming
> > convention.
>
> Okay. The message might've read a tiny bit easier if it was a bulleted
> list of renames. E.g.:
>
>     We're about to move a couple of functions related to handling of
>     refspecs from "remote.c" into "refspec.c". In preparation for this
>     move, rename them to better reflect their intent:
>
>       - `query_refspecs()` becomes `find_refspec_match()` for clarity,
>         as it finds a single matching refspec.
>
>     ...
Makes sense.
>
> I was wondering a bit about why we rename the static functions, as we
> wouldn't have to expose them in a subsequent step anyway. Other than
> that I think we should adhere to our coding guidelines with the renamed
> public functions:
Since we were renaming the query_* functions that are exposed, I updated
the static ones as well to maintain naming consistency across related functions.
>
>     The primary data structure that a subsystem 'S' deals with is called
>     `struct S`. Functions that operate on `struct S` are named
>     `S_<verb>()` and should generally receive a pointer to `struct S` as
>     first parameter. E.g.
>
> So:
>
>   - `query_refspecs()` would be renamed to `refspec_find_match()`.
>
>   - `query_refspecs_multiple()` would be renamed to
>     `refspec_find_all_matches()`.
>
>   - `find_negative_refspec_match()` would be renamed to
>     `refspec_find_negative_match()`.
>
> Patrick

Thanks for the review.
Meet
