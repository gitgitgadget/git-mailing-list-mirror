Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878652B9C3
	for <git@vger.kernel.org>; Wed, 22 May 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398410; cv=none; b=uHdgc8k9NJkeddfn+bxPrIjit87jYm+RIXgdvvUyhNsy0D5pRQpV0rxXD6MsNYvI3fJxFm6lToGM+oz6JvcrU7rqO12RaMmhSfs7KvfgKPbiN1SuRX4kCjtIfgUIXCuwrVV8vN0q8Osqqczrt6BBILHfoG+LLy936ZtpjA5ymwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398410; c=relaxed/simple;
	bh=dxylFm+pZdC8kZniTHviB66kRnQ0gNqx8K5w9XV3byE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WR2ImOsRX1AEObRmnDyauysYbNbiJ68NUnGb+d01iaGDY5TDIfaDcRzJ393Nf96vSXqv29w8IrIAMcOEqjCI5BwyWcWiGpziHK5HdOztt3XDh3xAe5exBtk/zYi0p4cD/dBHULMUCEL3GizHP3tyCC581LxBElHN6ZiCoL3taic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VncfneQE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VncfneQE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 173B0187F8;
	Wed, 22 May 2024 13:20:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dxylFm+pZdC8kZniTHviB66kRnQ0gNqx8K5w9X
	V3byE=; b=VncfneQEXRD7UCGUAqXpDxzJPFw0UU5dujFbe5+Y0gESxOCbyWss0t
	2fOA71jyUsavyeP+Kfm2Ih9rqShSN/hlxJStLJifLykjRrXBX8eWRy5oF7yDD03N
	g1A5fmFAz47k7+trXEd+wSG+Y5Wd7zYRopE8Btja3Nb/jNU1bc/gE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF762187F6;
	Wed, 22 May 2024 13:20:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0489187F5;
	Wed, 22 May 2024 13:20:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/12] Revert "fetch/clone: detect dubious ownership of
 local repositories"
In-Reply-To: <6e493925-f3f6-43aa-4381-612067e87d01@gmx.de> (Johannes
	Schindelin's message of "Wed, 22 May 2024 09:27:55 +0200 (CEST)")
References: <20240521195659.870714-1-gitster@pobox.com>
	<20240521195659.870714-13-gitster@pobox.com>
	<xmqq34qaaobk.fsf@gitster.g>
	<6e493925-f3f6-43aa-4381-612067e87d01@gmx.de>
Date: Wed, 22 May 2024 10:20:05 -0700
Message-ID: <xmqqed9t69x6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 88C5B4BC-185F-11EF-895C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> To https://github.com/dscho/git
>  + c6da96aa5f0...f71d7009814 maint-2.39 -> tentative/maint-2.39 (forced update)
>  + fff57b200d1...21dc6c4d521 maint-2.40 -> tentative/maint-2.40 (forced update)
>  + 616450032a0...0d21b3451cd maint-2.41 -> tentative/maint-2.41 (forced update)
>  + b1ea89bc2d6...e9bd0c8f8c4 maint-2.42 -> tentative/maint-2.42 (forced update)
>  + 093c42a6c6b...9926037ce8c maint-2.43 -> tentative/maint-2.43 (forced update)
>  + 3c7a7b923b3...aec5a9bf52c maint-2.44 -> tentative/maint-2.44 (forced update)
>  + aeddcb02756...d3c56966d13 maint-2.45 -> tentative/maint-2.45 (forced update)
>
> This command-line comes up with no differences (meaning: you resolved the
> merge conflicts, even the ones without conflict markers, in the same way
> as I did, which is good):

Yeah, but I am afraid that it is a bit too premature to worry about
the integration to merge them up.  What's your take on the symlink
stuff Joey raised recently?

Thanks.

