Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F333271A94
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999392; cv=none; b=lvWJKQ4ZYsZLyAM749z72a4FzuxiohV4lkLFMpTGlbN72SLd8l8O/KT2TZy8AbHDGwTYKh6PFZ4gz2koy8/aIiHyK0ANH+pWcH2uy6NmQvRd9As4bHW/12HPKF29ZKUFX68LHsKEskgSCcE+Kv3HEXpxjc/IfjGuAWivg4nYEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999392; c=relaxed/simple;
	bh=scO05FG5n9VRfVkTIv5/QvthNmE4j9FKBc8HsynhWhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rn2+BRIt7k28aVbriJ5p2mrc3krJn3wsuiUcvpzBMGOshCO90aQGz2g16PcZm6Dg8kx9tDeEjJsnNjLtgbfE4C3l+Q9UJwo0U/KNe5zeEsuz2/ev1iKrbn9rp4GqoJqaKlokDWyvydb33GqQRp9ZeZJBIOXNGbewu6euZF8rGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QvwahhAQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAqhdp8y; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QvwahhAQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAqhdp8y"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id F377FEC03D1
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 13:36:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 14 Oct 2026 13:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791999388; x=1792085788; bh=scO05FG5n9
	VRfVkTIv5/QvthNmE4j9FKBc8HsynhWhg=; b=QvwahhAQVeECXH9oHpAcnVY47M
	1S5deK8wq42qxdCcuCNFdb4XETNyRxIaBj+M6RO/hw60VqjYgS9Y5zQx9Wi/N6ok
	aPeLqme622yhC5g4fvKlMyjfdDX0mqmlEOlhHRmwQzVPuykNW9rwTKF1vcOgUoJd
	ViWPK+ldyOzg3azLjRcfBKOHTdDvo4TPwtqb/rMF1DqCzGz5IQ/i8CeJz44VaJOn
	etn5fT1JIYMT/yjnvznlliwChZxaQyS7pjyZmZ28pyeczhGQoe7KH4WUMLLyuHA5
	rv1xuMau0poXvrZomNbYLdYyIHX8IwCjIld7eU1NcLLgmBWn9C69e/W4odAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791999388; x=1792085788; bh=scO05FG5n9VRfVkTIv5/QvthNmE4j9FKBc8
	HsynhWhg=; b=YAqhdp8yolm04W8OtaiDWtztAEiuPJYXEApcvnnhTmRskxGpD12
	xve4gEdMxvkqKbj2989QgSgFpCdHNn9MibMXXXsmOCyc/tIp4BoX8OFxoMCmrcoS
	MTtx2wZNAqmNn/kyKdDppHRbzmCLmrjZ1O/5YXhvcvTUW4jxsvNbYkcMyKCaZTBC
	OTKKtgR3Cnbr+o1xtsO5znNaiQfWenovh+UBHvgUVMOh7/UiOdvnerM97WdiBt1A
	/Mh0LNmctUQh81Rn9Q6Xh4vEgwI9cv6GZX6mzshnITnXu5swYzViFIM4AYPyCZTz
	1e5eSQ9CPE5OcZAgwK0TgLjC6yj0fbkSUNQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791999388; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:aijdJSf7SDo5D1d0jIoyN9DGVaZDypX+Dbrj6ojbeUbk76W
	beYt+KQgeABXTEnjLGwxEWObBA+3a53+euAETST9nTqucX3xzPgbf4z4UX6rlYee
	KBUYYTd7LqK+X4c53L2vDce+6y4jtlO4KGkeSV49O2Kp29dJac0OX3EUyo+uGC6S
	QL2qN1sTf3XiyEr1CyMtgmozcOg51TSH77GU2/WnzI3kR0RCT8IxqlLp81KTlvdQ
	oxr/pxSuKnUv1vbMdEBbyaJt2Y8x/18f/OSSrPe8AAZPKKyMRopVXd7I6galegMu
	J6KiR8AiXqQy+TXGy317q0OLoUb7sOO0Ht9cfzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:RWACX/j7Nl67YqgD20/KZuvBLfh19+LgA08EpweJHVI=:scO05FG5n9VRfVkTIv5/QvthNmE4j9FKBc8HsynhWhg=;
