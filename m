Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B7143E074
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324742; cv=none; b=U7wzmzklNh1jla4c9ln/TolT5g8ug2UyxX04NFeZkvOK/knWr0gqWXMrXdnc66wWTovO+FJpEyeD9EintyDXtB1Du5iYkyhje2EMasr800vlEEnqMmCafsNlujlkA9l68rcVRB32ii6WpSAMkV0Tyz3nXof6SaenesoHtf3zVSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324742; c=relaxed/simple;
	bh=WSt4IyFIh/0ScCY5JobrY742+BTjCgNT8gVQQ484xAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V4pO9hav/V50mD4GU4/7gOa1PAKN1O7iV+r74VrUyedZthkpxEg7Y5ZaHajLtjFhhTW6i68RixqnelbdIxntt7LBlg0F3RuIOSPXUxNgRfFLRxmtFKELq3ncQdA6w6cOlKXmBlzhWBTjDx2igwP0xHOuzf3ux+RljMuds8cidpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MyjqPt69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MRWlspZT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MyjqPt69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MRWlspZT"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D51997A0100;
	Fri, 21 Aug 2026 11:05:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 21 Aug 2026 11:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787324739; x=1787411139; bh=h0kW/tKFw9
	z0gOWqLqTWYnQZE/FSq+hViAm9seBBkpI=; b=MyjqPt69KAhDXvY4j9OZU7Rv70
	UL5oQ3R1FTUhYjrW9T01Nyu7nEZTdF5yl45hQARdSmibpALW3b9JI7A0NHtikwTN
	ZNEjqhZITCeuIU5FSMGHlvVWI7hmqFfEGru0DBJ3UUCSdePYngT8YbVKiwEtRAh0
	XzXovVzwwe0z19LFg71M0faA7+uNfd8nMUdVnwesKHHbgMaO49++bMLzSnTbP8EW
	I/lZe9nQ2uZ8e+5aRceTvmH6qJ1xqX4nE2VnqLZnDQIRBQ19pA0qL1lkQwS5Un11
	UQKcmAErxSSFfJL+qftqBNMoWsCS+gsZix1bTputu0w262GDz4+opqjw/EQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787324739; x=1787411139; bh=h0kW/tKFw9z0gOWqLqTWYnQZE/FSq+hViAm
	9seBBkpI=; b=MRWlspZTYneKPIlJJhRaXsMa6UbWqDf/zRGs98u30z491j9zQUp
	rbz+iqVTRz3OjOOwnKCYCjHZRIPSPLZVBWfunT2zkM9pYlSCbLwwTdp3E7B3iMS8
	QS8gbdNqZifZlJOD3ei06kdsnMMHR7+UlYrYATzAJSzwQfpgCzv9dObW86M0ABpq
	5J566qtCYjGIcaS9JT2ComNZfScQb6MFDGKNKBlES5YCaFePZW/48ti4wav4VSf1
	VRVi/C2v2+VTsfWG7XleyxZS8kHODVWSoVAJTN2WCLCUxDM1ffXe10nE+Jxy1Nn/
	EBuKrFXuYqIz+d97DSJMY6oYZSfCNsBVaMQ==
X-ME-Sender: <xms:Q2mIanyGF8bULtb6O8kBNKmpCyBsxMe28SA41RZRM8oCff_R3Qu5BA>
    <xme:Q2mIamRrVmAizMSu33ZBUaqPYzKSwNAtiM4pYAQ3SDJ-Ba9zMd7tnUSRrRiDtlins
    78KjAg5UGAH_SNdpX8kP12AP1ChN776Zl5hSzSl7RIUgVEzqf-F1Fw>
