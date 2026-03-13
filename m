Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54433F8B4
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384328; cv=none; b=hc5X1PTUL20I1juY2iLJBhJ1NWFNlwjXCoqGrJfWmk0e17xHklljn/VK/esr6Jjc26ttnyCxgyEnwuNNhAXqO8PF/H4XYDwxwHdGKzLKpP2ZGz67nmLEYpLKdy0wtY7vxICWL615JlHFs30UCknxJYLvwvZkCExBHvveTFGPnOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384328; c=relaxed/simple;
	bh=dy0qkzgqdT2ZAL8oKhrBglQ+xPM3GT+1yRJDYaX45MU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=KCcFUrX0ndwYUleiG9BlXSXiNeMwzMBKHEtQfwJk0dX5GDhBhJ6e9C+w3oAacYNftFrXbXJKe04wo4w6auxwkQvEKtrop13IAytpZCHbEnOCgB02LWK0pcES/mu/E2wC0UE7eR7NpnQq4kbBrmMXbqVU3C0OokZwqgjVO9ovGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FO/MRYVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fw4P52uj; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FO/MRYVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fw4P52uj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 410961D0011E;
	Fri, 13 Mar 2026 02:45:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Mar 2026 02:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384322;
	 x=1773470722; bh=7eoRXY3gWP5EeEi5e3DCVNevwXsnwbMeqKQx7kRyQ3Q=; b=
	FO/MRYVRgc8H192ak4ZsCyRT/jAOMQbZZaP/rNn2XinqH5yaYSeuqg9m6DvGmHCA
	TrS4Rdp4g5xvQcxAxyBvPZ2GJw013mHXJxzkcbHL8xf18Pp4yCdSaR8m4JO5dzjS
	+4h+xbCW8bd+RMzZWDke/jy0FnWPe0gc2+0YEAUd9SePP+EHpqLAQSg1Rptq30fA
	nLClOmqAa9PwUosllkbHjzDvGLwXpAb06ZF9ptIEtPnL/3lzL+RXGl+xKRaPmUtR
	jzxbcRm/YwdTdRNHap3zxjl64Tn8RR1pqhJsq3aA3imd0Gjygp947nO4Bb/gTBue
	vHnQapzFMZhyLI40woMjBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384322; x=
	1773470722; bh=7eoRXY3gWP5EeEi5e3DCVNevwXsnwbMeqKQx7kRyQ3Q=; b=F
	w4P52ujODnlUn1YjGywrqypA4csALGviVd7WzDhQfJH5C2ARi5XJZcBKDv5ujLeF
	9P8MZvnrV/QnM5+7ft+gdLlAjzQJWWf6WeSX9xZfzuZud700XLb1X9KZu2Tkp25K
	2vVVYMO3tSGICPJ0v3/KwfMINCK0NYkDn/iSNLeVhmJDRQXg9UsWlUrjCRVk4I2p
	s5wM1Ksy+Ibq2d/HFD6/1qz7gCVEZq+jcfHS1fQD9ddamEG1AkIK+l8gf+0vtebl
	qL9bYqfBln4qiesqRSWVwTXjxSltDC6RadRxeSeD0Zo9C0ykrIT7M7TrkjifRpJf
	5Bn8epAOCqknWs5Iw97bQ==
X-ME-Sender: <xms:gbKzaY4LAD6U02qnVimL4Jy5NPBfN3hOo3PZ9AJv_bcFMIPijeAu1A>
    <xme:gbKzaQxme1Yhq8YSkLXbCkVL2ps5OtxfJphvJJCT5Dn40SedDw5PsAzIFxbFJ_c4v
    PsGkIM9XMnuPrVDBTuEzRdFtziIaD32IVo8d15xuuzZ0ivRRn7Rkw>
X-ME-Received: <xmr:gbKzafzNW84bccvljhecehRNfO3tQu6Wku8o_x7L6692sWVl6_lCSkSWCJx49Up9eeeeCV-IHjBynEHGnoJAKyjVeLUjGZtXENkXCKzavA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetkeelkeeuueevkeeufeegvdfhueeilefgtdegteeifeehkedvhfduvdekvdehvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlhgrsgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtgho
    mhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:gbKzaYxGGEqs3SbiRPHWqnL8XPYBeYT9KR1CURXtzvic5j3wdQ6ruA>
    <xmx:gbKzaZaO3QH57eD4fDSvt3xBF4ZRq3H_47aN-AyH-Kvpk42Umdmt6g>
    <xmx:gbKzaZXTtGOhnEPeSgk-CkPAn-ALOgHu6aWXRWzXPqKDfc-rJZIxRw>
    <xmx:gbKzaXg8q4NbSEzD5uXIgq_ogywfBYzdY2gGP7uaTLvPa0tI40_CjQ>
    <xmx:grKzaRRNbTpfXni5qTRlQ85JjtMN7rwmBUydH1l8-kn9PFdGtIcLPlkl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4852a24a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/10] upload-pack: reduce lock contention when writing
 packfile data
