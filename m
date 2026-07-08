Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825817BED0
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469770; cv=none; b=Vl8fuQiKlmDDQi5yt8BQSwKWlQQW80HdLFcVvbcUUV6T7tWpJ9bZgMqj++/lAhYfyZ1TSAnGttiTXEFg/H670sarxAVOc74vRSfF0t/MVFhJDtZPzYd0zcS5kFlxeZ6gkoFz8ueqAKnghkhriQ+R8qdzNpwc/Pdspm/4nL8BN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469770; c=relaxed/simple;
	bh=ZZJf69g4chm+Ci/xWaU/6FUcEveE5+TPlIKGExSBp+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRzWA1FM3RxGp4Wn3N/9lbmz10l0hHHbP7X2/hSErcQIfKXdaENSLuwJxKztYHO5a+WheEWKgAJ1fRD/KpunRdzRrBfBPFvC0BRonRyywPnXot21hlBHACQVEFxlxDif/sWw+B2WJezLSjaZb1M7R5Kmjz+tk0SXy+XoD5EjTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=i4eoZl4J; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="i4eoZl4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1783469766;
	bh=ZZJf69g4chm+Ci/xWaU/6FUcEveE5+TPlIKGExSBp+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=i4eoZl4JqpdmKgELLuaoYWUDSf2UElFNo6QGqGlS2XOZjl8m3YWKO9xgLPngrt8Sf
	 +vQKCPG+Xm4rZ4HyU4Piu+Q6TTrckCotXJfwAqrgvxEk9fSS1IsAezMwQTSYcgzBk7
	 +NHyqkgcTMXIyTevrz013IWbDTW64uOQxH/cB8yNdSeVlTr1oFrDeDyHhuGn93PBJw
	 T0pPBieGgzjP6HclaPcln0Jwlz4wTSBctu6HxLwjXn5B6YpIp6Zb+Dm4qtKqUmpgr4
	 nyEDzURXWHGAXmi34GTfpQNA4Y1KeS7gMXmwu8a2Wv0xQHtUvdsBgWSaiec+9XIbUz
	 OERaiGGP6YJ4ZfqrmJHKZAP+KXNXf6BUqbdhajDaVuXME+B5YkxaejwjrsYKgeATpP
	 Y4eTj4uMhB6p8DcY4s/wp9LddPV3uFNajTkheeoVzF+WnIBdFHRWBGd7x1/UDz73iy
	 r6fBw11CJEfx0hL+DFURUu2mWvfV+wKm/xheUKdMtmOA0yw3aI2
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9470:51ef:86dd:bc22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7E795200B0;
	Wed,  8 Jul 2026 00:16:06 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] parseopt: exit 0 on help
Date: Wed,  8 Jul 2026 00:15:53 +0000
Message-ID: <20260708001557.3581080-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
References: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
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

Changes since v2:

* Fix inverted condition in t1517.
* Stop checking for old versions of SVN Perl libraries since they are
  so old nobody is using them.
* Adjust the various cases where we choose between the error and
  non-error help output.

brian m. carlson (4):
  t1517: skip svn tests if svn is not installed
  parse-options: add a separate case for help output on error
  rev-parse: have --parseopt callers exit 0 on --help
  parse-options: exit 0 on -h

 builtin/blame.c                    |  2 ++
 builtin/shortlog.c                 |  2 ++
 builtin/update-index.c             |  2 ++
 contrib/subtree/t/t7900-subtree.sh |  2 +-
 parse-options.c                    | 22 +++++++++++-----
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
 t/t1517-outside-repo.sh            | 42 +++++++++++++++++++++---------
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
 40 files changed, 113 insertions(+), 74 deletions(-)

Range-diff against v2:
1:  558a53cc20 ! 1:  c8c7eac5f7 t1517: skip svn tests if svn is not installed
    @@ t/t1517-outside-repo.sh: test_description='check random commands outside repo'
      . ./test-lib.sh
      
     +test_lazy_prereq SVN '
    -+	test_have_prereq PERL && test -n "$NO_SVN_TESTS" && perl -w -e "
    ++	test_have_prereq PERL && test -z "$NO_SVN_TESTS" && perl -w -e "
     +		use SVN::Core;
     +		use SVN::Repos;
    -+		\$SVN::Core::VERSION gt '1.1.0' or exit(42);
     +	"
     +'
     +
2:  2b5ce2fb4c ! 2:  daa7aa2534 parse-options: add a separate case for help output on error
    @@ parse-options.c: int parse_options(int argc, const char **argv,
      	case PARSE_OPT_ERROR:
      		exit(129);
      	case PARSE_OPT_COMPLETE:
    +@@ parse-options.c: static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
    + 	parse_options_check_harder(opts);
    + 
    + 	if (!usagestr)
    +-		return PARSE_OPT_HELP;
    ++		return err ? PARSE_OPT_HELP_ERROR : PARSE_OPT_HELP;
    + 
    + 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
    + 		fprintf(outfile, "cat <<\\EOF\n");
    +@@ parse-options.c: static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
    + 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
    + 		fputs("EOF\n", outfile);
    + 
    +-	return PARSE_OPT_HELP;
    ++	return err ? PARSE_OPT_HELP_ERROR : PARSE_OPT_HELP;
    + }
    + 
    + void NORETURN usage_with_options(const char * const *usagestr,
     
      ## parse-options.h ##
     @@ parse-options.h: enum parse_opt_option_flags {
3:  e5d0167544 ! 3:  af69daffc3 rev-parse: have --parseopt callers exit 0 on --help
    @@ parse-options.c: static enum parse_opt_result usage_with_options_internal(struct
     -		fputs("EOF\n", outfile);
     +		fputs("EOF\nexit 0\n", outfile);
      
    - 	return PARSE_OPT_HELP;
    + 	return err ? PARSE_OPT_HELP_ERROR : PARSE_OPT_HELP;
      }
     
      ## t/t1502-rev-parse-parseopt.sh ##
4:  98481005ff ! 4:  f68c53015c parse-options: exit 0 on -h
    @@ parse-options.c: int parse_options(int argc, const char **argv,
      	case PARSE_OPT_HELP_ERROR:
      	case PARSE_OPT_ERROR:
      		exit(129);
    -@@ parse-options.c: static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
    - 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
    - 		fputs("EOF\nexit 0\n", outfile);
    - 
    --	return PARSE_OPT_HELP;
    -+	return err ? PARSE_OPT_HELP_ERROR : PARSE_OPT_HELP;
    - }
    - 
    - void NORETURN usage_with_options(const char * const *usagestr,
     @@ parse-options.c: void show_usage_with_options_if_asked(int ac, const char **av,
      		if (!strcmp(av[1], "-h")) {
      			usage_with_options_internal(NULL, usagestr, opts,
