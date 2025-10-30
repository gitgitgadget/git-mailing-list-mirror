Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569A2459F8
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831652; cv=none; b=kuxJXjtS6QW7pR2PXxny+05GN+WXMRYAfeD5hKUVzE12tpxwt3o25H8eiZ68EuZRn5G5uCNrOnTmBLHmnBsWGF3iLaJY6EzvNwPaZdNJmjs/HKr+buLOI0x2zDp7i+O2eDFRMaMbiD0SwO2evwxk6uto8TNBlR5pugEw/kInXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831652; c=relaxed/simple;
	bh=jgVUApPVJOOjUKaau5SiWBcxHIVYEcdo+/tk+HDXDZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjRUzVJx8HC10ipoVE32ifDMc9sFIeGfs2kPcs0O9ctsuYhVBTi/my0zRlsvUohDE1Tu4xVWGFjH9O47M52BzT0vv1BKbL8wY/7ishJUjWyk1v06lGNcSHyReknG6spqw9ZZUUo3L17jEqOyvTUEPm9Z3paKlXH9SAs8yRhyNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEe5WVjK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEe5WVjK"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso1835931a12.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761831648; x=1762436448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB5xdqHLbKEJQPYIazQmu4BtiJ6zQNVlAJunOvgV1CM=;
        b=JEe5WVjKQTw4q0zO4Qrsdr4ONQPHpx01V+iU8i3SHjYTQmsTj9F+CRBTkKBCtYQo1X
         laccBnVwK86fx1MVsXGG2JW8ePd7H5OnT19eRjIXWJq9BBKhnwnCVBsLJvycbuvJA3Tx
         OP8Vi4d8KrJJAXcedU0n8KXXgZ1GGEpraF4txb3Gmo2BrOkqEsHRxrEP5rRPs5qZ0bJ1
         sCZzc66nnrWsKqWFhEH4WoyAbEv84bmsR0O2zFFjpEW3zpMPzyo1OPBhHD1uWu/6zk7B
         djU/rkBM7h7W5scxFrLKUouJHz7gFnIMDgY7uPhDdc3hFKcRwsU2LCTWVfJMaVRvP4oO
         A0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761831648; x=1762436448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB5xdqHLbKEJQPYIazQmu4BtiJ6zQNVlAJunOvgV1CM=;
        b=QOq11wNpOnvwaEq8DHaghx0M9i9PqEKsobwMXBY57p7aIIN2CcIvPTlyaTHfc2QG8D
         DyuImTZvBZh+KGi/PQfsO9L1aC0s2e4ai0K+t88JmcpkewBt/JK3y9V1C0jlS7tDtEF1
         pkaaPED94OMEOtUZk/E+hEcgVddFPeZd7HAw9F+tNhXfTr5Y2Kd0OGTHwa8kFPZgk4pu
         +3KfAYK+j/ABCkO1fdpaX1c5FnZgZYuck3e13bu6by3HYxBsY0ESi7rtRWIvCYPwOJ+O
         vkkzY5rn+Ex6d724pghjLOnjkfEXi9LpSqK5Tov5MaQTTPuKBTn4SVxS9CiAwWcAi+LI
         Gd3g==
X-Forwarded-Encrypted: i=1; AJvYcCX9V1xHqw0MMuAySY4xewsggTQiT6vCCdy9icfxegXotgk+r4nWhMUCx9no8Pq+MAirdQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmp2scb0dbmuJltRYNkuFp22F9ARfUpTigFmpqLA92Ufpz7Az
	r4NYN+nQi99iTDtCJXakt+IJoEMyiX/G1xeeUOyphC2Qhf5ci6pYrAUie642Hh8r7WJLTbOjZdv
	rYrYMWqwNWHzsN0Ba8efomEkVY9+Asa0=
