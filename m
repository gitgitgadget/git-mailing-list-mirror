Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876C40A940
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083496; cv=none; b=hQqkNfnzrhLm2mIXwf3FatdfDXuCLyffYpx7cQpwF4nL7XK8x4U2tcc301OmAu5EHeQ0mo3Lvrs1SatmUYU3MVcfvaZ2SOGsNffoXEqXW8Zao6Lf5KtCOQEifKksU15WsYCbr2dk8TS4e+T8uAQdwpHZ3eeTvxc1TUW+EDXeClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083496; c=relaxed/simple;
	bh=+xSjb2GFf76zAOAdRFWOGxOqi9bT5hqT75f8zrKK468=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=GLlq7D+aK/zfnor4xXjovey+SohTojii/p0uMgRJQ139XOrJ54ZWd1pUPp2ARvqHA3bwEJuTrW2YiMeSh/+9LoQA9lu4QV4jJLW7KfQWUBwoe4b/tXSFurolZg0UZ4u0C4HREPVsU+6MaP9K84+dSsaWKJRYo4CW06ZxoAAV9to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VDAkWMyI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DZ8xqkyp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VDAkWMyI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DZ8xqkyp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF6A714000DF;
	Fri,  7 Aug 2026 02:18:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 07 Aug 2026 02:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786083493;
	 x=1786169893; bh=W3FOoka32SdYRjxzV5tI/nhEJhOGjJ/juz69FQnU29k=; b=
	VDAkWMyIU0cFoEv93tM5cvRgcf/g+CGNh96ymwOijYEVGDvVgkmBPtbFAHjLDR41
	d91KGHNkMPNHOUE5UBWQUrAUdaAq9TvXkUhjgEfK69dvnTJtWIrb5Tq5oOvAJGMN
	Q6LsQBx8jPcRANQMKOEOFR6Z4/DxGR7+CH9UMq+H1JD5VYHl6l4Yh+n/0m7cTRiX
	jzC4d+dZlv0xFnCPmJinuxPqhxgRWZoW4Ob7kXpE8R4LcbO5vGPZL0EUz2q8IpG+
	OKQFGxrPdXqBNm81D3bvvgwSGDoTPsyJmN9hbrOh9omyAj6HdHoZQVNktlTQBzWa
	P8GZmNs6XpusMtIuKIjbkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786083493; x=
	1786169893; bh=W3FOoka32SdYRjxzV5tI/nhEJhOGjJ/juz69FQnU29k=; b=D
	Z8xqkypCJU4Tf+JC6H41cJXlNOfFBvdxV9p8hhDe/zmsPVtDvwV++yO5EJ3ncL3f
	3XmFBmvfAnX0sJsxJVV2qlhXTCCXEaE4Jb6mRdjARTZFsETz/C9/TwCmKrHMSTey
	Fq2flOF/fcYpNzMfrOpBohun80ObjGvTynRgdKNYNBkgGPF9ZcHuEU1zOBhM+qA0
	Msre+XEo7HLSMqJUazf8QTK+FEdaSY5ktWn4HwU/cNkDL+YxXWo3Xa8yzRyXDILH
	ldh9zhinH/B77cup6TT8TnMhH3GPo4gUKUqnmtbkIVkdZx3DORM2dGYMmapqZ8pF
	dXAI6zTzM1IO1SNip54YQ==
X-ME-Sender: <xms:pXh1ah-IEgOZlsXmrvghCNX9rCf4h_ZDufOYk-11vNPn_hBBx5r28A>
    <xme:pXh1avvsrMjsZaF987nuSM3oAFE9VhRniWwUSjeyZi5mZdxBxhYEWK8711Ii2srGr
    u1GdtwP17ZAY9o6sl4AuUKIGNH3mRJjtWSY5rGfvF_SuQaqOgLeTA>
