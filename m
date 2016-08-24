Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BDE21F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 12:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbcHXMYh (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 08:24:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:54971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754213AbcHXMX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 08:23:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lev1D-1an0SS3t8B-00qmH4; Wed, 24 Aug 2016 14:23:32
 +0200
Date:   Wed, 24 Aug 2016 14:23:30 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 0/4] cat-file: optionally convert to worktree version
In-Reply-To: <cover.1471524357.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1472041389.git.johannes.schindelin@gmx.de>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:28cA6XvyQvI59R0XaJISGEK/GsZ76Z+3J61+0zzNhqxDnj2Cgkc
 e/IR+ZN4zjR04Mc71XGhn3qjcuX5UlvuUeNVFHQMEfmC54T1GWapmzWHzujouaLevWeICeP
 x0WtqabjIJzpyXYBXLwaxI4hytPLJEKCMThCu0yVtebbBfePK/ZTTBmk4KBZjEJ7DT0PiYZ
 mLxBV7Fk4f7jzcxEAO1GQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WlBEQeGjYcs=:EmjT9BEniLRRNmnKdjSwvZ
 tfNSc+a+26rlGK/vIGYgksOreQu5JpXyPFii8lkJ8b65vjUJo9oY8hOVTzwTknQweAZtVbDx5
 xFA0fB3DZUM4Q8K37H1WpZD2Yw4VrlQC7ZrdtUxn6qAaYe5AwKrx88O51D9OOLLE9olNOUFhj
 pQ2KfcC1UouLYlfrUCxZWRkSGn5l1JEf39W4fT5D72cgrjymwNrMmSi49sQB7j0q41G/w1rSK
 pwY/YDUK5dxUxSFiD23zZAVdtP8eBjZa+2buXU74G6N/ynDUago9g6Oiqrc/3Z7G1bRAnTQdg
 h8/OYi2CDBT8MpNXbIOrwLYgddIu5DTHdZHKVF1kkx22GEtHHxUa2c6XdPiydvfzmkinoQBUg
 K8aLuzNepcr26ixZl8ZI5+6d8Jc9UXH1ZNy3vq9p72yQbz+CS5IkaD5WPcjhkpbXwUPnjZK7x
 irhBKSMkf6Uk6knxu5AzytNTh4NdPBh0deEPrdA4nUpQzDdtBUSLLzbaevsTjpmJEWryPF3kf
 o/nt9N9vVNe97RYRW41LitxbzIwyOW3VFGETFx7Nkf9wlyvFmmh9iNsxAa0f3RB0/OTAJDFq1
 5bwtMFVbmyrPs4VlrS2yezI7K3F0YPmS8jyDPT6PXXivaLdPQocEtjE9UGHoyShzF6pEISXga
 0wvaf2H+Yssxu0EPETnWotw1new9XQyc+cdoD4B06t4oupZXtsnXm5jrkj0lHrSzdYqrrJ7vz
 t0vnemgEz+U5fQeAOUNIV85NWyUSA5iUlFaQ2i75I6mJ++XDjU9eOG1EuYzVT6T6Vckcec2yT
 JSzU1jR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When third-party tools need to access to contents of blobs in the
database, they might be more interested in the worktree version than in
the "clean" version of said contents.

This branch introduces the --filters option to make that happen, the
--use-path option to provide the path separately if the blob name rather
than the tree name is availale, and offers batch support in which case
it expects the object names and the path on its input lines, separated
by white space.

The new --filters option is an obvious sibling of --textconv, and shares
the peculiar feature that the drivers (and end-of-line convention) are
determined from the current worktree, not from the attributes stored in
the revision that may have been part of the object name.

As --textconv is so similar to --filters, it was taught to understand
the --use-path option and it was made compatible with batch mode, too.

I briefly considered teaching the batch mode to extract the path from
object names if they are specified as <tree-ish>:<path>. The changes
would be quite intrusive, though, and uglify the code substanitially. So
I decided against that.

Changes vs v2:

- two commit messages were touched up

- --use-path=<path> was renamed to --path=<path>

- a test was added to verify that --path without --textconv/--filters
  errors out with helpful advice


Johannes Schindelin (4):
  cat-file: fix a grammo in the man page
  cat-file: introduce the --filters option
  cat-file --textconv/--filters: allow specifying the path separately
  cat-file: support --textconv/--filters in batch mode

 Documentation/git-cat-file.txt |  40 +++++++++++----
 builtin/cat-file.c             | 110 ++++++++++++++++++++++++++++++++++++++---
 t/t8010-cat-file-filters.sh    |  64 ++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 18 deletions(-)
 create mode 100755 t/t8010-cat-file-filters.sh

Published-As: https://github.com/dscho/git/releases/tag/cat-file-filters-v2
Fetch-It-Via: git fetch https://github.com/dscho/git cat-file-filters-v2

