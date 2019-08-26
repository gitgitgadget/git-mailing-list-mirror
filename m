Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021CC1F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfHZBoB (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58258 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbfHZBoB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 50AF26047B;
        Mon, 26 Aug 2019 01:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783834;
        bh=nozcoFZPOBVj5hZ8wEvY26h0BJK8m642l/8noqd+h8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UD8Vmv6NcrN+UqyBSf2HZbx2E+miyZ/p5lEr3JT6OKPfOPekJ6FgW+2dCrfBPpGTU
         LQKexrmBN3R4dN/LuwVmBvMVKv98qiZVACJqpQ9aGmoEx2UiYqBe6AKtyObpFB3cr+
         RZexw4AavBQzqEXMXxd+8uerA3MjO32oSS24dY/tCge+qWLAnTNG9ZiN/tMzVckG8b
         0CegaOAMfO2hUvl9FLP8MyyaMK7ROP/z5f3b2BVY0xU38rjD77D6i2HNaFikZtjl9f
         tTDRWLXTDWpMp+gr0sGheDccBvgf103G52K35P5cddkVM3IqJ+/0O9+siCr8Q0Q3Jh
         fVlTB3MtyQ0Fj0POcQXLvU2GDMf/cOMYrJqvD6wknxzfPYayvC8ORRWvRkCdMFt2en
         HbNqFzUPa0+5Z/bxCsv5iGAwlHnPov59zsgDNXl8+jxpyyCP0hSomgjUnJZopu+Hpj
         LYnotvYvMy48h1Um7C9NzOb9dx3b7e1PdcQr4UROrq2bZQR0gPl
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 00/14] Hash-independent tests, part 5
Date:   Mon, 26 Aug 2019 01:43:30 +0000
Message-Id: <20190826014344.16008-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190818191646.868106-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the fifth series of test fixes for SHA-256 compatibility.  It
consists of 15 patches fixing various tests from t3201 through t4009 and
has only test fixes: no test helper changes are included.

Changes from v1:
* Add sanity-checking to the sed invocation.
* Remove whitespace between redirection operator and file name.
* Change "Refactor out" to "Factor out".

brian m. carlson (14):
  t3201: abstract away SHA-1-specific constants
  t3206: abstract away hash size constants
  t3301: abstract away SHA-1-specific constants
  t3305: make hash size independent
  t3306: abstract away SHA-1-specific constants
  t3404: abstract away SHA-1-specific constants
  t3430: avoid hard-coded object IDs
  t3506: make hash independent
  t3600: make hash size independent
  t3800: make hash-size independent
  t3903: abstract away SHA-1-specific constants
  t4000: make hash size independent
  t4002: make hash independent
  t4009: make hash size independent

 t/t3201-branch-contains.sh    |   8 +-
 t/t3206-range-diff.sh         | 227 +++++++++++++++------
 t/t3301-notes.sh              | 140 ++++++++-----
 t/t3305-notes-fanout.sh       |  22 +-
 t/t3306-notes-prune.sh        |  45 ++---
 t/t3404-rebase-interactive.sh |  22 +-
 t/t3430-rebase-merges.sh      |  23 ++-
 t/t3506-cherry-pick-ff.sh     |   8 +-
 t/t3600-rm.sh                 |   4 +-
 t/t3800-mktag.sh              |  49 ++---
 t/t3903-stash.sh              |  32 ++-
 t/t4000-diff-format.sh        |   2 +-
 t/t4002-diff-basic.sh         | 367 ++++++++++++++++++++++++----------
 t/t4009-diff-rename-4.sh      |  19 +-
 14 files changed, 640 insertions(+), 328 deletions(-)

Range-diff against v1:
1:  bfc39503dc ! 1:  1a0bda61ca t3903: abstract away SHA-1-specific constants
    @@ t/t3903-stash.sh: test_description='Test git stash'
     +		sed -e 's/^index 0000000\.\.[0-9a-f]*/index 0000000..1234567/' \
     +		-e 's/^index [0-9a-f]*\.\.[0-9a-f]*/index 1234567..89abcde/' \
     +		-e 's/^index [0-9a-f]*,[0-9a-f]*\.\.[0-9a-f]*/index 1234567,7654321..89abcde/' \
    -+		"$i" > "$i.compare"
    ++		"$i" >"$i.compare" || return 1
     +	done &&
     +	test_cmp "$1.compare" "$2.compare" &&
     +	rm -f "$1.compare" "$2.compare"
2:  2da09f10f4 = 2:  64b2fc645b t4000: make hash size independent
3:  239d6de517 ! 3:  a8f0255ea0 t4002: make hash independent
    @@ Metadata
      ## Commit message ##
         t4002: make hash independent
     
    -    Refactor out the hard-coded object IDs and use test_oid to provide
    -    values for both SHA-1 and SHA-256.
    +    Factor out the hard-coded object IDs and use test_oid to provide values
    +    for both SHA-1 and SHA-256.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
4:  7cb314ec8a = 4:  837d185fa6 t4009: make hash size independent
