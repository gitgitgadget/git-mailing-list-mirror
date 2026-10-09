Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2D3DAABE
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533812; cv=none; b=LIBvbaq+yXyv9t4TQsqa6UuIO0ZyBPr5GkBUEf6ctR3aZQbGQIPfZI0cYZYrt6r9eQV5s8FFzQsV1g4faqgwb50kEwDaGh1SDRjbYMxFU2UIZRmZKik9WGKfYgIZ6mA8d8pW3gpDJnaIQE/nPfTy/sHuhGHdwdqDdw+Ij7bRkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533812; c=relaxed/simple;
	bh=iq3ZjYShiKh5ClnT2TYNM6/7BxcJ8N3UX2Y1GNPqrBM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ftLg26HxW62a8Trq3Lj0lvp2PpoOuWfhtH3u/AwnDZyIXTW17nWMFU/IyDdJifp/bRfqDQijkH/QKFqJZ13b86xjbfrjyreyLzcGUttpxxqm3sbAAtn/8Kvg6tv3Clqr7dMjDPeL39fZG7Qu1ABT3df5GKsnO9tMfio9GNKb150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q9Gg6dcl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G4XoEjc5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q9Gg6dcl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G4XoEjc5"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03D3F140007D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 04:16:46 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 09 Oct 2026 04:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791533803;
	 x=1791620203; bh=iq3ZjYShiKh5ClnT2TYNM6/7BxcJ8N3UX2Y1GNPqrBM=; b=
	Q9Gg6dclCwszvTk548jaIiGxlrHMKjyLbAGdkUocyfU+qzqTPk7Y4/yIRhvUtR9Y
	OxbpxtLyttQZ3+xDxB4ePXMg8GK1HuG8UfzIhd5SRsrsnDkUyql+VvfvYrdpDbYv
	GHA73XB3ZXBKYfBpGKluaFWhLsFa52wKs2QGep2WxKWpZMX+8K0dW0YrSjWhKWG4
	VosSVtj07kLxypl+nM1rOTEdCFBzytylqYrhrj6EL66mnnFcCOQy9dWmxiv4np2q
	cmLlu6iJpdECO0u+Y+DP9vHio2AT1K8n6B7zs7cweDPMndHYD/6j0VbUeo6WFVWm
	JCCSsmAJU7tCSda5FgCBTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791533803; x=
	1791620203; bh=iq3ZjYShiKh5ClnT2TYNM6/7BxcJ8N3UX2Y1GNPqrBM=; b=G
	4XoEjc5cSsd4JSTL5oeGFzXRAptJLnax/6BlVfeMfHLC6oIgVoEAKCnEqIWzi/W/
	JHhCDFVOB/CuzMALtvT74alxLVu66RAIiOi9St3SG34U4R4gKLbL59No90fstMHM
	tKMtUFiajGISb3Jgin/1621hzXNL6DAe3qR1knHr6n6IRkfH8cGsOVpEjogNxjSm
	hmjW+95/wTKtBJr5J62DPjyCoGhdX79j/kXlIA/5cmG2c8mJyX+9ZRzZiE038Qe1
	b2bn58vqudAeSyE8WG1Oom3yVW+lR4vbhGl5nWVFuAUs6u+HY6q79NEF6lpJg2o8
	l9u3XuqMEgXPihGs0dprw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791533803; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OGXNb4j51XaG5HeCxRabkjzN9KAGOJWmr9jcF4X9biJtuOg
	LVc3aTe0nAlmbGfRlDXx5KLKxAN7g5nd2+iM9jEZ/oWpjNmGIx1Seuaa7Sa8t0rh
	9nsRCPx3CIb5D+fJEH0XXOCr2GZXvB7G2mKk+UMct4d5vWPYXCwtWto3nM5ZmpoK
	RWDPzwrmedUznv7ZhNO9haDKuCZsJ0L2m6ow18SE9Yt9GpedH5KOBbdrzLL9PtC0
	z55nOsFqA6LzCzMkjYfskmfs+ujPprwb37EONG1R/OFN7JTGII4OaHeoOgLOT16E
	HjwD67L38A4Y3Jgfo7gzOwHAEg6Ol9eR6RfeyhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OF1M/muXadzECNRXkdzpeculMXJSruvjGB79Q6C2fX8=:iq3ZjYShiKh5ClnT2TYNM6/7BxcJ8N3UX2Y1GNPqrBM=;