X-ME-Received: <xmr:pXh1alr3LBhLcpfNToRZLGFmnt1_uJqzsstOLZfP0f1a5LHC5t2-LE50yU_5drwpXHB_0u6zbm_PPwgsXAQihvE_O4ciuK2cIjpdoFFcFHFkJg>
X-ME-Proxy-Cause: dmFkZTFAYxr/gBtsd93GBbRfb2/C1hu7omVY9H9i+4awpHqkW6FlkqjIBeCDwXP4Kk50jT
    ZblfYDxrSV2WZ9vPENaEpg2jYpd7O/13QnXiDyl/3V5XJ77E0328gqpF6DcCd2HP2+M77a
    HRkPO1+Dh+TlfYp/wrCDelPVJqnnqtrRZ4I1zCHVHgzfNY3hYSoWq/JLn8pyrcG5IGI76z
    hcYB8XoPWcez7TLhewXlF0RtE87FHOVgi64vR+Qcl8zvy/Mp7EZMNUMwgXNgKfWRpeJ3Kw
    B6jdPf+NSEoyzunhwA8jXZcS7tctK3MHn5H7f4aOf2dZywJECQ713aaNOpFCIMf0nJRgpW
    lgSqhSm7wtATLDFr4+d9CT8iE58W/uJzm3m4JvyIMBKvCGBEW174LQLtoZ1MytaY2gkiwA
    GKPGlpXKBL30BaK+Cgilk7Pi+vJ5sQIneeSS4jfZN1uyXAd826bBEvQGuHNGUmxtH8g5pQ
    ZZz3KKB4A2IPm1MCoedKrNSCJ6akovNhGvbYbolqAc8/gaGa1nW5As6Ym3gBUEvPmJxfwc
    /p559joC/Ar7+Df1cRIMsUxp44MGAzdh0sHfH2qxF+PAt/qwc3mKKBpOvJ0pLLXukRGNHE
    aU9YhDaRvpRUpFUbN6z3PQi1OReC3bYiHCEcaputfmDnE92q7yDSZFBMvFNQ
X-ME-Proxy: <xmx:pXh1ajorEKUyoTXLSxsDc7EczLTsuwh3_tA4qxouMogymnhE7mGa8A>
    <xmx:pXh1akbU83aQoWiBnJ6NtmIVGhHgONcQCL4acDLDfksaA8EiGuFXrw>
    <xmx:pXh1ah8mxE3qKaw_gLZR33lcgWvSFs2NVp8LbhQgyC2ujZCooeNUxw>
    <xmx:pXh1ainqdeToNWTnfYNzehiuLM5QQFGB3mF3N0iw0DO3eaXyV9zK1Q>
    <xmx:pXh1arNBEyCP2gUHUsgOq5GxxcX4-14MNvv9uyE4wmhZhy6N1eGzCY_r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 02:18:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9c63bfc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 06:18:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] Reintroduce writev(3p)
Date: Fri, 07 Aug 2026 08:18:02 +0200
Message-Id: <20260807-pks-reintroduce-writev-v2-0-30fcff0e89c1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0JmbU2pCMWV9zAsoAwyGguZlqoh3
 N2CcenyJe//N4NDJnRwSmZgDORosBHULgHT1/aKgtrIoKTKZZFmYrw7wUjW89BOBsWTyWMQqtV
 dgUeFiCXE8cjY0Ws7vlRfdlNzQ+PXt9XoyfmB31s5pKv3i+T/IiEVUmBdyoM2WmeNOUdxTw+ol
 mX5AClNfCbLAAAA
X-Change-ID: 20260714-pks-reintroduce-writev-2d8f7e52eee9
In-Reply-To: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Hi,

this patch series reintroduces the writev(3p) wrapper. This wrapper was
originally introduced as part of Git 2.54 [1], but was ejected due to
issues on NonStop [2].

This patch series here revives the effort with a couple of fixes on top:

  - It picks Dscho's fix for CMake [3].

  - It picks a fix for NonStop [4] and polishes it a bit.

  - It adapts one more site to demonstrate that its usefulness is not
    limited to a single callsite, only.

Furthermore, I have included benchmarks now that demonstrate the
benefits to make this series a bit more appealing. Ultimately, I'd be
fine if we say we rather don't want to go this way though. I merely
wanted to tie some loose ends that I left dangling.

That, and it's nice to not work on pluggable object databases once in a
while.

