Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18AB65C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840495; cv=none; b=drvyfPgJ5NM65xITCQoPUwuTRS0gHyYJ5O5tRJFEgoHDN/eQJaTzMZ5euYUWdttId6NwO85+HDNNok/dGCeJy3O0WqM4oD2H2xqKYTJbpw+At95Xrj5rPxvhmBwEdGZ7MldjkolLlzDacYb96blHTi/mpdvK3IDa/KhZ8fNvN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840495; c=relaxed/simple;
	bh=w7ufhriCZUnKnZmEL1+oCAiAi3v0IcUX7HP98nEJC3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YqDSywGb+M3pTE7hN8cKpVfD7CfZa2J/ymMmmrdVZwfw49iXey9hxoKYTnSBT7bRXlxnzdRwc9xZ93qcyJq0/YVaGLHqXci4qLWMdJ8oeTmJsZeEVyXoWfz3KOKylJuhu5/T6NZgATzVIoucCGmb/A7jQDoztONnLsMM5tEPoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mTsDvpui; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YmLOuKeO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mTsDvpui";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YmLOuKeO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A1C14138012B;
	Mon,  2 Jun 2025 01:01:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 01:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748840490; x=1748926890; bh=CZx/fOgGHn
	kEjRRUSModbvwF0b50kSzsfLPmKbbSbRQ=; b=mTsDvpui8NIxQ308klsRD8w9T1
	OgMZAplmIXAs1qbKN5p5oqp3gmsvZxoP3JXRsVJ+SPiA0E++NfBsTk2jeQm4Q5kd
	ZAeZGkpt7b3kHSS00m3+5e6DZGec8lr/sOMsSxVvZdNiwYhI9NpAKm+GO+bgnKSm
	Fy3uS8TPvmCZfbngYrpcNIthe9f66JMj6BvRBg7h2iM+N1qA2qQIqkAIHPDrC8s/
	WmAmQDcvpC6hSYERlUsHbKhmFV1DDtgwvc4Rqbg0GS8yr17utKp2VeX/5FzLhV1Y
	AtX92k0nv7XEKfOv4WUhNxkMd/lMcU4OApIO62mNCS4B2xsZ6V4guO5Mz1Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748840490; x=1748926890; bh=CZx/fOgGHnkEjRRUSModbvwF0b50kSzsfLP
	mKbbSbRQ=; b=YmLOuKeOLgbsmeC7rRVSvDWmW/z8XZ8Y85jAl4Wj7JIAQEdQPOF
	w5J9/mRHrUXRpZNwkvFlyRIr/r6nYS8TC8XHlH8vWcW0CR2sBTOADPtSuUHC+hNT
	MdeOIycV0Vfa6rXO+/07lNe2xtczq7tp2eIDCR+xL8euR9UaVieVgaQB1BsIzfvt
	yus7EKFb3mLu/zheld0g4MENhVMk4/wlWCyqejQzweJHgSy8iS7Ri1RSzi1tBN6z
	48nrMGiPljYEX9Zt1uTpWDViUxfuUcDFA4yQEkm5WrZFnN02EalNtf3PLvgZqhki
	Quk0G1ANjvzNzc/WOHJHVRBPu9tQcWPG8lg==
X-ME-Sender: <xms:KjA9aCvjebCx2993WTghMJUpphgwd5Tn3VPdfi9AYfdpsT-3njTlHA>
    <xme:KjA9aHd3mKPDpktqcmqlyIYBgkH6HSlJtluulxbXSHZRfxqa8PiC-13TWKFpMa4VC
    cSr2kUr60F9Z7jkLQ>
X-ME-Received: <xmr:KjA9aNwfVO45fsh_NxRIhqAhTorbeD9gDfSB8FWbfETorqw24lbCB_W1DMU-TxhWALCLCyz4G-5L_wopN7dT7CYzsiEKyOMKBKTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieejjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeevjeetteeg
    hfduvefgtdehjeehvdffkeeiteeiffejffejffdvkefhgeelkeevfeenucffohhmrghinh
    epuhhnuggvrggulhihrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpth
    htohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrrggusegtohhmshht
    hihlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KjA9aNOkJHqh1D67r4Tn40l4z24mT7uAIQqMbiR5aroGuS_oLG0a8g>
    <xmx:KjA9aC-EdxY63zYWLFfj4KePm5dLQQ5RUTPgybkQTaGYXhtdqqH__g>
    <xmx:KjA9aFUe4A__K8nqpqbYCXF7tju-VDZi9KDGE0WeiQQA7P2nhTXHkQ>
    <xmx:KjA9aLfZpjymaiKmglxZZY24cfMKsWVBjXDLEhNzEwdjSgyDcSPovw>
    <xmx:KjA9aA9vivnNCLnFGPR1jj6MFh42eBnhzjV2NuOCzRKoA77t1qYsgeCQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 01:01:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: update settings for OpenBSD
In-Reply-To: <aD0XIxPRQjA5t8oi@humpty.home.comstyle.com> (Brad Smith's message
	of "Sun, 1 Jun 2025 23:14:43 -0400")
References: <aD0XIxPRQjA5t8oi@humpty.home.comstyle.com>
Date: Sun, 01 Jun 2025 22:01:28 -0700
Message-ID: <xmqqldqavis7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brad Smith <brad@comstyle.com> writes:

> OpenBSD requires DIR_HAS_BSD_GROUP_SEMANTICS.
>
> OpenBSD has never had the BSD sysctl KERN_PROC_PATHNAME nor
> does it support or use the /proc filesystem.
>
> OpenBSD has had strcasestr() since 3.8. OpenBSD has had memmem()
> since 5.4.

;-) Thanks.  

5.4 was from Nov 2013 if I can trust
https://undeadly.org/cgi?action=article;sid=20131101142807 and it is
about time we adjust ourselves to the more recent world order.

Will apply.  Thanks.

> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  config.mak.uname | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index df172d5871..5a0b4200c3 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -301,17 +301,14 @@ ifeq ($(uname_S),FreeBSD)
>  	FILENO_IS_A_MACRO = UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),OpenBSD)
> -	NO_STRCASESTR = YesPlease
> -	NO_MEMMEM = YesPlease
> +	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
>  	USE_ST_TIMESPEC = YesPlease
>  	NEEDS_LIBICONV = YesPlease
>  	BASIC_CFLAGS += -I/usr/local/include
>  	BASIC_LDFLAGS += -L/usr/local/lib
>  	HAVE_PATHS_H = YesPlease
>  	HAVE_BSD_SYSCTL = YesPlease
> -	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
>  	CSPRNG_METHOD = arc4random
> -	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  	FILENO_IS_A_MACRO = UnfortunatelyYes
>  endif
