Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0E13D313
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164301; cv=none; b=KKk1XS34DD5sgEvEpsRHALVEhTWa/7fTmXiSb5PGOCpe8HKIWAkJOyjgIT85z5PMlaL00eCyP6Jfkx5EterpELOCDPxqvsVb+fm8E990BlkyQLnQBlD/QBZQ7IkCO2g10LfCXcPAY0J4wdPKuFiyqL0ktO/85FKMx6DgWQhMqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164301; c=relaxed/simple;
	bh=aYQNQafJlu+RzqdJ+r7IWXLAG1B1ORk3cC3ndTTZwCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lKKS8GDz+YMyTY3HGpJ0TF3XVmL2PoGab6d2dAh5gJDZW62P0PMxJt4YSR3i06uB8gjLJN9su/hSptbofvM6B1PekhN06LuhtjoKG5f3A1hx+udxarmFaBw34anQGnpgKIROhAVHHAvGxbjaKberwyeqIjmJaKvJ43bQxRCduyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wf8uWPVO; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wf8uWPVO"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 59E132F246;
	Wed, 28 Feb 2024 18:51:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aYQNQafJlu+RzqdJ+r7IWXLAG1B1ORk3cC3ndT
	TZwCY=; b=Wf8uWPVOsKhAx1ff0K8mx+4XMVZEGGXQh0KFau4Vv/YsgY78/e1oyf
	Wh3EOkZ8X/mpSM+VGpKX2CTAyxVsNXFiW7GLMo71WEnkLNrXOhLtu2eJr89fDoKz
	NdD0GQFpiP/Iho02094CQaZgI2U1SQAS0OZ9O4odiDX/LKkKfTM1c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 52AF52F245;
	Wed, 28 Feb 2024 18:51:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA2032F244;
	Wed, 28 Feb 2024 18:51:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] some v2 capability advertisement cleanups
In-Reply-To: <20240228224625.GA1158651@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Feb 2024 17:46:25 -0500")
References: <20240228224625.GA1158651@coredump.intra.peff.net>
Date: Wed, 28 Feb 2024 15:51:34 -0800
Message-ID: <xmqq1q8wjgft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EBF5640-D694-11EE-B666-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> There are some small textual conflicts with the series I just posted in:
>
>   https://lore.kernel.org/git/20240228223700.GA1157826@coredump.intra.peff.net/
>
> I'm happy to prepare this on top of that if it's easier.

Thanks for a heads-up.

The other one merged first and then this one does give the
following, which does not look like a huge deal.

diff --cc upload-pack.c
index 281bdf85c9,66f4de9d87..0000000000
--- i/upload-pack.c
+++ w/upload-pack.c
@@@ -113,7 -113,7 +113,8 @@@ struct upload_pack_data 
  	unsigned done : 1;					/* v2 only */
  	unsigned allow_ref_in_want : 1;				/* v2 only */
  	unsigned allow_sideband_all : 1;			/* v2 only */
 +	unsigned seen_haves : 1;				/* v2 only */
+ 	unsigned allow_packfile_uris : 1;			/* v2 only */
  	unsigned advertise_sid : 1;
  	unsigned sent_capabilities : 1;
  };
@@@ -1648,10 -1651,8 +1654,11 @@@ static void process_args(struct packet_
  			continue;
  		}
  
- 		if (skip_prefix(arg, "packfile-uris ", &p)) {
+ 		if (data->allow_packfile_uris &&
+ 		    skip_prefix(arg, "packfile-uris ", &p)) {
 +			if (data->uri_protocols.nr)
 +				send_err_and_die(data,
 +						 "multiple packfile-uris lines forbidden");
  			string_list_split(&data->uri_protocols, p, ',', -1);
  			continue;
  		}