Changes in v2:
  - Adapt the writev compatibility shim to not do torn writes anymore
    across multiple iovecs. Instead, we now only write the first iovec,
    which should be fine as callers are expected to loop around writev
    anyway.
  - Link to v1: https://patch.msgid.link/20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im

Thanks!

Patrick

[1]: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
[2]: <028901dcc859$d2419470$76c4bd50$@nexbridge.com>
[3]: <pull.2078.git.1775206502134.gitgitgadget@gmail.com>
[4]: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>

---
Patrick Steinhardt (5):
      compat/posix: introduce writev(3p) wrapper
      wrapper: introduce writev(3p) wrappers
      wrapper: properly handle MAX_IO_SIZE in writev(3p)
      sideband: use writev(3p) to send pktlines
      fast-import: use writev(3p) to send cat-blob responses

 Makefile                            |  4 ++
 builtin/fast-import.c               | 18 +++++++--
 compat/posix.h                      | 14 +++++++
 compat/writev.c                     | 41 +++++++++++++++++++
 config.mak.uname                    |  2 +
 contrib/buildsystems/CMakeLists.txt |  6 ++-
 meson.build                         |  1 +
 sideband.c                          | 14 +++++--
 wrapper.c                           | 78 +++++++++++++++++++++++++++++++++++++
 wrapper.h                           | 10 +++++
 write-or-die.c                      |  8 ++++
 write-or-die.h                      |  1 +
 12 files changed, 190 insertions(+), 7 deletions(-)

Range-diff versus v1:

1:  69b8be6ec5 ! 1:  f519260452 compat/posix: introduce writev(3p) wrapper
    @@ compat/writev.c (new)
     +
     +ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
     +{
    -+	size_t total_written = 0;
     +	size_t sum = 0;
     +
    ++	if (iovcnt <= 0) {
    ++		errno = EINVAL;
    ++		return -1;
    ++	}
    ++
     +	/*
     +	 * According to writev(3p), the syscall shall error with EINVAL in case
     +	 * the sum of `iov_len` overflows `ssize_t`.
     +	 */
     +	for (int i = 0; i < iovcnt; i++) {
     +		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
    ++		    unsigned_add_overflows(iov[i].iov_len, sum) ||
     +		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
     +			errno = EINVAL;
     +			return -1;
    @@ compat/writev.c (new)
     +		sum += iov[i].iov_len;
     +	}
     +
    ++	/*
    ++	 * We only ever write the first non-empty vector so that we can
    ++	 * guarantee the call to be non-interleaving as guaranteed by POSIX.
    ++	 * This works just fine as callers have to loop around writev anyway.
    ++	 */
     +	for (int i = 0; i < iovcnt; i++) {
    -+		const char *bytes = iov[i].iov_base;
    -+		size_t iovec_written = 0;
    -+
    -+		while (iovec_written < iov[i].iov_len) {
    -+			ssize_t bytes_written = xwrite(fd, bytes + iovec_written,
    -+						       iov[i].iov_len - iovec_written);
    -+			if (bytes_written < 0) {
    -+				if (total_written)
    -+					goto out;
    -+				return bytes_written;
    -+			}
    -+			if (!bytes_written)
    -+				goto out;
    -+			iovec_written += bytes_written;
    -+			total_written += bytes_written;
    -+		}
    ++		if (!iov[i].iov_len)
    ++			continue;
    ++		return xwrite(fd, iov[i].iov_base, iov[i].iov_len);
     +	}
     +
    -+out:
    -+	return (ssize_t) total_written;
    ++	/* When all iovec members were zero we ought to return 0 according to POSIX. */
    ++	return 0;
     +}
     
      ## config.mak.uname ##
2:  f6013a18ba = 2:  41814b6668 wrapper: introduce writev(3p) wrappers
3:  3dc0eff00b = 3:  af2e351491 wrapper: properly handle MAX_IO_SIZE in writev(3p)
4:  95c872432f = 4:  d3ba9d73d2 sideband: use writev(3p) to send pktlines
5:  4c1efb5284 = 5:  148a2c8928 fast-import: use writev(3p) to send cat-blob responses

---
base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
change-id: 20260714-pks-reintroduce-writev-2d8f7e52eee9

