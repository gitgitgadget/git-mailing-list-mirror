Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12718BE8
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771438; cv=none; b=uDXcbycKRpkgUxG7LFD2LiPL+6iLFYSZv/NVG5ps9M8PCawQJDR0+o4iZ/NMna/GDhmJPSGXCNobDKTPRaUDbonp4Nlr+QTFSY+Tf4bvoKuHJsZlWrdDbnnbUJW9PltJ8oHEBflnuuwe6AJtgsmi1HWkP2mAuKBrvg9hPr9ucpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771438; c=relaxed/simple;
	bh=ua+/ExFjk3+H68tYPw0oGBGyTGcahaMDxvRetI/17lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDBECi5Hn5AZOS0wcrXsM1sWvzvDNtG4OgTbfrBcyGE/NIk8l7Cp8Dz88F2rBS6hcp8HemCNMrJgTZjE94WUqU+7BvlmDwdoIm8sjzeDCj4Li/LoPu2o3SNt9C6ElSLIiwk164IC4OBHDFyVzFo/N+rNPq9M3gmOy+ErAuEptXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuD6H8Va; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuD6H8Va"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38231e9d518so717668f8f.0
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 07:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771435; x=1732376235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtLTFZxU8lUxQ7m741d59iGFQZ8SJsHD9GjZXPV/+Lk=;
        b=AuD6H8VaqolSIxEjuuQ61BLCZEHtOtcNTipl1/dkzdUV8crFGJy2vCC/gJcizfdzs6
         SuMklolWWjAYeoK7p2m7V8QAr+Uh+Ozzi3sZ8Usc2us4u8FbF3Y+AR4A7ULk2NBS44oe
         1Ed075JUepMSVlvGV/MiyI8u55l8WBRdvJ72PSFiz0pDG3UU3bFGbHI1mxOYfxIaJliz
         XvBUVnh817RKzd7XyDAJvXjr3e5W7I0L2i3tvnxm22keqI5ynHlpwdMswZUBr4yDgIWM
         qaY8ALx77e29+GWDfkZsV0sIFXd9niXkW96RxpHR8L4JsGViD3Eo9a3wxYA2CUbBE3Y+
         GlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771435; x=1732376235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtLTFZxU8lUxQ7m741d59iGFQZ8SJsHD9GjZXPV/+Lk=;
        b=vFULbRJl7ncEKnA6026f315ECITNBgCqDAcZrN3nvleIUQJK15zkw5wF+MS+HCSJr5
         FWlSxHc5xM3WuGG4/NcUZt6hLwyZQCkL+ENhMub0RK1U71MDtXBlOFqrLscIldK9rMY+
         xtZ01EXvUoUKlCmqaQqy7KfKc0bgX0OKeRKs8sZUBC9e3eURLg7kCOLpMmf1Fwf+pDNA
         zR1AmT1pDCfHOBoVHwiK5rlhCoYrkwcoG/qu7ur5FNSJFkbsxiLs/VuZzECd5NIlnLof
         GZBwr1dnfyyvBwsneajo+6zCnsc3Buhnxw1YfMhinxmCeT932UxrxQ+NhhrjaFdFTBt5
         w8dg==
X-Gm-Message-State: AOJu0Yw12r2ZDu3JeYrs1TMDHP0ILztS4WHjaUdXb8YzKsySiSQ7/h4A
	4rXIJQT9F7/oSA908VFRVk21oKNuVZlosyBia7L418T47VwjCb51
X-Google-Smtp-Source: AGHT+IG55edkKRTQEruqzvUrnCe4bvIsQnu5g0pWl+g4zKp/s8uH/FljB9b12cFN+bVXGLi3ZlNZ9Q==
X-Received: by 2002:a05:6000:1562:b0:382:37b2:87ee with SMTP id ffacd0b85a97d-38237b28a3cmr1491062f8f.21.1731771434874;
        Sat, 16 Nov 2024 07:37:14 -0800 (PST)
