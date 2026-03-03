Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE743570DF
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550035; cv=none; b=ABrEDIiMgnlJ3mi2bfJi7/C8iljEKWeru4ddR3BHDbNTqA2p3Z78ZlS+l3NpDyyiUFAR7/agmFzh34jGSc+rvelicAX57O1GedcL6qiV4nzj/Pt5bp1vLabJJHPtylDWrjbF5F1+bkcd8G/N6qFEnJtcEb6wseow455LImFMWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550035; c=relaxed/simple;
	bh=aT5Rx6slmejBt5pb9UyjS4yFfpOcBfOzEUY8EIFXr5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=BzXCqouVyYxUkitfzbCI5mO8cQPrQtUt+9hD41nU6PCMyEsXS5DT+LHpEX/nTkNhprk/QLExk7vKWjCXXj0NcIdMIEmJUO8akimq6r0C1gl8yKjCf/bEBbwBxc4XaVJlHbVE3P33bbiQ3U4zGYc4FiKQOnfEz7nAI48nqhdm09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c8l0O3eu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FWTpgOdM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c8l0O3eu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWTpgOdM"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 105391400195;
	Tue,  3 Mar 2026 10:00:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 03 Mar 2026 10:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550032;
	 x=1772636432; bh=kVIX58mr2vK6eXA4KNfaHu4VGiOJPhVcmDNcVyTsE6Q=; b=
	c8l0O3euoZg+Yt3hhBVjiUgEVN5SxvD2POXXtvBvzTJWsl88PGOKlQx0cxphqoYQ
	CX+WggiwIZS2XPVqQheNoI6ymMDEK25TiBBgCOXmijziWQ0kQ/jJhta3v2qaMkti
	lqPU9FoQdYKy6E7XQMMaq5BocuUQtpQToNfB51ZtUOe8fNpAX10FA3VcF1pAH4Zt
	sIy8cfYiiehG5wUnNSiUZGTEIpI4C45nRlvlvB25zVhwwMFqhImewj/1VS9RTC8u
	vS5pqa3oBmMfBo9NIZq6JOQnkYdzJgaTCXUSCZY+LFGwQi2fFSjGcvk6GOpYig93
	bS7mMJDPlZ7zpgcWDoJ38w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550032; x=
	1772636432; bh=kVIX58mr2vK6eXA4KNfaHu4VGiOJPhVcmDNcVyTsE6Q=; b=F
	WTpgOdMC7UlAqtoXWgNH4oqzVQquTnrVnhdN80sDufINcK5ffxLAfR8L4PTIx/js
	VWQPCbaaxLy/UYzDcclPrAKw+wsOHflJgw59x/J4BLDxtAnmTvcpu8GZLfsQ3C4/
	4Yb64rdfR+1csce6ssiUFwyt0uBEFeTa+rp+jFXG0QlF7EfzCpBVBMfJj5nHFlbC
	f14jziY0Wqzs0eGvT1HHsx9pyC4w+uouVLNWO/GmEab/M6PNgDwiOgekBfdnqMOD
	05vfZn+r/uLkBilngt233p6IErUC2jj4WFeG/0k41AKbbNzbBDVTcTOIDNMvFZwP
	eM72RZG2DqLsUagsf3MFA==
X-ME-Sender: <xms:j_emaX64Hqf-561zSLY98lmtkym4M4y1vcboRaaNUMjaaCKmMYcT_Q>
    <xme:j_emaT6CLH2-xbGR7OXb82nWkhfE2YegBNaAqwE5w4KMKvq4Bl_wroVIqd4gCbrZS
    WEX3RCYw-yZOnNblnq6Am6Pw0QkCOD02PXYMr6D2e8KJFk-XWTzGjg>
X-ME-Received: <xmr:j_emaTc2CYxsP9dSgwyoQtE2jm5uPzO5ynnoGaORhpI12xlIvq45NukaOX0Nxr577tMSbJ8W1-kteRCtBodh-SlVwzGCVKPC1D-ABiJ9uZ4G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetkeelkeeuueevkeeufeegvdfhueeilefgtdegteeifeehkedvhfduvdekvdehvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlhgrsgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmsh
    hmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:j_emaXCNdWwxG9786QqLUXEuysMSQRUX-dQAVI4pn60mcDvxTVADaw>
    <xmx:j_emaW8OofsNqYOPq31bRn7N3ahw6uJJYhy84haAaJMycuWsqb3hRg>
    <xmx:j_emaSItdbXnR6E9VCnp33chChNlM-8nVtMBH76yKRjWUQIpZjXacw>
    <xmx:j_emafjWsyiNGRNXYCw6mKdeYAqKAnb6LhuA9BMIbzlNP8PhcsYyig>
    <xmx:kPemaYWVcnzHG4lhblSxV6dWY7M0iExiZdASpN0PzvAQ0CyVU5Ek6iBP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 527f0c06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] upload-pack: reduce lock contention when writing
 packfile data
