Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48271FA272
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304898; cv=none; b=G6Lv+M3luXxEkBI9SjPKrll9hZZWkM8D+FN2jTeOeQ0tryq70EJA3Iv0xEiWwxcjG2fnDwJg3UBpKy1M7ww5Sg4y4Rlg/+k81TzR7Rg9DI4hb9uCbLrP6D9KLEUv9pnDYDkotSF/9kujlzbVpE+dDB7ANZ7vaRAVyyJI9Lzy0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304898; c=relaxed/simple;
	bh=tV8ulOk03jcECa/BFnv0GQoIynoKx6HNIgPrNAVDfg4=;
	h=From:To:Subject:cc:Date:Message-ID:MIME-Version:Content-Type; b=NghYLDPXsZGWhMfqJN26xXsQOUSGK8ti5cVCGorjgoQWVJ9Bnhx5Igitfphjnlb+Z5Rfw6fNhXeMS4ulZ6uyJrAng/d5qSvLqHbb8fIpM3ZeJbYdyDxocFFeLcqxdH0ondttwahF39bIXxJrMBALtKte1WjRejJp6vL3gczkfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eNQu1ury; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWr0rMnF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eNQu1ury";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWr0rMnF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E6E11400087
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:41:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 06 Oct 2026 12:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1791304896; x=1791391296; bh=Hwjp9mbg39u1BdD3NeUgHsVFuIOJZAVe
	nzQWh5Cz2bk=; b=eNQu1uryf2pCs6/bXpKK5/WVofPvoW6cn42L47GwQ2WBnt9Q
	1HRS6oz01RomuHhyv7j0urVukpAUXVcW8kA597CrGWHrxcPxAk3MVHmtI0dIgaUb
	NfjPv3JSzkSUe7GNCQUU7DdPfLc71s1jt6jCk3pKsJ8hqAhdEhV9yoRtYYFN+kpa
	puWPZLvjBzS+DOLMNUK+qPdkDobigxEoCbweuBGTBpjPIJw4Xs+nsIIAb1Iokvdx
	wDGmnl7VitaiW/NTkpC7cV3Pyc/eD2Xowy6fE0I0iLs/FbbsOH0RRABcU8vPuprM
	38p0Xx6l/PGfWKmN/cRyRrFluozIOFQHlMU5QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791304896; x=
	1791391296; bh=Hwjp9mbg39u1BdD3NeUgHsVFuIOJZAVenzQWh5Cz2bk=; b=b
	Wr0rMnFtQKQZtfrkX0BOEqpZdNNm41LeNXX9/tIZBqwtW79hANTWkE5Jo8GgfF4X
	yy/HCONNMVoky80fiSaj+Pu2+yFZi0HM7nEyOKuOTvPOBLImbMe9Sq1E/We2bkSX
	1RA0fwvTyRYJZqMzSWvk31UeneJAiFq91gX9zIv0NsFvjVvf6+Re/67/Uac5ilQQ
	p9WC9Ty1Q4sbCc8Y04EayDdVQrkIgBoLBul/M5EKhY5ydFRK1gHtth3R650DxNcO
	rfPNTy9mTC0Zi3jCJfkeyAqQ0xtSTMSNkUyyxEZxFH3DvIzNJtApTzI06S5rbdu7
	fnsDTkomCYluo9ru3gCMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791304896; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:GhuZC7YkOOSv8Cucnw4mq6S/7dDlIf8ug0aZdUJ1u4V0m2n
	lJRIUsfAIwUS6+TpR3taXlc6/LIVJrx8zP9J7Y4fvvtz9Cgungxo2b/AcShwonYO
	ITLrr6Vq0CtfVGckjQkbHjjIrWLnRkIjf2djIbFEBOGOUOqWcVHU8oYMlLYuxwz4
	cKfBAdC9oQ0bdbJoOwynibdtvB7kExPr7Yw4IAMdnd8cKH+5XAPzG5M1SDM60HWb
	MdoXG7oIoUeSzUoWvTnVFnN+b26PqOcqBPY/BwoNTFFw0s1URSx1eZ8NtXmIgVa2
	77hoMFII6ZHKZAmaFFQYZFi5wu9hy/cT5LVdzFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-type,date,feedback-id,from,message-id,
	mime-version,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kXiP5gqr8VlxSE5ln9HOu2uZUVTFIDYbqiw5xPLvNhs=:tV8ulOk03jcECa/BFnv0GQoIynoKx6HNIgPrNAVDfg4=;