Date: Fri, 13 Mar 2026 07:45:11 +0100
Message-Id: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHeys2kC/5XNzQ6CMBAE4FcxPbtmuwWKnnwP46HWrTYqkBZRY
 3h3Cwd/bnicSeabp4gcPEexmj1F4M5HX1cpZPOZsEdTHRj8PmVBSAUSaWhOEa7NuTZ7aIw9wS3
 4lsHWVctVm8aQqdwySpc7XorENIGdv48Xm23KRx/bOjzGx04O7R94JwFBy6JwTHmuMVunycJfx
 CB39NEUqgkaDZoiWSp0WDr+0dSXJnGCppJW7uxSG6OYCv3W+r5/AXEObwNpAQAA
X-Change-ID: 20260227-pks-upload-pack-write-contention-435ce01f5fe9
In-Reply-To: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

Hi,

this small patch series fixes some heavy lock contention when writing
data from git-upload-pack(1) into pipes. This lock contention can be
observed when having hundreds of git-upload-pack(1) processes active at
the same time that write data into pipes at dozens of gigabits per
second.

I have uploaded the flame graph that clearly shows the lock contention
at [1].

Changes in v4:
  - Drop a stale half-sentence that I wanted to remove.
  - Link to v3: https://lore.kernel.org/r/20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im

Changes in v3:
  - Fix handling of `iov_len` overflows in writev(3p) wrapper.
  - Add another patch that causes us to flush out data instead of
    sending a 0005 keepalive packet.
  - Link to v2: https://lore.kernel.org/r/20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im

Changes in v2:
  - Change the buffer size in git-pack-objects(1) to also reduce the
    number of write syscalls over there.
  - Introduce writev to half the number of syscalls when writing
    pktlines.
  - Use `sizeof(os->buffer)` instead of open-coding its size.
  - Improve keepalive logic in git-upload-pack(1) to account for
    buffering.
  - Link to v1: https://lore.kernel.org/r/20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/work_items/675

---
Patrick Steinhardt (10):
      upload-pack: fix debug statement when flushing packfile data
      upload-pack: adapt keepalives based on buffering
      upload-pack: prefer flushing data over sending keepalive
      upload-pack: reduce lock contention when writing packfile data
      compat/posix: introduce writev(3p) wrapper
      wrapper: introduce writev(3p) wrappers
      sideband: use writev(3p) to send pktlines
      csum-file: introduce `hashfd_ext()`
      csum-file: drop `hashfd_throughput()`
      builtin/pack-objects: reduce lock contention when writing packfile data

 Makefile               |  4 +++
 builtin/pack-objects.c | 23 +++++++++++---
 compat/posix.h         | 14 +++++++++
 compat/writev.c        | 44 +++++++++++++++++++++++++++
 config.mak.uname       |  2 ++
 csum-file.c            | 28 +++++------------
 csum-file.h            | 16 ++++++++--
 meson.build            |  1 +
 sideband.c             | 14 +++++++--
 upload-pack.c          | 81 +++++++++++++++++++++++++++++++++++++++-----------
 wrapper.c              | 41 +++++++++++++++++++++++++
 wrapper.h              |  9 ++++++
 write-or-die.c         |  8 +++++
 write-or-die.h         |  1 +
 14 files changed, 239 insertions(+), 47 deletions(-)

Range-diff versus v3:

 1:  65471f969b =  1:  f9896a8451 upload-pack: fix debug statement when flushing packfile data
 2:  c5705c1cb1 =  2:  b1bc6f5749 upload-pack: adapt keepalives based on buffering
 3:  f34fa584f4 !  3:  fcf5f06375 upload-pack: prefer flushing data over sending keepalive
    @@ Commit message
         the early bit waiting for packfile URIs. But the optimization is easy
         enough to realize.
     
    -    Do so and flush out data instead of sending an empty pktline. While at
    -    it, drop the useless
    +    Do so and flush out data instead of sending an empty pktline.
     
         Suggested-by: Jeff King <peff@peff.net>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
 4:  8d08e93929 =  4:  f2bb7a38aa upload-pack: reduce lock contention when writing packfile data
 5:  aa42217e43 =  5:  78a1bbb810 compat/posix: introduce writev(3p) wrapper
 6:  c5d194ca2b =  6:  c199dd398a wrapper: introduce writev(3p) wrappers
 7:  e4df805840 =  7:  b7fe2b818f sideband: use writev(3p) to send pktlines
 8:  16f9968bcd =  8:  b9d33b93cd csum-file: introduce `hashfd_ext()`
 9:  47ae58440b =  9:  b2af62c4ff csum-file: drop `hashfd_throughput()`
10:  c92ccf9df2 = 10:  47f5090b66 builtin/pack-objects: reduce lock contention when writing packfile data

---
base-commit: fb1b83bcddff60463f6e86bb021784c88d0b748c
change-id: 20260227-pks-upload-pack-write-contention-435ce01f5fe9

