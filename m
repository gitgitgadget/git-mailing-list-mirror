Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE267342C93
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805576; cv=none; b=QT8wvqbfeDBY/xjknaU3d/cLHjSVjHt8lZLJ2d0EEBZE24IR+tszEFz/4c+gLU8GHwblyO0ANjftgbvVnphdUxZDtRryX9YRRhF+M2Kx6ePLyK86Q+J6/l8z6sFqfPM+1dXCIjFsTuvY1yi818muoKb1taG7QB7NX5gp+TU1mTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805576; c=relaxed/simple;
	bh=z1GUXXuqDzKGGdHtj5bsAdVvx8vpG0LVG/KfYSRxAhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uvaxySo6oVqET7K2b521OxtW3q6pDrAqdr6gC6nV6tWRxPp13rukVUyOlaAYWQS4GO4V4PYiLcMO0IY0mAXWdahLtdRzk2u9PjqkhIV3lNeyqfw35n5XmqxK1l+R+6cdIyNNq8VbQUY8Hm/KGsO0BYLtRSjKEF3lBZjKiONdSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sv+B/ssa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=czBwF9D4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sv+B/ssa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="czBwF9D4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9162140015F;
	Thu, 18 Jun 2026 13:59:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 18 Jun 2026 13:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781805573; x=1781891973; bh=l1OzFciQiS
	Mue+9tOUuMbFj+aqtqek9HwCdsjgaHcbo=; b=Sv+B/ssaS1lhALaKqgBdGf/6lo
	SKSIga3WCahhiG54JijCJxqlIKPHK8Fx8jZ9uuEbV9aQ82h9GHdjlY9nztdaXa+j
	8Z7Tvu4UUPVyB0Qy60vJGFOxM2QUbWMpMyhgBlCGayAWIKeAR1dkJl4lrm7qolt1
	Qjl8+RDTGP9whj4NNJFYaqtos79TjN0wzCsrK8igg/dqp6SfuUjDfES77b28nBX2
	uWm1CH/Jd5u6kWGEsiUqAFD9uIVRz6clxK7Ixj4QDTRjr3yQRl6M0d8adsaKBD9D
	MaZL2Qz6gb3nq8+G6MJp75XJ6uyivBfGuN/APsUfwLwV/CzYG7TNZabV26uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781805573; x=1781891973; bh=l1OzFciQiSMue+9tOUuMbFj+aqtqek9HwCd
	sjgaHcbo=; b=czBwF9D4mboUwsc0qxwzPIpliXclYbu5MrDdsojcdcomz+Fhs97
	YYze1tIKHerHhPxb/971neN952rKpljzqLRemHjLEGFEcUnvpU+Rp13MIi6CU9s1
	HZxuHBL9I/cVcbkTbJ3x5U4ZVmPYgjvj13jvFtv8YmuxVjQBVBifJettTBV/cKVH
	4BG0Ynxux9UMQ0eZRQ9aNt41fwLVTD5IoWfEFf0/EleIc22Vn/Bqwn8lzHgoom2h
	arvhVNvYV2Pae8id/JUBSm4GjCLz+i3MAtiCh9EUpy7PrQLhIsHRtcGMT/oB/dSu
	/OYFZM3txBFFafESGNINZ2oPP2u95/+h43g==
X-ME-Sender: <xms:BTI0avVq_IkJyAWIz09XA5eapDmwDHHjboIK0lSGfGSl_2jCalnTBA>
    <xme:BTI0aueOmrN2x3UsUxwbdkE7rbf3sas1K7bxatrh3S0xmmj1SRJ5RXINJi9idLuZH
    JEyGfuPyUufuVm9ujrZ2VpZzkW2l0ebiDU7sVOP7KvHuoBHRPDJl1Y>
