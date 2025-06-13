Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F95146A72
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841606; cv=none; b=ltwGB16IscBbF9EBlDZcXlO1sjbKdyZMQNuVDwBWNwplZ2dJtsysA298jTgo7yWJF6dtl+OkoagdQKqudwwv/ywY0BK0JfQTQNhIz5piyTVIb6UN2f49ENe5kDuOUJvBEvVp5PRHfaxviEddZ+FPb57dIb0PiIjtmzUfid0b2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841606; c=relaxed/simple;
	bh=bxV6RwF5LY4eC7VCXTpU0C/+/YKuu8LZhJiY0pupZ7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KzjVHeH0zBAaybU5mQpCWkQXOo1komUWKlSqG7W8g9YcPdjfosvpvFDxNVTI5rvyCxbXLrZbQ1yTbiyQ1/aJXENNh/B6sZh2PCDHbb9qLdZfncmoQK95zCDP9jL75eqs9f+t9owDF/wX5N0QFRZV42z5bJQSrU3NhNw8Ksk2DDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aFO673Yk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kq8GZDi8; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aFO673Yk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kq8GZDi8"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 668501380362;
	Fri, 13 Jun 2025 15:06:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 13 Jun 2025 15:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749841603;
	 x=1749928003; bh=LPDdk545vf6Me9VOCz5/i5vctMI9Ed5oPfq/W0rEjRA=; b=
	aFO673Yk6aWhKxZ75zqQ9I1tGWdduIBYGxpG4xx5xn16fbWDVzxBqrdynsuaa1Qh
	n9AYNQFRzpKkh/DWKqEv6BcErfN6GmFN7Ud3GrzNmNsiQCHk54CzncBm/imsxk3q
	z7jkl8u+bjHyuNERwtxPPFHJr6heG6XKmqbPVLPAQB3AsjzkQt6GabSzdUEyejGb
	zQRlCDIV3jeb/TKx0Qq4ELmlrwK1O/4axeEm71JFUAtkBl/Onf8xmWPKn+EyJmLt
	NC/XM3S6nZkr5PWWHSkaFI3CmKJWCst75TAljfUKm11t0PYL3RA/uFEqeZSeNlIf
	JHH2yTDA01Wss7wouvIvRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749841603; x=
	1749928003; bh=LPDdk545vf6Me9VOCz5/i5vctMI9Ed5oPfq/W0rEjRA=; b=K
	q8GZDi8qNDo8XjxjTQx8P+Jy4DTnJsJrN+tgZwBF1qv5UDuGmdpfQq748wPdQDhe
	U3le+9k2vbCEk1qqlodNeiOUwBJdNajaTXkhdxpopGaEt5Sb+Wn5xoekv8bFBNx8
	ofmnLumnKtIZ3rtd9BMoG/KIdASshqogsqhz3IXTjzVKyBOBwDOY4pPIBVZ3E0mZ
	NX/G6YRcS63SkLDroE5BToy8bI2DukGnZeCEP1yxVvXeCkJS5oD0KHCnUaxj9q0I
	+PEWHSDUnDhsEenn+KJFjlR2WYeg+cDaC4KvqPSlX23Eb3FIB/0RfmOqwpI9ilM3
	8madyor+8p96fZUdBR0tQ==
X-ME-Sender: <xms:w3ZMaEU2xdK3GiLDGd4yQeUuZRBow691tNaruJHo22Kq1oU5JYORaA>
    <xme:w3ZMaIk1TBKySbKMgRqcwwLli4mJ5edEAdAU0ZwcDonQhu3o9LOMrpCk_MRVPXMos
    0JYKElm1v9RiM-dQw>
X-ME-Received: <xmr:w3ZMaIY5OGJ_NCkE32LPEr7uq4h7AZFkv4A_pIaWyGIx8AZHqopHAjwMM5UfTcsK9SZ-fCLvkd2BgJ9yiTh-Qd5R3nmq0ZO0Vadq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhuohekgeeise
    hpuhhrughuvgdrvgguuhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghlvgigghhuohdutddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:w3ZMaDVOCtZGisRL7SOmdau3-oiVcef6TQF9N0ZO3HHhnkuOXR3wnA>
    <xmx:w3ZMaOmuxq86O24V5CKsgCLfoCAsJj55LvY_ouSy4e4umeWVj4izJA>
    <xmx:w3ZMaIdrcCZvhFmotUdD3xSn48IKhaSZDZHsw1OT_Ge3NwUxzmlBvQ>
    <xmx:w3ZMaAGkigPs3lip634g2yhuwb3FdPS9xaODh7E2AdscyukMra_9jA>
    <xmx:w3ZMaPJuMBYNSS3512dy17jNET-HNCsKhP9qBXMrKjW9QMhN5ztlpB8x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 15:06:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jinyao Guo <guo846@purdue.edu>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  "git@vger.kernel.org" <git@vger.kernel.org>,
  Alex <alexguo1023@gmail.com>
Subject: Re: [PATCH] Fix memory leak in function handle_content_type
In-Reply-To: <SA1PR22MB3999874B7FD9FFF7D90C9F89E477A@SA1PR22MB3999.namprd22.prod.outlook.com>
	(Jinyao Guo's message of "Fri, 13 Jun 2025 18:36:42 +0000")
References: <pull.1997.git.git.1749833577767.gitgitgadget@gmail.com>
	<44066126-ece9-4c77-b38a-292b6f748955@app.fastmail.com>
	<SA1PR22MB3999874B7FD9FFF7D90C9F89E477A@SA1PR22MB3999.namprd22.prod.outlook.com>
Date: Fri, 13 Jun 2025 12:06:41 -0700
Message-ID: <xmqq7c1f8nr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jinyao Guo <guo846@purdue.edu> writes:

> ... I believe
> the confusion came from using two different Git identities.  I’ve
> now added individual “Signed-off-by” lines for both accounts.

Please do not do this, if these two are the same single person.

Instead, pick the one you want to be known as to this community, and
use that consistently while working on this project.

Thanks.
