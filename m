Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8B171658
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244739; cv=none; b=tcFYlceYCizZ4W9j8q78xU5qoKqSYOkdtRzPvo94ImbdK/s+aEuvUib0P9PgpBhpFJxK3PEpzE6hvDyF1qk950/fqKAqaLNQ4+fdjoWhupTPqqXv1MQLT3BuTOL3SfWUemiBildKEQcl5k/xlaUTUI0DgLchjjq7zevFlNVciJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244739; c=relaxed/simple;
	bh=Xy74JhJ+wqaaD9e0AU38HLo4b0bxlJLFE1w0V79treQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aArh4omtyhZFQMsYB0Y6KXsJR33Z9PSgNhxZQKKcjycCMOHneRIKfDyhG7bhTs4uF0hW0OzNGICDq7275nwQH5LZhisSw8at7o2BRstM4GPiLkKU6zdRgMJgvqIrqhc611VEfSYjq4hc2AnsMNM30oRio4ZWlzmZE819SrEcHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cYF4o46u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVbFLIAa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cYF4o46u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVbFLIAa"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 061621382E0D;
	Mon, 17 Mar 2025 16:52:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 17 Mar 2025 16:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742244736;
	 x=1742331136; bh=mLHn0Z9C8fhhX8hSyfdKlqywlAmF4O5c/KX+YTnZQ90=; b=
	cYF4o46uQuSbVvMopKodvcJGESUaZNCvNyEyRzXHM9mV6Hzl/UW3ag46ism88sKl
	cBA+DB9sy3Gved/RpXI9K7Hni0dkQ2xoSDk5yWPaR6Yap2l5Ovyq+hjuf3JCh+PW
	/o7XYt/ONdDAbLRqNUwLkZfesJXjAbZf7DcZFNzFujGHJvqzjSgU3aulJyLt2JVh
	jd1kpnAEwMT5vfT3nYbs8UylysTgdUlfZIsCCgf/a9+dV6uks2i58acavnz0zm00
	r++N8mmEVLwIKK1F3ByqsiqkRpEyZZ5+beBLxPMe14QEFYqMrVJeEf9Swl5WEuKZ
	xGOUeiSIV8SaD4/QgfE9hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742244736; x=
	1742331136; bh=mLHn0Z9C8fhhX8hSyfdKlqywlAmF4O5c/KX+YTnZQ90=; b=Z
	VbFLIAav7iS7zsPLCEJob3DNw1AItZWUwgSnccz56Fp82vnMNdpjjIUtf/o7VLlD
	9U60Bd1toruI6fZuxSNtnuc6JFu9dtjadtUWocE0GHO1KhjpLqYioYVUKZqKbfaT
	Dm2al2xqxiojFv5+BSDK175kolIC7OiilEokQ4HjQbKWGBtApo5UJCbEf8888MQW
	aMd3Y+5ZOgPmr69Jf7Kee2j/upJu6c8ow3q3YZR7x+kGkBnQShI/phHsNqfB6OUo
	CwBUxp8o7tpOeJguOMGKQq3KQq8LTNWLMHk5iwGksuZRDnSHn10t+c4IA/dFw8ME
	99PMY0vBpPA7sX89qonCA==
X-ME-Sender: <xms:f4vYZ7R2keR2kDXVdxOF3SR9C9sqAul7KDWrsJ0rhzJAWVCC6OND4Q>
    <xme:f4vYZ8xee9CytfRLchsbTtjIXWfvOcXPVldSA-YyU_nP0TGViBSDk0_exc-90dQJw
    ZMYN21Je4HmEXCXXA>
X-ME-Received: <xmr:f4vYZw39It9j6EEjIoqhlBxtVBnGXfke9umhdpnyNFAWa3U5jY7kfyK6i4ilTYLx3NDzCq2ZTdQBfcDLP34xKGuj_9vXVEpmUZnjm_U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:f4vYZ7DYHkR9nCneELC3HRT9Bpx2oz5fftjF-BPCn29Z3sd7i8h24w>
    <xmx:f4vYZ0gnVFZeYPn_8FPCe1iRhh6jfd3otCt5V4n0GqmU6ciMjzfITw>
    <xmx:f4vYZ_oFZoT3zfpSEUYhEES8dqi6TtH3LVM1NyxT5C9aH42Dij4A9g>
    <xmx:f4vYZ_i45Mm1G-VIarnKO8tpzsJ9TZcx0thg925She_EzO7xT80bGg>
    <xmx:gIvYZ8duJy7RA0qyaaepNr0QlJu_kmwGIcick8P8ePsKbsQFFokpcwDb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 16:52:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 1/2] completion: take into account the formatting
 backticks for options
In-Reply-To: <f8883d83f3096ce16e5dfc9647a41970396693f4.1742056310.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Sat,
 15 Mar 2025
	16:31:49 +0000")
References: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
	<f8883d83f3096ce16e5dfc9647a41970396693f4.1742056310.git.gitgitgadget@gmail.com>
Date: Mon, 17 Mar 2025 13:52:13 -0700
Message-ID: <xmqqplif8jnm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>
> With the modern formatting of the manpages, the options and commands are now
> backticked in their definition lists. This patch updates the generation of
> the completion list to take into account this new format.
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  generate-configlist.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index dffdaada8b5..802178daad4 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -13,8 +13,8 @@ print_config_list () {
>  	cat <<EOF
>  static const char *config_name_list[] = {
>  EOF
> -	grep -h '^[a-zA-Z].*\..*::$' "$SOURCE_DIR"/Documentation/*config.adoc "$SOURCE_DIR"/Documentation/config/*.adoc |
> -	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
> +	grep -h '^`\?[a-zA-Z].*\..*`\?::$' "$SOURCE_DIR"/Documentation/*config.adoc "$SOURCE_DIR"/Documentation/config/*.adoc |

Using \? in BRE as a short-hand for \{0,1\} (or trying to use any
single regexp magic in BRE by adding a backslash when that magic is
only available in ERE) is a GNUism, isn't it?

We probably should rewrite the thing as ERE, perhaps like

	grep -E -h '^`?[a-zA-Z].*\..*`?::$' ...

Also, if we can avoid piping grep into sed or awk, we should do so,
when it does not lose readability.  Perhaps we can do something like

	sed -E -n -e '/... that pattern .../{
		/deprecated/d;
		s/::$//;
		...
	}' "$SOURCE_DIR"/Documentation/*config.adoc ... |
        sort |
	...

in this case?

> +	sed '/deprecated/d; s/::$//; s/`//g; s/,  */\n/g' |
>  	sort |
>  	sed 's/^.*$/	"&",/'
>  	cat <<EOF