X-ME-Received: <xmr:BTI0ajv1OAefqRlSnWF5gweNddQC42cJ2qnXdNz5Y0Ok53Nj_5XJhJmDZGwJNkq8IVW9jmH2bYsLzQ0NhmlFmimtOY3QgwuK0pWw>
X-ME-Proxy-Cause: dmFkZTF0veXoy5ySjO4gyawDYY9soKfZedAnpPlSYW3AOaguQAi0NwFqX4F80mi9bBI68q
    Lxtj4NJnJu91wztkaCMEtgSm65gLqPwVhoanf1tdq3CkyPjB3dXVZ3bgAkHUzq1YHkahC2
    jQdl+6dFRvoU0aRMn+UTi6QpBx5SEy3j81a4yVy0to25PuLWeKLXfXGQG9vF6lNQf3bAKu
    OJFyWne7sFjWIU9qTbEea8xu3n0qu3EbHMfMIjcjHdtTFoBd9G8qdvNloengBmXdduY9pZ
    or4idLVOaVP5T2u+wNWBGIVbuXrZZsUP8vBxuYIyrsCoZMuYWpy4bpTR8G3E9y+91NJ1pW
    EsxWT5YLHFJTXXW6rPCqGvAgRO38p0aSKbZGsQZl/IJh+909ayyJMoM9JYbMhcVG+prRaB
    +IJ7jO0eDaAtXdUgGazoVCGgL0FpLJakKhCznugvKw9etR1edQcTV972fvzY4/h5xPWSP2
    tKPNsfw58RV6vFy3EyZ4tTq2sMBbYQ6Tkx4zxy9vyNFk5v6VYhavGA4ASXRR8WzP44Q4go
    fWxeLhj29t1YyTRkzGiRD+F+KZwvtYlKCm1CeixDUJLspt8NFIczy/FUdSZbGbtj04DLIa
    EeFL0jTH05lgJDuonhaJIsC6F0fCyi6WIe1Mn8ozLrqmaHi3IXoTyk6LYIrw
X-ME-Proxy: <xmx:BTI0al-WmAFO18lJHbN7vgBCDYpqU0bLTtQBbS-xt8HknB9zrbJH8A>
    <xmx:BTI0am0du_svo3_m-qnjtPLz3r-4NLxZt1EmZYDZMUVPhgMiSP2QoA>
    <xmx:BTI0aiDPk_X6H1Z89lk5qoH15TI9y0r3vjfHiPU_8ciri4ibwbzIIw>
    <xmx:BTI0aqc4v2O1CFSUa7UEDQYhYq061HradbYYI4QRAhrljeEuD_DIlQ>
    <xmx:BTI0alMFMImPv7YSSWri9uySFsW03l7X8UGPOa9p5ULhopdRt69LVNaD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 13:59:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 15/17] odb/source-packed: stub out remaining functions
In-Reply-To: <20260617-pks-odb-source-packed-v3-15-b5c7583cd795@pks.im>
	(Patrick Steinhardt's message of "Wed, 17 Jun 2026 08:39:58 +0200")
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
	<20260617-pks-odb-source-packed-v3-15-b5c7583cd795@pks.im>
Date: Thu, 18 Jun 2026 10:59:32 -0700
Message-ID: <xmqqik7frapn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

Just FYI (i.e. nothing wrong in this patch)

> +static int odb_source_packed_write_object(struct odb_source *source UNUSED,
> +					  const void *buf UNUSED,
> +					  unsigned long len UNUSED,

The type of this parameter will become size_t via another topic in
flight; I prepared an evil merge to address it (otherwise winbuild
would barf, as expected).

-- >8 --
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Jun 18 10:49:10 2026 -0700

    merge-fix po/hash-object-size-t vs ps/odb-source-packed

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 42c28fba0e..decc81aa52 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -503,7 +503,7 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
 
 static int odb_source_packed_write_object(struct odb_source *source UNUSED,
 					  const void *buf UNUSED,
-					  unsigned long len UNUSED,
+					  size_t len UNUSED,
 					  enum object_type type UNUSED,
 					  struct object_id *oid UNUSED,
 					  struct object_id *compat_oid UNUSED,
