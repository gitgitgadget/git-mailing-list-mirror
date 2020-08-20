Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4262C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 17:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A554A208B3
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 17:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TYX2emd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHTRtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:49:19 -0400
Received: from mout.web.de ([212.227.15.4]:60003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgHTRtR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 13:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597945746;
        bh=6e1c1DGaGlzJrbUtnH6wq4GyqUK49VydGV/7aSqTYqw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TYX2emd4CM6qV4lAYhAJu9mmUVjhxb9pOsJcrg6Hoa2gwM+xDQxRa4DT23g3CfDTP
         L+nQ1V/d9B++TFxdpxP/NUnsRfs37+ZMMXbIDeD+yd74+SjTGYOWN5SvTWqJVHDzox
         c+37k3BF7Krrr2JjnKaFWVxPr6mXbir/7n5iRmHE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lakoa-1kWqqI2V56-00kOyj; Thu, 20
 Aug 2020 19:49:06 +0200
Subject: Re: Possible bug with git restore
To:     Jeff King <peff@peff.net>,
        Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
 <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
 <CAFvH=vuFg+kM2GkBaE7jRqHWWcTcZMrs36KLS+-VTy8tgNZXJw@mail.gmail.com>
 <20200820134013.GA2526241@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c3f0d51a-d0e3-ed0a-c9ed-da092704da5c@web.de>
Date:   Thu, 20 Aug 2020 19:48:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820134013.GA2526241@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S21wH6nHLrPcOo1kT/LmC7lXSu4On0SVXfI+j/F0A55jBzeR8AC
 RUZ+DcHA6NOgHyRQaiA2wbHjUOqDnDKPRs20lZ8/bJ3l2CdqQ6sU3/SoHB/QbAWD5SjsDyg
 3YDB4r5ShyBzhM6Na6U9PNoJGEhI/86NdoYOw4d1kkOFyMIaKTfs8fNQ8oVJ1z8lOFccmon
 iuBGjk3+TFRtU3NNxbQVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:agYgYFvaDXU=:fmzl9J+ix6KpKeuqlPLb6k
 vu9wApcOQFUdgj3yXRW1lWaU/Q5P1W6cXwN3kv3Zsb4Zqqr8YbbJMvNqQ1aJf1/lhT9V7Fg6d
 zAJEBMcog20kmjwx25+vkxeyPixrLySEdlAi1Z2QAP8FtKrRbh4JT1dHlS1u8VHVxgZlwXhOe
 i2JorMTjiyz4ke0yWOBz+hhXfRABUocdlCRNKJtml6CsfQXUwj0NTeqBEA7o+x3mHIwXBO5aT
 h1cRF9rFrC8dDJeez+YG2LOV1cw9d3ST3rYNXIB6PfHgkev/gCrCPglwnV9EJcVJSjVDE7pe3
 DspuzvX/yyqjmfvVYoK/+C61ui55ZY/BaLGBBx8CT+JQT2NvxKnS1/TYPU7runGRfawT2agBC
 fuvjbxa70DzMC1sy3pQ/VxUAvFq0lvFsKKHwq2lUED0bLjuYUk8A1LW0+mFp3cuMGWYNrFIrS
 eFhLsEEjQC0ITc4ZDJkYJ824TmM/3kegFjtH4HGIoVZ4DuXvj8GYjyUxNV0tu6t6BpbIrBOZC
 2eEVfXIzt2MWb5O3biq7n3uD2wnrCTqg20ImFl0cWAtyWVsJMDrrUzqQ+66dPp3RJfetaBzYj
 uGzjU4m7hvrZcrNvBisbRrFJV0TolIwweyuW2F+0k8G9w+y19uZ5uVWe9K6bNuyHhcx4TwmPM
 Y+ip9c74pwsmOyVD3o0g2F0Ynq2EDKsaltiOo82/IXZQfzI+/ulXYcalETxKnSGjO7Sp9nEdv
 IjCC9wc6g+FSkLoD8c/uQmcdr2eCwMf6vP8f8DltwG3BRekgyD21Uis3Fp8D4twDmGja4qpcg
 //q5Jf/uK3OMl3y7E81MxNPGl/ohNa7Ias1aHyVfO0HHukiCl41DNexN0vLiEUI2JDrjKQ68M
 f2W4Ibn4mDdR7riRCHeRZqk9qdl7S3vTohRlYSTqDV46Jd7LEJLzwORqMJAx8awUqSZQmmVxn
 0xK4Rqi1CdwF+XhJ7lqnCQiH5eg2zZI1h9uG1W+B1jfq/AaX/P14bTx26+O5/LuOnKkDx+NMJ
 lXqw26kwCUfZJtgbSo81UfWQfGYtoDp60OYsfYodClXDFr6XK0LxqqYp1oeyMSv0JiqoQZOeQ
 BQg+6eoMtHByM4LVo70Au4pn/1ZDRjnPCDVzDADBYl264OZS7E9RCD1JmQjt1Er0Q2XukrWCL
 HpLe/+m/3yvnDUZ3Dms981kjth/HgzRtiLCHqUWbJ6L/ltSmG6XDnUy0KjIUXU4Gtt5O0v3HB
 uRcrdVqiSGfrR2O31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.20 um 15:40 schrieb Jeff King:
> On Thu, Aug 20, 2020 at 03:59:00PM +0300, Sergii Shkarnikov wrote:
>
>> Here is a script to reproduce the issue that works for me in Git Bash:

That's very helpful!

>   - shouldn't that wildcard pathspec match those files? I've confirmed
>     that the glob characters make it into Git's pathspec machinery, and
>     since it doesn't have slashes, I think we'd match a basename (and
>     certainly "git ls-files *test_file.*" does what I expect).

No, because restore doesn't interpret pathspecs recursively.  I don't
know why that causes files to disappear, though.  But here's a fix.

No sign-off because I don't understand why pathspec recursiveness is a
thing that can be turned off -- I'd expect pathspec syntax to be
consistent for all commands.  So there might be a good reason why it was
not enabled for restore (and switch and checkout).

The flag was introduced in bc96cc87dbb (tree_entry_interesting():
support depth limit, 2010-12-15), but I still don't fully get it.
Anyway, here's what I got -- feel free to incorporate it in a real
patch:

Ren=C3=A9


=2D--
 builtin/checkout.c               |  4 ++++
 t/t2072-restore-pathspec-file.sh | 19 ++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 28371954912..8d2dc0cfa48 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -66,6 +66,7 @@ struct checkout_opts {
 	int can_switch_when_in_progress;
 	int orphan_from_empty_tree;
 	int empty_pathspec_ok;
+	int recursive_pathspec;
 	int checkout_index;
 	int checkout_worktree;
 	const char *ignore_unmerged_opt;
@@ -1707,6 +1708,8 @@ static int checkout_main(int argc, const char **argv=
, const char *prefix,
 		die(_("--pathspec-file-nul requires --pathspec-from-file"));
 	}

+	opts->pathspec.recursive =3D opts->recursive_pathspec;
+
 	if (opts->pathspec.nr) {
 		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
 			die(_("git checkout: --ours/--theirs, --force and --merge are incompat=
ible when\n"
@@ -1852,6 +1855,7 @@ int cmd_restore(int argc, const char **argv, const c=
har *prefix)
 	opts.checkout_index =3D -1;    /* default off */
 	opts.checkout_worktree =3D -2; /* default on */
 	opts.ignore_unmerged_opt =3D "--ignore-unmerged";
+	opts.recursive_pathspec =3D 1;

 	options =3D parse_options_dup(restore_options);
 	options =3D add_common_options(&opts, options);
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-f=
ile.sh
index 0d47946e8a9..da976665095 100755
=2D-- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -9,18 +9,21 @@ test_tick
 test_expect_success setup '
 	test_commit file0 &&

+	mkdir dir1 &&
+	echo 1 >dir1/file &&
 	echo 1 >fileA.t &&
 	echo 1 >fileB.t &&
 	echo 1 >fileC.t &&
 	echo 1 >fileD.t &&
-	git add fileA.t fileB.t fileC.t fileD.t &&
+	git add dir1 fileA.t fileB.t fileC.t fileD.t &&
 	git commit -m "files 1" &&

+	echo 2 >dir1/file &&
 	echo 2 >fileA.t &&
 	echo 2 >fileB.t &&
 	echo 2 >fileC.t &&
 	echo 2 >fileD.t &&
-	git add fileA.t fileB.t fileC.t fileD.t &&
+	git add dir1 fileA.t fileB.t fileC.t fileD.t &&
 	git commit -m "files 2" &&

 	git tag checkpoint
@@ -31,7 +34,7 @@ restore_checkpoint () {
 }

 verify_expect () {
-	git status --porcelain --untracked-files=3Dno -- fileA.t fileB.t fileC.t=
 fileD.t >actual &&
+	git status --porcelain --untracked-files=3Dno -- dir1 fileA.t fileB.t fi=
leC.t fileD.t >actual &&
 	test_cmp expect actual
 }

@@ -161,4 +164,14 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "you must specify path(s) to restore" err
 '

+test_expect_success 'pathspec matches file in subdirectory' '
+	restore_checkpoint &&
+
+	echo "*file" | git restore --pathspec-from-file=3D- --source=3DHEAD^1 &&
+	cat >expect <<-\EOF &&
+	 M dir1/file
+	EOF
+	verify_expect
+'
+
 test_done
=2D-
2.28.0
