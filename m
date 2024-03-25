Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21F804
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391937; cv=none; b=TvzS9Oeh82vpm1BrNmwXiv1RFraSsOKBnODk9NnQrp9yCPPAvmX5zJUxfuPj6384pcqhZfR1nGOfFIqsJU84qQ6/matBeF8VQRa6041ylJiyueaX0Ygpk4UFxTE/EsCuCgeC7Yp2/fkiL3YZG8L/qpnaOePmkRm+Q9ihNir5LvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391937; c=relaxed/simple;
	bh=5dmAJVnKBdlni73SnNA2gcBGLI1LByXFgVMKCzZGQTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CL5YgTY/k16QHNSI6d4d2k7cb8102iRn/p7CSEv5OJeELMASpXnP6C7CuRjYNtTpMNkXqDSKY+yu2/eofKXOPnZ4t8/PiHuvzHtME1In5ZloDHgiCCSR22EZuwf9VNdX4PnN2CD5ege6Yb+5fUo1fsZMThHBLdObI31vLVRCec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nvqtWos1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nvqtWos1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 87E5F1E93D3;
	Mon, 25 Mar 2024 14:38:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5dmAJVnKBdlni73SnNA2gcBGLI1LByXFgVMKCz
	ZGQTA=; b=nvqtWos13Op5g91giKn4Ze5AZm2c0AU8TcDtfBRlk8yJdY+CigFlma
	/aucfppivnC9HvaPA4oTrKzQ5j6y7KYTC+qymJbaZUPHl0HBKyZaIHuQzbvCZRaR
	RH3eRbPEN/KU9WcbSz2MQdHKSILstZyUp4VngHege0HTtkh2/QJFY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8056A1E93D2;
	Mon, 25 Mar 2024 14:38:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB0C11E93D1;
	Mon, 25 Mar 2024 14:38:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #07; Fri, 22)
In-Reply-To: <ZgEcuDJfPoN-MYy5@tanuki> (Patrick Steinhardt's message of "Mon,
	25 Mar 2024 07:42:00 +0100")
References: <xmqqedc1zs1p.fsf@gitster.g> <ZgEcuDJfPoN-MYy5@tanuki>
Date: Mon, 25 Mar 2024 11:38:52 -0700
Message-ID: <xmqqil1akvgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EE77A916-EAD6-11EE-930D-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Mar 22, 2024 at 05:54:26PM -0700, Junio C Hamano wrote:
>> * ps/clone-with-includeif-onbranch (2024-03-12) 1 commit
>>  - t5601: exercise clones with "includeIf.*.onbranch"
>> 
>>  An additional test to demonstrate something I am not sure what.
>> 
>>  Waiting for a review response.
>>  cf. <xmqqo7bjjid9.fsf@gitster.g>
>>  source: <0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.im>
>
> Based on [1] I think this topic can move forward now, right?

OK.  We may want to leave some clue to help us remember there are
still things to design (i.e., your "more thought into how this is
supposed to work"), which is far more important in the longer term
than just avoiding the BUG(), but other than that, I have no more
things to add.

Thanks.

