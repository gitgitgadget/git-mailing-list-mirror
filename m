Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4D46B8
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271398; cv=none; b=M8/n/7qABHiQ6vjwbFYtwJ+B4cVry+ePoZTBXta6Z9KiNthMbS2hqwIX1C0/nalzAjA3B1+Iteetd4dz0QPU8QVZcI2gwefDgOdoBZfmDv/LHROM+LnFvR4rioP6ikotzbODUc1+4I0a2PoceG5fQQAetnVmXW3ouIiHFz1yVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271398; c=relaxed/simple;
	bh=IxjThvtTjHNYBk/CVsc4+JFH0DH8YNZslXP20nAatAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r72kEiWcWeSrkyi+AEhc16bYcuTd9qyT+LwOzqF1VDO5acanSDB2MCjogP/FC0BHRcYMIg7brZqVCEX2F4379KE1tezFOyYXO7qrfW2zPnOWYtuk1U9Qb4o+hnZWeSyXfcJlPgLqDtpC/vhGg3pltSPwlELpfWVSHJsihJKR7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ObGz9fjw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pIKYiX+Q; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ObGz9fjw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pIKYiX+Q"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E93041140256;
	Tue, 18 Mar 2025 00:16:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 18 Mar 2025 00:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742271394;
	 x=1742357794; bh=0B4zb1/PPn4gTLzXj6UabJXbiwzfuSoOyTiZEkPWz2Q=; b=
	ObGz9fjwIlwZQzkUTO8oLe+CiZAJhLKgS6XYLGLZYPXsNLIef21t+5Ly81eVxdPR
	H9UIgTI5mcXG7nYHDBnKGadE9YTiRox6LQpVqoDUtP3KM26Bu6L+imjWEvnGQjOf
	tGM68ffCT/lcDuSUG05mn9bw7NhjSQq/eB9Yl4iGLvdhSz7y7ENlmeBcnQ8vs/KG
	fDeEgNpGeSSvPpwTnFjoPHGoFg6QQC511ksZDHUJX/O5BUoJYfvrpnLDWpIxoG0N
	udEMU2WVsf4A8NApoEZ86nl5aqAMseBWSffx1CNxyta4JpWWQpG/ORVsgUavZ1cK
	bxKrY1/fxin0ZuiGkAgIIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742271394; x=
	1742357794; bh=0B4zb1/PPn4gTLzXj6UabJXbiwzfuSoOyTiZEkPWz2Q=; b=p
	IKYiX+Q8TCvvXC3FFpz1a0KncURFy5R5AZjdOnXJg+JvmszoZ+OPAN6yKdV6xGwg
	kwAqySnTu2pK3c8By/PxlSxLSgUkyD3a0gj9vydSurGFJezTg/cnFvnaVR/QrZ1p
	rbAAR2ycl+0OM9BKUi7MG0XBRzzyk+pDczIXLPwTdLLPDAgxgmAs89SHdxwKHYK3
	NGUleVwUSLX6I6qEndrPJEYRmNMneogNbMSzoAxFrZDBMUkLPlyUhbwQOz/F60hF
	t0AuaxAI1JluNLhA48+IDgZdSsxiGkS0DXZ4ivz4YrdCcLXU7YEpIIgCWhbrpMS5
	dG0KfRORN0Li4scD0GURQ==
X-ME-Sender: <xms:ovPYZxq7KYAjM_s7LGbPypT4G8BBPlep1lua1FAMTjzNgzHnYOxJMw>
    <xme:ovPYZzoizF-4OgNeBmYDuQJn9Yi06gB2IFyum5jTn2TDWNH_PoVhhhgbXQ4JXkFYP
    fJvNiMW3w-5mkIoKQ>
X-ME-Received: <xmr:ovPYZ-MGgwEFcP3LS_q2oDj-i6JiEuPV5DKpBozf3t7m1v1snQEzP3RxQbfHF4LUo2WMqBb4Ly-fb_3nLk5OrLkpYt0x_UsTnOH6WDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ovPYZ85MIdW8ZzUmaTulW5BXjrB0p0RPDYTBJnPK2vDoYdddGfd44g>
    <xmx:ovPYZw6MWlgDC2hb2eEfsPtVH8_3wG5qPrfkp1GsPJL3Ge7ykCVfng>
    <xmx:ovPYZ0jSMLrUJ2Bg2lrCrISXOhd7MoY4A8SLdHufWyBgrLIsmyovGw>
    <xmx:ovPYZy7Ks-B_n3dOLjSzxBd_4owpoxRujjJ41jBWxzvFdJOKzex1cg>
    <xmx:ovPYZ6SEbrCF9A0PhV1FD3V0K9FfJeZGCLgFoQOTL6XK9vm2ZFIlFTfM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 00:16:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/2] completion: take into account the formatting
 backticks for options
In-Reply-To: <2773494.mvXUDI8C0e@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Tue, 18 Mar 2025 04:58:51 +0100")
References: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
	<f8883d83f3096ce16e5dfc9647a41970396693f4.1742056310.git.gitgitgadget@gmail.com>
	<xmqqplif8jnm.fsf@gitster.g> <2773494.mvXUDI8C0e@cayenne>
Date: Mon, 17 Mar 2025 21:16:32 -0700
Message-ID: <xmqq1puv55y7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> For the GNUism, the tests on MacOS and Windows by gitgitgadget passed. But I 
> get your point and will reroll.

Is there a good test in our test suite that validates the output of
this script?  I had an impression that even if the regexp match by
this grep were a bit off, the only end-user visible effect of such a
breakage is that some entries from config_name_list[] may be missing
when "git help --config-for-completion" is called, but I do not
think of any sensible way to notice that some entries are missing or
extra entries exist in the output.  So unless the regexp is broken
so badly that makes the resulting config-list.h syntactically
incorrect, it is unlikely that our test suite would catch anything,
I suspect.

If I deliberately break the regexp (this is before your patch), it
does not seem to break t0012 (which uses --config-for-completion).

 generate-configlist.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/generate-configlist.sh w/generate-configlist.sh
index dffdaada8b..a6eb9739ea 100755
--- c/generate-configlist.sh
+++ w/generate-configlist.sh
@@ -13,7 +13,7 @@ print_config_list () {
 	cat <<EOF
 static const char *config_name_list[] = {
 EOF
-	grep -h '^[a-zA-Z].*\..*::$' "$SOURCE_DIR"/Documentation/*config.adoc "$SOURCE_DIR"/Documentation/config/*.adoc |
+	grep -h '^[a-uA-Z].*\..*::$' "$SOURCE_DIR"/Documentation/*config.adoc "$SOURCE_DIR"/Documentation/config/*.adoc |
 	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
 	sort |
 	sed 's/^.*$/	"&",/'



