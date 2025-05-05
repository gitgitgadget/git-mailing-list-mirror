Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145351459F7
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438737; cv=none; b=LeIFjPR/c8iL6mCGlrcV/qmA0zqhLzW8a6o6k787arL5j+Dw91D4iS/5xTNm5vxBYiroIlHgHueSO2C3duc5e2/XHNgs73sbSeCHKvtlNzvPYvvpj00vpHhJjBUWWonVj1rrtcr5QEtt7t6cy1Kn3T3P8J7R3fTf2siXxnFoNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438737; c=relaxed/simple;
	bh=GiZPXYfKC/tZ5RZftQgtiPE//lzRb8VkcWsfU9aul/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khknXiFh3ZlKo4NWEL6TVz2xG1uMsrV6TkYenQ3sgSBfcVO/1d+xZZzE5gIKbRu8cQHcdw1sRzj8ii+q3UCQdy87plm8eeb+Vh1Gx5WgHdViq5tAzEjnCu6saqLj3PQkzifjvajLSeEWhSn+MdvUxZfK/4nvHrjoG87q/iOX40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v7TDKxaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MPrc8r1c; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v7TDKxaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPrc8r1c"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0B7262540262;
	Mon,  5 May 2025 05:52:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 05:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746438733;
	 x=1746525133; bh=gyft9BBIWFVSou7h6MO4McJZOKWDWKwP+uVhXPjWees=; b=
	v7TDKxaMSDPiCn5JwukC7PlsUTWNiH/uy/jCpHHURrt/o/r13Q9ZPr2KOt5KWWNe
	iGUowOal+weZffPGI3IxGvtCdD4VnhT5eEZkNNtUvF2gm2PDQsLtGFyD7+DADZuZ
	bi+gG4kQIMG8WLOprYzWXl3C/lAdilawlxtjhvnFSvJr6t8bFahQ0BXsicRCJDXA
	gACI3guby3iCe75QpTQOPANPKFHeOzzelNKAJHqDmruV0SqPM69MUn5UrC+0O68/
	hoz774spofeOlT0dS31LQycxi4/ULa4ylpzDBsDQcdAhn5BbZK2IRhMji/wrXly3
	sgRX+phY9qMyJyuo4ux9Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746438733; x=
	1746525133; bh=gyft9BBIWFVSou7h6MO4McJZOKWDWKwP+uVhXPjWees=; b=M
	Prc8r1cGMCgbfH5s54LknH0avQ9AdBTM8P9WO/o2CbqAbc+67WwpuneN9Ay/sUJc
	1q5FPrAJpwvJH3T0xi6jkY7w/G5HS6tvucrGRkQEKayLwm9q6cRE66NJKP/DUTHu
	YtC6fCQAQf6tSTuMxr2n2F761RHJr362IW/wgGuRapV9Y5Ww15JpigtQpnxMWR0Z
	pxq5xKRo9m0gxrZQvVL/rGehz02OFOcMsUZpQqrVZ6V1ODvhVNoNgA8ROZsI3OWM
	Mo8wOmTTqey80PdLPIfGn/UrM8WpVFJj4FhDwvIAQqgwX8g23lh787U6a6mCPsOK
	Twezdr45y54GQy5i7uT3w==
X-ME-Sender: <xms:TYoYaIZrw8qhEkzOC5ldwYz5PSZc55cYPlGj5UKJIh4KtRMT0-RsUw>
    <xme:TYoYaDZITYOxz3RTK5joFeUKbsiqPK2o-CxSm8pdKRFgUwgzv2HPZqgoZn3RmvE4H
    wp0AF9pNcKxtRXmAw>
X-ME-Received: <xmr:TYoYaC-b8LM1XzY_v9HCDZaiorqfDRduDqZ9nvYM8Fcje_A1a8NDkSBx7BWqxfpN1sh__GDy4wVLshSCZKG-y3mIGGFD6lP_3N9pGe1ZtBsrtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhfohhrihhjihelkees
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:TYoYaCq5Fd8Rwx9WnaumkQ8CRYqy4_sjzf8UPdm1gLZcKhh_LqGoVQ>
    <xmx:TYoYaDpXl9v0bSqJzfeR89EX8DC95gVjKUMIvdqDwF_zqbY8j-fb-Q>
    <xmx:TYoYaATcLK7E3PwHWgTCBXdW7kghZptS6mouj1PfWQV8QujOePsHRQ>
    <xmx:TYoYaDrXEjXZcVE6m2BB4dlF2_zwqapH3CLodt4FYyMXq-tWWL58JA>
    <xmx:TYoYaDMOvHmian1jhDPb97bbmHf3zZO7K50EY1fHFyX3YTwGzjKl7Yol>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 05:52:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6476b918 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 09:52:10 +0000 (UTC)
Date: Mon, 5 May 2025 11:52:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/10] t/unit-tests: convert reftable block test to
 use clar
Message-ID: <aBiKSeTLItw85A8z@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-4-kuforiji98@gmail.com>
 <aBSXGz_eIljWbb2H@pks.im>
 <CAGedMtcBsT=7=tL_y99_G9xNW43Bttb3dFqy68DfFt0ZgpZ-4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGedMtcBsT=7=tL_y99_G9xNW43Bttb3dFqy68DfFt0ZgpZ-4Q@mail.gmail.com>

On Mon, May 05, 2025 at 08:37:27AM +0100, Seyi Chamber wrote:
> On Fri, 2 May 2025 at 10:57, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Apr 29, 2025 at 06:52:55PM +0100, Seyi Kuforiji wrote:
> > > diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
> > > deleted file mode 100644
> > > index 22040aeefa..0000000000
> > > --- a/t/unit-tests/t-reftable-block.c
> > > +++ /dev/null
> >
> > Hm, why is this recorded as a delete and creation? Weird, inspecting the
> > diff locally properly shows it as a rename, which makes it a ton easier
> > to review. It would be great if you could try to play around with the
> > `--find-renames` option in the next iteration of this series and double
> > check that these are shown as a rename.
> >
> 
> I used `--find-renames=90` for this patch series. Is there any
> recommended number to set it to? :/

Note that "90" also isn't interpreted the way you think it is, at least
going by git-format-patch(1):

    -M[<n>], --find-renames[=<n>]
        Detect renames. If <n> is specified, it is a threshold on the similarity index (i.e. amount
        of addition/deletions compared to the file’s size). For example, -M90% means Git should
        consider a delete/add pair to be a rename if more than 90% of the file hasn’t changed.
        Without a % sign, the number is to be read as a fraction, with a decimal point before it.
        I.e., -M5 becomes 0.5, and is thus the same as -M50%. Similarly, -M05 is the same as -M5%.
        To limit detection to exact renames, use -M100%. The default similarity index is 50%.

What you probably wanted to say is `--find-renames=90%`, but without the
percentage sign it is read as a fraction, where 1 means "exact copy" and
0 means "all different".

I'd recommend to just play around with this option and inspect the
outcome until things look reviewable. :)

Patrick