X-ME-Received: <xmr:Q2mIamWfYc_naa_70ozOCjLuBqOSV3JwjU_yqSmB6Ds8dEhZW0seClQlZZFG83VYzj0rdC524HKE6mcIckuPvtnU2HJUAgXoXQ>
X-ME-Proxy-Cause: dmFkZTFFs7nW0sDrlwBT014MCnHT6iz10M8Tpm+gmOtL1MEdwiSlKixrRGyt/pu7pBumDX
    S8XFk0rq5KDjRQY1xe90//c/G7bkmQUOiGpXEX8gghTuoE3NmPtqFKktmFeDHFznePJ+kv
    2ZSBObpHeiLP8OUzIg9OAP3O/4AzD34zFgLpRg7iG8gqUsb7aG1KK34v0Pi2I4ahD7sglz
    GqJLgvhqmf3eZ2n+jVm1bGnukNLmhqgAdd4nV1CIeQyYdfJMhEPmBH97hgwWwjYcAdpjHA
    YjdIu256hjPP+EGigTArZr2twrjt2Tobqpzy0yFjGyww3uLRBFNAd2gEyJwZdxOgcjijOX
    pY1m7swM7/C12eECwiJrkdymL9DhUkp1z0gdZwd+OcMxS0169WXAnC0nPVxTHaMkiPyQuK
    CWtBFJi3MlT6GlMhTwI2BqWfpE3uC7YC+HLseVdu+qr5KDUAgMKwLAPjD4Zil42EqL+iEm
    sRWRSzsqJ9ddwYFFuqwIjgFbQVp4yjz1tJRCFKwOwKC9mhRNTk15U6ntjIo/Q5AKtpA9z7
    g2NUCCbDP8iKMAyCYBkusUVwJB/lKvT8Ou8iCI+XIMuwWw6SUkqedw5GGRqcTteSDp9u6Z
    zCwpyVJPrjDbfACfCirQ/vO8DjhHtkY8pcbxtxn8Y4GsC/vphKOiyu27eJVA
X-ME-Proxy: <xmx:Q2mIagaqAWJ5DXIO7x-nwY5dpV2gCiFd_NdCcDM2HTT-Yp9jf80BzA>
    <xmx:Q2mIak3-P9g49MnDh-HULbMTKXQNQllHZYK-j4g1SU8Qwedc4KdAXQ>
    <xmx:Q2mIaqjCShUYEefVWhXhkr_yGssr9Fu-5ZtPRU-O2ObzL0Hhc0TNEg>
    <xmx:Q2mIagblguYDdA9ZFK6h0drrH9nKTyPvVtlBCWL-qtqHJDTHL8u82w>
    <xmx:Q2mIat0V-69dJ0MYjn1zdjP0uy-lIQzKXQlqVrTXNgPfSCWb2K_sJzyN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 11:05:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 9/9] odb/transaction: add transaction interface to
 write packfiles
In-Reply-To: <20260820234940.894624-10-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 20 Aug 2026 18:49:40 -0500")
References: <20260819215311.3880274-1-jltobler@gmail.com>
	<20260820234940.894624-1-jltobler@gmail.com>
	<20260820234940.894624-10-jltobler@gmail.com>
Date: Fri, 21 Aug 2026 08:05:37 -0700
Message-ID: <xmqqo6evqzsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> In git-receive-pack(1), the incoming packfile is written to the ODB via
> `unpack()`, which spawns git-index-pack(1) or git-unpack-objects(1)
> directly. With pluggable object databases, an alternative backend may
> need to handle writing packfile data differently though.
>
> Introduce `odb_transaction_write_pack()` as a generic interface to
> handle writing a packfile to a transaction and use the logic from
> `unpack()` as the "files" backend implementation. Note that when storing
> the objects as a packfile, git-index-pack(1) also writes a ".keep"
> lockfile next to it to prevent a concurrent repack from removing the new
> pack prior to reference updates being performed. The "files" transaction
> backend is responsible for managing these ".keep" files and removes them
> post-commit once the transaction is finalized.
>
> Call sites in git-receive-pack(1) are updated accordingly.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  builtin/receive-pack.c | 160 +-----------------------------------
>  object-file.c          | 178 +++++++++++++++++++++++++++++++++++++++++
>  odb/transaction.c      |   7 ++
>  odb/transaction.h      |  62 ++++++++++++++
>  4 files changed, 250 insertions(+), 157 deletions(-)

Reading receive.unpackLimit and transfer.unpackLimit in generic
object-layer code feels like a layering violation, as these settings
belong to the transfer layer.  However, deciding whether to unpack
or index is inherently up to the file-backend, which is what the
'*.unpacklimit' settings control.  Future ODB backends might not
distinguish loose from packed objects, and even if they do, their
performance characteristics will differ.

We can attribute these '*.unpackLimit' names to historical wart; we
lacked non-file ODB backends when they were named.  Had we named
them today, something like 'odb-file.unpackLimit' would have been
more accurate.  If we had other bulk-import mechanisms that use pack
streams, they would use the same '*.unpacklimit' to optimize the
object layout for file-backed ODB stores.

Thanks.
