Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF572E1726
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767874; cv=none; b=XHIOd+XSQpKYXXLrsf5P+sJkcURnLj6moVPtC6W7IulxzOF3ez21mtQ1HuP1kuPx846RmgAX30HtdwJ+Wxql0N16k1c3vwzY0JzWPxLDXDFoL9gT/U7tYAQsVDnPXax1Qn006Z4ArkJ4b/ovb268JpJfGneHllefDB8FlUQH1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767874; c=relaxed/simple;
	bh=ycdKCF/I5Ar9Lu3nO0bHgmCE7qZ0nyOhqmMcu8X8B64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=brsZFx7HF6EBXRHAwiF/VA+vj5b3lL+GYpyzSxZy29YPkrnQQO81IlIW5biykAljzJeA8ctl1Yn/aWCft83eIsv0GHPhe5mo6uZC87cnWLN7oW4PEaHap/tTuKGcqZ5G7LtzNit0//bk4Q/umXygbDjuIdcTpD0hUZ+THSNbVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iH8dggyr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfXEZd8p; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iH8dggyr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfXEZd8p"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 20BB125401B0;
	Thu, 12 Jun 2025 18:37:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 12 Jun 2025 18:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749767871;
	 x=1749854271; bh=Rql3nXv+WRuiZV/QZTNegGKZo+glvZdYG2BcMbxmzJU=; b=
	iH8dggyr09pxGRPE4bAzkbGOMilPCWhjubg7EyaMDJ5ecc8dQHK62u9C45FXyDug
	xZ9rWStc+eCqsbtPWMcmBBNPEkHLHQNXwjuhlel1rm5kVTfNvhigv4eljZRwp8o4
	aJJ6xB7PVqjWc8XPPYeRu6aIoN7SmjVp1cfmJ2cnpzvpFtVkGGzS4Kpq4iU+au6k
	d+RYbd0IuVnwnqs55VbWElTKpZgCAPztGkzF8DprhnPsIgjy6xn8cv1Cc5NpYjjJ
	Ncgy8iDTGm/7ie8/U1hhu9QyOh3ycI49D+9DnFDMHuY3tSPeWni5amNisH4noqbK
	FdY37S34cKEAiQITJWTBwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749767871; x=
	1749854271; bh=Rql3nXv+WRuiZV/QZTNegGKZo+glvZdYG2BcMbxmzJU=; b=P
	fXEZd8pj5qqZ3YfaLbdX1k5S0xfLDAVw7QnbCJckjhj8/P2SfczC3yNIjdQXWC1i
	5yVuDiGbhiMluKzjHdj1uNzXSAErNvcTKY9Gw2IxFL0ZbOtxnmTzxRfrmHGVL2dF
	krCbZ9hf13gO4LZNr0QztYDhFBLUHUYPAJ8dqvVbSpXMo+iZk0SS1ZWp769sTEvp
	CI6dKBMmDd179qrQ18oyLHmxilzuof559D8udNvzawdyt4itycRE2Yu6KweeFbv/
	aTMIBk3/+wdzLFMy34jZm3wbHKug9Bzbn8wvncA6ABtDciYzrmCW0lkEcJrS2fYX
	+DoL0yMPRnuNkObROs10Q==
X-ME-Sender: <xms:v1ZLaDSbo01TMbAaL0p3uuvhJz8Ap4UCJikBqE21I-nAjK6p00l6ZQ>
    <xme:v1ZLaEzp_3-oAdmkYmC50kIrnVqWz6WOTZ1TSAC1YFL5Pyn43kNd3XfVj6OI_jq8V
    u755b7BvnwdZdRkjg>
X-ME-Received: <xmr:v1ZLaI31AF1FwdmUt674ssYPS1G_eAY6ls4ugIKB2yiUnAMIwwG0IkvosqC0ZnI1YiWxjvIhijfz1P6hwBPhopFh0maoeTczcfZJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduiedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrsh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsghrrggusegtohhmshhthihlvgdrtghomhdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:v1ZLaDCn5F59-XzKYNfcVRYncFZdfBtXvcIEbQF8t0-oQPD9WQslig>
    <xmx:v1ZLaMgTFNID7SILMaUfHblpEQbw7xHn-VL1KZep89kgi4REQSMvkA>
    <xmx:v1ZLaHq4mKn_FFc4bl-kDuLItj6EicvlacMl3xLAV6qpucdSer2ugA>
    <xmx:v1ZLaHi52bo8YzSygMZ4ZHINaaEw4sXl9GST5p7BJt_lGDB-hZPl6g>
    <xmx:v1ZLaMT-qMQyqpKW3OU4_z_YQtt6WCuZuZn6Y9wHFWVDToLnBELEkw_x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 18:37:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  Brad Smith <brad@comstyle.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] config.mak.uname: update settings for FreeBSD
In-Reply-To: <4fi5rwhpavu3se3htd2s4ym7oppswrwam545vczwf2jvumeqs3@z7imdc7cdw52>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 12 Jun
 2025 15:30:59
	-0700")
References: <CAPUEspguEY+e-J0dMA2EdDgu=t4fK5ASS13Jfp_Mgwiq3Rtd0Q@mail.gmail.com>
	<aEsE8S90fJSr9Or5@fruit.crustytoothpaste.net>
	<xmqqv7p0bpdl.fsf_-_@gitster.g>
	<4fi5rwhpavu3se3htd2s4ym7oppswrwam545vczwf2jvumeqs3@z7imdc7cdw52>
Date: Thu, 12 Jun 2025 15:37:49 -0700
Message-ID: <xmqqjz5gbn7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> I was hoping something more like with the following (untested) "fixup"
> on toa, obviously the "unconditionally" in the commit message should
> need adding "for the supported versions"
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 9cac400d94..cbf1f4c0d2 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -280,6 +280,9 @@ ifeq ($(uname_S),FreeBSD)
>          ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
>  		OLD_ICONV = YesPlease
>          endif
> +	ifeq ($(shell test "`expr "$(uname_R)" : '\([1-9][0-9]*\)\.'`" -lt 12 && echo 1),1)
> +		NO_MEMMEM = UnfortunatelyYes
> +	endif
>  	BASIC_CFLAGS += -I/usr/local/include
>  	BASIC_LDFLAGS += -L/usr/local/lib
>  	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
>
> Note that either way the build won't be broken

As I do not think we quite care about anything older than 12, I am
perfectly fine being a bit extra defensive like your version.

Care to assemble the final version with both code and log message
updates?  We are not in a hurry, as we are talking about a rather
ancient issue and this will not come close to 'master' before the
final release next week anyway.

Thanks.
