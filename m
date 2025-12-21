Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8C3016F1
	for <git@vger.kernel.org>; Sun, 21 Dec 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766337236; cv=none; b=OLMuYstoZc1eglykaz5U73zEoeMFhfPhzzRMAbEhJoM9T7wedB+1bmXuAattFdikVOwjiFX6m8xqK/C83iqFOO1iE6VJM/x31D/B5Ze6YItAz0K0oElk5A8FX0D3COJ/dDOp69E46MXUQlASnRCL8oPnMeoynUuiaD39feIwVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766337236; c=relaxed/simple;
	bh=+Rd9E0RWFY9ETP872HvdeCOWbtrOK61bkzOp2xX7gy8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R+2hudibyAHfqgRdYPYxbtQIFDU05HQyIeUod5jcR234vPa8SkawoijSNj87qC/QBFaC8TueDmEqWcgtoWZpRjscMiR8hJvyONd5VK+eNJYTjwD9JFUviMBPxVCyatXgVGiIfg/ATGB68Ro2YkEnLot4z0fz2XZ3zOHlLyw8Cc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=U0m1l/EA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rI+6hWQm; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="U0m1l/EA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rI+6hWQm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 023081D00091;
	Sun, 21 Dec 2025 12:13:53 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 21 Dec 2025 12:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766337233;
	 x=1766423633; bh=wov5WODmhOac3vGaOAlYFjt7TcUUrMMrJhfhVV6WUh4=; b=
	U0m1l/EA8j0lVt5nWCrvI0LSPt12oH4yVzRrh0PVnuqGeQVU0R+8Z5EnBn9HKqBr
	dWTLbDVIvQq+d8OUr60T9pOpbprKMPCamntfk7kZD9hTs2VAYKdqEC46xt20lr9E
	Lzt3RDCGvt7cq6bQnLveTT0+xTpi58x5kff+ZyOJMirPI0vP21cCYHpyu44cJnH1
	Rtl5Hovt3F74UHjDWgi4FFpYK3A2ZLIRoW6Tj+eK/hSInLXBjaFcKfWXl7C35+Xk
	/WrGn+S07YxyPnCsRG4VN3hC5n43wk1jSBSfRBfBVWHcN4eHeYTM0chG5j18qC/r
	LLkoIQf24XhgO8Wke9zwqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766337233; x=
	1766423633; bh=wov5WODmhOac3vGaOAlYFjt7TcUUrMMrJhfhVV6WUh4=; b=r
	I+6hWQmwCDwS2x94ReJiBaZn7vscDkWwGhjk7xpwreuGMTtzKmciJhlUQNcg6Y17
	qfwe363JDWNuhf+s7de+OqVLDyMJWxxAZXC84HKqor3x3QXO6xI/4ryDUV9OK6Lq
	Uke7GAYFTPthg5jLHg3RTWW3VYHTklOv6jCYSJASn7nhvSTTKBKJt0BVgejVbnmT
	s4IVUlrm42zykg9cbpg2LA/iniECu4ICRCKJZ9H9+mgNLQLuWOI7uetPWqcOL8NX
	jowxZGHn87+emxwiv4A4V1ePUl2x2dABHcUkWzDRS5OvFnftESv9/aKhUXK4C4bS
	cEGeG8hYu46jD8pnhekNw==
X-ME-Sender: <xms:0SpIadv4m31PpTTME8XQz3oL3rQHuqWyE2GCPyejTb2y5Ogj-UHHl90>
    <xme:0SpIaRSLcMx-Dm27KAYqVIuHTtQlo1TyOtAqPXaetB0Hl8Tfcj4ft7k-sqMZfF6ai
    yISH9TQ6YDx_TzpI3BgCasNuvIP2Zebb5LPWrULe9Z3muUyOLRfBUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0SpIaRrezf9gf1bmxYdyIvBvFLnpTaDRRw5pS-SLRDgdkCEcAggPEg>
    <xmx:0SpIabZw9RQvlZfZhf5T-lYm7RdRnzopVls97oxxsT11mP8Qu94Ctw>
    <xmx:0SpIaRT97ZVPjFIyLkr1Ja6V7C-qHVSxQVjefWbsY04veXKzCnmJQg>
    <xmx:0SpIaa46tljjzB36mTnMXA8T2QZHWa7vif-MQ3n5T99htwkLXKomHw>
    <xmx:0SpIaUkPc2wyYD6LvlSNmXed3emh3Jm2_L4cvixIWTJWz_aVygLmQ9sL>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2A2A1EA0068; Sun, 21 Dec 2025 12:13:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2fY4G7fiZDF
Date: Sun, 21 Dec 2025 18:13:33 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <ff43e66c-359f-4493-9da5-a089f15d3cf7@app.fastmail.com>
In-Reply-To: 
 <31694ab9d337d68294a5710d55fc4f7e1ff6f83a.1766170456.git.gitgitgadget@gmail.com>
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
 <pull.2016.v2.git.1766170456.gitgitgadget@gmail.com>
 <31694ab9d337d68294a5710d55fc4f7e1ff6f83a.1766170456.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 1/2] doc: fix asciidoc markup issues in several files
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025, at 19:54, Jean-No=C3=ABl Avila via GitGitGadget wr=
ote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> * fix incorrect use of backticks for markup in
>   git-checkout.adoc, git-worktree.adoc
> * switch tabs to spaces	in git-send-email.adoc list items
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>

I have reviewed these changes in v1 since the changes are the same but
split into two commits instead of one.

Beyond what the commit message says the only other thing is:

>[snip]
> ---smtp-ssl-cert-path::
> +--smtp-ssl-cert-path <path>::
>  	Path to a store of trusted CA certificates for SMTP SSL/TLS
>  	certificate validation (either a directory that has been processed
>  	by `c_rehash`, or a single file containing one or more PEM format

I only mention this for completeness (of the review).

Acked-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
