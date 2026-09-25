Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4F3B3895
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354994; cv=none; b=tqove8WOTWjWUBRHaLDJNO9SY1YtxGgfmgzcbFOwE7CgiMpkueP7L1N/PpgUu9NlU/RFXYAGH5bn9zBTak8ZIVmD+a4nmh9gdafjqNdJadO5PWtccLIn0dwuF4j1qdXXzlOthf3aCO8JFOGX0PnTsDflNMbqpEgpRVnuGVRelKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354994; c=relaxed/simple;
	bh=Mr+RfJ4SFh2rSBtaz/A3KeVgeA7xJtlMS9mG3NgM7Xc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkpCR+Lg3ozTd2NjASzR+Y7V85zHpmLzwwCqoOJgFEJV3Zn9OAnT72X4+xfyoG2XjEmWbEqfR91oc9G2F9qa2i19fSZPnIHZ3H6BUbyVr76Wu6kq6uqHfBEI/WK9K6RY30zIT9KjPoLjAkHTQTyZkRAsAxnyGC62OgpNqyBclzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QmfxUPO9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q6ECKteQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QmfxUPO9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q6ECKteQ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3506A1400173;
	Fri, 25 Sep 2026 12:49:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 25 Sep 2026 12:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790354972; x=1790441372; bh=Mr+RfJ4SFh
	2rSBtaz/A3KeVgeA7xJtlMS9mG3NgM7Xc=; b=QmfxUPO9BloXxolAD1cqGm6eH3
	SWBPexfVYGUTIF53rZye8g3/VwBmGEUxhu5avcPXOhCqHeV0EuUlWg/l75cmQx4c
	yvRUnLO1pnU8HAE9WSGPmdiAAmBS5417niPE/leND3UdBTGVDCMbcYEoCdCDMnqY
	+4/k36/3Vt/s+qg565TSYvSvVTBvSIQVpfHusgWLT7G+AW1Q1vmZtB4aHlrp5MDt
	bSA1lge5R/BYXZVmn+K+yEj/PD3YRLo5q7fp82DHI4fmN7f+3Iu2yQihj365sS3K
	x8dPyjg482tE/TbKFbWXHYBDqRj7lhopQq5x54vFxxnbYEQlySsFXRv6n6Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790354972; x=1790441372; bh=Mr+RfJ4SFh2rSBtaz/A3KeVgeA7xJtlMS9m
	G3NgM7Xc=; b=q6ECKteQfUboso+vc+hgYe89lIk37xM/4+ynsIuAIJ56HiECMWY
	VzlDdtOLj8RsvQMOVxK6h7RzwgjHiLfcAxHRgxpe0mvodhPVjzRU5VfA7zK2JKCK
	X9o35Y7LIbCEjliTIKC0/51bTU0UiCpBohcsnesG5KcwWmOm3D7BhWWyyrYx3ykr
	tau3/RNXx+6W9eGHWrs5OzIUHstK6Ko/A3FpCS8KZhO5up020xdknHchASCI2eN6
	OC/qEMav+i4/71ZXC9i/SCjROJAEPAt9miJkvy/m0jYMQvCR8JZT2wkdZbgT67N9
	IjpyaUMyL4L6Zc3rWONIqxYWX+EnLMtWnOg==
X-ME-Sender: <xms:G6a2al_G8Tp0TGG6lHKWA2Z4ud9ulxYl6zEnG1xS-VcqjpOUYacYfw>
    <xme:G6a2ajzbqCsDSUOqhYDgdtgu4I67vFVCcWzuykcIOtDNbT3TBzciFfQ9ME7vCl6DN
    retkar3c9Y6dqZWcGTBDP4zcBwOGNlkpqP3nr-hhem3eHudvJmIjg>
