Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87E12E7E
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738275751; cv=none; b=La63QjfN76y2Nkaj7gaoXPtNt7gECc//A3FO8i6kOZ7MRFB/UWmt266/dYmcjGSEzGkjEOhGYw5QVTyx2MpFSBjlmSB3v9hwE3lQW1tqAtJ83yzanqHK7RjYzfCejZ0G+Lg0kPzCsdevoBWWmCskYtpiEnsynohb+iy+6cN9rrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738275751; c=relaxed/simple;
	bh=4sKxjyl4f3h4DWUuyAas+eUwB5hhXXBOy5jj0k8h/QQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HPR8mBG+AJX52O3K4PHrhY9J/QfyoWrk21kpQtjI/QJyyoCGYhzmWH8dU2vNPWQPDHmGMJHj01rc2x8mPsWQfzJNB+Kt1KECr/1WjzZO11BnyTaI8hZxXhzOWisjl4BbbYl4cLslAdSaGBucxUHCmwD6BIlI8CjX8rVOj2t6DPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J+TQb0Me; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=boBn3ygP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J+TQb0Me";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="boBn3ygP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 331F9138016A;
	Thu, 30 Jan 2025 17:22:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 30 Jan 2025 17:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738275748;
	 x=1738362148; bh=KoeNlU5Mqa9N5eMv6+peiHoRBkS3vFhi+vkPqTIYyW0=; b=
	J+TQb0Me+awEGnT2w3c54l6pC+MRT9dt2jKEQkGAxrk1XNnc16fPS78uDQStOfNG
	vgmFjT8aqZFYam4jNZHBtrtoPAMhUpVPE0rSTWEcsTMnuHY5xPrIpzmmNU1okbMy
	1cjghKcyOaf4hhPurGuwaftG/QUKDo8scCJk7zzJ0Dy6ufpVI/vuoPmMsxrO4Zsk
	yxdofvFjLjBZ9LCN8bdSkU0h7sgxzHSaCS8gRzHybzWU+lEB50v2s1yn7xIgsb9y
	nYgDacl8hwH+kr/+XHlTvDTndbaBoZFnjCN0VPN23PAypCGVsHZjW04e30by9BXF
	RrlgXhjVgIUjNIPpkL1Ijw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738275748; x=
	1738362148; bh=KoeNlU5Mqa9N5eMv6+peiHoRBkS3vFhi+vkPqTIYyW0=; b=b
	oBn3ygPL4vHbKkKhQwiIuJCdEItZTlGbiRdhFZFbsRoA9bMEtXk1piYaq2yv6BXb
	vCrHLy8jVzzI3Es5f8ifU7e1YJTsaktfPBrPzuzR1egIQpGAUzNzTw5hmJWThS7I
	wuuF8F/bEpqradrICb7pdj5g1xHSEi3rcDhmx4cpvGKxkOiUUxbJik+fd9ANAcSS
	jyihX/NvNZ+PuEAVy8lv1KlgGryrvKqzDCEohj/hHuJixVlquv3Sy8IbMKDp0mLy
	2WO2GJtvwOWDsbbt+89FWIOBjumSQbRonbH7IWWFUwnC+3de/Tb3vkyxs2fZ9oOz
	yiCVDjdTswZ5B8TD35Slg==
X-ME-Sender: <xms:o_ubZ0DZT6racQ2Mcu6MR-4EAnAHNKlpaJnXNWmNMr3r10-24Zlmgw>
    <xme:o_ubZ2gcJVAgSaqtocuoQ-NUaKBLW8xf2H3vU8_udTgsm43NZWeqLY_sectk1Pug4
    zCl7Pt-YDSMDEsUCw>
X-ME-Received: <xmr:o_ubZ3ngks4AfQoIIiZnwZzSatOzCvZyusP_pn7FKMrVYgRk1XZkCsoslCCfsdsTuQ9qZYZ0mNOYqfb58mRbWQlVoJ499d9tOkps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvfiesvg
    hmrghilhgtrghrthgvrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:o_ubZ6y1pQyNXZIYm2mz9lvxF1qccjv4nd4PTQMj_7rKv1fFw52QHg>
    <xmx:o_ubZ5SmmiKcOXp9VViZwDGSh2-L-XxqHT7pPMjxHdgEAYPF4svUtQ>
    <xmx:o_ubZ1aB2BbUgZANeS8LP3KQ49mcaPTaWoV2ko942TZ03nCdHZOhBg>
    <xmx:o_ubZyTnR4AyGUIzw9XROCPN0gONnEALsUethxcVTBaopos10Cr77g>
    <xmx:pPubZ3O2-UqTeUz7Iklmgb_XhnxBwimJIgLONpxBOB9vVZwDhr43mU_L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 17:22:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Carter <andrew@emailcarter.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] docs: indicate http.sslCertType and sslKeyType
In-Reply-To: <dd5d9b93-1585-4165-8f5d-d9737725071e@emailcarter.com> (Andrew
	Carter's message of "Thu, 30 Jan 2025 07:18:08 -0600")
References: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
	<dd5d9b93-1585-4165-8f5d-d9737725071e@emailcarter.com>
Date: Thu, 30 Jan 2025 14:22:26 -0800
Message-ID: <xmqqa5b8aqn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Andrew Carter <andrew@emailcarter.com> writes:

> 0a01d41ee4 (http: add support for different sslcert and sslkey types.,
> 2023-03-20) added useful SSL config options, but did not document them.
>
> Signed-off-by: Andrew Carter <andrew@emailcarter.com>
> ---
>  Documentation/config/http.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

warning: Patch sent with format=flowed; space at the end of lines might be lost.
error: corrupt patch at line 10
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Applying: docs: indicate http.sslCertType and sslKeyType
Patch failed at 0001 docs: indicate http.sslCertType and sslKeyType

I thought that the initial iteration I received from you on Jan 23rd
was just fine.  Did you change some settings with your MUA?  The patch
is heavily whitespace damaged, with full of &nbsp;.


> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
> index a14371b5c9..38e874307b 100644
> --- a/Documentation/config/http.txt
> +++ b/Documentation/config/http.txt
> @@ -216,6 +216,21 @@ http.sslBackend::
>      This option is ignored if cURL lacks support for choosing the SSL
>      backend at runtime.
>
> +http.sslCertType::
> +    Type of client certificate used when fetching or pushing over HTTPS.
> +    "PEM", "DER" are supported when using openssl or gnutls backends. "P12"
> +    is supported on "openssl", "schannel", "securetransport", and
> gnutls 8.11+.
> +    See also libcurl `CURLOPT_SSLCERTTYPE`. Can be overridden by the
> +    `GIT_SSL_CERT_TYPE` environment variable.
> +
> +http.sslKeyType::
> +    Type of client private key used when fetching or pushing over
> HTTPS. (e.g.
> +    "PEM", "DER", or "ENG"). Only applicable when using "openssl"
> backend. "DER"
> +    is not supported with openssl. Particularly useful when set to
> "ENG" for
> +    authenticating with PKCS#11 tokens, with a PKCS#11 URL in sslCert
> option.
> +    See also libcurl `CURLOPT_SSLCERTTYPE`. Can be overridden by the
> +    `GIT_SSL_KEY_TYPE` environment variable.
> +
>  http.schannelCheckRevoke::
>      Used to enforce or disable certificate revocation checks in cURL
>      when http.sslBackend is set to "schannel". Defaults to `true` if
