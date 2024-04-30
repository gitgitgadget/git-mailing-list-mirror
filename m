Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47841BC59
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503720; cv=none; b=ID7ZoQKcloVUL0Ff7gzsyC3bzLI1rbRearMkwmBpfq89NU6/43e8akQmFbzmHjnOiViX4o+fHza9wK0yvmr3zvi/6mO0UyPpy8Xm6XNovllFPXdwxzZuL6Zy2/V3zaM+CMbie61H1ta5xG+mK0c6gEnbJ8EACjPiVViUx317678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503720; c=relaxed/simple;
	bh=RYt8V2VqWtceKpZ4i7YcuPUIrGSh+22BT1QpF89Kjf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NDOUDl8RIF95CAhjs+XT/rXvCIJQi3L17odqXb/c9bNzfooFerF8p7ACGZxdNkfZN0M/itfbhdNS9pepprdwTD6Ztc6/FIqxWPs6EdG0LKlWX+qh4aQ4YsDfVbBRwR9IJ0kUre+41MywqPU21eLhLj0mTlSHPJ6J5W2p4OiaFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mT9l8c08; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mT9l8c08"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8007539BC0;
	Tue, 30 Apr 2024 15:01:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RYt8V2VqWtceKpZ4i7YcuPUIrGSh+22BT1QpF8
	9Kjf8=; b=mT9l8c08MILNRGqr3AJU02AgS0/OyiXREkgEwUTm/6h/FTsaIesbY3
	P8TfJ/KUcrfKo/mYVRxY4lUg+u1/DZSS51phJAkEUqheejB4yjWTZSr6dCuMXU6k
	gr2r5FQJyRgOuS+R8Mx6vgPCd3F2ZSbf2jKOpuIzS7ZbGVeFFEqgw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76B4439BBF;
	Tue, 30 Apr 2024 15:01:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E009639BBE;
	Tue, 30 Apr 2024 15:01:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Beat Bolli <bb@drbeat.li>,  git@vger.kernel.org,  Beat Bolli
 <dev+git@drbeat.li>
Subject: Re: [PATCH 3/3] color: add support for 12-bit RGB colors
In-Reply-To: <xmqqikzyzoam.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	30 Apr 2024 11:41:05 -0700")
References: <20240429164849.78509-1-dev+git@drbeat.li>
	<20240429164849.78509-4-dev+git@drbeat.li>
	<20240430105727.GI1279403@coredump.intra.peff.net>
	<xmqqmspazrj3.fsf@gitster.g> <xmqqikzyzoam.fsf@gitster.g>
Date: Tue, 30 Apr 2024 12:01:54 -0700
Message-ID: <xmqqa5laznbx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1D0C7C0C-0724-11EF-A51B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Ah, I take it back.  The preimage was added by [2/3] so it is fair
> to say that that step would be the right place to do that from the
> get-go.

Perhaps something like this can be squashed in.

Subject: [PATCH] fixup! t/t4026-color: add test coverage for invalid RGB colors

---
 t/t4026-color.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 9a6f8a4bc5..e60aa588c2 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -140,6 +140,14 @@ test_expect_success 'extra character after attribute' '
 	invalid_color "dimX"
 '
 
+test_expect_success 'wrong number of letters in RGB color' '
+	invalid_color "#1" &&
+	invalid_color "#23" &&
+	invalid_color "#4567" &&
+	invalid_color "#89abc" &&
+	invalid_color "#def0123"
+'
+
 test_expect_success 'non-hex character in RGB color' '
 	invalid_color "#x23456" &&
 	invalid_color "#1x3456" &&
-- 
2.45.0

