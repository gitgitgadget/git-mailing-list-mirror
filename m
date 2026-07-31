Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59042427A10
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502570; cv=none; b=pUpIdv2YdVpHdKquXOJuR6kUdDsH3mtWRDssVDIcK/CeWRYdOdjQCgiIKIXXwkOGQI2mhSDehQ/diC5sQ8W+qqqxlhgQOg65kbv2dLOtnN0DWeKZLHeVoqtiK3VYRKBjwxDTR864zwnfpPX99lN+K3gE4tm1z5iOV21qFC1M+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502570; c=relaxed/simple;
	bh=CvK6hg8Uy5APj/WlbOIUr8fRMB3ho3QK3PPcDxQ5Ch8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhLA/Wug04jeZFzbTcYmLu4vzO6Wgu642/EsHR0njZ0G0Dz8/L9B6fXQSg6Jp59CvaoIWrlrn1mqLIT6Ex2e0nOcovi1wPANeIZuIyg3kmoQWyWNXQYVFtD27D9EkwX0sx8dEZEQbOh3iG5i4cLR7PyJHj5zBa7ZMZCfVmza0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uBlHRSOd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HiUXb0iH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uBlHRSOd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HiUXb0iH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FB50EC0104;
	Fri, 31 Jul 2026 08:56:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 31 Jul 2026 08:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785502567; x=
	1785588967; bh=TuZXnRQ+5dZK9V2s8PmtV6Oue9KWrVFWEcs18g706G4=; b=u
	BlHRSOdZVGlDetBBJIN4UUIlSTCgBm0K/52Z5AKWSSf+pmcleCheS5YI3GDm9zxH
	fJ/LEyYbeh2rbztQJ5u4w1HuqPLxc9jOlkpkbagLkllQ7bvYCN1/3NzC0MhpbS5/
	bLthVROMi0I/3xBw+XvQLhVPGuH3Z8QccjJYxgDNZYXk4LxJhz/BBT8lG4Pk+fIw
	Dk3PqDiPJTs2f5coGZsdMd3tH7yY7ZNBge7fBIG3yJXjWzmkExCQvGAXDhkT2C+E
	rWrOTpMqUduuSMOXdftqCt+lC2aTJ1/9+NlOBsmCfCccu6IU2ioem2j3fCIDuIgn
	i4zSSUk9w/0UTMKMGTAVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785502567; x=1785588967; bh=TuZXnRQ+5dZK9V2s8PmtV6Oue9KW
	rVFWEcs18g706G4=; b=HiUXb0iHv9Wr7xQfQJEGHiUX68iebKjnbgj+0jIa5/FW
	sEobw39J/9cQfMib1PrejvnDWve1ZphJB/cYkKaElGABg7MnxZkVEw5YWZdeZ3DN
	VinTjxLhZ9u13NZ3nfU+F+guTluXl6fqAjxNoBTPQ0m0OAkd813Vl72zmPVp/E5z
	7WA+gVg+RHiMWKBhi047+01JhYc4TnTUDvhqpRf5vyL6GaEXhx1HTrT6V9/cd7Y6
	8vhsYrc0dTKtnMj2mePI34r2zSEzO/R78fGWJnYG+0Pr+lI7lKDF4+j/frVBWmdU
	7AFy9DkiZmSfLmGfnZoqa+bPPsGnaWYHHUu5xZkW/Q==
X-ME-Sender: <xms:Z5tsao6GfkHdKTLl66uifHqpKx-1ThDSN_gwvgd32Y3GQgMX-9-1vw>
    <xme:Z5tsav59PpetSDt_jRu5NbVYZnAyvSmI-Xge-oTRqaa9mCbwHjGXLHXIljKgGNReN
    f_NYw_kdMFHDYcynPDXUZvIfYWCR4tZbd4d4qimET0VZgbdDMN10A>
X-ME-Received: <xmr:Z5tsalHPPikY5OamPXHo3_u2PxMzTKHSUu69nuL_g18vP1mdnArq_GgMg3Aq7Tgu24wCf6fmeUEhffyMVgqMRbUpKDWTZ05Qlw>
X-ME-Proxy-Cause: dmFkZTFMkCIVKemp9ObFYAYeHzMQWSWQ6kXXN4anz/jw6dSbJioQy6WW+BWqDGGC9mol+4
    qqdND1kxjGR8WYds5iwSs+iyh6Eh/x2Mr6oMvWx2Exad7P1rfAo8i23v7vgbu4AaSqUv6m
    E96nVBVGW9Lcx6GMxre067Opv7j9Bk+0zWqfwjy+9YBf+LTPeNlc2AvXC0LAE1QRTt/up7
    d/TkjFIZ9T8zqyP12+07lPSNGK1zDOw2JWSyKITZtbcwM3PWQBL45gMM4IX/ezlFwNR3z3
    FRum5d72uI7maMm8yXQ47ZWwjrAOSr5i9aUpbTwaU6dIPFKH5IveFVvxS0ZC3ZGIaqpjF4
    sM8IPrxFXm7E+k41906bkwtXR7n+RHD5tWOJWY6utxe8w3aa3BKDvP4oYIvPLVIn4VI2Ce
    1RhpzcHZBtARFVxPfj5DefxoVWys8c8gJAQgOeUyQUgb7FO4xr9nE289zinr75pfxlVe3B
    CkcKFAFzzGXuunE3AlZxweY8NH4827EfBSgGXApt8y6OUhg/p111N+ua/VdBIghv501sOB
    H3/5LCCBeimh7ekUnbm8bF9Q1fUR2sHKb0UvZmPr1EAbs5OaAk8Z7lN0natl4zNzK6qUGH
    A7ZtjavTmb+SL9+ZjGZgu+sMQnjTnaClecARQqWLIwmBpNiqNfmyKHH62R3g