Received: from gmail.com ([93.176.135.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbe7dfsm7427531f8f.56.2024.11.16.07.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:37:14 -0800 (PST)
Message-ID: <e540c259-df6f-4b65-9066-606beb462f5b@gmail.com>
Date: Sat, 16 Nov 2024 16:37:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Nov 2024, #06; Thu, 14)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqy11kys9z.fsf@gitster.g> <ZziAy187d_VU55QM@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <ZziAy187d_VU55QM@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Nov 16, 2024 at 12:24:02PM +0100, Patrick Steinhardt wrote:

> > * ps/leakfixes-part-10 (2024-11-13) 28 commits
> >  - t: remove TEST_PASSES_SANITIZE_LEAK annotations
> >  - test-lib: unconditionally enable leak checking
> >  - t: remove unneeded !SANITIZE_LEAK prerequisites
> >  - t: mark some tests as leak free
> >  - t5601: work around leak sanitizer issue
> >  - git-compat-util: drop now-unused `UNLEAK()` macro
> >  - global: drop `UNLEAK()` annotation
> >  - t/helper: fix leaking commit graph in "read-graph" subcommand
> >  - builtin/branch: fix leaking sorting options
> >  - builtin/init-db: fix leaking directory paths
> >  - builtin/help: fix leaks in `check_git_cmd()`
> >  - help: fix leaking return value from `help_unknown_cmd()`
> >  - help: fix leaking `struct cmdnames`
> >  - help: refactor to not use globals for reading config
> >  - builtin/sparse-checkout: fix leaking sanitized patterns
> >  - split-index: fix memory leak in `move_cache_to_base_index()`
> >  - git: refactor builtin handling to use a `struct strvec`
> >  - git: refactor alias handling to use a `struct strvec`
> >  - strvec: introduce new `strvec_splice()` function
> >  - line-log: fix leak when rewriting commit parents
> >  - bisect: fix various cases where we leak commit list items
> >  - bisect: fix leaking commit list items in `check_merge_base()`
> >  - bisect: fix multiple leaks in `bisect_next_all()`
> >  - bisect: fix leaking `current_bad_oid`
> >  - bisect: fix leaking string in `handle_bad_merge_base()`
> >  - bisect: fix leaking good/bad terms when reading multipe times
> >  - builtin/blame: fix leaking blame entries with `--incremental`
> >  - Merge branch 'ps/leakfixes-part-9' into ps/leakfixes-part-10
> > 
> >  Leakfixes.
> > 
> >  Will merge to 'next'?
> >  source: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
> 
> Rubén's review went through all of the patches and his findings have
> been addressed.

Yes, this iteration looks good to me.

Two thoughts about the merge:

First, I'm concerned that we may not have sufficiently documented how
contributors should proceed to prevent new leaks when submitting
patches, and perhaps avoid some unnecessary noise on the list.  I
reviewed Documentation/SubmittingPatches and didn't see any mention
about it.  Perhaps it would be helpful to add a note about
SANITIZE=leak.  I'm unsure if we want to be explicit about this,
though.

Second, in the (hopefully) exceptional cases where new series discover
old leaks that cannot be fixed within the series itself, for whatever
reason, I don't think there is documentation on the use of the
SANITIZE_LEAK prerequisite.  Its use is not desirable and documenting
it could be counterproductive, so perhaps it's better to leave its use
suggested on the list when necessary.

> The other comment from Peff seemed to only relate to
> dropping the use of `UNLEAK()`, so I don't think he had a full look at
> the patch series. So personally I don't plan to reroll this, but am not
> sure whether this had enough review exposure.

I admit that reviewing this series, and reading the previous nine,
hasn't been easy.  It involved reading code I hadn't seen before.  So,
while I'm glad to give it my reviewed-by trailer, I share the concern
about whether it has had enough review exposure.

Finally, I would like to reiterate that I continue to be impressed
with the achievement of reaching "test-lib: unconditionally enable
leak checking" within the time frame envisioned [1][2].

Thanks.

  [1] https://lore.kernel.org/git/Zp4gILfskdpc6RUk@tanuki/

  [2] https://lore.kernel.org/git/cover.1721995576.git.ps@pks.im/
