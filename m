Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D7D13D2B2
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098689; cv=none; b=r03acBaCtmqAKZo6Y6rMwAylTxBZuIoVU1UCf6N8cD8ozyss704sezh+twbd8JBSmVWwKXtLqbrNOq0j7PkQTdnfyWHgzFmilyERC+LS38L5+X3ySWICjbB3aPPVtCGtYC6RQjKcyB67af/Me85QHXvj9gtJVLs9u4wpNpD2yJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098689; c=relaxed/simple;
	bh=BirA/QT27ApG+N9CNWk+D5s15PLvCDSyxP+CaHk42UI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bQHFvz/JKFrtv8LYegnzjUA1i/pfuIelrI/eTb4XqDZm31GbUkFrWdb1whtlG7tsp6I5aQg5s3eagV9QX19mou22G7J3Gv+AgNZoLaMQg3qfYERs2e90B0gFIZeWdJ3vfngkwGh239C5v/033eEJywKfOvn6042TDfT15g5BhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RJZXl+/4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k/8gMsq0; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RJZXl+/4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k/8gMsq0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B1481D00151;
	Wed,  9 Jul 2025 18:04:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 18:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752098686; x=1752185086; bh=Zl6/jiP7g5
	ok2+PZeZaculFNsKdqMZqAgPejeI36pJk=; b=RJZXl+/4eOXi7XZ9R6Ikvbf4gZ
	2TAarpNGzTa/Yh13qh5gOS8RLlNxXCCQdlkSqer4imuIvGoLh3xd+n3qxRH82Wud
	Th5h+frfG8xWgPbQJ8xxW7+bJhNmkNW5NH3ArlKGSjbmcFsy7VDWFmvRhzHHc+KW
	BWAq8b8Z/cSBNHcyb6OuiNkA6Op3OZA66Nt7uc/0FQrUs86zDjq3Wm3gu++N5y/g
	WA5f/d1l9rt6jxe2bcjt1Iq9Ib+w2O+3enyB56FsidNc75uI3cL5hoO8xGajye+8
	+ZAXI7St2f0OmgsF0VINhkcE/xtFudXwoqH4E63HeNB6Ip1Eic8YS9L3h7UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752098686; x=1752185086; bh=Zl6/jiP7g5ok2+PZeZaculFNsKdqMZqAgPe
	jeI36pJk=; b=k/8gMsq0Y4A7sMBo8xpv5JWI2y9TcmMD4g/l9HIlQEPY7/xBNuZ
	0t3IMHP3Nlc7QJW5nFN+TOSK9dkSIwss6MxMqoFMZMm7hy125i1HUT9r8HjuPY19
	pXb+4L6rgVU/y8Oj6pAouM23BxtjDOea5JMQH/Er0hbgDbxMeZkJfD+hCm0a5KgX
	INW197S8AhH1dv5r+AA2I163e8c0s5H8Hs/kpEuer4GhSrYkiO1yxXVzCFvT5uOp
	oexIUZP7EuBnitstKRP8LT+5T2XJydR25KnygI2aGpbnn0wx6GOUxBkfGpdd0ADO
	aU5fMjal/W/Pv7YuUGnLJLzE+f8IZaNk2sQ==
X-ME-Sender: <xms:feduaKGC2sSD899cdYFh3T1aWbqB8-nVzlMc_XPFlJg8qGcxUP_r7g>
    <xme:feduaF5SvJpLnxqBk8cYEvmT6Q9X8yD3xdgbh-Y77Riv6e4eSrFIJP--9d_fJrj0Z
    Sb18iGTsZKflhtRxw>
X-ME-Received: <xmr:feduaAuU91_Dpjx8Ovm8OVnMpk9ACGzeiakkQHAitZ7Vz38FbautnBuovPYHes3fs80QBxZJC3XX5jIHtMY3fHkbVtYolJvbJR46HgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:feduaG4g0fwqaPEsDD31jmvnQB48lgzzKkaV7QKoP4jlbpnPnRxrbw>
    <xmx:feduaLXwKyCfT1Mom8n1DZ4nMmQ9ZPt1a8slXzh7KyjjafuEATi5oA>
    <xmx:feduaI8uv5GMRGzuClqAvwtI__fhUvzT6kBxsP8PhyCeJXlbTWSBSQ>
    <xmx:feduaHkzPNuKPvIFbiYrm3Wn6-Ah_3DeJmlno3-b0DQ9a3LC_TxjaQ>
    <xmx:fuduaCtWUmWa1eTlZJBHeR0iCKACem-Q6SI1HTZnJ8BCiLcB8voa6GvT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 18:04:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] odb: track multi-pack-indices via their object sources
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
	(Patrick Steinhardt's message of "Wed, 09 Jul 2025 09:54:48 +0200")
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
Date: Wed, 09 Jul 2025 15:04:44 -0700
Message-ID: <xmqq34b5aumb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This patch series thus refactors the codebase to stop tracking MIDX's
> globally. Instead, they are being pushed down one level so that every
> `struct odb_source` has an optional MIDX itself. This simplifies some of
> our code and will make it easier in a future iteration to move the data
> into a packfile-specific object source backend.
>
> This series is built on top of a30f80fde92 (The eighth batch,
> 2025-07-08) with "ps/object-store" at 841a03b4046 (odb: rename
> `read_object_with_reference()`, 2025-07-01) merged into it.

You do not have to deal with it just yet, but FYI, another topic in
flight has a commit that adds a few more callers to a function this
topic renames away.  Namely, 5ee86c27 (repack: exclude cruft pack(s)
from the MIDX where possible, 2025-06-23).

If this topic needs to be rerolled after the other topic graduates
to 'master', we may need to see this topic rebased on a newer
'master' with something like the attached patch squashed in, but
because the other topic is at least a few more days away from
'next', and it might still need another final finishing touch
iteration, let's keep these two topics independent from each other a
bit longer, and let me deal with this trivial semantic conflict
resolution, at least for now.

Thanks.

diff --git a/builtin/repack.c b/builtin/repack.c
index a74b2ca7f3..21723866b9 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1531,7 +1531,7 @@ int cmd_repack(int argc,
 		 * midx_has_unknown_packs() will make the decision for
 		 * us.
 		 */
-		if (!get_local_multi_pack_index(the_repository))
+		if (!get_multi_pack_index(the_repository->objects->sources))
 			midx_must_contain_cruft = 1;
 	}
 
@@ -1614,9 +1614,9 @@ int cmd_repack(int argc,
 
 	string_list_sort(&names);
 
-	if (get_local_multi_pack_index(the_repository)) {
+	if (get_multi_pack_index(the_repository->objects->sources)) {
 		struct multi_pack_index *m =
-			get_local_multi_pack_index(the_repository);
+			get_multi_pack_index(the_repository->objects->sources);
 
 		ALLOC_ARRAY(midx_pack_names,
 			    m->num_packs + m->num_packs_in_base);
-- 
2.50.1-382-gda22511645

