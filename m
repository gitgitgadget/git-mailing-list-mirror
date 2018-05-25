Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA7C1F42D
	for <e@80x24.org>; Fri, 25 May 2018 12:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966528AbeEYM3A (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 08:29:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39692 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966497AbeEYM27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 08:28:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id f8-v6so14165623wmc.4
        for <git@vger.kernel.org>; Fri, 25 May 2018 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=IZP1pnb0mHgBb1B+V1y7LcV433kyqbDUDUzviIZhviI=;
        b=RzpfLbuNQTcx6SAmF243wdfJbAapeKULWVDPV050n2ls+DkmeEVjxVNON+vt1nVVDL
         XB1BvP/imX4aXyxrI2dlh7HxOYksPDoxeZ/EWCokY7fZAaGXkbVQrJRX3PKnVczY/uV2
         GKA61JQIGAqbwVsyfscxQlyJARj373ThFX3h1TxotgAnr7iJ62PjrN2FDfLTSXeekRAh
         AzrqsT4d5GtKsSbK2YttzQpv6FiC+NQ2dNxuPUSWWFj5id3Vrg4UcH/ZNg2m/hu8CyOv
         e4Yrt/t7H2GzacXwcXBinoTYePgtctY1rAqdpDYkU/mo6VWkCYIV3rp4wTN7LPkw9SEG
         NlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=IZP1pnb0mHgBb1B+V1y7LcV433kyqbDUDUzviIZhviI=;
        b=cbTdb0bO/yfTrewLcnyi3Pzsbsnz9r9gBAuaopX8ecaLNMd48QGInKJmqBQcpOqViv
         vZVZqoEvvKBtGkRLaE99y+meEgKo8fbVzHeHKbCbXZK4Jx5zEdXyhPgbvjw64j0IQgP1
         qoGebyxrWwzACHI48WEYj6mAGmg0A/VvzMr5jlyt3zTFECUDLLxhU//abO7BpicDqAOG
         WzT7ftNY+a9bMfMlT6ywFOF+DBKJhM9zcZqt1CFTHYHlSbvkn3tg5xhs9hcdZ9r26+hd
         QcrR5qNfHFV83/AoBJgHO0bmX02+zU3oroGYz056gYP2Nq2v/F/h5/tZ7CaTbdWw4c/9
         rMsg==
X-Gm-Message-State: ALKqPwfdYxzJT1qPaU1PHjrC1w39swqlSXbRMkeKLtSOTqLkMhIlSX6r
        HoTP8uMSM/IQm5Qjj4xbcfw=
X-Google-Smtp-Source: AB8JxZqzZ1hMGJb2/RXQEmU0JTwgUyeNfBSeJfp9KyhroHZxf8PnQfp+btNOwGr919MW5zsdNFsAIA==
X-Received: by 2002:a50:c181:: with SMTP id m1-v6mr2712714edf.207.1527251338091;
        Fri, 25 May 2018 05:28:58 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id f11-v6sm13747553edf.68.2018.05.25.05.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 05:28:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>,
        Stefan Beller <sbeller@google.com>
Subject: sb/submodule-move-nested breaks t7411 under GIT_FSMONITOR_TEST
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 25 May 2018 14:28:56 +0200
Message-ID: <87lgc77wc7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 17 2018, Junio C Hamano wrote:

> * sb/submodule-move-nested (2018-03-29) 6 commits
>   (merged to 'next' on 2018-04-25 at 86b177433a)
>  + submodule: fixup nested submodules after moving the submodule
>  + submodule-config: remove submodule_from_cache
>  + submodule-config: add repository argument to submodule_from_{name, path}
>  + submodule-config: allow submodule_free to handle arbitrary repositories
>  + grep: remove "repo" arg from non-supporting funcs
>  + submodule.h: drop declaration of connect_work_tree_and_git_dir
>
>  Moving a submodule that itself has submodule in it with "git mv"
>  forgot to make necessary adjustment to the nested sub-submodules;
>  now the codepath learned to recurse into the submodules.

I didn't spot this earlier because I don't test this a lot, but I've
bisected the following breakage down to da62f786d2 ("submodule: fixup
nested submodules after moving the submodule", 2018-03-28) (and manually
confirmed by reverting). On Linux both Debian & CentOS I get tests 3 and
4 failing with:

     GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all ./t7411-submodule-config.sh

-v -x output follows:

expecting success: 
	mkdir submodule &&
	(cd submodule &&
		git init &&
		echo a >a &&
		git add . &&
		git commit -ma
	) &&
	mkdir super &&
	(cd super &&
		git init &&
		git submodule add ../submodule &&
		git submodule add ../submodule a &&
		git commit -m "add as submodule and as a" &&
		git mv a b &&
		git commit -m "move a to b"
	)

+ mkdir submodule
+ cd submodule
+ git init
Initialized empty Git repository in /home/avar/g/git/t/trash directory.t7411-submodule-config/submodule/.git/
+ echo a
+ git add .
+ git commit -ma
[master (root-commit) 27e9f0e] a
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 a
+ mkdir super
+ cd super
+ git init
Initialized empty Git repository in /home/avar/g/git/t/trash directory.t7411-submodule-config/super/.git/
+ git submodule add ../submodule
Cloning into '/home/avar/g/git/t/trash directory.t7411-submodule-config/super/submodule'...
done.
+ git submodule add ../submodule a
Cloning into '/home/avar/g/git/t/trash directory.t7411-submodule-config/super/a'...
done.
+ git commit -m add as submodule and as a
[master (root-commit) 5a1dac1] add as submodule and as a
 Author: A U Thor <author@example.com>
 3 files changed, 8 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 a
 create mode 160000 submodule
+ git mv a b
+ git commit -m move a to b
[master ab1e9c7] move a to b
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename a => b (100%)
ok 1 - submodule config cache setup

expecting success: 
	test_when_finished "rm -rf repo" &&
	test_create_repo repo &&
	cat >repo/.gitmodules <<-\EOF &&
	[submodule "s"]
		path
		ignore
	EOF
	(
		cd repo &&
		test_must_fail test-submodule-config "" s 2>actual &&
		test_i18ngrep "bad config" actual
	)

+ test_when_finished rm -rf repo
+ test 0 = 0
+ test_cleanup={ rm -rf repo
		} && (exit "$eval_ret"); eval_ret=$?; :
+ test_create_repo repo
+ test 1 = 1
+ repo=repo
+ mkdir -p repo
+ cd repo
+ /home/avar/g/git/t/../git-init --template=/home/avar/g/git/t/../templates/blt/
Initialized empty Git repository in /home/avar/g/git/t/trash directory.t7411-submodule-config/repo/.git/
+ mv .git/hooks .git/hooks-disabled
+ cat
+ cd repo
+ test_must_fail test-submodule-config  s
+ test_i18ngrep bad config actual
+ test -n 
+ test x! = xbad config
+ grep bad config actual
fatal: bad config line 2 in file /home/avar/g/git/t/trash directory.t7411-submodule-config/repo/.gitmodules
+ rm -rf repo
+ exit 0
+ eval_ret=0
+ :
ok 2 - configuration parsing with error

expecting success: 
	(cd super &&
		test-submodule-config \
			HEAD^ a \
			HEAD b \
			HEAD^ submodule \
			HEAD submodule \
				>actual &&
		test_cmp expect actual
	)

+ cd super
+ test-submodule-config HEAD^ a HEAD b HEAD^ submodule HEAD submodule
warning: ab1e9c76c1e6a15df51b20e75552ec5ad00708ac:.gitmodules, multiple configurations found for 'submodule.submodule.path'. Skipping second one!
warning: ab1e9c76c1e6a15df51b20e75552ec5ad00708ac:.gitmodules, multiple configurations found for 'submodule.submodule.url'. Skipping second one!
warning: ab1e9c76c1e6a15df51b20e75552ec5ad00708ac:.gitmodules, multiple configurations found for 'submodule.a.path'. Skipping second one!
warning: ab1e9c76c1e6a15df51b20e75552ec5ad00708ac:.gitmodules, multiple configurations found for 'submodule.a.url'. Skipping second one!
Submodule not found.
Usage: /home/avar/g/git/t/helper/test-submodule-config [<commit> <submodulepath>] ...
error: last command exited with $?=1
not ok 3 - test parsing and lookup of submodule config by path
#	
#		(cd super &&
#			test-submodule-config \
#				HEAD^ a \
#				HEAD b \
#				HEAD^ submodule \
#				HEAD submodule \
#					>actual &&
#			test_cmp expect actual
#		)
#	

expecting success: 
	(cd super &&
		test-submodule-config --name \
			HEAD^ a \
			HEAD a \
			HEAD^ submodule \
			HEAD submodule \
				>actual &&
		test_cmp expect actual
	)

+ cd super
+ test-submodule-config --name HEAD^ a HEAD a HEAD^ submodule HEAD submodule
+ test_cmp expect actual
+ diff -u expect actual
--- expect	2018-05-25 12:28:30.000000000 +0000
+++ actual	2018-05-25 12:28:30.000000000 +0000
@@ -1,4 +1,4 @@
 Submodule name: 'a' for path 'a'
-Submodule name: 'a' for path 'b'
+Submodule name: 'a' for path 'a'
 Submodule name: 'submodule' for path 'submodule'
 Submodule name: 'submodule' for path 'submodule'
error: last command exited with $?=1
not ok 4 - test parsing and lookup of submodule config by name
#	
#		(cd super &&
#			test-submodule-config --name \
#				HEAD^ a \
#				HEAD a \
#				HEAD^ submodule \
#				HEAD submodule \
#					>actual &&
#			test_cmp expect actual
#		)
#	

expecting success: 
	(cd super &&
		cp .gitmodules .gitmodules.bak &&
		echo "	value = \"" >>.gitmodules &&
		git add .gitmodules &&
		mv .gitmodules.bak .gitmodules &&
		git commit -m "add error" &&
		test-submodule-config \
			HEAD b \
			HEAD submodule \
				>actual &&
		test_cmp expect_error actual
	)

+ cd super
+ cp .gitmodules .gitmodules.bak
+ echo 	value = "
+ git add .gitmodules
+ mv .gitmodules.bak .gitmodules
+ git commit -m add error
[master 7cb6f0e] add error
 Author: A U Thor <author@example.com>
 1 file changed, 2 insertions(+), 1 deletion(-)
+ test-submodule-config HEAD b HEAD submodule
error: bad config line 7 in submodule-blob 7cb6f0e38e67568f41da9828cc7d5eb1c753b7b4:.gitmodules
+ test_cmp expect_error actual
+ diff -u expect_error actual
ok 5 - error in one submodule config lets continue

expecting success: 
	(cd super &&
		sha1=$(git rev-parse HEAD) &&
		test-submodule-config \
			HEAD b \
			HEAD submodule \
				2>actual_err &&
		test_i18ngrep "submodule-blob $sha1:.gitmodules" actual_err >/dev/null
	)

+ cd super
+ git rev-parse HEAD
+ sha1=7cb6f0e38e67568f41da9828cc7d5eb1c753b7b4
+ test-submodule-config HEAD b HEAD submodule
Submodule name: 'a' for path 'b'
Submodule name: 'submodule' for path 'submodule'
+ test_i18ngrep submodule-blob 7cb6f0e38e67568f41da9828cc7d5eb1c753b7b4:.gitmodules actual_err
+ test -n 
+ test x! = xsubmodule-blob 7cb6f0e38e67568f41da9828cc7d5eb1c753b7b4:.gitmodules
+ grep submodule-blob 7cb6f0e38e67568f41da9828cc7d5eb1c753b7b4:.gitmodules actual_err
ok 6 - error message contains blob reference

expecting success: 
	(
		cd super &&
		git tag new_tag &&
		tree=$(git rev-parse HEAD^{tree}) &&
		commit=$(git rev-parse HEAD^{commit}) &&
		test-submodule-config $commit b >expect &&
		test-submodule-config $tree b >actual.1 &&
		test-submodule-config new_tag b >actual.2 &&
		test_cmp expect actual.1 &&
		test_cmp expect actual.2
	)

+ cd super
+ git tag new_tag
+ git rev-parse HEAD^{tree}
+ tree=934687743cd5ca685cfa8d3c77aaebb75ee12e1f
+ git rev-parse HEAD^{commit}
+ commit=7cb6f0e38e67568f41da9828cc7d5eb1c753b7b4
+ test-submodule-config 7cb6f0e38e67568f41da9828cc7d5eb1c753b7b4 b
error: bad config line 7 in submodule-blob 7cb6f0e38e67568f41da9828cc7d5eb1c753b7b4:.gitmodules
+ test-submodule-config 934687743cd5ca685cfa8d3c77aaebb75ee12e1f b
error: bad config line 7 in submodule-blob 934687743cd5ca685cfa8d3c77aaebb75ee12e1f:.gitmodules
+ test-submodule-config new_tag b
error: bad config line 7 in submodule-blob 7cb6f0e38e67568f41da9828cc7d5eb1c753b7b4:.gitmodules
+ test_cmp expect actual.1
+ diff -u expect actual.1
+ test_cmp expect actual.2
+ diff -u expect actual.2
ok 7 - using different treeishs works

expecting success: 
	(cd super &&
		git config -f .gitmodules \
			submodule.submodule.fetchrecursesubmodules blabla &&
		git add .gitmodules &&
		git config --unset -f .gitmodules \
			submodule.submodule.fetchrecursesubmodules &&
		git commit -m "add error in fetchrecursesubmodules" &&
		test-submodule-config \
			HEAD b \
			HEAD submodule \
				>actual &&
		test_cmp expect_error actual  &&
		git reset --hard HEAD^
	)

+ cd super
+ git config -f .gitmodules submodule.submodule.fetchrecursesubmodules blabla
+ git add .gitmodules
+ git config --unset -f .gitmodules submodule.submodule.fetchrecursesubmodules
+ git commit -m add error in fetchrecursesubmodules
[master 1fa1547] add error in fetchrecursesubmodules
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
+ test-submodule-config HEAD b HEAD submodule
+ test_cmp expect_error actual
+ diff -u expect_error actual
+ git reset --hard HEAD^
HEAD is now at 7cb6f0e add error
ok 8 - error in history in fetchrecursesubmodule lets continue

# failed 2 among 8 test(s)
1..8