X-ME-Received: <xmr:G6a2an-M13wSyZlzzWF6abP6ti8wEbu8rHUkbJ13zwtt-lXfLddBnffw-qVVufRUJqNfB9_dRsznOYhAVYqcbh_sNEy_7ejXqmZU>
X-ME-Proxy-Cause: dmFkZTE8hUXxnYBZ4/qtdIYcTcwQZkFMsNK9Pbvvrl+nTbcXEu9FacyehOSfQx4AM6tpPf
    hMTGG9kXFWvq/6rTXGPwjUIyGFCOCsfOq1PEjjj6wJA3l5LEmcTOW8TQzN2TVDb+vtINAm
    zJLo1MVG7PEDslEtNCDzT3Pftmeg5klwHsdIYa8xlNzVVLxSA1HFKaecb47dlaTRoCAaMO
    XzBGq/nrnisahP0oY0pks6locboJRkye8bx2AIxzxbI3UIOdrSdr84fdMWoxEiGe0ahapO
    shEqujHql2Fy6AU0J2dx38dDv0V639uzv359sg6Q41DtGVGNeKCZsofGAkzLfB2Vj4XaeR
    3aRLOwsYPLbnjTKtzymKcVbPEGB07TsVTKMBT5vLrvn7E1ypzkAnc+1XnlKFx+CRmYcGMb
    O/5reGmusXhjyUPAe/ZJ+Z1Pnr/igwdmsXXLgUryRonFMJoUNL54lKk7HbWHyHWljq+oRy
    c+WvupdlGnrGesm8Y8iuNTf44zbkvT+r6QqaUMmWUe3pO5Da8JVxYVjTCVNerrt9vbabcU
    auZgJeVCxSEPegAcFVt4XgYmfLJVnJU1V7muWnxbVW9ldBTN+rIE5beWIap8IPF/l9p+mf
    3ZydaxrUqOy8rmx6R9R3NFesT8pPBOt68n8GaFOfW3o74mx2aAnMJNFqeyWw
X-ME-Proxy: <xmx:G6a2ahPPAvG1kQFugOI47Q5xTpD8lGWGSmi7PRBlUuzMa42HS3xkAQ>
    <xmx:G6a2anowhyHcsAkcSc7LR20ZGKRhcavgSYN3pHuzzCUTssQ--HAzZg>
    <xmx:G6a2ao6NDABStJH5rLeCEzDP2I3WcwoLurRJfE9_I7Z4Ev7avqzDDg>
    <xmx:G6a2avEg7h_seaVYmoKmlqFuraQqSiWQ1r0WNj-09EHOaf4bB6YxGQ>
    <xmx:HKa2auGUBq8o7X7RGcp5wRVHKSJ8psqYPUigMaZ2LVRZ-WhxZ9GRcyFA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 12:49:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,
  Eli Barzilay <eli@barzilay.org>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Patrick Steinhardt <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Adam
 Johnson <me@adamj.eu>,  Victoria Dye <vdye@github.com>,  Jeff King
 <peff@peff.net>,  Derrick Stolee <stolee@gmail.com>,  =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
In-Reply-To: <CALnO6CDzbUMSAqLgZ_A1xx=XJPN1_HR-tJUDqG4-Q_xV2Ypzkg@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 25 Sep 2026 12:17:31 -0400")
References: <cover.1789853192.git.ben.knoble@gmail.com>
	<cover.1790168285.git.ben.knoble@gmail.com>
	<e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
	<xmqqse2yz4y4.fsf@gitster.g>
	<6e6420e8-3cbd-4975-a781-645e1ffbc1d2@gmail.com>
	<CALnO6CDzbUMSAqLgZ_A1xx=XJPN1_HR-tJUDqG4-Q_xV2Ypzkg@mail.gmail.com>
Date: Fri, 25 Sep 2026 09:49:29 -0700
Message-ID: <xmqq33uxwa1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> I think it is definitely worth fixing them to take the trees in the same
>> order. My preference would be "base", "stage1", "stage2" but so long as
>> they match each other I dont object to "stage1", "stage2", "base".
>>
>> Thanks
>>
>> Phillip
>
> FWIW, I concur with changing them (and Phillip's preference of order),
> but I'll elect to leave that out of scope for this series.

Oh, absolutely it is out of scope for this series.
