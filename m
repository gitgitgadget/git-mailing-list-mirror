Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2A1BEF87
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824996; cv=none; b=aGoxbsyPeGsGY4IYMhSW3tggJDK3VA17K1pIXGyZ6V8ex6kFYFiu4r28WK5BAeJYbWPUhup06m2rkA4guFHU5V5d9DlyfzmY0Ty47XnRbuYGl/1FaqEd2yQ9PzPt4IT0C+TT9PJ9GHiAZ30q5lKU1h0arLyFxY1ztKo39tkfQAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824996; c=relaxed/simple;
	bh=cxfKpOjjPRCO8jERjIYgp7VBv9N7x5Ss87YzfBb5M5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e0eb2vupItY6w6WxtbKBNNEvsF8I5Dvq49cWFSlnw6pBYQh6NH4QAXkwE1O7605mDUvSWgsiFwXCMEDstn0br0TpvxrJwie2V2hG9DHNRyjKL3A611UxRLrMsmCNQEc6R/E2jB6t5s9A5hOGgC3oPuOxSfG7MfjiqbMB9EfLYw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K+9DEDPB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LfezpBuI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K+9DEDPB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LfezpBuI"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 339F71140091;
	Sun,  1 Jun 2025 20:43:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sun, 01 Jun 2025 20:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748824994; x=1748911394; bh=JvvOoAPOd8
	JkOW918OnldVACSv6UyzChuFV/kgV77I8=; b=K+9DEDPBJlpahJI5Y4wiJtq0Tf
	im3nHWMhn+c9OExCrtb69VyM1I0VRaw/2Q90jFsd2ASlAeIr1Pp13CExLjALdS4v
	qSiAzV4NN+UxOAS9Uy/cFHrrFALicXzAOJbFU4cNq9o9EYlovC3lEIKdzKrca4rX
	7gr0I2KjCO/HlMOeSJ0NzolNHfdGKS4djKksk5VRl0BaQ6hN/AxgYB+/PdHlcIRM
	FuoIP5LczHAOEJInVCHk5d1FBi/Tqw85iLap+dewH1IiIrg3v60WP2wmLtQQmMpk
	eiNpjew6drJbmpo5nhW2/9dJtO2Fm5Yc0eSbFpRBBHcfaBNUM3GDLA1LCKeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748824994; x=1748911394; bh=JvvOoAPOd8JkOW918OnldVACSv6UyzChuFV
	/kgV77I8=; b=LfezpBuIttKu2CliYf7fkpTv6VFwqYZQ7R2GJSEnlRfuukxhciM
	wWI+EalttFpdXdP1CqPtXHb+8BC3YPS360AmhiHLZWbxSqcUt9DT5sKz/AWI7zOx
	JvVKXhupB8ojYWAN8Ws5g5Y3Ch9uOt03wFQrLhpxtw63GcfsFuUtBHrhh13t9fDk
	YiGp6nqVnFuWil9ARG1Yfz6k/EHJnKCxXACfCjgKJSJKG0n0zqH7Fosee3eTrRlG
	+lc3i7A1svcaUGB15X5WFuN2FAi+S+TT0fS38XsG8JbBWAmUw7CeNZlv/twjp28x
	IXBPmGPcosKU2OiT+/9AjjS0gDyGmkF2Y4Q==
X-ME-Sender: <xms:ofM8aAce3OHAGoIHHsO2wmX5-vmWFowtQMj7ZEQhwfLZpk_lNjjDQA>
    <xme:ofM8aCMvHfb2_3JM1LUNJE-1TBOdERDcJvlFmjLnzJ9Fd9kNEHiOfy_KUx407bVS1
    I6sTklF-g2OMSfWwA>
X-ME-Received: <xmr:ofM8aBjcashWmWQUhHmV_Fwk9vcLu9Fv3uA7fJz9voEaQDwZ-lGHBHvo6JPMQikYaUMRvPr08R0eKf1549PH58Nlw0GhSIEjnWPb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefiedvieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepiihihigrohesughishhrohhothdr
    ohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvg
    drnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:ofM8aF-yQFKnN_eBf9xkVKYIqJRvtvAyD3GIKV5mfIuyOzOVLncVPQ>
    <xmx:ofM8aMsQpTOoPVjIf95j2y5G-jKoU2THmORDXUwsVNDy5BEdLVdveA>
    <xmx:ofM8aMEkaVA-8vIAUIWo_YqDGjrz8zYzHrVke4B17Bh5j22myjVzXQ>
    <xmx:ofM8aLOdU2bPlEMBLgXl3uN6jXdsCq4Bf1b1VNzdLGy5WgwrToIVBQ>
    <xmx:ovM8aNJiLHms0N-NmYHQ44Y6lGhg9ILQ_WCU0hnplh3dy-m2C1NvRs3K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jun 2025 20:43:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben
 Knoble <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v11 8/9] imap-send: display the destination mailbox when
 sending a message
In-Reply-To: <20250601083821.2440110-9-gargaditya08@live.com> (Aditya Garg's
	message of "Sun, 1 Jun 2025 08:38:57 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250601083821.2440110-1-gargaditya08@live.com>
	<20250601083821.2440110-9-gargaditya08@live.com>
Date: Sun, 01 Jun 2025 17:43:12 -0700
Message-ID: <xmqq4iwzvuqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Whenever we sent a message using the `imap-send` command, it would
> display a log showing the number of messages which are to be sent.
> For example:
>
>     Sending 1 message
>      100% (1/1) done
>
> This had been made more informative by adding the name of the destination
> folder as well:
>
>     Sending 1 message to Drafts folder...

Nice ;-)

>      100% (1/1) done
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  imap-send.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 9c3c8d8c3c..3565a91ca3 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1599,7 +1599,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
>  	}
>  	ctx->name = server->folder;
>  
> -	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
> +	fprintf(stderr, "Sending %d message%s to %s folder...\n",
> +		total, (total != 1) ? "s" : "", server->folder);
>  	while (1) {
>  		unsigned percent = n * 100 / total;
>  
> @@ -1708,7 +1709,8 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>  	curl = setup_curl(server, &cred);
>  	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
>  
> -	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
> +	fprintf(stderr, "Sending %d message%s to %s folder...\n",
> +		total, (total != 1) ? "s" : "", server->folder);
>  	while (1) {
>  		unsigned percent = n * 100 / total;
>  		int prev_len;
