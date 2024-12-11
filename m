Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C1D24634C
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929678; cv=none; b=PmDsn0806+FC/qI14BHjaKZqZ3cslKw6ZDKo/5iNYtoDTybuJjU61UBt7bVq7aLOAxneV1PZXmXWybr1Pxc/qBde9GUM2EjsXL1i68eAmj4a+VBa40HXXNCE2Ez6qxwAkqwJPID6L2z+7Qt/UY1Nh5x1BeT8ygd159WyI9eVBLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929678; c=relaxed/simple;
	bh=rBZZwy3FO8gTyq+wXExMjw3ncFa0QecmqzQ1HljzMh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OckXqJ2DL3aqhGfs1yytz6oDgV0SlJY8j5KkF0IbttS/G9qvwITpkByD+2vuePP3voPaAxXgpF8d4ZxpJVqul3RtX1f89L37KL7IgQZHyDPk4tSzbRJrWrQeSGpaReg636N4Bju6fAaARbaeLdqemqbRT+Q1FXD1tv5UcdOXatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NteIxtxR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lb7e/Ydf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NteIxtxR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lb7e/Ydf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 985281383C87;
	Wed, 11 Dec 2024 10:07:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 11 Dec 2024 10:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733929674; x=1734016074; bh=U/MD6JBi3N
	dCGum/AbUJlRsRx+J96vRADd0Wemw24+c=; b=NteIxtxRu8Esecly/nmZk9VB3/
	h4HhFaGyjoF31kAAGQS5Y6f9syEOFRwiN57Lww6pF1kt1Npq6lUT3j2tiebHY2UG
	2hDvrKAg8nbksiBAtFSY4ThpmCE31CS9qcv+8DCtanfbJ4mIQIJ20UJfGI0dS00R
	YkmHptSjzE121p/JpYviBd0bjVUj/GG0xdiO+Vx0n5wrlrgU5vqMwXd6qpyanJC3
	Dz2uOX06JV0AJdmkyQAmydPBDduJLZK67RHr3EPLK7ItUQd4/faeStmk1HzGpiMH
	3TuNFe1jr0/43OXO9TqP9SW8YIxLOlqKKUSUWcmf5VJGdFaBgbohXKlzxlAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733929674; x=1734016074; bh=U/MD6JBi3NdCGum/AbUJlRsRx+J96vRADd0
	Wemw24+c=; b=Lb7e/YdfwTSl9B/Sn17QCDFGqs0mj4oppqPQOIoaeQtU5Tb/hw7
	tatmPxL+x8DoEMV6Nu39MpZiSL/0MI9Lz1CanLXiRHEaGROzUwcS04O9arnal1kc
	mAag3+pTI+Vr3JY092BkGykhRFdZcmZAsbmvDAI7lpzh+LILtil6GnA/SbxLVRCi
	Ouq+Me1ytEeW2WW6f4ASIlpts2Y3Ijj+XzyvsmJEk62VqxWCq/dhyK44d7+f1TLF
	mt9DdRkW0KjzrQbQyeokFr9JceZqJnKJqU53hcRS3O9d0YM0U241/K2Blos1S+5H
	qJfUMzvI+ikqUckRZ+UsuNRiW8r8S3wo+Dg==
X-ME-Sender: <xms:yqpZZ7ET9FjFKmZE_OGrbVEUo8tpinzd7A4euNtceaEY5nx53ekm2g>
    <xme:yqpZZ4WEvxYnpXY2rqLorjUs8WstWGYeDrUZwARh6TZW7TJOzzXBu-2xPg7l54DZt
    1g2DB2W5nbMbpitfQ>
X-ME-Received: <xmr:yqpZZ9JClziqkkA9B2lk_HRss92PM6_BNoCEuD2XeN7B9o5JphXBIqHCmvppEVVr9o1n-g9nWrjsERpXwWuFFW1aZG8gv5Ko1yh-Wkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yqpZZ5GL6_jmY8kiZ5__jzNBPoIZd9CBC0JvBktaORnHrttUCc4_1g>
    <xmx:yqpZZxV3nj-8cHPRFuJVy7NTxxOX4V8HjipMM7BZadAYipu5vrxmuw>
    <xmx:yqpZZ0MuuPMer1cBz06cKi2HXie3dwP1eQJrD8GBwz1ypXKFDY4kug>
    <xmx:yqpZZw12XXHVVF5GMemvMd2-dCaFtfNLWZQUnjEUyor2aBtsI6KVhw>
    <xmx:yqpZZ3zZMCGknaRVU3tc8ZnpdhHR3P2R9nF1eFMLXQrM3v1thU9-C0B3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 10:07:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] bundle: remove unneeded code
In-Reply-To: <20241211-fix-bundle-create-race-v2-1-6a18bd07edec@iotcl.com>
	(Toon Claes's message of "Wed, 11 Dec 2024 10:28:15 +0100")
References: <20241211-fix-bundle-create-race-v2-1-6a18bd07edec@iotcl.com>
Date: Thu, 12 Dec 2024 00:07:52 +0900
Message-ID: <xmqqcyhyi7g7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> - No longer user the term "bottomless bundle" and use "full bundle" and
>   "incremental bundle" instead, because they are more commonly used.

Good.

> - To verify the full bundle created upto tag actually contains the tag
>   object, add a test to clone from the created bundle.


expecting success of 6020.17 'clone from full bundle upto annotated tag':
        git clone --mirror v2.bdl tag-clone.git &&
        git -C tag-clone.git show-ref |
                make_user_friendly_and_stable_output >actual &&
        cat >expect <<-\EOF &&
        <TAG-2> refs/tags/v2
        EOF
        false &&
        test_cmp expect actual

Cloning into bare repository 'tag-clone.git'...
Receiving objects: 100% (35/35), done.
Resolving deltas: 100% (6/6), done.
not ok 17 - clone from full bundle upto annotated tag
#
#               git clone --mirror v2.bdl tag-clone.git &&
#               git -C tag-clone.git show-ref |
#                       make_user_friendly_and_stable_output >actual &&
#               cat >expect <<-\EOF &&
#               <TAG-2> refs/tags/v2
#               EOF
#               false &&
#               test_cmp expect actual
#
1..17

What's the "false" doing here?


