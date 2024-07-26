Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453935588E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025250; cv=none; b=TwapH+h8K1DbTID9FlSLweXZ7G34WuRXHzTwigE/7BFzlenBQ72xbSuWYkf1NFK+Ig3oXkWZSrFdyuqjVY1XL7OcsYn3z0EWz1YQOz0PafRbe/YjzY9wl/9eGV2pALvJMmjpPNEZAZY5KPuEWyUm43KBh8DU7/K8S4sd1oJCO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025250; c=relaxed/simple;
	bh=Do4e+BUzQ5BxKaRtGSA2vA2oqHX95WieBDyE1bcE4HI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tjc4OAbWV9JqoL3alVJzW+Trogy93+IT3LJgfMVnaMqk+T3gk6RfBn+HNUXKBLwc2HFyNhaEUbuxK0BYfMFRv4Gi/7CqagoAOvKZuF2QwEq9ZUvPervOPmEBbYVFcs5JgBkQ8bifTivoxMoOtzeeAdCzJxCPBMtttdYQ/y1FVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AQeJ2O2V; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AQeJ2O2V"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B690836F38;
	Fri, 26 Jul 2024 16:20:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Do4e+BUzQ5BxKaRtGSA2vA2oqHX95WieBDyE1b
	cE4HI=; b=AQeJ2O2VfD21oXUc64KhhvFSajpTjtXGt+G4eMqgZtBewQwnx3Jf9z
	dEXsDTSQHzAdDFHJbsYo98np9rersy1XYaWg2nZS8b3961QUz/ILZQ61bIoJ9VHK
	UifYiUqVhJqUho8cX3njhKTD7K18bkunnqWKlHF90LkKUAVJmGnyo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AF11236F37;
	Fri, 26 Jul 2024 16:20:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3E25736F34;
	Fri, 26 Jul 2024 16:20:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] ReviewingGuidelines: encourage positive reviews more
In-Reply-To: <ZqOVC_F4fdQUognX@tanuki> (Patrick Steinhardt's message of "Fri,
	26 Jul 2024 14:22:35 +0200")
References: <xmqqsevysdaa.fsf@gitster.g> <xmqqle1pjwtt.fsf@gitster.g>
	<ZqOVC_F4fdQUognX@tanuki>
Date: Fri, 26 Jul 2024 13:20:43 -0700
Message-ID: <xmqqh6cbucpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 89E3D8BE-4B8C-11EF-A448-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jul 25, 2024 at 08:49:34AM -0700, Junio C Hamano wrote:
>> I saw some contributors hesitate to give a positive review on
>> patches by their coworkers.  When written well, a positive review
>> does not have to be a hollow "looks good" that rubber stamps an
>> useless approval on a topic that is not interesting to others.
>> 
>> Let's add a few paragraphs to encourage positive reviews, which is a
>> bit harder to give than a review to point out things to improve.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> This version looks good to me (well, the first version already did).
> Thanks!

Thanks; will mark for 'next'.

