Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 796011F437
	for <e@80x24.org>; Fri, 27 Jan 2017 12:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754823AbdA0M55 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 07:57:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:59464 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754781AbdA0M5S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 07:57:18 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MhMg2-1csaf00zQI-00McHm; Fri, 27
 Jan 2017 13:38:52 +0100
Date:   Fri, 27 Jan 2017 13:38:50 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 0/1] Support `git reset --stdin`
In-Reply-To: <cover.1476202100.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1485520718.git.johannes.schindelin@gmx.de>
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5gCS1OzLfS+LiZ6yPmK5LqTF2z8YEAxc4j5TBHjlUgXX2WJexIw
 vaC/j8jLdSKKyb/zYUeBfiP3BDcOkvJLaV3WzWwmlWE41QBvS+8dQ4NEqQl0RQK1GqW2x88
 QIHekwPV2+S00QGRZPXXVSTQrk+OqyrWVs+4KdGR5vk8Sp9G4MmVOrZBtgZG9/snKtzCPL+
 byVr+5lCDBisOar8t+9Lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rF8NySuKPdA=:2xJ45CfMWctTr+d1SbVhc4
 h5A7rFPeggsRa0Noro/qlMZQsTuu29vni8poBX6YQWHNz4Z5MJaOEPLEF04sHD8BPBs7peIBS
 kiNy6oMJDdyN/TERAJDTEmQKziDEQl2DBBPcc6G981EC/na8pZ1J/6UsOqxn/nsMWY9RDYvim
 bKfA1Q6TeoGZZPUofF4I/ty5jYHiROYb6TOSYfv35kKMgeu78aAwUQpRt3WU55qhvhdwyZmLr
 pjDRkG2t8t+szHyJBs4JFN6Nn9L8DwtvM6w0JYm8V+7Sc11yAPEIi/xLorU1JpSkMpIW+YHhe
 gqaFXjS53359S40xjEDGoS+W0XuRIRo+Xk3Pln7BvLfgj4/wOx92wQ+AC00XZOANxPwZ63NbV
 KFBoqVa6pu8VDV+BnxyjHQUJh0871wUj29+d6hrcdTEFYVkJcOlHreVf9pbA8E0WuvdndDrJB
 krdFV6QloMkxECZwQvK1W133dwWptueYLg+ZHcvAGQjlF1E8tutL6/dptEeXtusCnWb+Tk86h
 JRbAMghS5Z/ieyz9UgmmPiGJFubGq+2NATio/BmDrl380IZhwG2SCoX+z6zs0Gnx7LTW7WeO7
 dHc9fX++fRvUA14Z7So9EKjGhKIY3wR6/VGwsMUApzciRIAUAGOhsMbQ2JZoOc1DYhNfAA1fL
 NICNn80zi0V9zll39LuYBun7DdShpy0MPAn4u2l/D2nuHWtctQC5Rq1HRHPGLHh/lYF5+T8WM
 uBUeN4xhjlBqmGTYA1aDlrZ3o8IAyf5YHJdHUdhurrPTYYds5WIerDOH9UeRcCHLz1Hfhj/AR
 I31ANhJVcOJH2svh3jdgrSW91ZJeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This feature was missing, and made it cumbersome for third-party
tools to reset a lot of paths in one go.

Support for --stdin has been added, following builtin/checkout-index.c's
example.

Changes since v1:

- adjusted commit message to explain why we read everything before
  resetting

- fixed synopsis (`--stdin` does not work with `-- <path>...`)

- avoid handling patch_mode twice

- use PATHSPEC_LITERAL_PATH to avoid interpreting input as wildcards


Johannes Schindelin (1):
  reset: support the --stdin option

 Documentation/git-reset.txt |  9 ++++++++
 builtin/reset.c             | 54 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t7107-reset-stdin.sh      | 33 +++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100755 t/t7107-reset-stdin.sh


base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
Published-As: https://github.com/dscho/git/releases/tag/reset-stdin-v2
Fetch-It-Via: git fetch https://github.com/dscho/git reset-stdin-v2

Interdiff vs v1:

 diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
 index 533ef69f91..abb71bb805 100644
 --- a/Documentation/git-reset.txt
 +++ b/Documentation/git-reset.txt
 @@ -8,8 +8,9 @@ git-reset - Reset current HEAD to the specified state
  SYNOPSIS
  --------
  [verse]
 -'git reset' [-q] [--stdin [-z]] [<tree-ish>] [--] <paths>...
 +'git reset' [-q] [<tree-ish>] [--] <paths>...
  'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
 +'git reset' [-q] [--stdin [-z]] [<tree-ish>]
  'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
  
  DESCRIPTION
 diff --git a/builtin/reset.c b/builtin/reset.c
 index 6de3936aed..1d3075b7ee 100644
 --- a/builtin/reset.c
 +++ b/builtin/reset.c
 @@ -26,7 +26,8 @@
  
  static const char * const git_reset_usage[] = {
  	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
 -	N_("git reset [-q] [--stdin [-z]] [<tree-ish>] [--] <paths>..."),
 +	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
 +	N_("git reset [-q] [--stdin [-z]] [<tree-ish>]"),
  	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
  	NULL
  };
 @@ -317,9 +318,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
  		if (pathspec.nr)
  			die(_("--stdin is incompatible with path arguments"));
  
 -		if (patch_mode)
 -			flags |= PATHSPEC_PREFIX_ORIGIN;
 -
  		while (getline_fn(&buf, stdin) != EOF) {
  			if (!nul_term_line && buf.buf[0] == '"') {
  				strbuf_reset(&unquoted);
 @@ -336,8 +334,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
  
  		ALLOC_GROW(stdin_paths, stdin_nr + 1, stdin_alloc);
  		stdin_paths[stdin_nr++] = NULL;
 +		flags |= PATHSPEC_LITERAL_PATH;
  		parse_pathspec(&pathspec, 0, flags, prefix,
  			       (const char **)stdin_paths);
 +
  	} else if (nul_term_line)
  		die(_("-z requires --stdin"));
  

-- 
2.11.1.windows.prerelease.2.9.g3014b57