X-ME-Sender: <xms:nL3Pak0dfsAcsX9y4WPJ7HM8DPwcMnXLXxH0rzV5v79WQxn5Vge1qQ>
    <xme:nL3Pal-OLiiB1wXIIKPusxaHSB0TZBa0q46sEdhdm4CB_K8L16qecnOSsDvSaRx5G
    kJEEsog7HpauIHDux2HEymqRdFwpFWyEbRe-4IP7bBDr_vfReOQHDw>
X-ME-Received: <xmr:nL3PalOLYjSD7JP3j7MBrTP2KspjBL3J-__PC28UsmUi_Xj9cJ4FTV52hGONKDVj5f87FEvf8XGbIHs0N9lxBeBWqwDHg6XVDV8z>
X-ME-Proxy-Cause: dmFkZTGlDYpbK6vBxwc3xn01JrPDYbkLY7ElKADAcWcPwzE3djChJ+YwwMGsCgH0wuQzmA
    5wJUX7L3Sy6r8VxO31qE4aTDI6iPoyENyUfjWQYCXM1B/JL1wCflOKbw05PadZeo/cwv4+
    qbUpoqiAMmjel4PXp8Bok7flySIt7Ct6N3Geo13rmkDBzTlxCC7l8KlogOsjYb8EodMM2u
    URhVXhg9qbT8tkB5yBxBJn6WBReR0sr0t8BQzAlPJgVKPpMag2sRcgKy6V8VGnknj6doo6
    l5n0nJL5VGD6/tZJ7oHtbyIv4EqDRqG8DY3VvQY63702FIHmS7AbF5+uEl4pWrvDNhjZtn
    3Yj0KvmnUy6Lu8dGhMJTMz7JWAzTWPO+qXHr8xiG/eKJ+g+jf4cSNF/c7XyKCbSolsbMxN
    j60wdEi0hXIRbGIwJHgAeDpGoMzdHeRw4mjSC5gS5qUMViQOHObcjlzhjY/cwUzFjcgBjE
    mFTgBzFCiTqWpY/Ye9HRAYDDlIAwHsqRfsjrfkBporDc0LkAyxKvf0E7VmazT6SXiObW+2
    6qNozYMoYiHaTaHMIwItOj/l6rFRT93gx/U7A6uu6f9IP75khGpPSfRG4Fha15WLRPL19Q
    udbSO/0nprX5SL4GicD0hK6dJIFepjl9TW6n5b4Ot8/V/seL16mqWmoIhuaw
X-ME-Proxy: <xmx:nL3PapcOR8f-osKmFedkhjIY9ir78p4PzDyaYB3oIqC5WS7r6CYPyQ>
    <xmx:nL3PakWdpkoWKuJx-oBwnsR7cdL1u2TlmN2gQQ4tuZoZ4ABxyg7wbA>
    <xmx:nL3PahhO1U9JDCFPwusb-C7YgyGtqT3GtdESe2dBgPicXd_1yHmGug>
    <xmx:nL3Paj8YVcbjoIBFkOKDJNyVeHZb4InODtK1gow_QUsSUVK78kRfvQ>
    <xmx:nL3PaqVbFqj6sBIvtlM6wBbiRK4Gm9YITUn7AATfCERmINCmFtxD1hXA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 13:36:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Antoni Borowski <antekborowski11@gmail.com>,  git@vger.kernel.org,  Josh
 Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [Microproject] describe: pluralize tag/commit count messages
In-Reply-To: <20261014092923.GA1344504@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 14 Oct 2026 05:29:23 -0400")
References: <20261013204351.428800-1-antekborowski11@gmail.com>
	<20261014092923.GA1344504@coredump.intra.peff.net>
Date: Wed, 14 Oct 2026 10:36:26 -0700
Message-ID: <xmqq4ieotc9x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> OK. The patch looks obviously correct, though I do find it a little
> funny that we bother to translate these debug messages in the first
> place.
>
> I wonder if there is even really value in keeping "--debug" here at all.
> But that is a somewhat bigger change.
>
> The patch here seems OK to me in the meantime (and totally fine for a
> microproject).

Yeah, but a microproject that convincingly argues that output from
the "--debug" option should not even be translated and undoes _()
would make a much better case to see how a new person works well ;-).