X-ME-Proxy: <xmx:Z5tsaoRUh4LYZFodkAY8jgUrWt6RJCE_p4R82mRDsI2RJUWouUroIQ>
    <xmx:Z5tsausRBHVWiK9Z6p79s9Yf7osTwFiCpR2UGaCwFvFHL_dEq4dIJA>
    <xmx:Z5tsanyuEGdNO9GTejm2XNETXY5PFrLdH9Eu1rp9VUhwklsmkPza7Q>
    <xmx:Z5tsao5lwhygJc7RYziwsi7FLweRZgA6a9xWGUWiaWMPIrlu9xW5HQ>
    <xmx:Z5tsasTzDyeau9w8Ti4--GDywjP548h2aPWR_eGj_tQbwAHc1cX6UlLu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 08:56:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 0/4] git add --resolved
Date: Fri, 31 Jul 2026 05:56:01 -0700
Message-ID: <20260731125605.3638938-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-599-g5cacd2ad51
In-Reply-To: <20260728215219.753678-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When you are the maintainer of a project and make many merges day
in, day out, a lot of your time is spent resolving conflicts and
adding the results to the index.  It is not unusual to have local
changes in your working tree that are unrelated to any particular
merge [*].  In such cases, 'git add -u', which adds all changes in
the working tree to the index, does not help much.

Here is a new option for 'git add' that lets you add paths with
resolved conflicts to the index, while keeping unrelated local
changes out.

The first three patches perform preliminary refactorings.

 - [1/4] is a totally unrelated code cleanup that almost disappears
   when viewed with 'git show -w', but it was an eyesore to have so
   many lines with broken indentation while working in the vicinity.

 - [2/4] consolidates a helper function to determine whether a line
   is a conflict marker (replacing two slightly different
   definitions).

 - [3/4] introduces a helper that makes registering path removals
   from the index as easy as adding them, complete with automatic
   '--dry-run' and '--verbose' support.

The fourth patch implements the new feature.

 1/4: read-cache: reindent
 2/4: merge-ll: consolidate conflict marker scanning logic
 3/4: read-cache: add remove_file_from_index_with_flags()
 4/4: add: introduce '--resolved' option


The only change since v2 is to fix the test under BREAKING_CHANGES,
where the tests are run with a future default initial branch name of
'main'.  Instead of assuming that the initial branch is named
'master' when returning, we instruct 'checkout' to return to the
previous branch, i.e., '@{-1}'.


[Footnote]

 * This is not limited to my own workflow. An earlier message on
   this topic worth mentioning is:

   https://lore.kernel.org/git/CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com/

 Documentation/git-add.adoc |  10 +++-
 builtin/add.c              |  92 ++++++++++++++++++++++++++++---
 diff.c                     |  25 +--------
 merge-ll.c                 |  56 +++++++++++++++++++
 merge-ll.h                 |   2 +
 read-cache-ll.h            |   3 ++
 read-cache.c               |  89 +++++++++++++++++-------------
 rerere.c                   |  38 +++----------
 t/meson.build              |   1 +
 t/t2207-add-resolved.sh    | 108 +++++++++++++++++++++++++++++++++++++
 10 files changed, 323 insertions(+), 101 deletions(-)
 create mode 100755 t/t2207-add-resolved.sh

Range-diff against v2:
1:  b0643ed516 = 1:  414219a89a read-cache: reindent
2:  4533fa4da1 = 2:  f64ad26d1f merge-ll: consolidate conflict marker scanning logic
3:  dbf70c2d3a = 3:  1431d0bfdb read-cache: add remove_file_from_index_with_flags()
4:  033a3d2526 ! 4:  42fb33200a add: introduce '--resolved' option
    @@ t/t2207-add-resolved.sh (new)
     +	echo "theirs 3" >file3.txt &&
     +	git commit -a -m theirs &&
     +
    -+	git checkout master
    ++	git checkout @{-1}
     +'
     +
     +test_expect_success 'git add --resolved refuses files with conflict markers' '

-- 
2.55.0-599-g5cacd2ad51

