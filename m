Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B335F8C9
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727764; cv=none; b=Acp6G2BXvvfz6hiiJAFW5q3xHMLfGq3i9wDZIs19OSMAu585XfiugWce6WPixFKh1xtSjVBy6EhpClZ8WJ0wwwuEZn14Y/rf6KrndQE+RRPbkiLUBsGAXXkPmenmENOLALmnCi+p7rtJJ9gBY5Z5McB05p0QO3Xwn2QTmB9gnII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727764; c=relaxed/simple;
	bh=Uojxhw3TK0cL4XisDvXAL5moJjXmvFlrFPV5xUbeYJg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=Z/6o8JUVogGcPNb8OStsyhLLmitkfnE1cpWmAs2qrr544LdBZo1rlKn5BxB7ADNf7mOX67G838S8qziFXWueq+T/oMKvEi73Dr4mLLeQW36dh+E/ysAj0mv388fhuf6Fr3ehO13Oi+fUIYQt2nxlqexY8DyPQycypsA7CNTpWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sw8FjnyE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sw8FjnyE"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487214ad2bso11990689b3a.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784727762; x=1785332562; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uojxhw3TK0cL4XisDvXAL5moJjXmvFlrFPV5xUbeYJg=;
        b=sw8FjnyESpc5NIc24daPclQ1uJJ9Ioz1HxN+eE5EAf7DM/t9JDtGTS9lEDLtDCNzLL
         Xe1mrH+UOWIHXbT4HBPeuW2LJluaT1ge6/r6XeAnw4XZ/55qlPHMu0Qj0KQbAXpGV5W7
         gPMnAVCo3Q6atQ13IZbYzXQoxc3+ojnq0zVwPYFLA+NSnunPUvJu7TASVi7929ESngxh
         2icae037B95bftWCZrn+aGXyi8TgBJOoyz+olSBC3KyTJA4memG7rwUkHV+fYSOY4O4u
         ZkoiyNarDa8cd85Q5M0KjscqOL+FLCcoMIF/Zt0mtAI8HE4LarqnUvbBYwtm4ILLDTdS
         lmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727762; x=1785332562;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uojxhw3TK0cL4XisDvXAL5moJjXmvFlrFPV5xUbeYJg=;
        b=s8XOHK6nfD8N9RnUMjv81Dc0mO3FDb5vkkWYj3a9uemzodh79MCtqpIXq9kS5hPozD
         hQJxPFhQvs5eOWxJejS7HvJqYPcx3VweZa53nUX/8YCP0xFRJb9gdXMZAL3UWb/WDapK
         PwitNUUSiKflpbSMODGdji3G0+p00tjiqzEc5MAocYQJazdQO/wIclocwF4uxBzSD4lb
         afB2ZUw50MSJtK0+A50kC5UcTRaIvPHAEoqvXnxoOsDTsHK9NYtHsRe6X49zIwoPsIb7
         8hrtTqAdSFgt9MMJeyiZxDUOMSSg7k1KZ/lJ75oGSJNAjo9TPDHkPtVki+4l7/isJauX
         GFhA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3npAVG2wXiEyp0usfqxb+lnypzpgMaFc4zzaYGW8s7CKTe5EgnEME2s++sKiSt2A3x1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGgwx/YT2BPvPfJArQGTE61vf9Bm0NcJuJwyu5f+BOzc/2n+Y
	h8WGX7szLaKk/oYuoqOZ+np6ZaH2GFENixsP/9YxDcL4i30iJcjZMCAK
X-Gm-Gg: AR+sD11yZcWPsMoD5NHQXh+GWFTysD6h5ACyrPoRZPgsA4O/5TuJ+pCSzks689YHIZY
	+PT4hSQg1mOJJLyry/bmsIKvSWAfLzH1+Famg6xnAVKQSTwleH8mjA51G3kDIFoeJLjhH+Kc1Ac
	KGt8DSC+eDajPUOQvEzMcUDwPh8WTD1tokMUxT2ujGOYxl1biU/dRII8T2HyXIKgF4D2YTXWO6i
	90f2Ax9P114yPzu6yzdMFG6FN44f5pKL1ZSKf0Ea8IH9fYURzy1Ll3+iSnjqxh5Gm9tjkzx7T8L
	4cUjLEJpeyI8kP5CNAofHY8ueeujuzdpzU/2xnahmIfZrErVGj+0j6EwB9w4l4J0I6CkoVy/35a
	sQ0XCSIHOOY3FeRW/5vjZCZr3uGH+frntIqhyFjJTJIRKZKF/NR+MyeFve8xlwUfux0ih/f7Dko
	hXOGApXN07
X-Received: by 2002:a05:6a00:3cd3:b0:848:788a:e7f9 with SMTP id d2e1a72fcca58-84c292b4922mr23553141b3a.18.1784727761545;
        Wed, 22 Jul 2026 06:42:41 -0700 (PDT)
Received: from localhost ([220.158.183.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175a4b98sm1370888b3a.45.2026.07.22.06.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 06:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 19:12:35 +0530
Message-Id: <DK556S085CN5.25WTVX3W1DSUZ@gmail.com>
Subject: Re: [PATCH 1/1] Extract only the message body from git commit.
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>, "hardikxk"
 <hardikxk@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260722083836.744338-1-hardikxk@gmail.com>
 <20260722083836.744338-2-hardikxk@gmail.com>
 <DK53I00U9FJS.2MUNWC5000IZ5@gmail.com>
In-Reply-To: <DK53I00U9FJS.2MUNWC5000IZ5@gmail.com>

> nit: I think this can be written more clearly. Let's use present tense
> and state things affirmatively:

Sure, I will update this in a later commit.

> Reading the code, this doesn't seem to do what the log says it does.
> Testing it against what it did before this patch:
> We can see that the previous output only shows the commit log, title
> + body. There were no SHAs, tree, etc., the opposite of what this
> patch's log claimed.

I see, I was comparing this to the how git stores your commits in
.git/objects. My assumption was the function would take an object
from there and (wanting to extract just the body) was taking the
entire object as is and not stripping out the subject.

> What this patch actually does is drop the commit subject.

Yes, since I suppose all the other places in the file where
this method is being used don't require the subject line.

> Either way, this patch does not address the '# fixme' correctly.
>
> Before continuing, I think we should try to understand what the '# fixme'
> meant in the first place.

My assumption was that the function that I made changes to was solely
responsible for sending back only the message stripping out subject and
metadata related to the commit object.

Moving forward I suppose the one suggestion would be changing the name
of the variable `foundTitle` to `foundSubject` instead since that might
result in less ambuiguity in what the function is doing (and the fixme).
Although I dont't think if that really makes any difference.

But yes the #fixme does seem very vague now. Not sure if this is worth
it.

Regards,
Hardik.
