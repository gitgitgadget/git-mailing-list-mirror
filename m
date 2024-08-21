Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98E15098E
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256168; cv=none; b=YBzhntkTAfzEFfyp2A5Bcsmc93cr/D5zg9V+1bLqte4JzhvX14R7mOJq/RCJBzJgAzj8xmX91MIaIjVL++UX95Z8HyZUpfPmJ/4VuCBVNQte2Cit4VjNFcIjZsc9lrVq2agNcfzTW7Vtvm98Jw/hfiYt2ykN+7bcAXlucueQjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256168; c=relaxed/simple;
	bh=iMX+vYA9OIfKMQNKO+c5ACJAC1NlVvE0OWYl592/YhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZWwkFikzhI75/OfPnIMz6nbEnEbuTlmD4d4zsmhpbk0okSkXESfC7AXWYKPRYmkGffOIBdo5CZFY/r49GqvmlkG4rUF5DnsbIy+Ihvorc3c/xDelGNBWVqFlFYlMAWY6mNIfNWuJp8DFRA/mM7TTIcpEwNFl4WKV92SO7mmMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S3g4LgEB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S3g4LgEB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B9F9233DB;
	Wed, 21 Aug 2024 12:02:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iMX+vYA9OIfKMQNKO+c5ACJAC1NlVvE0OWYl59
	2/YhA=; b=S3g4LgEB0YNRaAXELJ5KIYvEMkVaekgfUkVIhOYDjdFNMobGncKijs
	ynNeI/h/czAncJgaBrRut8CnKvF7vUX6KvBIRQoQK9uilEvO6r6+wCpEXdwwRAEA
	JOPWft0DnbyDWNjK24axjflOkIFmLK25cQE0BANHYizYVxKlsp3vs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 018C1233DA;
	Wed, 21 Aug 2024 12:02:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6412F233D9;
	Wed, 21 Aug 2024 12:02:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Yukai Chou <muzimuzhi@gmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] doc: add --show-names for git config
In-Reply-To: <ZsWPBCW-pI4qIykK@tanuki> (Patrick Steinhardt's message of "Wed,
	21 Aug 2024 08:53:56 +0200")
References: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
	<xmqqcym4fqhp.fsf@gitster.g> <ZsWPBCW-pI4qIykK@tanuki>
Date: Wed, 21 Aug 2024 09:02:44 -0700
Message-ID: <xmqqy14p27a3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CDECEB6E-5FD6-11EF-8BCD-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Aug 19, 2024 at 09:04:50AM -0700, Junio C Hamano wrote:
>> As to the name, I tend to agree that --show-names is a strange name
>> for the option, and I would have even suggest making "--all" to show
>> the name by default and give "--hide-name" option to countermand it
>> if we were adding this topic afresh today.  But that unfortunately
>> is all too late to change without much more effort than just changing
>> the name.
>
> Mh. Yeah, that might've been the better default indeed. The new command
> is still relatively young, but still, I don't know whether changing this
> is in the picture now.

Yeah, it appeared only in the latest release, and may not be relied
on yet.
