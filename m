Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5E156230
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759660301; cv=none; b=ryJ5jGfR7TxMcz+mgz6v/NP9GXPfwoHR/PFw9TSLE0+VwFR13KWLH62uxtfwE2uu8bQzpVzRkGMrDPhVNFBYDMBj+KX8KBfazlwJoMLdLhsSUfMDq0jF6TrMmKdCjivWgu3Ih/Zxi5Dq91iCyeHr6K+GqWpwyYyH3MdCc1/jKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759660301; c=relaxed/simple;
	bh=xGXROBLEVPJmditIFaYFuHOS55R8CTbMKM3VGHaYpBA=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZxNwxZViHoCfgz1wIU6UqOtwjCYN7NOL7lIOQmSnZ7OUPxLo9Eywxg96gAYNci3vkxR/jtqNJd2vhz7rJcrE6RnvOge1CsZYzeB1kHg0NDYeTEkI92ehrr/LXh+2LIbzjuOhaYuV80MOV51ZrucWAU/eiKx4d7eaoFcdjpMzFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QsAmJRxN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fe5+h+Fl; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QsAmJRxN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fe5+h+Fl"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AC628EC0122;
	Sun,  5 Oct 2025 06:31:37 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 05 Oct 2025 06:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759660297;
	 x=1759746697; bh=YXi76n7He9xMfpeCur3btRseKV6MWAFtqfkeiCM336c=; b=
	QsAmJRxNsZ9mEFpZl8Z3iWVWDw561IWqumJnhbJ+4I47sOcJha2ffCaK7W93Lr9I
	aRgdD0rgxvZrDT7rslRt2iSeRiZDm+uxEpbulWN03X8JQjauX5P88U6xwDDbNfZT
	BHjg2PZtvztxGx+7VUpNka4qxcoG09bEVkPoK0ZIYHh472xRUBqC4Cn6XCrUvHsi
	6FUD6iF0enH174nt5dMDtv6J8lTdyu/5qNg0/AuANJcRVx+GWnNSz8OoSV9ND6JQ
	krm8EIRaJ4BkZ09JHQx2cO3VKLd9TNS4AgZt97WqoHeDTlyDdSRb7KqIL7iLo2wC
	Cx8b5KzMdhPz6OEMXyOe9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759660297; x=1759746697; bh=Y
	Xi76n7He9xMfpeCur3btRseKV6MWAFtqfkeiCM336c=; b=Fe5+h+Fl/n9f1X5c+
	jEFEAWYGwTSFScSXCaU8oiqyLXkhPGL7eEJH5FLCWjCncQX8nMfgddg8Xj7DF3F4
	jmFqdTXqqqd1B1gunQHL+e9uB/L1odcPBPO/ijTjArKf7EZsghsGPVCvdnjZ+Kgj
	6M7534xfomUMWztIU5J8EjYoOjWDkxQBE6xklyJUu1dHrqZZxUEh5qjpPkENBsBv
	5Q2jEUpmdqM6io+LFOxGEIJwQZ8p32/ul0I5Hgwz2T6BQGPmjnyMSv38Zon/OhYi
	zfwgpcEqik/sQOjan6nbHPvKqa+w+a6Su+goSzICdZXzLDGSi8/IRbockENUilVm
	qpA1A==
X-ME-Sender: <xms:CUniaNpDPx9ZCEExyLgZlsckbTJsbuY32yFJQsmrz6hHmRbsipV3oGU>
    <xme:CUniaKeTbJnVMKAVxRwufsxayyK30ejS8rYI3DtJUWWmTwt-VvwqgI_wC0Wb3m0bO
    1Lk0QjkNn6NOsx3OAE10c-0nyGly2vByebToJGnMyuF-zEXnZvjki8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelgeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveei
    ledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrsh
    hilhgrrhgthhhirgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CUniaIVVquf1NV0YJAwc00os10UeESTuBDCGPQ_kLVq3oF6vh9z_Vg>
    <xmx:CUniaKgw0gC02ulKz2hC20o6oz0TjQUw-MijvM7bSTgeUXJZl2sqBg>
    <xmx:CUniaD8l3KW13p2ezEEuLVqYJ9JnSHzc0MQkyfWJs6aNoycdsHvI8Q>
    <xmx:CUniaEBh3v126PKJU1NQj3QRsSr_sU9p2vNcl44GovPAgwhaYcNKpA>
    <xmx:CUniaLPKWSy7S1_Q6gPc-lEG_6BmvCFpLK8OrqizBT4_C8MS1TpK0fnA>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5EBBD1EA0068; Sun,  5 Oct 2025 06:31:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKp_x5_8Y8vk
Date: Sun, 05 Oct 2025 12:31:16 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeffery Carr" <basilarchia@gmail.com>, git@vger.kernel.org
Message-Id: <b3a8dd87-fdab-41cc-b221-b62aa7f74387@app.fastmail.com>
In-Reply-To: 
 <CA+Hr9go-jyDeau8HVi+fUuiTTgAS_SNgyGL9x660+GzGJZJBEQ@mail.gmail.com>
References: 
 <CA+Hr9go-jyDeau8HVi+fUuiTTgAS_SNgyGL9x660+GzGJZJBEQ@mail.gmail.com>
Subject: Re: git whatchanged -- yes, I still use this
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025, at 04:14, Jeffery Carr wrote:
> If you are going to remove it, "alias" it to something.

Git doesn=E2=80=99t have built-in aliases, if you mean Git aliases more
literally.  If not then it already acts as a sort of alias, I guess.

> alternatively, I guess I'll make "git-whatchanged" binary to do it.

This command is being removed because git-log(1) supplanted it over 12
years ago. Both commands use the same machinery, just with different
defaults.

Here=E2=80=99s how to replace it with git-log(1):

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).

> I'd also suggest, instead of the message:
>
>[snip]
> add to the message:
>
> <run this instead>

This is coming in the next versions.