Date: Tue, 03 Mar 2026 16:00:15 +0100
Message-Id: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH/3pmkC/5WNQQ6CMBBFr0Jm7Zi2UoiuuIdhQcpUJmjbtBU1h
 LtbuYHL95P/3gqJIlOCS7VCpIUTe1dAHSow0+BuhDwWBiVUI5RqMcwJn+HuhxHDYGZ8Rc6Exrt
 MLpcz1idtSEirLZ2haEIky+89ce0LT5yyj5+9uMjf+od8kSiwlU1jSWndirorlyM/oN+27QvPK
 SBizQAAAA==
X-Change-ID: 20260227-pks-upload-pack-write-contention-435ce01f5fe9
In-Reply-To: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

Hi,

this small patch series fixes some heavy lock contention when writing
data from git-upload-pack(1) into pipes. This lock contention can be
observed when having hundreds of git-upload-pack(1) processes active at
the same time that write data into pipes at dozens of gigabits per
second.

I have uploaded the flame graph that clearly shows the lock contention
at [1].

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
      upload-pack: reduce lock contention when writing packfile data
      git-compat-util: introduce `cast_size_t_to_ssize_t()`
      compat/posix: introduce writev(3p) wrapper
      wrapper: introduce writev(3p) wrappers
      sideband: use writev(3p) to send pktlines
      csum-file: introduce `hashfd_ext()`
      csum-file: drop `hashfd_throughput()`
      builtin/pack-objects: reduce lock contention when writing packfile data

 Makefile               |  4 ++++
 builtin/pack-objects.c | 23 +++++++++++++++----
 compat/posix.h         | 14 ++++++++++++
 compat/writev.c        | 29 ++++++++++++++++++++++++
 config.mak.uname       |  2 ++
 csum-file.c            | 28 +++++++----------------
 csum-file.h            | 16 ++++++++++++--
 git-compat-util.h      |  8 +++++++
 meson.build            |  1 +
 sideband.c             | 14 +++++++++---
 upload-pack.c          | 60 ++++++++++++++++++++++++++++++++++++++++----------
 wrapper.c              | 41 ++++++++++++++++++++++++++++++++++
 wrapper.h              |  9 ++++++++
 write-or-die.c         |  8 +++++++
 write-or-die.h         |  1 +
 15 files changed, 217 insertions(+), 41 deletions(-)

Range-diff versus v1:

 1:  368a984880 =  1:  81c00e3b52 upload-pack: fix debug statement when flushing packfile data
 -:  ---------- >  2:  01c86a9573 upload-pack: adapt keepalives based on buffering
 2:  f014e8005a !  3:  16bc5661d4 upload-pack: reduce lock contention when writing packfile data
    @@ Commit message
         write(3p) syscalls from 130,000 to 100,000. So overall this doesn't seem
         worth it.
     
    +    Note that the issue could also be fixed by adapting the write buffer
    +    that we use in the downstream git-pack-objects(1) command, and such a
    +    change would have roughly the same result. But the command that
    +    generates the packfile data may not always be git-pack-objects(1) as it
    +    can be changed via "uploadpack.packObjectsHook", so such a fix would
    +    only help in _some_ cases. Regardless of that, we'll also adapt the
    +    write buffer size of git-pack-objects(1) in a subsequent commit.
    +
         Helped-by: Matt Smiley <msmiley@gitlab.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ upload-pack.c: static int relay_pack_data(int pack_objects_out, struct output_st
     +	 * Make sure that we buffer some data before sending it to the client.
     +	 * This significantly reduces the number of write(3p) syscalls.
     +	 */
    -+	if (readsz && os->used < (LARGE_PACKET_DATA_MAX * 2 / 3))
    ++	if (readsz && os->used < (sizeof(os->buffer) * 2 / 3))
     +		return readsz;
     +
      	if (os->used > 1) {
 -:  ---------- >  4:  f42a8a0558 git-compat-util: introduce `cast_size_t_to_ssize_t()`
 -:  ---------- >  5:  830c72f588 compat/posix: introduce writev(3p) wrapper
 -:  ---------- >  6:  733ef129f1 wrapper: introduce writev(3p) wrappers
 -:  ---------- >  7:  18f7429e14 sideband: use writev(3p) to send pktlines
 -:  ---------- >  8:  8eb2aee74d csum-file: introduce `hashfd_ext()`
 -:  ---------- >  9:  a634506b81 csum-file: drop `hashfd_throughput()`
 -:  ---------- > 10:  ca6d52b012 builtin/pack-objects: reduce lock contention when writing packfile data

---
base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
change-id: 20260227-pks-upload-pack-write-contention-435ce01f5fe9

