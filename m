Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20D15383E
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734500959; cv=none; b=BwVUZQl/Qf18Yceu4BCgwk7X8eiMPqDK1GmYVrwGqJ4lXj5u8LgD3TV8Wj15XdvKyccMFF5yRSZz2WFcaKeC3t98dwgWsMCRaazN+oJJJxbBPKsRmcZo4HfkgARQiNtJpb/+nvGa0LN2bLe3FrdimuLlWopdjPVTNyHDY9QdKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734500959; c=relaxed/simple;
	bh=BEN6AsPxK1aylPIleK+oi98dDR4uBX/tVphUtsO3qbY=;
	h=MIME-Version:From:To:Cc:In-Reply-To:Subject:Message-ID:Date:
	 Content-Type; b=HaaQsGC/ryv1YD1kHz7JxdO/JCpbv4O4ePzRzei7DcX43skowe6qtCsRXacEXiPC71rvMD3atAl7nSxP6Q7ri3rtzvOysgxkHTUqtEHTFdbKRT9HQBo4Dg0ayW3D7L1o+sx+d6E3Qklr7tNTeVQMH2DSSAK+dh9f6bzoTbf63rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFy6/szk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFy6/szk"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728eccf836bso5352145b3a.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 21:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734500957; x=1735105757; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=enDN8J0GERD0tkzA41R4c1IeMYoJmE1ciadfFQkuY0A=;
        b=VFy6/szkokXUV79UuW/cyP3WX855kz3oedb2WQr6x21D430OWvYaAjg2sxIX3q4aRG
         EdqAFudcHzKT7ccqgB13nQTHxCB4nJVA8ysvRVdNLgFmHUk0b2mGTaS1gbWGP9aUqdXE
         TXPHrRtS9NWL0FOwV83vAAxZJzxFucENObnIxut0U0n1z88z93J+bxA6rNgbZBQwGVFw
         pEUnZTDHseO0n6CYLbsCRCg3lALIza0xNLM8TafuLStl5d9iXPOONpqbLA10VBULWiJE
         0lkCkstK8iodbHW93AqfplxnGHzCwv16bYN1G2Ysf+2K2r3uaqBwQbiPjVWdjLmcJDU8
         gzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734500957; x=1735105757;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enDN8J0GERD0tkzA41R4c1IeMYoJmE1ciadfFQkuY0A=;
        b=P8LvIlxm5NSsKkI0N6dlQxTSpsN0fWEyGu8cAOVjk43lblZ6LXKDnqAA8fXjMXXxu2
         DPXEA2qTS5YnppaR0xOCT8bGlhzNhBnT1/zWt93lRFSAZf69h4xOmegxk48C1ZCVHFGL
         DsRRaM8mzDOFSOlS/G4PKuT1jMyIihnwB1Zuy1+kNdoEbIPHvlgOPnPyICivqGF05NRE
         75x/xqCI9L9TnvYiDWfQskpU98LqxA2GaMlqwQMHYOUxKVTNjgtbnHmEcCHTP90a3fRG
         CI+Os1bi4InvPstT+lF4AYBLouhxKYLr/+SfFD4BiZXyrumml3g5KAJCVKg8X9bROqaM
         +1gQ==
X-Gm-Message-State: AOJu0Yzk4aIWZ0zXE1kO5AMoitacdDZBvGnEeZSO44FQMDyyq2BmZRbR
	Q0cF2oD5oBr6igPu53FX+2NXCAfp6IwhqWrm265gIiTInyunEvud
X-Gm-Gg: ASbGncsQ8mzUbtwtmnqmL7nOsAIz4yklMHmoZaRn6PtzeN1AKw3nshiqxqoSAx4LuQU
	FPveeQGFpLMFU4URNWzE8GWP9fNDKwEt1LDfCcj6K+j/0i1uzqPOFcMFGmp3sY8yU10O8k2zCFE
	TAWbaQe4ar7UULg+rydCnuLctZg231trYkcjEOkfLgSI7Pddklf+2IKzCNRiEkG452qk6XBAJqz
	uZJ2xs3N1RHv9iinsnpyGqOzia8EcW2grpkmplpTeUSNJM41nGuE6nSdLEA2yx9sDt13nLmL2Gf
	4DzUeg==
X-Google-Smtp-Source: AGHT+IGUTeOcc6HyPd0asDLuW+1QVTq7VC2DK1ONjjt4lvIb0WB8K73IKMUl71i6OoUGxdY/gjAvjA==
X-Received: by 2002:a05:6a00:244c:b0:725:96b1:d217 with SMTP id d2e1a72fcca58-72a8d2461c1mr2155198b3a.9.1734500956552;
        Tue, 17 Dec 2024 21:49:16 -0800 (PST)
Received: from host (36-230-86-110.dynamic-ip.hinet.net. [36.230.86.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c380afsm6668583a12.76.2024.12.17.21.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 21:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Wang Bing-hua" <louiswpf@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, 
	"shejialuo" <shejialuo@gmail.com>
Cc: <git@vger.kernel.org>
In-Reply-To: <xmqqr066ysa6.fsf@gitster.g>
Subject: Re: [PATCH] remote: align --verbose output with spaces
Message-ID: <18122f6da7729ff9.8ab23eb43f7bb6f4.c74125d7d6163423@host>
Date: Wed, 18 Dec 2024 05:49:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 17/12/2024 12:21, Junio C Hamano wrote:
>> On Tue, Dec 17, 2024 at 12:39:36PM +0000, Wang Bing-hua via GitGitGadget =
wrote:
>>> From: Wang Bing-hua <louiswpf@gmail.com>
>>>=20
>>> Remote names exceeding a tab width could cause misalignment.
>=20
> If all of them are named with ten ASCII characters, on a terminal
> with fixed-width font, things will still display aligned ;-)

Indeed :)
I did consider this scenario and wrote "could". I should have worded
this more clearly.

> With a Devil's advocate hat on, a change like this will completely
> break tools when they are reading the "--verbose" output and
> expecting that the fields are separated with a TAB (in other words,
> the tab is *not* about alignment in the first place for them).
>=20
> Now with that hat off.
>=20
> For users with that many remotes where the alignment of URLs in the
> interactive "git remote -v" output matter, I am not sure if this
> change is a real improvement enough that it is worth the possible
> risk of breaking existing tools.  With that many remotes defined,
> wouldn't they be doing "git remote -v" piped to "grep '^name<TAB>'"
> or something?  That use case would break with the change, too.

Agreed on all points. Another point to consider is to align with
"git branch -v" since it also uses spaces for alignment.
This patch was also originally lifted from "builtin/branch.c".

