Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40029803
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691457; cv=none; b=iZ0+GNGZGe3Pxj400y5nTHrVWcbjxVa6Yqe+jH4/F/qhoHc2YlsNz1/HNZUwosulInkrhRgZbURTJEPCjrBs1N12WRC3h6IGn9IqfX5jT5xGlz+2yp1coEijnRcZshfv8j/PdPH5tp6f/fp1g3sXA75Zn+33uV0XCXPty4KL3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691457; c=relaxed/simple;
	bh=2OlM9Q6beFCz89hYgY/3O0kv8cfHAy2MfKLMufXHIBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVI8Oim2OGEPnuSwfIAZJJbOomfqRYMtcE5Vl5VNw6O6XwZez8e/K8PyT5RJ+xpah8Zam0sP7Rq/dnZUbWw5VnZ4mbKlDtLczUSw8oaUyalh+v5ZAvC4aNhwbcpNEKNTrGi3b1eGI1VK69WtzckFSu03t2xsuVXFrFx2NmWahkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DLExCc6F; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DLExCc6F"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E05B71DE1EF;
	Tue,  5 Mar 2024 21:17:34 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=2OlM9Q6beFCz89hYgY/3O0kv8cfHAy2MfKLMufX
	HIBc=; b=DLExCc6FuCPZemAib26M+jdLt2EvpA8BmClUFxSeGkONfhR5sFG0EBo
	ZoAP/hkfSQNPojkbm4U96HOQ432PuRaQ7nE9eQL3m0eD9v8eI+QBjuK8tr8glYsA
	y+e3dsPC7u2yZg2rMUhM3Vp4IpTFS91YM/0bgfK5CoTkpIyx6XaI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D8F661DE1ED;
	Tue,  5 Mar 2024 21:17:34 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D7A61DE1EB;
	Tue,  5 Mar 2024 21:17:34 -0500 (EST)
	(envelope-from tmz@pobox.com)
Date: Tue, 5 Mar 2024 21:17:32 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Beat Bolli <bb@drbeat.li>, git@vger.kernel.org,
	Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 19/22] t/t8*: merge "grep | sed" pipelines
Message-ID: <ZefSPAiTLrRVeXm6@pobox.com>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240305212533.12947-20-dev+git@drbeat.li>
 <xmqq8r2ww4xg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8r2ww4xg.fsf@gitster.g>
X-Pobox-Relay-ID:
 B1A2C92A-DB5F-11EE-9667-78DCEB2EC81B-09356542!pb-smtp1.pobox.com

Junio C Hamano wrote:
> Isn't -E a GNUism?
>
> At least,
> 
>     https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html
> 
> does not seem to have it (we may need to fix t6030 to rid its only
> existing use).

I _thought_ that -r was the GNUism.  The GNU sed-4.8 manpage
says:

    -E, -r, --regexp-extended
        use extended regular expressions in the script
        (for portability use POSIX -E).

That doesn't mean the man page is right, of course. :)

https://www.austingroupbugs.net/view.php?id=528 suggests
that -E has been adopted and, importanly, is more widely
supported than -r (if we were considering using that rather
than rewriting this to not use ERE syntax).  MacOS in
particular supports -E but not -r, according to that link.

It seems like the documentation hasn't quite caught up to
reality yet, perhaps?

-- 
Todd
