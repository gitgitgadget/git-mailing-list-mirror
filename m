Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50C3C1966
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941097; cv=none; b=A3PF59qZkgVmH7yVAg2n71hgOha8WE+0oA0nwClfAnd65u+C6CjwWs0khxhElHBaz2xE75cjA51MVzg+qqZp+tWRWEcqa9S4d4094YdAv/8CnXU+i8fJLdg4Uqcq8HryKA8gSv13FDM3KBHQfsa9S+m8eRhI8t8yr2k3qoe+PMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941097; c=relaxed/simple;
	bh=M7OmZicHR7QjiGdIAWqq+lYCeGVvHcg8eclWInQa0Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ol78d65igphhckKbjPPEc/+z/GNpy7Tz0AlnZqhoD3aVVbC5QjJprSZSNJJm4+rxBWsYLbeQtF/CMn24rstIy852SCiui1ooAETpml9lMdaI3JwWRL9l3jdoM/haNgLZvv3Cy/AjwkDfC53IOZJOYMeazSnjt/rfsCnjmWnb0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FukUzRek; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FukUzRek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1782941093;
	bh=M7OmZicHR7QjiGdIAWqq+lYCeGVvHcg8eclWInQa0Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=FukUzReklw32VsU51l5zAig4El82XxL12NsrTk0C2mKGSHi/T0HfMfgdK/7kVj8+s
	 KoZ+m2Xx/U4R0YnWwVbiUATKHtDvuo05SFVhCfT7d62tWjgxKyRFAFl37LzR6CCY9i
	 Pq8uy437roZcphPEzalqxWitMi11jar2h1Pg05NKsCL5yhLDgwACD8iSCmBPPeODmw
	 BrNA669aecEoa75QGVqphkWE9djlmqd5JL9udOjeaEbrtEACoh1swLuebYT4RApm0N
	 dg965yTI4i3jNiXyvg/aThf2/UPV1rq1i5p3WyRwSaMA4uoLgbrRdvWJKGQlVz21dE
	 XMOXJsrSkDLoWBq7ySOu3kn0Yfnr9gF8QV8H715n7fApPAuDRWhE3VU0YXayY7WpWQ
	 E+ahsoZB5ySNL/5XM+gz49WnHqs1vskLwNI2oObxnrRmGjBBhV0u4P4hh1Gus1VV1Z
	 YvxqF5+UMKSE1qjV9CT+WyHUU+3V3zgqdEtCZaERvNcQOqUeHDC
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:cd97:af94:901e:255d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0701220074;
	Wed,  1 Jul 2026 21:24:53 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 0/4] rev-parse: exit 0 on --help
Date: Wed,  1 Jul 2026 21:24:38 +0000
Message-ID: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The standard philosophy for Unix software when a help option (such as
--help) is specified is that the software should exit 0, printing the
help output to standard output, since the standard output is for
user-requested output and the program performed the requested task
successfully.  If the user specifies an incorrect option, then the help
output should be printed to standard error (since the user has made a
mistake) and it should exit unsuccessfully.

git rev-parse --parseopt properly directs the output in both of these
cases, but it currently exits 129 when it receives a --help or -h option
on the command line, which causes its invoking script to do the same.
This is not in line with the usual behavior and it causes scripts using
this command to exit unsuccessfully on --help as well.

This series introduces some changes to distinguish the --help and -h
options from other cases in which we print help output and adjusts the
exit code to 0 from those two options.  We continue to exit 129 when the
options are invalid, which is useful information to have for callers.
We also make the relevant changes such that `git rev-parse --parseopt`
does the same thing as long as it is invoked in the way specified in the
manual page (which a quick GitHub search shows almost everyone does).

One of the patches is rather long because we have many cases in which
we've hard-coded exit code 129 into our tests.  However, the changes
there should not be complex, only somewhat tedious to review.

brian m. carlson (4):
  t1517: skip svn tests if svn is not installed
  parse-options: add a separate case for help output on error
  rev-parse: have --parseopt callers exit 0 on --help
  parse-options: exit 0 on -h

 builtin/blame.c                    |  2 ++
 builtin/shortlog.c                 |  2 ++
 builtin/update-index.c             |  2 ++
 contrib/subtree/t/t7900-subtree.sh |  2 +-
 parse-options.c                    | 20 ++++++++++----
 parse-options.h                    |  3 ++-
 t/for-each-ref-tests.sh            |  2 +-
 t/t0012-help.sh                    |  2 +-
 t/t0040-parse-options.sh           |  2 +-
 t/t0450-txt-doc-vs-help.sh         |  2 +-
 t/t0610-reftable-basics.sh         |  4 +--
 t/t1403-show-ref.sh                |  2 +-
 t/t1410-reflog.sh                  |  4 +--
 t/t1418-reflog-exists.sh           |  2 +-
 t/t1502-rev-parse-parseopt.sh      | 23 +++++++++-------
 t/t1502/optionspec-neg.help        |  1 +
 t/t1502/optionspec.help            |  1 +
 t/t1517-outside-repo.sh            | 43 +++++++++++++++++++++---------
 t/t1800-hook.sh                    |  4 +--
 t/t1900-repo-info.sh               |  2 +-
 t/t1901-repo-structure.sh          |  2 +-
 t/t2006-checkout-index-basic.sh    |  6 ++---
 t/t2107-update-index-basic.sh      |  2 +-
 t/t3004-ls-files-basic.sh          |  6 ++---
 t/t3200-branch.sh                  |  2 +-
 t/t3903-stash.sh                   |  4 +--
 t/t4200-rerere.sh                  |  2 +-
 t/t5200-update-server-info.sh      |  2 +-
 t/t5304-prune.sh                   |  2 +-
 t/t5400-send-pack.sh               |  4 +--
 t/t5512-ls-remote.sh               |  2 +-
 t/t6300-for-each-ref.sh            |  4 +--
 t/t6500-gc.sh                      |  2 +-
 t/t7030-verify-tag.sh              |  4 +--
 t/t7508-status.sh                  |  4 +--
 t/t7510-signed-commit.sh           |  4 +--
 t/t7600-merge.sh                   |  2 +-
 t/t7800-difftool.sh                |  3 +--
 t/t7900-maintenance.sh             |  2 +-
 usage.c                            |  2 +-
 40 files changed, 113 insertions(+), 73 deletions(-)

