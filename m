Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484B345729
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364863; cv=none; b=osc2PUVxzShuEtx84AEyU75sMjGki0zgXB7YnZj2Hax4og2bmlAfb91FfhEXizSRyrqhPRz2ZpxX+YmqPjjXEe60YH1n9At3+3k3RNcXG+9KKkut33XJwYrHSybE2hSilHs6SWp+6f+KAe1u+OXaPpS6H8IqzsWjoP/UN8L/JFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364863; c=relaxed/simple;
	bh=+r6XOAd7Kr0u90O4oi66sjDPDTXNSsHg+LlardFPSGM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ruiUoAQ55wZxIMdJVkJepPevzbRn7tEq+ZcwYiPl9/tqWao0QQmnalHBKe/Vt4yk1Ho+xW4MJuA/ZJS5EVbnYSLSGaZSpNu00cm91xCSKsPpQzShByDj0nRAOKO6Qeyiz3fyWH9/Qdx5Eg8gFiQW+7tjNhN5dDbn245UEaqYnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCwHgC/n; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCwHgC/n"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201ebso1353272d50.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364861; x=1790969661; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WbrH9WBQ3Hy2MiurYl8XUv8zADhYNIQshehDbZadJ20=;
        b=tCwHgC/nwGnOCSxaI8zJL23/OTxpZPksGnSUld7Ok0EFMoRsgcq5GmpW6yojxUcZQ3
         XwjjEezDL+4n/ry8plqummLnfj1VR9SKJ28tlALd+PXLaC2dUb5fUov80kSBdFmThwrq
         auZqHX9yiy0me2FDG0Mzn6kW0836bHLUuA8Q3wLRu5lXGAEC5m6RhyZrmHjF7KIebH5p
         vJ0w/b5SDQivlv621JnUGhAjPytYBxReyk+n6TqvXbjCzEajmLmWIXUWqU2XVu+cgA5Z
         wNbwKJXKXiHczAWIqCweGANhYDC6B6+6E+x+CvyT0HLjwIFqyn8/1Gxj38h70Q7Z91XI
         w4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364861; x=1790969661;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WbrH9WBQ3Hy2MiurYl8XUv8zADhYNIQshehDbZadJ20=;
        b=LelvtM0xPYl2saL0VNy62O78xvcJYjnD8W762eNFjFYjuCAH+F1rWG/i1Vl4Bnn7Au
         lJ8iqiXrM04L1zqDCCMxfx4vNufCYjd2L5DXXBp8YeLxubvb3WEXLTjPLkfuCMO8gGec
         tJESgih4eMWrqXEpLYzipb9FEAMXj23Y3hhvIygQ6iuoZ7TxwNLUSfM3zLRefewzyj9r
         5EJmbouVfMxcQ9tHsxQSo4hrAJEGJWcYlXJoOlTEBvLTt+KUGV4YdWgeJXIIekkJMGiY
         sVnjXGZ8NSOSrpaQIoyMIjZaf4ytRitetfj7JREiLZS5jg/WHoVgG9OZ6zMSNU+jT3WF
         4sgQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8iGsw4Kp2sFY1zklCJR76n8VVcIu+7IT7Lt7VCe9MOxlBVngDZp6zBzkePP5NOwWFuxY=@vger.kernel.org
X-Gm-Message-State: AFuF++kvli7LA3c1CTZnz2pHE+NIRJ+joDnxKCzdFzwmYqxxKXot4/WN
	cGv2iOf+WKtDmAcB2Jgxx82tR+WrPY16cbbSOErjw8c6kUTk7P+Z7kxhh3knurz0
X-Gm-Gg: AYBFou3DELvb6uz1cWZ7wU/ZYx96AJB7aPHAxZmOFyb0jUXqGL/M66MrFEDf2D/RYWp
	zwA62EWM01vKISO+E1v7DE4TJgovHoUzhXml4+VZpR4NHz6zqeJxaWk+Wh0Z6dMRp+jxXvOjkv6
	6d9mQ17oh/bU3WFjlsQRDQonW0vDVX8JV0mf8MNCIQ3nJ8cAT0vakXvXBG9oeEvzTwEkCqZTkW/
	bt4ROwjjQBagCG3EeMLmsd8wMYVxtVtVQfKtQQtzVfctM8piJVRpNRBSzw+SKjmLD872fzfuFgj
	nyb6Qua2YkhwM/VeKPZBo5K4N1LIuk3IbA7dI3J5tt6YdY7aZTctbHKf56yhdsG/HZvfFqM/fDv
	1g441vCDeFx9VulC72Ap1373JwCX+yR9iYKM8hQyHrFE/eMTaht96rZVCXp7NQ6cGmNuMovR4U2
	//pNHUrH3tMC8t2DbE40KyVi0STbKci5UcsxWSaKoxj8MMgy79Sx7mfcgg+pENKVfY3q5tvR0pi
	TlCnoVzG2gM517dgEvkYoGQ+E2pzvvz8dLaQqWNeMVkPqK6RsZLcYtbGm5DQyCqCxqk2g4FHWI+
	A3SUnDeRwhQM0rFJMyAXD9hG5kdYyX1JE+pZSkvJjiocnsFI
X-Received: by 2002:a05:690e:43cf:b0:672:e7bc:ae75 with SMTP id 956f58d0204a3-672ed507673mr2189381d50.137.1790364861050;
        Fri, 25 Sep 2026 12:34:21 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:f9a9:65f6:303f:ab61])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ee940a0sm1308533d50.3.2026.09.25.12.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:34:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
Date: Fri, 25 Sep 2026 15:34:09 -0400
Message-Id: <C66B019E-9107-49BA-B54A-6B82BF11CB77@gmail.com>
References: <2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
In-Reply-To: <2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com>
To: Julia Evans <julia@jvns.ca>
X-Mailer: iPhone Mail (23D8133)


> Le 25 sept. 2026 =C3=A0 12:59, Julia Evans <julia@jvns.ca> a =C3=A9crit :
>=20
> =EF=BB=BF
>=20
>> On Fri, Sep 25, 2026, at 12:36 PM, D. Ben Knoble wrote:
>> Hi Julia,

[snip]

>> The second is a very useful way to get more context to help resolve
>> conflicts! I have an alias "conflict =3D log --oneline --graph
>> --left-right --boundary --merge" for a similar purpose, and I think
>> the new guide should help folks discover --merge. Often I can get a
>> better sense of how to resolve conflicts by comparing the original
>> changes on each side, or I might at least know who to ask about what
>> to do.
>=20
> Thanks, I meant to flag this: the reason I deleted it was really
> just that I couldn't understand what `git log --merge -p <path>`  did
> from the documentation and so I removed it until I could figure it out.
> I thought that `--merge` meant that it had something to do with merge
> commits, but upon further investigation it looks like that's not true, and=

> that `--merges` is related to merge commits, `--merge` is something
> totally different which is relevant any time there's a conflict
>=20
> My best guess now is that it would make sense to include this
> under "Tools to get more context". Maybe something like this:
>=20
>> `git log --merge -p <filename>`  will print out all commits which
>>  caused the merge conflict for `<filename>`, and the diff
>> of how they changed the file.
>=20
> ("which caused the merge conflict for" is a little more vague, but
> I'm trying to convey the intent, and hopefully folks can look at
> `man git log` if they want to know the specifics)
>=20
> This does sound really useful.

That reads well enough for me! Thanks.=20=