X-Gm-Gg: ASbGncvXo+aH4J36fZmJXY8gcgNWvtJKjJSN6ZP4+ls4BFAahG09wqoBUhdY3MQuI1w
	5L39MIlfJx/dRd0on4Yu5sHwRXg9sC3J1i6XQvKdunlBrEU5HY+UH+ZzbMAY0CrXxsqozGOfcJk
	i3PFwkjXXvrWh1akNY8cOtcJw1Lpl6YFpr1nGVrOZXH5qGQPXRu7mMaMW3jzwQXWUQMt6b0LWrU
	Mxp3YBO0bigOT173IlXbigqAG2l/ymUXWwl8cT6ra8wNIkkEecwpxiyVSTfMZJBty3OONS3aapv
	g3KAJ1Y3W98yxAj7T7s=
X-Google-Smtp-Source: AGHT+IFkRD7WWgA5nZoK5fyFTpIlgwXPgp9qnKEE8fK1JC8bbkQBs+MxfxqbQUPag0bFFzbbpG1lYC7r+5f/dSHWJ0U=
X-Received: by 2002:a05:6402:2687:b0:63c:4e00:5cad with SMTP id
 4fb4d7f45d1cf-6404424b178mr5729260a12.20.1761831648346; Thu, 30 Oct 2025
 06:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
 <20251014003404.GC1507@coredump.intra.peff.net> <xmqq7bwltlb8.fsf@gitster.g>
 <20251026152614.GB2095501@coredump.intra.peff.net> <xmqq7bwhmecb.fsf@gitster.g>
 <20251027142902.GB2758515@coredump.intra.peff.net> <xmqq4irkl5ms.fsf@gitster.g>
 <20251028231945.GA4128296@coredump.intra.peff.net> <20251029153237.GA1133542@coredump.intra.peff.net>
 <20251029155559.GA1134232@coredump.intra.peff.net>
In-Reply-To: <20251029155559.GA1134232@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 30 Oct 2025 09:40:36 -0400
X-Gm-Features: AWmQ_bkm2OedvvA5pbfj9Ni7LZyxM30rAzZvnzutgpYDL0G8_t9cw5uGsLG_rDM
Message-ID: <CALnO6CButUc89H0a+FrrdY4pWh10=U8yeWfd7Oesb=1wpHMmSg@mail.gmail.com>
Subject: Re: [PATCH] doc: document backslash in gitignore patterns
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Sruteesh Kumar <sruteesh.oss@protonmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:32=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Oct 29, 2025 at 11:32:37AM -0400, Jeff King wrote:
>
> > Subject: [PATCH] doc: document backslash in gitignore patterns
>
> Oh, I forgot to mention: obviously gitattributes inherits the same
> behavior here. I looked at whether it would want a similar patch, but it
> does not define the pattern format at all, and just punts to "see
> gitignore(5) for details". I think that's OK. Unlike where we refer to
> fnmatch(3) here, you cannot even begin to wonder how backslashes are
> handled by gitattributes without reading gitignore(5). ;)
>
> There's also the "pathspec" entry in gitglossary(7), which does mention
> fnmatch(3). Though it is even more confusing because of the literal
> matching that pathspecs do. I don't know if we'd want anything there
> (and I kind of doubt people get as exotic about patterns there as they
> would in gitignore).
>
> -Peff

I certainly wondered about the pathspec case, since the commit message
called out the difference in behavior. For example, at least in this
one corner, we can't reliably use Git commands with pathspecs to build
up example gitignore patterns to throw in .gitignore?

BTW, is the literal matching intended to be conveyed by

           =E2=80=A2   any path matches itself

? If so, I'm not quite sure how to interpret a pathspec like a/b given
a repo with a/b and dir/a/b=E2=80=94do both match or only the former? I exp=
ect
in combination with the 2 subsequent bullets that only the former
matches. Conversely, with a pathspec "b" in that case, I think I could
read the docs as suggesting both match, when IIRC none do. Hm!

But this is a bit of a tangent, and the pathspec entry is already, uh,
complicated [1]. Without a good place to leave extra notes for cases
like this, I'm not sure what to do. Certainly unifying the behavior
would be incompatible (if obscure).

[1]: https://lore.kernel.org/git/20250802094657.GG3711639@coredump.intra.pe=
ff.net/

--=20
D. Ben Knoble
