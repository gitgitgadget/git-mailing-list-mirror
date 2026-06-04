Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016E36A368
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567661; cv=none; b=Sa19ENUYfu7ag+x/pMLAaqxJRyFw6XJnBXWuZinRgQ4P/Cxq8pfBhm06EE18gSPZ5bJhthDK5kK9Jna2hiF8j97JCR0tvWsoWbavylsQmBFaSgx3rKPasG7BqvXozuOzJ27m8TgfX+ZyuCSr0ZMGFaPmCQwG13kyCHwp9fqggrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567661; c=relaxed/simple;
	bh=wzxxABcaii+BskSoIdCwSvODb7AuQw8duKRP5pvJBZo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=eVsU1zZf+vtbToTFdSMVfTaU9Juach0YKcyG4sq8asZ5t2Uso31eCdwdB+pNQAz3lOeH+IIq9e2OGwdl8e3mKOBslCSl5CrzB/5mg75OO2RjhG9R9Ql1uQLksmpKnLG7UYWkJfy1kKzmZPf24vzoWKaCYHGRj+8x/oy38x+2Kdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eKq3g1CY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQ75iYx2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eKq3g1CY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQ75iYx2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4585114000F1;
	Thu,  4 Jun 2026 06:07:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 06:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780567658;
	 x=1780654058; bh=E2FghkwGF8fQvEtCa3lCNjBcAxpwxF40dGP3fYhXZ68=; b=
	eKq3g1CY6T2ZaWeJMkXQvbNa4aw9kVjoibn+GTV2Fch1ht3gZlGXLX1k86QyWU0w
	vb1+SZRkxxqdJYq+c1x/UYB22W9WllbKLEIkHhyE7/7HnRY7SMdFfqaoBPSnEskC
	HNccO6hydgKMnBQ+gu1x1/EvgEHeacD6GajtjTk9MzKFCG8WNvnOo5sPdj8egLm+
	jEEsrHwVQn51EhJ4Nx71UE5uD4fe2wDv9p15IpVUjT7//OTlEXF2Dr1j2Nw1jqm1
	Yl9vFx0BLgA+dXH0tsX5FNl1lpSgixowiHFVlOl+P/wTeyqDP3ykhS1HmPD2DjR9
	bDYn+5Z81a+ORhmdCXyopg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780567658; x=
	1780654058; bh=E2FghkwGF8fQvEtCa3lCNjBcAxpwxF40dGP3fYhXZ68=; b=h
	Q75iYx2R6QDN5ajQidE7eAbUtA/VDF6QPnaN6WThvH4gCjSIcLLmxY+6QKxktbPi
	NPgpJJz2bfiN4vVSJwZoIiKqRUly3ZqaA4RC/POX9Vxr26okpG8a+rAkT83LRO1V
	1GeJzQeSWd/3RGDTqyKIQ/myAiwzyi7Px6anMFJeH+qr+tlFVPBQalNzj8DQMWss
	SduwUunsZyrEBouuFPx8V/fIWrrM5AVw2BjkbuSc7XA8yyj8Syok2hxaPKZGKvtW
	gmf5ML2PPj8TMhn+NzgjAMsRn40xdLw5Z4qAxc6FJcY5BJyoZGG4tXTbbmwJTY8U
	x5apASkHNOCkxMjYFzQcw==
X-ME-Sender: <xms:ak4haiAyKAqJNpGQjVSRnyJndccXwgM2nOMD-TgC6c4e9ywzqreuGA>
    <xme:ak4haj8PeBeo-_zLVNoBbOzeYGduDB33uKObv7hqL_iEINyQyFdX0E4oe7fmThMzx
    jYLxS8K17BRWvC-hyFS_L_tB8r_fxAbN5C3WwjvDB_tiRqjbh1aFnw>
X-ME-Received: <xmr:ak4hai8gY8APKOkTSqCddwvbBGCGSlWmOTiy6R5zcUcOZaf-acxqFQ8Ki-F0PDdtNCNvsC04i901Vk5sk2yEZgqQfynHo76IGNwshjI80sI>
X-ME-Proxy-Cause: dmFkZTGoLBcyfEp5RxrODrY4I7pHxeYqM5pyLC5JwuYENes3m4pDVMFAUtHJAmF5akGy3j
    QMMppgNJ1kUpLIzxWR2RfSfyQuipqej73W8DbfdW0uBRQcqEEzh1q28LfhoCAtodSn+vO1
    LDTJBwQqEJGhldyngvGTn//dr4z6rQDrIU3KxjIv4dhOD8vLNlKO+Ze7ng9acCh+T88I9Y
    IyV+9O+KMvFEW68mvZaR3fnPMvZRA6oFJ6sPn0mwS0A9bZTfaxK+a4o36MKdtNTnKlFKwF
    oYTqaEODA3bXK1IAQGZngtqOKzuN4fxxvLdO0376ctrFBEO4pITzl57u6W8vaZi5VnAffW
    Q3MtX+og0vJxPm9I9cBNcjGk5impKOluSN6mKGlEpc11C7O/Mo7Mb+706JUsSuuAe6NGkV
    pDIzjnbMKS0HsMzrnLURY2jbFAytJZW6IiISBV21kUxtCV8pnP4kmrqJZKaCnwtqfqNxH+
    MAmI0DXxnfGozjaiyEyH/liOTSZMppYeZKAlDxhgZoGJL+KGHCaVm0K5nLoez4osocAAnh
    ilQUr6GUqrERuxuNZUqWMI03rNJaEju80Ortma60AkFq0RA4Jc9Vr4nR8Uai+iLNA8DHZ6
    PiuiQKXrzECfJDbKFQPuxc5Bc4/PsFzkfgLl7VZvDDYpcAsndYdrvHcGxo0w
