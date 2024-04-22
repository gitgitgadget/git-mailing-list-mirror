Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06D1534E2
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801027; cv=none; b=L0bYaDVoE6i2Fh2agQoZxJn6fNqSklsv5MF3fqdaBbfDRuh924SOnPXlD92o+wRn1M0SwJL8IUAAgMZuh5wlTaj9rBRvKmiLejdA+4MjnjQbaygtW5561cBl7TxlmQSoKcS7+ElAGONWigNbZyunN0RZ+P4D3NQrbvDFH7LwDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801027; c=relaxed/simple;
	bh=CqlsKuntZKmL2MbFjWWJdhijcVFQrNigQUF7yYDGKTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aiDmwuvc46Tun33fG3XOr1j92cpai4RcY1Hl0XU7zhnerXZorGp8mvmen/8ujxjsXVNKHqdqZKd83fjuveG2sta5FfQW7C4FVcGLpCo+mqNNHlF4nqnNjVnDPiTZaOzWUUhrvMJmsAjfxpKNBM1cSoYa6cQsvxLjNJAPcHYMfo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GoPCoMfm; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GoPCoMfm"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EEA091E9F09;
	Mon, 22 Apr 2024 11:50:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CqlsKuntZKmL
	2MbFjWWJdhijcVFQrNigQUF7yYDGKTk=; b=GoPCoMfmDiDG99JW3vCXlQKTRMfr
	scrlQq9Y7TxzQfc9BeIO2Rkadoshh/cjJsuTKmZ95iqCkwEKDFVAnD6Sup/oeIyo
	kIL2r83MEdNu+wlgjqqxOB7HzqNUKm2Jmu9MBdT36aSGWaHWBjzd0fpiL1UmrFwy
	fkm7d9xR5VatV/8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E70111E9F08;
	Mon, 22 Apr 2024 11:50:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57BE91E9F07;
	Mon, 22 Apr 2024 11:50:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] add-patch: response to unknown command
In-Reply-To: <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 21 Apr 2024 23:52:33 +0200")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
Date: Mon, 22 Apr 2024 08:50:23 -0700
Message-ID: <xmqqv849xups.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 083DC386-00C0-11EF-A0B9-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> 1:  0317594bce ! 1:  b418b03f15 add-patch: response to unknown command
>     @@ t/t3701-add-interactive.sh: test_expect_success 'warn about add.=
interactive.useB
>      +	test_when_finished "git reset --hard; rm -f command" &&
>      +	echo W >command &&
>      +	git add -N command &&
>     -+	cat >expect <<-EOF &&
>     -+	diff --git a/command b/command
>     -+	new file mode 100644
>     -+	index 0000000..a42d8ff
>     -+	--- /dev/null
>     -+	+++ b/command
>     -+	@@ -0,0 +1 @@
>     -+	+W
>     ++	git diff command >expect &&
>     ++	cat >>expect <<-EOF &&
>      +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${=
SQ} (use ${SQ}?${SQ} for help)
>      +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
>      +	EOF

Interesting.

My first reaction was "how is this different from checking just the
last line of the actual output?  The early part of expect and actual
both come from an internal invocation of 'git diff', and they must
match by definition".

But that may really be the point of this test.

That is, we may later decide to tweak the way "git diff" hunks are
presented, and we expect that the way "git add -p" presents the
hunks would change together with it automatically.