X-ME-Sender: <xms:6aLIahgkba_xpP6E_TyXhtqsqgo6f-VYlvgKqOY7oiZDgT5yp-LUT3M>
    <xme:6aLIag3ClLElj9KWLNmak1FE8UQhNXRw9j_Hm6pYfJ-1yaB1Q6jMSRW3DH5R__C70
    fCStzO3Nvf77BJUBO8f6iehdFjGeRE3hMQzW4pYSF_6AjRPAHHwOys>
X-ME-Proxy-Cause: dmFkZTFex8azVWjhL6tE5RZC+D7hHBB97BmzgM+RoXqoRRLzlALs51QAHRAhzRSVAR0ljc
    n0VLiOFv8titacpOFio4ifGjB3dG/x6HIplKxhQTl6lkHrgDxPGWlVyP9O6vcHT5KY1gJ7
    Xzm8HailtUBEfif4BW4aed5T6116+x9BKBB+GUcuSIHc2IwWrQRW0D/kY6ctfbubLvoede
    f2ojEPWYF7EhLa+HYuZsaxwnoB0Lle7Ydy+bY0psPCpcLABJHGIQYJv3VItMwPzTVOREvD
    xgRXJ1hWnzAK76sgYhvgdLe/jK1vDys4UZg4UwAvNj4IcwFQQ9NfVyj0Jfjyx1vj7Ucqb+
    iXGpzG7yQAyUvG/qblJDy85aV2nfSTx4xjFwVfOJ23ibrDRSrzmzo4swr4AqQ3do4rEGBj
    CIOQvZh/Ppd0TWNQcHWAsaLq/SeRamPUsz5FrXwCmekoazX42Ynx0f3MepyiWffN0qRCUp
    21ocBlV/T1TBE4qsfFzo4oxw+q56BZxuxpZc1SCslzGGiuc/PHoc5On1pUOLIkpV7bEinR
    EUEnjUilVngU87PzofRZzqABjO4Pb/9yKgK12PV8o9/porL4qmsvDNSNQa/Eio/S9UZcDu
    61fMH887D74Bz/4qfGswj9gLy6Qm7jJRPlaGIM/5QnOFJ6vuF4x68X8w5kTQ
X-ME-Proxy: <xmx:6qLIagtbKzfjVdh65sl3nERG-hniYAjTBtR8ZX-06GtygagWjZq5Sg>
    <xmx:6qLIamb_Ye2M53TS9tijbvjnQvHn7T3LOwe2KIfpHWEcbrob5lCm0w>
    <xmx:6qLIanWqcFoSEmAgP3oMbn2rGOii4FDHyolhxwiRUBdIWw1XdQxODQ>
    <xmx:6qLIajTzakw_rI_CWFLS9oJ64mvNL1A-db_GoIC9M2CsV-Bira83ug>
    <xmx:66LIahiuHUBBf0iKWKbpK28NNygFHGDlxt2GXiGMl4eK0DCHTPsTKUwA>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 66B1B22C009D; Fri,  9 Oct 2026 04:16:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACf_4gHdHLcR
Date: Fri, 09 Oct 2026 10:16:21 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
 GGG <gitgitgadget@gmail.com>
Message-Id: <cf3bb2a4-5956-4ba5-9957-b0598f22a122@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnWkTvicU+U99j0MzzUUXeVnUj=FJJwUDR1F7DGk1hmtrA@mail.gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
 <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com>
 <CAHwyqnVoMnO_fYGJ0N29bQv=Lh5naZ0jc5uSpiS2urQMZVG5-Q@mail.gmail.com>
 <61ae371a-225c-4400-b878-8547547d1269@gmail.com>
 <CAHwyqnWkTvicU+U99j0MzzUUXeVnUj=FJJwUDR1F7DGk1hmtrA@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026, at 20:42, Harald Nordgren wrote:
>> Even an efficient implementation is going to be a lot slower when it =
is
>> trying to find branches that have been squashed, so I think we probab=
ly
>> do want a way to turn it off. That's especially true in partial clones
>> where we'll have to download a bunch of blobs to do the squash
>> detection. So long as it isn't diabolically slow enabling it by defau=
lt
>> is probably fine.
>
> A bit slower (depends on how much!) could be worth it for improved
> usability. This is not a command that users will run multiple times a
> day.

I would really like a solid delete operation that I can run, say,
overnight. I have better hygiene practices today but I didn=E2=80=99t ba=
ck then,
so things have piled up.

One big cleanup is worth a nightly run. So I don=E2=80=99t care about ho=
w slow
it is.

>[snip]