X-ME-Sender: <xms:vyTFavGfTrfKx4fLZ287u4xUlOoJu34yo7pmXgekYBFUQGupS-XPsQ>
    <xme:vyTFajyXKtKjbR-Hk38o7RfmH0rogXZ6pg5uGhl3G-4OI6chUcxYKFsaNWWGBgDGF
    _FYTE7txCc_Hn1q5nfuhZCg_rjuoKTOIc66saA4pGDwRc2IIsG6zZpO>
X-ME-Received: <xmr:vyTFauhU0Gc6nGQf1Thh2ljdClptmj7B9g4Axcqnt2GJDfnu04tDEgYY56CO7QvlUlewj-BB9NnSzZQqUkKLJaeWkbspzmk3WkhM>
X-ME-Proxy-Cause: dmFkZTGCGCckmP/EyGRtAHq8/2llkofS7tupKzb5nfyZtO4tKiJlt6rolXA73aCcbwH0eu
    /Nhv5jB6ju5K+Y3L13728v4zfX2nzISXKgOoHtZv5ff78VmEoXav+GcCkSvlALbSt2467t
    9GPv9TNpSjxrjmh1YfsRyw1RRfBTF5MtEhqMa9FQPZJayJptK7eFpgJBaAGpDJRnsm+eWC
    o138otxYF2145P5y48/j+yzkRQTmqG3cGXurOA0KQV9GROoZHtdtc2vcd5m8Ec4K+vwol4
    7NJSbJ3Z53F1nmSYnUoUBblxAgfOdP6T4jKuoZtfq8tQHvfVpRKxIb9k8D0XNDdRGtdVQz
    iLaMMMPn3j1lpLt8dKCuYkJ34JrQy5RW7wrKI5pp/MVkfpB7mSBhCsWffc7e3QW8ZCjtD9
    qFC/uHUtZAyLTxPB2iPkH68zOukZW5Ji1IsRLl6aXsUjhE5lq3qGPnTnF7CFx6rPZmYV+G
    ur1ZNSu0o8bx/4jqyZSuZUbjxbGhMV5DjciHJ7yoIx08w177upGJpN0n4HLQUP/jG568gt
    PQlL2ckPTo6ZvU2UOJM50ROrJeOPtS/SeACjjlco86yyRNBzh4OXwdSq0SU0SHr/NEIrne
    z5hKc0vMF9cYybKXYs4NLhzaj16CLji1RaouZO5+dsWW99cdDPhWawTki9Gw
X-ME-Proxy: <xmx:vyTFamwap75Xu16T58ElosKlpf0fNYnq9ZrqKWomlcPPDCtpSvk3YA>
    <xmx:wCTFapLD1LxCX_gpeA-I7rE_rkeUlv3N-Ap6MIIjIFKxUOFS91TlwA>
    <xmx:wCTFalTydX-ZqPcYeh2kfy14a5bcbwt28hOf_4ljK1rwm-dx2TchnA>
    <xmx:wCTFapqvMuiy3BE-qyJZAO1zSteXH4uxnd1YIfTOJrcmzLIwHRoPZg>
    <xmx:wCTFanwkC_atLCWzu-LtLfu8_nC6paSBsZo0bQh0x6ymmIQiR9Ecdu6Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 12:41:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: test-grep-lint is uncomfortably slow
cc: Michael Montalbo <mmontalbo@gmail.com>
Date: Tue, 06 Oct 2026 09:41:34 -0700
Message-ID: <xmqqjynueq81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Does anyone else feel that make test takes too long to start?  There
is a noticeable pause after "rm -f -r 'test-results'" before the first
line of real output is shown.  The time in between is likely spent on
make test-lint.

Here is a time to run "make test-lint" 5 times in a row.

$ time sh -c 'for c in 1 2 3 4 5; do make test-lint; done'
real    0m49.221s
user    1m37.796s
sys     0m4.597s

If we revert the merge c9a92e239f (Merge branch 'mm/test-grep-lint',
2026-07-19) to disable the grep-lint, it becomes somewhat tolerable.

$ time sh -c 'for c in 1 2 3 4 5; do make test-lint; done'
real    0m9.166s
user    0m59.156s
sys     0m2.887s

Is this something we can make go faster?  

Thanks.
