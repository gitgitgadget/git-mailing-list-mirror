Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736218E349
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137665; cv=none; b=DtXLRgTzn94dGbn/8/EM5kiwG22+yH1Bp4JhJUtEamlzxjJV1PMlxS5MURtuIf3CHYMOYGJH248F37gCzr0sHXn0ZZji4exuMnmyQzPU7lvXg4gqCEeWXEZ09zwKpqV9yYW8s+Jq8HRG7PsT7ONyBFlXoxlvYTY9oXiKGnpOLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137665; c=relaxed/simple;
	bh=WLEPpI7EEs51yJ+9AydXaoSjWP1FIZ4PLpsEA0FPTbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQtpwQHA0NRdM5Sll2yDKEbvn7MqwH4hNrSE++zPacevumTZmbZuOHUopF1olzLjuZls2dDGHYiJSS0qR/gM3ct6ZATIIvwu455i0fndkfki4QeEoU5HJmpcMdeCk7nVzm5OcHeeDmG5HjQu9Vn1+TUCieAGEcLqJywOQ2qIUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qhlWv9t+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kHzQdIAK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qhlWv9t+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kHzQdIAK"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id BD3F21380649;
	Thu, 12 Sep 2024 06:41:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Sep 2024 06:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726137661; x=1726224061; bh=z0zypG3e5w
	9AhQIuaqL81I02FnlCkkToxdgFzlTd9Kk=; b=qhlWv9t+WjKXDBHfOlAAZZJ+iH
	XDHeWkrCfpzLopm5eP0TTT8eCc9ys3i/PQwa+JA6rC9aXiK2QYRNJIDcJvZCxcbU
	RABOaQUiMQz0h7Z+AFWL814cvk1EtEfg9EquPyiLn5EgonbeUiAJLoYV5aQgrhJ5
	IBk4Qio9jiIFNaGXI3aoYa6yZtgpQPbKikThMqcKIe9wYomFOHiVWBghyGYoacDI
	LGSfGq+67qs5euA/xV9EyWqQs6YuclIyEeU7BVy3ibVXTipfhOIDmU1DY62FFu7E
	PDYQvSp3bo18Mc3L9R7m1rDAQuvc16Olg2y24tC7NcUBzw9t5+605CNfdYaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726137661; x=1726224061; bh=z0zypG3e5w9AhQIuaqL81I02FnlC
	kkToxdgFzlTd9Kk=; b=kHzQdIAKgcnwcN1adwaR4axy8szBerH3egq5Q5fJpe57
	/gCC9XXPdxCPr0fxlAnSj0CD7og8ANRehxSJaQhjv42+ec42XxcBnjgYEb7qYZsZ
	HinhdczX8n35lC+QR97PmGv69JbHKH81WKaGf5ZItCgOksayYZl39Tmnz1wA98FX
	/KMuZM165o8VkYEPVvJArA4yzZEqAIa6YgD+Ui4v58TMnilDLoimpDspX5tjs71e
	UhsG+6ojHI6xm2XkJfP3YDYjorCMad+h6H987+4xkOpFLShyka+NXl/xyzSt60Px
	DvFT1XL7TQYN3+xJ6gUjhv9SCYnIKduEv18h9Z1r2Q==
X-ME-Sender: <xms:PcXiZtcC0_DWiQ4kbWdh_DNcrFwv1GUvRC3xtmKGVxWhrH8tuNwZjQ>
    <xme:PcXiZrN7j3Z4m-4MF4_bjVSvPqPbrCZVhCL4qkMlNrhoxCGt5XBhBCkd2njrM18UK
    kIK4OKyBBVN4q3efg>
X-ME-Received: <xmr:PcXiZmjVnp7G-x1EbkiDKEMBLxB0QSrYuVXH0SsbEvPUEMAoWcPkVl8hQtufMvc_-ax5y_eFIHIJyfmxD-cnofbhd9Sd480NjDHgpXOjAqlU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:PcXiZm-5H25j8WlC5iSSN7BcQoqRUsooUlnqCB7iiSPbSd1jEHbCIA>
    <xmx:PcXiZptys9T17Td3la7H9cqBxhbgbj2CgGUiAmsz2hTrOfRuty9qQg>
    <xmx:PcXiZlGqKVtzaqP4MvMvJoQweY-IxlXXpeoma5OS2nAP8ncFDrBiqg>
    <xmx:PcXiZgPcC_OaXL8xsZJoukO6LoaI5LRiRAUEAgYTOYu4WDieQKTJRg>
    <xmx:PcXiZhKphHPvrHuZK7H6oe1vjJ7Igsc6jVpHGnJ3PhHKr6cinfmVxO0H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 06:41:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 824a0e85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 10:40:52 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:41:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] ci: unify ubuntu and ubuntu32 dependencies
Message-ID: <ZuLFPI2miN0_667m@pks.im>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <20240912094537.GB589828@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912094537.GB589828@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 05:45:37AM -0400, Jeff King wrote:
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 4781cd20bb..00cb7df67a 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -33,7 +33,7 @@ fedora-*)
>  	dnf -yq update >/dev/null &&
>  	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
>  	;;
> -ubuntu-*)
> +ubuntu-*|ubuntu32-*)
>  	# Required so that apt doesn't wait for user input on certain packages.
>  	export DEBIAN_FRONTEND=noninteractive
>  
> @@ -45,25 +45,23 @@ ubuntu-*)
>  		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
>  		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
>  
> -	mkdir --parents "$CUSTOM_PATH"
> -	wget --quiet --directory-prefix="$CUSTOM_PATH" \
> -		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
> -	chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
> +	case "$distro" in
> +	ubuntu-*)
> +		mkdir --parents "$CUSTOM_PATH"
>  
> -	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
> -	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
> -		-C "$CUSTOM_PATH" --strip-components=1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
> -	rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
> +		wget --quiet --directory-prefix="$CUSTOM_PATH" \
> +			"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
> +		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
>  
> -	wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit"
> -	chmod a+x "$CUSTOM_PATH/jgit"
> -	;;
> -ubuntu32-*)
> -	sudo linux32 --32bit i386 sh -c '
> -		apt update >/dev/null &&
> -		apt install -y build-essential libcurl4-openssl-dev \
> -			libssl-dev libexpat-dev gettext python >/dev/null
> -	'
> +		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
> +		tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
> +			-C "$CUSTOM_PATH" --strip-components=1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
> +		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
> +
> +		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit"
> +		chmod a+x "$CUSTOM_PATH/jgit"
> +		;;
> +	esac
>  	;;

Okay. All of the build dependencies retrieved via apt are the same
across two platforms now, but the dependencies we fetch and install
manually are 64-bit specific. So overall we get more coverage with less
duplication. Nice.

Patrick
