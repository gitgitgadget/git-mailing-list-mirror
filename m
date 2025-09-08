Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A41E1A3B
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342826; cv=none; b=td3gZkhapPNID6BlMziOxnKl4FTvQcGqzA6VkmQmK0yi+UGQg2qjvHYDuqLDOItpvE8c0IaeXll7Tet61zYYOgClEN5x2Os9X5R0aULjsY0aOHV25wS5MNwNazMOujFiGIbc+k3pU4DTDXpaT1U+rLCu4V4ockTzgq+CogxIHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342826; c=relaxed/simple;
	bh=PE7J511DxM22tXpXrWmZfYSWktT1Azm5R7G31yW9aNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmDdfUopo2FIl0UlLoTH9NkW0rAwUW5W8FgB5vS/Fl0Oas8YXnz5FlcYuvce6kUnR13h5xMZ6lynz1bqCFYnl94w/rxkGWab6rLUtV/+bp9aBUv9F6sSY6OuGHVegs6E81QrHu61PVcPVR5+QysUyE7kXBkA+svIwgA3IM0YsxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCN0k3Bm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCN0k3Bm"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5f6ad78e4so23807841cf.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 07:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757342824; x=1757947624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PE7J511DxM22tXpXrWmZfYSWktT1Azm5R7G31yW9aNo=;
        b=eCN0k3Bmo9PfgvO8t1H5RJF5chLJsjBoRLV0iSjNkieekBSZ/023BcjjsYKtUAjgPx
         MJ+wELemhb6aUZY5INtzW0acqG1GFrj/zC01OFgvUcZwpAU+dqqnFIyrzO4Xn4BKeeFJ
         XLSLEqL+/+MdXCpW4wcTNAFdEYYfuilnnLDF5P3pVwbsvJdXQLQcN+XD7iCgOHyDqPSQ
         txE+LoYTB92u0I+ZpNdTPyVEWkKb5EnbJnIO1YforUx1I6SYOEoleHFXpN3EEp2pOvS5
         yxvYSh7tvePpDEJ0CZ8TI8dpMdy9n3hHuatDckbRDIQ9/DViEyxwhUu+IiyhPPQyH8c6
         gnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757342824; x=1757947624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PE7J511DxM22tXpXrWmZfYSWktT1Azm5R7G31yW9aNo=;
        b=Rqt3gvJj4lSBje5lOHdQjlCgGSgkMtnQ0AQ40IevxAq3YsQWDljq0+tvv8Q3jGCGfY
         hqGefpnLLMf7NbM5w0Cq2ND+M0HGa/r4TCqVo8Ds2NhmbKdNaQLBJeWcyQ0TyDoAx7Np
         RV93behzsejGd1xYWjm/g6x8FjDIiFQidU+0r8olrcXJg3EW5PaQTgCUm3P/9yxDOJRk
         U8iB0W8sf4sNIJFDzCrHT8Tf/rSvpkRCAH9bAZ8ih+Y5liLoWwq12XTgcaN8QLYHZ/QW
         3Ubrbour8sjhJWEF2pIcsLO2wllrDaFza/nEyEWAVI8ntIosn1ut6sCYaeOxc8CgPfsR
         xkJg==
X-Forwarded-Encrypted: i=1; AJvYcCUfqlloiJ/U+1wBZFVQXImbRDW4/Y3b2oAGlZI0H6fNjHql1MsKOJ8C3FJHvIh+a7KHDww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLC5Ac1QoGIvjgK7HVrHq1hpFTKr11wnd2yOjz+Sx7gBBUTX5
	1uKrd4ww+pO3rjxlvMxPN2rU7AyaxrZ4Nj+JUEdzsGMpgyAiI0BIdOL8
X-Gm-Gg: ASbGncsuMjmt+pmGD1UnXxGHbYAyuZuznxvg+VzxLvQ/llQO5DeDjZBhBjs6iCcD98y
	Io11ilRJLX/5ZBI/WMCjPBkBCdhw2yPuQzo18dy+CEOCBGoF206hrPQMu+i1DuCs3051y0XxwMD
	uEoIf7w146Wz447M0/eX57ldVFJcXrl3VyHZAnZjjxuxK/11eY9n/juyweBJDhrucvZwFqWqnce
	t0Keo7EQO6UYJh6zbz66iWUfoLeDDt+F5hMYZvfvzIWgfXEGUZtR/cRZEs3IOv9A6rwUVcHUO+n
	UlrvSKct01rqug8Tuy2sIpQloX3YY1Xmz4LB9DKeG3hJ+0aUOsNcpB8tESWgK/wn2O+T/MRx8sB
	kpYMshXMHecAC6YOyhEhkaf/oL61s+IGI4v31sSuFCJoR5w==
X-Google-Smtp-Source: AGHT+IHvNoJKG/siXooXjSudvx27pdmzBIEvzSdEy7H1gvrxAV/Gp8ZRyXNBlu1gKZti5wYPH8aa2w==
X-Received: by 2002:ac8:7e83:0:b0:4b5:4874:4fa5 with SMTP id d75a77b69052e-4b5f83ace18mr97241951cf.18.1757342823765;
        Mon, 08 Sep 2025 07:47:03 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f658302sm101800281cf.15.2025.09.08.07.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:47:03 -0700 (PDT)
Message-ID: <4e67fb02-bbbb-4cd8-9892-6f65b4f82b26@gmail.com>
Date: Mon, 8 Sep 2025 10:46:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <xmqq5xdx7qx4.fsf@gitster.g> <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
 <aL67U0-tw7O-y6_X@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aL67U0-tw7O-y6_X@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/2025 7:17 AM, Patrick Steinhardt wrote:
> I (probably unsurprisingly :)) don't quite agree with this.

I think I can summarize the main point you seem to be making with
this quote:

> So I would claim that the commit graph is specifically tied to the
> actual storage format of objects, and it's not at all obvious that it
> would need to exist if we had a different storage format.

I think I agree in principle, if you are saying "different storage
format" means "different commit object information" which then means
we are talking about a completely different object type that is not
at all compatible with current Git.

You could store commit and object data in SQLite, in the cloud, or
via plaintext files on disk. As long as the data is still representing
commit objects as we format them today, the commit-graph is still a
cache that can be used as a faster way to fill 'struct commit' objects
in memory without navigating to that object database.

And you also mention that the commit-graph format itself could be
more efficient. You're right! I think the way we did it within Azure
DevOps is more efficient, because most of the commit walking algorithms
are built working directly on the integer labels within the in-memory
data structure instead of operating on commit structs. This allows for
less overhead when loading the graph (it's already cached in memory)
and when walking thousands of commits (we only translate to object IDs
if they are important for the output). But this is all the more reason
to keep the commit-graph structures outside of "the object store" since
a "commit-graph database" can be implemented without being tied to an
object store.

If you are saying "but our existing commit-graph format puts it in
'objects/info/commit-graph[s]'" then yes the storage of a commit-graph
is tied to our storage of objects. But the way we interact with it in
code is in some way a layer above that.

Thanks,
-Stolee

