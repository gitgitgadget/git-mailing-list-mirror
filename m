Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA931FD6A
	for <e@80x24.org>; Fri, 10 Feb 2017 15:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbdBJPlc (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 10:41:32 -0500
Received: from mout.gmx.net ([212.227.15.15]:59996 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbdBJPla (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 10:41:30 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M86jp-1cFiLF2zWj-00viXu; Fri, 10
 Feb 2017 16:33:32 +0100
Date:   Fri, 10 Feb 2017 16:33:31 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 0/2] Fix bugs in rev-parse's output when run in a
 subdirectory
In-Reply-To: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1486740772.git.johannes.schindelin@gmx.de>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yOESW4qIXJBdFD6kMS6CR/zOsMQFCta7xucMOxaWXFbgcKlVQkU
 mWJWZ0IwiL4GibZuVmG1ViXHcn7EXEbWMankLZahOBd/9aHTZFuvwt9DHiOIpUgROZSpmVd
 CrWvY3RIsRAd4qn5TprGGf6aa1gsAvOLucrwBAgD0m6/JNjk60SU7BrwKB6HruTb18/8HEk
 wSgcJDd2TDTG/2E/p4FBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bw0yZEPe+b0=:iy62z4EoYVVKTjoM6updQK
 C6TBhUVN7X60pXvTa82tnS5IAjC9/x+k71x2Vk2yRA9bOox/UGrGKgK3fZhmgBAUKJBvUSpYp
 tAs9yR/x8AHlNr2DLnIuK/AiNlUTxq8XzHK0kYRq6YPDNLV4WPUJU4UArQ69evntwP9XyOgPD
 Qxs//XsE0VfE0g2Sz5SHKjawSTD6MRMp2bGXwsqVYSSQPe0+XbqK03bINie5voTvCR2R5bJss
 mQgcuU7p9yQcCzNSnTUiPsEWd+9mthe+nQWSZiH76/8yzRtWNvw6ApkCt6QycjJgS3SSCVUDi
 9piRYOOo8ujqX6OrnST60GRaAyW2gxKfRDcNHBxQi3nyi1YpmFu5Z4Q3xOR9lWSug2qIz9p8y
 L+ZNnEF1/pXSfeTOTZYPt0Y5vwd8JWu5DieUShYDn5lekSmMxB4eUgmqJfXPryKIyWnmZ/Tvq
 ztNQfSsQS91ouL6wSv3gxHuV+H8F31uhZK84rz62mDUjKJaBK9ZLdXEmJ+Aqj7ui898towO+U
 ejiC8VuVSGG0X9HmuU5wUURVqjSVs+b1j47oGAN+/WYpZBrXyUHrsx0F6SSDQT5Q5xitJ/PX4
 V7LFUYSypDjMx7sAPvbiRa8dhcZS9OKXnYqLm1qOz4fd9uXhWllslJrJpMptsa/QWoLXElV7l
 oqCPv91oWy08WYrEseUZp5w52ORbru1WhWqx8MkTEDb9p+P6AWeY2FijfwfSHLAarucnap9sD
 psKnrclnECOe3coebfg/6c/CGO628Gd6RQSWQeMcmgOw3pBB9//VJxWmViNdhFpxqCzG/dSow
 MntOZOH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bug that bit me (hard!) and that triggered not only a long series of
curses but also my writing a patch and sending it to the list was that
`git rev-parse --git-path HEAD` would give *incorrect* output when run
in a subdirectory of a regular checkout, but *correct* output when run
in a subdirectory of an associated *worktree*.

I had tested the script in question quite a bit, but in a worktree. And
in production, it quietly did exactly the wrong thing.

Relative to v1 of the then-single patch, this changed:

- the patch now covers also --git-common-dir and --shared-index-path

- the output is now a relative path when git_dir is relative

- I plucked the tests from Mike's patch series and dropped my ad-hoc
  test from t0060.

- While at it, I fixed Mike's test that assumed that the objects/
  directory lives in .git/worktrees/<name>/objects/.


Johannes Schindelin (1):
  rev-parse: fix several options when running in a subdirectory

Michael Rappazzo (1):
  rev-parse tests: add tests executed from a subdirectory

 builtin/rev-parse.c      | 15 +++++++++++----
 t/t1500-rev-parse.sh     | 28 ++++++++++++++++++++++++++++
 t/t1700-split-index.sh   | 17 +++++++++++++++++
 t/t2027-worktree-list.sh | 10 +++++++++-
 4 files changed, 65 insertions(+), 5 deletions(-)


base-commit: 6e3a7b3398559305c7a239a42e447c21a8f39ff8
Published-As: https://github.com/dscho/git/releases/tag/git-path-in-subdir-v2
Fetch-It-Via: git fetch https://github.com/dscho/git git-path-in-subdir-v2

Interdiff vs v1:

 diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
 index f9d5762bf2b..84af2802f6f 100644
 --- a/builtin/rev-parse.c
 +++ b/builtin/rev-parse.c
 @@ -545,6 +545,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
  	unsigned int flags = 0;
  	const char *name = NULL;
  	struct object_context unused;
 +	struct strbuf buf = STRBUF_INIT;
  
  	if (argc > 1 && !strcmp("--parseopt", argv[1]))
  		return cmd_parseopt(argc - 1, argv + 1, prefix);
 @@ -597,13 +598,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
  		}
  
  		if (!strcmp(arg, "--git-path")) {
 -			const char *path;
  			if (!argv[i + 1])
  				die("--git-path requires an argument");
 -			path = git_path("%s", argv[i + 1]);
 -			if (prefix && !is_absolute_path(path))
 -				path = real_path(path);
 -			puts(path);
 +			strbuf_reset(&buf);
 +			puts(relative_path(git_path("%s", argv[i + 1]),
 +					   prefix, &buf));
  			i++;
  			continue;
  		}
 @@ -825,8 +824,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
  				continue;
  			}
  			if (!strcmp(arg, "--git-common-dir")) {
 -				const char *pfx = prefix ? prefix : "";
 -				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
 +				strbuf_reset(&buf);
 +				puts(relative_path(get_git_common_dir(),
 +						   prefix, &buf));
  				continue;
  			}
  			if (!strcmp(arg, "--is-inside-git-dir")) {
 @@ -849,7 +849,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
  					die(_("Could not read the index"));
  				if (the_index.split_index) {
  					const unsigned char *sha1 = the_index.split_index->base_sha1;
 -					puts(git_path("sharedindex.%s", sha1_to_hex(sha1)));
 +					const char *path = git_path("sharedindex.%s", sha1_to_hex(sha1));
 +					strbuf_reset(&buf);
 +					puts(relative_path(path, prefix, &buf));
  				}
  				continue;
  			}
 @@ -910,5 +912,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
  		die_no_single_rev(quiet);
  	} else
  		show_default();
 +	strbuf_release(&buf);
  	return 0;
  }
 diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
 index 790584fcc54..444b5a4df80 100755
 --- a/t/t0060-path-utils.sh
 +++ b/t/t0060-path-utils.sh
 @@ -271,8 +271,6 @@ relative_path "<null>"		"<empty>"	./
  relative_path "<null>"		"<null>"	./
  relative_path "<null>"		/foo/a/b	./
  
 -test_git_path "mkdir sub && cd sub && test_when_finished cd .. &&" \
 -	foo "$(pwd)/.git/foo"
  test_git_path A=B                info/grafts .git/info/grafts
  test_git_path GIT_GRAFT_FILE=foo info/grafts foo
  test_git_path GIT_GRAFT_FILE=foo info/////grafts foo
 diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
 index 038e24c4014..d74f09ad93e 100755
 --- a/t/t1500-rev-parse.sh
 +++ b/t/t1500-rev-parse.sh
 @@ -87,4 +87,32 @@ test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = tru
  
  test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
  
 +test_expect_success 'git-common-dir from worktree root' '
 +	echo .git >expect &&
 +	git rev-parse --git-common-dir >actual &&
 +	test_cmp expect actual
 +'
 +
 +test_expect_success 'git-common-dir inside sub-dir' '
 +	mkdir -p path/to/child &&
 +	test_when_finished "rm -rf path" &&
 +	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
 +	git -C path/to/child rev-parse --git-common-dir >actual &&
 +	test_cmp expect actual
 +'
 +
 +test_expect_success 'git-path from worktree root' '
 +	echo .git/objects >expect &&
 +	git rev-parse --git-path objects >actual &&
 +	test_cmp expect actual
 +'
 +
 +test_expect_success 'git-path inside sub-dir' '
 +	mkdir -p path/to/child &&
 +	test_when_finished "rm -rf path" &&
 +	echo "$(git -C path/to/child rev-parse --show-cdup).git/objects" >expect &&
 +	git -C path/to/child rev-parse --git-path objects >actual &&
 +	test_cmp expect actual
 +'
 +
  test_done
 diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
 index 292a0720fcc..446ff34f966 100755
 --- a/t/t1700-split-index.sh
 +++ b/t/t1700-split-index.sh
 @@ -200,4 +200,21 @@ EOF
  	test_cmp expect actual
  '
  
 +test_expect_success 'rev-parse --shared-index-path' '
 +	rm -rf .git &&
 +	test_create_repo . &&
 +	git update-index --split-index &&
 +	ls -t .git/sharedindex* | tail -n 1 >expect &&
 +	git rev-parse --shared-index-path >actual &&
 +	test_cmp expect actual &&
 +	mkdir work &&
 +	test_when_finished "rm -rf work" &&
 +	(
 +		cd work &&
 +		ls -t ../.git/sharedindex* | tail -n 1 >expect &&
 +		git rev-parse --shared-index-path >actual &&
 +		test_cmp expect actual
 +	)
 +'
 +
  test_done
 diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
 index 465eeeacd3d..848da5f3684 100755
 --- a/t/t2027-worktree-list.sh
 +++ b/t/t2027-worktree-list.sh
 @@ -14,10 +14,18 @@ test_expect_success 'rev-parse --git-common-dir on main worktree' '
  	test_cmp expected actual &&
  	mkdir sub &&
  	git -C sub rev-parse --git-common-dir >actual2 &&
 -	echo sub/.git >expected2 &&
 +	echo ../.git >expected2 &&
  	test_cmp expected2 actual2
  '
  
 +test_expect_success 'rev-parse --git-path objects linked worktree' '
 +	echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
 +	test_when_finished "rm -rf linked-tree && git worktree prune" &&
 +	git worktree add --detach linked-tree master &&
 +	git -C linked-tree rev-parse --git-path objects >actual &&
 +	test_cmp expect actual
 +'
 +
  test_expect_success '"list" all worktrees from main' '
  	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
  	test_when_finished "rm -rf here && git worktree prune" &&

-- 
2.11.1.windows.1

