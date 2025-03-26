Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417B323D
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742950943; cv=none; b=BB1CUjtZJkYBRGMi9222eT56T55H/j5Y8dwXDoWfJ7BdgvIcg3napOoBEjPtUpOYxK8mhGx9QRhLpiGZRxqKF5x+6Q1AsjtWYiLGMtA1tCNnftIXCrPa5aEL3gnHH4vHI0HG70iYjxOAy4fySdACHN5ALvg+RyqjoNCZJJbYhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742950943; c=relaxed/simple;
	bh=bAc9MDvcjf/GtpPMImYCgg1EMd2exB63yZaoqtaRc3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMDZpzLwF77VjYyZXHZxYt8X51ZElEL4KHKzVzjXbwZuqwFVEdNjKRStRtvZbkJs2KxL5n9cjy3/mbN8aqNozQz0fSXQHD1Ta1VbSg2vDObcn1bf6e6ZBRLSTRk24jtgei9XXw8pz3Ys0WSKyp1XVoPKyZxAJLQfrf8reFKL5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hvc3EEU1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UHl/FE33; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hvc3EEU1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UHl/FE33"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C88925400AD;
	Tue, 25 Mar 2025 21:02:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 25 Mar 2025 21:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742950939; x=1743037339; bh=/On6COyuhS
	Gt7ugW4tbChGV9erXuAiRTBKpaoXfCik4=; b=hvc3EEU1eY0vWAckjC158X7DxD
	05UGpkXylJyD4gClfpL99SFFTqiImt1BMa30Rn9CyNktIqe900QJDmVdKX1xdjy5
	0ZrzMekzYWWRqJf/z2xPdx2djkb+7lVMEbIXTPY4WE+83QWoQ7nf7a3AF9ehZmhD
	q4vJd1utsp6e3FdVdNmi1Jzl3yzxDpMm9N/Z4fmyWz2/TbsF8aeUqy/dqGKsNl8o
	SR596//91it4bcY0O9hrf7aiuJPJkrnyHQLjlGgINM8dGfIoc3iFat2vAmDS93Fe
	37v0Vi0ulLC+Qr/0bIQF9sTglC5rFMfS0D8h95CFmn5PA4+oePX47pnPmlWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742950939; x=1743037339; bh=/On6COyuhSGt7ugW4tbChGV9erXuAiRTBKp
	aoXfCik4=; b=UHl/FE33571j83HBI76ArM7r+ZIAlMy/43Av2levZ/7hK5rbVUO
	O/sueLZC+ZsLYxPpB7BgaITEE89FcePGKG2BWSYFxJc7RPx6huRijB3qmGMPyBra
	/G5jIE4AwM4wV/uOKa2yA7jd7t5yROyNprrPuDUUtGsHjDAiRa5adfgNU2tO9mys
	Bn2h9At3Z3I7l+RYTbZ2KtFZ2gbbtjbh+ZejoxEv1m2iXBSoz+G4hQnlni+zpIUn
	aQljVz0yvkiIfmzejMLg89CkRR2zHECi9P/lp1dmE4b9Qws01HwLTOob3CCBJkRS
	d3lkvIuK78XY9zUNprcM/BgtjX9F9AcHhPw==
X-ME-Sender: <xms:G1LjZ6beD2ocT8m6sjFVc69j_avzjxJORYjpvzXLzcg_npadhOHgtw>
    <xme:G1LjZ9YMyedC9k3ALsu0VThLQ4U4GzzmY5Um0lZhjUCeECO0Tm-O8arDeaT0yIgrt
    NIA9PGKyQo04dZKgw>
X-ME-Received: <xmr:G1LjZ08Ty7JEcxC1sphaI5MIc_i_W7g99sDiaf84-oy5YHFnHRuRzQL-6yJ0VRmn1iziXYXduNe0P_VP_LzBnGZ7X2NisaqY-0pDhSiT8rQhGRmJoKV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepgfevfeeviefhheehhfegtefhvdffheefheeuleeh
    ieffuedvvdeuhfevffeigfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhikhholhgrhidrshhhuhhsthhovh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:G1LjZ8qehydzh2-DRRnK_JevbmjduO2aF7nOEAYUXfKLRZ7zxyFPuQ>
    <xmx:G1LjZ1rc43dwOh9Hn6Bww4TVHA3g4FEkxouaGRQlL6xtZa1g-foqyg>
    <xmx:G1LjZ6RK3HMtWdK01XGIm0tU-XKrkq8HX3v4K3tDsjKnf9tYT0f2nw>
    <xmx:G1LjZ1qxqLkXV3epJdIj1ntwc_L2dIZ1wwYzL1jzzCAcNNQ4QBKhdQ>
    <xmx:G1LjZ-D1wKfuEYfZXXnqmMeOvrgWKwxQRauE7_Vq4XesNBZ_3zBQUha2>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 21:02:19 -0400 (EDT)
Date: Tue, 25 Mar 2025 21:02:18 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Nikolay Shustov <nikolay.shustov@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [Question] Moving from Python2 to Python3
Message-ID: <Z-NSGtV06NPE_C9D@teonanacatl.net>
References: <022b01db9d99$e68785c0$b3969140$@nexbridge.com>
 <Z-MgpuxFQ3xEgvsU@tapette.crustytoothpaste.net>
 <66e39a95-09a3-44dc-ac71-a6c02b5949c9@gmail.com>
 <xmqqtt7glmut.fsf@gitster.g>
 <6977f08e-3c49-4bcc-9ab7-e3cc61a78396@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6977f08e-3c49-4bcc-9ab7-e3cc61a78396@gmail.com>

Nikolay Shustov wrote:
> You are right, my answer was over-engineered.
>
> Instead of speculating about what else needs to be done if
> one decides to set PYTHONPATH, I should have just advised
> to use the OS specific method on setting up the "default"
> Python as Python3 and be with it.
>
> Well, unless the dual Python is needed (git-p4 running
> with the Python different from system "default").

Perhaps you were conflating PYTHON_PATH, which brian
suggested, with PYTHONPATH?

PYTHON_PATH is used by the git build system to set the path
to the python executable, e.g.: /usr/bin/python2,
/usr/bin/python3, etc.

PYTHONPATH is used by python itself to point to the
location(s) of module files, similar to PATH, as you
mentioned.

The Fedora distribution packaging set PYTHON_PATH to python2
or python3 while both were available and things worked well.
Only python3 is supported now, and PYTHON_PATH is set
accordingly.

That ought to work just as well for NonStop.  If it doesn't,
that would most likely be something to take up with the OS
folks handling python3. :)

-- 
Todd