X-ME-Proxy: <xmx:ak4haqdxPU9Zm7eEHRMRa805vzNc96PLxfCpHn8a5HYh1bDqg6MceQ>
    <xmx:ak4harHpmvMNDHJ53Zp-0Qwx7RoQmRspnu3VA-ZURPg0XJcVmDhkSg>
    <xmx:ak4haocHqN6NlCPsfDa8496OiCBk4IT0jRiBvvNuX4sebpjFMofVEQ>
    <xmx:ak4halGIlTS9G1xFyQdHeZQ6D2cqcWMI1NdjyoTvfBC20rtQL7mZ_A>
    <xmx:ak4hautTJaQ6vacDGskwI8vEer6FFe6KQ6qwiMvJKMrMfJjtxIttOAQz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 06:07:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b650667c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 10:07:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/8] t: fix broken TAP output
Date: Thu, 04 Jun 2026 12:07:30 +0200
Message-Id: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGNOIWoC/32NQQ7CIBQFr2JY+w18bImuvIdxQQtYNLYEKNE0v
 btQo3Gjy5fMm5lI0N7qQPariXidbLBDnwdfr0jbyf6swaq8CVKsaU0ZuGuAKCoUYOwdonQwjNG
 NERitlGRKcGUoyXfndSYW9fH02mFsLrqNxVeIzoY4+MfSTqxw7wz+ziQGFFTDlUTJGsbFIaMbe
 yOlkfDbwv9YMFtaw6Wp6t1WI/1Y5nl+AgJ20DUVAQAA
X-Change-ID: 20260601-pks-t7527-fix-tap-output-105da1d73df0
In-Reply-To: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
References: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

Hi,

this small patch series fixes another instance of broken TAP output that
has landed via 4d11b9c218 (Merge branch 'pt/fsmonitor-linux', 2026-05-31).

As this has happened multiple times by now I decided to have a look at
whether we can fix this class of issues a bit more holistically. So this
series also contains a change that makes prove bail out when it sees
invalid TAP output, which uncovers a small set of preexisting issues in
our test suite.

Changes in v3:
  - Fix a test gap for AlmaLinux and Debian in GitLab CI, which uncovers
    an issue flagged by Peff.
  - Fix TAP breakage in t7810.
  - Link to v2: https://patch.msgid.link/20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im

Changes in v2:
  - Fix waiting for p4d, and deduplicate the logic that does this.
  - Link to v1: https://patch.msgid.link/20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im

Test runs can be found at [1] and [2]. Note that GitHub-side tests are
failing on Windows, but that is a preexisting failure on "master".

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/585
[2]: https://github.com/git/git/pull/2320

---
Patrick Steinhardt (8):
      gitlab-ci: rearrange Linux jobs to match GitHub's order
      gitlab-ci: add missing Linux jobs
      ci: unify Linux images across GitLab and GitHub
      t7527: fix broken TAP output
      t7810: turn MB_REGEX check into a lazy prereq
      t/test-lib: silence EBUSY errors on Windows during test cleanup
      t/lib-git-p4: silence output when killing p4d and its watchdog
      t: let prove fail when parsing invalid TAP output

 .github/workflows/main.yml   |  2 +-
 .gitlab-ci.yml               | 23 +++++++++++++++--------
 ci/lib.sh                    |  2 +-
 t/lib-git-p4.sh              |  4 ++--
 t/t7527-builtin-fsmonitor.sh |  7 ++++---
 t/t7810-grep.sh              |  5 +++--
 t/test-lib.sh                | 10 ++++++++--
 7 files changed, 34 insertions(+), 19 deletions(-)

Range-diff versus v2:

-:  ---------- > 1:  5e817b102f gitlab-ci: rearrange Linux jobs to match GitHub's order
-:  ---------- > 2:  83646cc834 gitlab-ci: add missing Linux jobs
-:  ---------- > 3:  cca1567fbf ci: unify Linux images across GitLab and GitHub
1:  52abbd5280 = 4:  430bc51818 t7527: fix broken TAP output
-:  ---------- > 5:  78ef22df8d t7810: turn MB_REGEX check into a lazy prereq
2:  ea1f1eb466 = 6:  7bbaeff48c t/test-lib: silence EBUSY errors on Windows during test cleanup
3:  e97a515470 = 7:  abf2be09e6 t/lib-git-p4: silence output when killing p4d and its watchdog
4:  436d7d8cf3 = 8:  04367c34be t: let prove fail when parsing invalid TAP output

---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-pks-t7527-fix-tap-output-105da1d73df0