Interdiff vs v1:

 diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
 index 1f4d954..204541c 100644
 --- a/Documentation/git-cat-file.txt
 +++ b/Documentation/git-cat-file.txt
 @@ -9,7 +9,7 @@ git-cat-file - Provide content or type and size information for repository objec
  SYNOPSIS
  --------
  [verse]
 -'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) [--use-path=<path>] <object>
 +'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) [--path=<path>] <object>
  'git cat-file' (--batch | --batch-check) [ --textconv | --filters ] [--follow-symlinks]
  
  DESCRIPTION
 @@ -63,12 +63,12 @@ OPTIONS
  	<path>.
  
  --filters::
 -	Show the content as transformed by the filters configured in
 +	Show the content as converted by the filters configured in
  	the current working tree for the given <path> (i.e. smudge filters,
  	end-of-line conversion, etc). In this case, <object> has to be of
  	the form <tree-ish>:<path>, or :<path>.
  
 ---use-path=<path>::
 +--path=<path>::
  	For use with --textconv or --filters, to allow specifying an object
  	name and a path separately, e.g. when it is difficult to figure out
  	the revision from which the blob came.
 diff --git a/builtin/cat-file.c b/builtin/cat-file.c
 index 5f91cf4..f8a3a08 100644
 --- a/builtin/cat-file.c
 +++ b/builtin/cat-file.c
 @@ -61,6 +61,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
  	struct object_info oi = {NULL};
  	struct strbuf sb = STRBUF_INIT;
  	unsigned flags = LOOKUP_REPLACE_OBJECT;
 +	const char *path = force_path;
  
  	if (unknown_type)
  		flags |= LOOKUP_UNKNOWN_OBJECT;
 @@ -68,6 +69,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
  	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
  		die("Not a valid object name %s", obj_name);
  
 +	if (!path)
 +		path = obj_context.path;
 +	else if (obj_context.mode == S_IFINVALID)
 +		obj_context.mode = 0100644;
 +
  	buf = NULL;
  	switch (opt) {
  	case 't':
 @@ -92,23 +98,21 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
  		return !has_sha1_file(sha1);
  
  	case 'w':
 -		if (!force_path && !obj_context.path[0])
 +		if (!path[0])
  			die("git cat-file --filters %s: <object> must be "
  			    "<sha1:path>", obj_name);
  
 -		if (filter_object(force_path ? force_path : obj_context.path,
 -				  force_path ? 0100644 : obj_context.mode,
 +		if (filter_object(path, obj_context.mode,
  				  sha1, &buf, &size))
  			return -1;
  		break;
  
  	case 'c':
 -		if (!force_path && !obj_context.path[0])
 +		if (!path[0])
  			die("git cat-file --textconv %s: <object> must be <sha1:path>",
  			    obj_name);
  
 -		if (textconv_object(force_path ? force_path : obj_context.path,
 -				    force_path ? 0100644 : obj_context.mode,
 +		if (textconv_object(path, obj_context.mode,
  				    sha1, 1, &buf, &size))
  			break;
  
 @@ -510,7 +514,7 @@ static int batch_objects(struct batch_options *opt)
  }
  
  static const char * const cat_file_usage[] = {
 -	N_("git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|-p|<type>|--textconv|--filters) [--use-path=<path>] <object>"),
 +	N_("git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|-p|<type>|--textconv|--filters) [--path=<path>] <object>"),
  	N_("git cat-file (--batch | --batch-check) [--follow-symlinks] [--textconv|--filters]"),
  	NULL
  };
 @@ -558,7 +562,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
  			    N_("for blob objects, run textconv on object's content"), 'c'),
  		OPT_CMDMODE(0, "filters", &opt,
  			    N_("for blob objects, run filters on object's content"), 'w'),
 -		OPT_STRING(0, "use-path", &force_path, N_("blob"),
 +		OPT_STRING(0, "path", &force_path, N_("blob"),
  			   N_("use a specific path for --textconv/--filters")),
  		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
  			  N_("allow -s and -t to work with broken/corrupt objects")),
 @@ -609,12 +613,12 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
  	}
  
  	if (force_path && opt != 'c' && opt != 'w') {
 -		error("--use-path=<path> needs --textconv or --filters");
 +		error("--path=<path> needs --textconv or --filters");
  		usage_with_options(cat_file_usage, options);
  	}
  
  	if (force_path && batch.enabled) {
 -		error("--use-path=<path> incompatible with --batch");
 +		error("--path=<path> incompatible with --batch");
  		usage_with_options(cat_file_usage, options);
  	}
  
 diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
 index 89ae868..acdfa09 100755
 --- a/t/t8010-cat-file-filters.sh
 +++ b/t/t8010-cat-file-filters.sh
 @@ -31,19 +31,26 @@ test_expect_success 'cat-file --filters converts to worktree version' '
  	has_cr actual
  '
  
 -test_expect_success 'cat-file --filters --use-path=<path> works' '
 +test_expect_success 'cat-file --filters --path=<path> works' '
  	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
 -	git cat-file --filters --use-path=world.txt $sha1 >actual &&
 +	git cat-file --filters --path=world.txt $sha1 >actual &&
  	has_cr actual
  '
  
 -test_expect_success 'cat-file --textconv --use-path=<path> works' '
 +test_expect_success 'cat-file --textconv --path=<path> works' '
  	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
  	test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&
 -	git cat-file --textconv --use-path=hello.txt $sha1 >rot13 &&
 +	git cat-file --textconv --path=hello.txt $sha1 >rot13 &&
  	test uryyb = "$(cat rot13 | remove_cr)"
  '
  
 +test_expect_success '----path=<path> complains without --textconv/--filters' '
 +	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
 +	test_must_fail git cat-file --path=hello.txt blob $sha1 >actual 2>err &&
 +	test ! -s actual &&
 +	grep "path.*needs.*filters" err
 +'
 +
  test_expect_success 'cat-file --textconv --batch works' '
  	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
  	test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&

-- 
2.10.0.rc1.99.gcd66998

base-commit: 2632c897f74b1cc9b5533f467da459b9ec725538
