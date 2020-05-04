Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0F3C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18979206C0
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwa0fAB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgEDTUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbgEDTUk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:20:40 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CB3C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:20:40 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f3so13589251ioj.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UAyKzTUqVdYst5XYcKXHdZ1bc5VQ2hABLfiFVZ3uyNs=;
        b=Kwa0fAB5rqOCKQNLHykyA9Gk8oVsZ+uCnZNCbbVxczaVYWy9fNhSXXeOAsF1DfEZp6
         q4BgGg324ySi63qTEBc9Ic2C6fTgtZDa6hbe4+CdIkJii44zqino7t/NX5Szj6p2XDQN
         PuDV9nxYdC9ZGwNqOjmg5GhXXDAUMmEIgXEWT8su80MdZyDvhj50a3lE/4HHG4T6Ibxa
         QxLhL6zZbXX2a1upUauMS7HX2K200uI5ehVvulZBJ7/GGGKZ7OblN4so+PX4jjUUe82e
         UaOhHtmrlw2mMwNBVabmGSwJYLVmeRrGQLMzuG9+/KWDUq9BTZIewNMsPb4N2NRy4Rjo
         Oedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UAyKzTUqVdYst5XYcKXHdZ1bc5VQ2hABLfiFVZ3uyNs=;
        b=cMxNtzF1upYG5OIOmkZFHAe+E2QoQvn+LM74KSbBhRcsud2eO47siT+8oYRuGVPMF8
         qMupfK5eeT3kgtKuodUJODP1syCxnZuub8Mc8XLBNynohf5KLOmk+KNIjwaOTeAZRHvq
         m2Wuy+2/vuCcnAusdMl14rST2n+kw1wuyp0fsbIVaiOJUzXwkfEjK2iDFjk5+4ZDkDNH
         TPZIokEAVZ+2/NBmBgu2N/1Bz3eoI7x398xRPX4cxtI7OLujcIm9bzZEmtuyXOE7OQSS
         uyP5FDYAZEBn8NRj4uoL7wYETcizqxhc/UWwQVdY6n7gY+gWTC5etnOtjcsXj+lnvTdS
         L8fg==
X-Gm-Message-State: AGi0PuYEmc9n9TX+f/nrjTuQgXNF/K0WpuEWoMPCvIGCWURbDWDfr6EB
        omqV38Fo1nL6+r3iS0T3Xx1m7viLJu8JXJi0p7U=
X-Google-Smtp-Source: APiQypLQtlDXw3UlI2sdtcOz+SRoQjm50mKLClEhrMKflMCmVfFlHbEZdD35QvbStEXkDKqH9aD6aoWi/Ksv4ZcNbkM=
X-Received: by 2002:a6b:750c:: with SMTP id l12mr3514947ioh.66.1588620039666;
 Mon, 04 May 2020 12:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP> <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
 <20200504190830.g2tlrognjw6ddipo@tb-raspi4>
In-Reply-To: <20200504190830.g2tlrognjw6ddipo@tb-raspi4>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 4 May 2020 15:20:11 -0400
Message-ID: <CAH8yC8=zsbXDVV99tdBMHwEhr-=dO=wrwBYZi=0J8iFmUHkk=g@mail.gmail.com>
Subject: Re: Git 2.26.2 and failed self tests on OS X
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 4, 2020 at 3:08 PM Torsten B=C3=B6gershausen <tboegi@web.de> wr=
ote:
>
> On Mon, May 04, 2020 at 01:18:06PM -0400, Eric Sunshine wrote:
> > On Mon, May 4, 2020 at 12:52 PM Carlo Marcelo Arenas Bel=C3=B3n
> > <carenas@gmail.com> wrote:
> > > On Mon, May 04, 2020 at 03:03:01AM -0400, Jeffrey Walton wrote:
> > > > I'm building Git 2.26.2 from sources on a Mac-mini with OS X 10.12.=
6
> > > > and a PowerMac with OS X 10.5. Some of the t3902-quoted.sh tests ar=
e
> > > > failing.
> > > >
> > > > The Mac-Mini uses Bash 3.2.57(1)-release. The PowerMac uses 3.2.17(=
1)-release.
> > >
> > > if the problem is the bash version but you can build/install a newer =
one that
> > > doesn't have this problem [...]
> >
> > My OS X 10.13.6 has Bash 3.2.57, as well, and I'm unable to reproduce
> > these failures, so it seems fairly unlikely that the problem Jeffrey
> > is seeing isn't tied to Bash.
>
> Should I read this as
> ".. seems fairly likely that the problem Jeffrey is seeing is tied to bas=
h" ?
>
> I can't reproduce it either, so my reasoning would rather be
> "The problem is probably not caused by the shipped bash version"
>
> It could be something in the environemt, that confuses our tests here.
>
> Does
> ./t3902-quoted.sh   -v -d
> give anything useful ?

Yes, it looks like the command reveals a couple of problems.

I'll have to look into my iconv recipe. It has not changed in a while,
so something else may be responsible for the failure.
https://github.com/noloader/Build-Scripts/blob/master/build-iconv.sh.

I'm not sure what to do with the HEAD problems.

$ ./t3902-quoted.sh   -v -d
Initialized empty Git repository in
/Users/jwalton/Build-Scripts/git-2.26.2/t/trash
directory.t3902-quoted/.git/
expecting success of 3902.1 'setup':

        mkdir "$FN" &&
        for_each_name "echo initial >\"\$name\"" &&
        git add . &&
        git commit -q -m Initial &&

        for_each_name "echo second >\"\$name\"" &&
        git commit -a -m Second &&

        for_each_name "echo modified >\"\$name\""


fatal: iconv_open(UTF-8,UTF-8-MAC) failed, but needed:
    precomposed unicode is not supported.
    If you want to use decomposed unicode, run
    "git config core.precomposeunicode false"

not ok 1 - setup
#
#
#               mkdir "$FN" &&
#               for_each_name "echo initial >\"\$name\"" &&
#               git add . &&
#               git commit -q -m Initial &&
#
#               for_each_name "echo second >\"\$name\"" &&
#               git commit -a -m Second &&
#
#               for_each_name "echo modified >\"\$name\""
#
#

expecting success of 3902.2 'setup expected files':
cat >expect.quoted <<\EOF &&
Name
"Name and a\nLF"
"Name and an\tHT"
"Name\""
With SP in it
"\346\277\261\351\207\216\t\347\264\224"
"\346\277\261\351\207\216\n\347\264\224"
"\346\277\261\351\207\216 \347\264\224"
"\346\277\261\351\207\216\"\347\264\224"
"\346\277\261\351\207\216/file"
"\346\277\261\351\207\216\347\264\224"
EOF

cat >expect.raw <<\EOF
Name
"Name and a\nLF"
"Name and an\tHT"
"Name\""
With SP in it
"=E6=BF=B1=E9=87=8E\t=E7=B4=94"
"=E6=BF=B1=E9=87=8E\n=E7=B4=94"
=E6=BF=B1=E9=87=8E =E7=B4=94
"=E6=BF=B1=E9=87=8E\"=E7=B4=94"
=E6=BF=B1=E9=87=8E/file
=E6=BF=B1=E9=87=8E=E7=B4=94
EOF

ok 2 - setup expected files

expecting success of 3902.3 'check fully quoted output from ls-files':

        git ls-files >current && test_cmp expect.quoted current


--- expect.quoted       2020-05-04 19:14:39.000000000 +0000
+++ current     2020-05-04 19:14:39.000000000 +0000
@@ -1,11 +0,0 @@
-Name
-"Name and a\nLF"
-"Name and an\tHT"
-"Name\""
-With SP in it
-"\346\277\261\351\207\216\t\347\264\224"
-"\346\277\261\351\207\216\n\347\264\224"
-"\346\277\261\351\207\216 \347\264\224"
-"\346\277\261\351\207\216\"\347\264\224"
-"\346\277\261\351\207\216/file"
-"\346\277\261\351\207\216\347\264\224"
not ok 3 - check fully quoted output from ls-files
#
#
#               git ls-files >current && test_cmp expect.quoted current
#
#

expecting success of 3902.4 'check fully quoted output from diff-files':

        git diff --name-only >current &&
        test_cmp expect.quoted current


--- expect.quoted       2020-05-04 19:14:39.000000000 +0000
+++ current     2020-05-04 19:14:39.000000000 +0000
@@ -1,11 +0,0 @@
-Name
-"Name and a\nLF"
-"Name and an\tHT"
-"Name\""
-With SP in it
-"\346\277\261\351\207\216\t\347\264\224"
-"\346\277\261\351\207\216\n\347\264\224"
-"\346\277\261\351\207\216 \347\264\224"
-"\346\277\261\351\207\216\"\347\264\224"
-"\346\277\261\351\207\216/file"
-"\346\277\261\351\207\216\347\264\224"
not ok 4 - check fully quoted output from diff-files
#
#
#               git diff --name-only >current &&
#               test_cmp expect.quoted current
#
#

expecting success of 3902.5 'check fully quoted output from diff-index':

        git diff --name-only HEAD >current &&
        test_cmp expect.quoted current


fatal: ambiguous argument 'HEAD': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
not ok 5 - check fully quoted output from diff-index
#
#
#               git diff --name-only HEAD >current &&
#               test_cmp expect.quoted current
#
#

expecting success of 3902.6 'check fully quoted output from diff-tree':

        git diff --name-only HEAD^ HEAD >current &&
        test_cmp expect.quoted current


fatal: ambiguous argument 'HEAD^': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
not ok 6 - check fully quoted output from diff-tree
#
#
#               git diff --name-only HEAD^ HEAD >current &&
#               test_cmp expect.quoted current
#
#

expecting success of 3902.7 'check fully quoted output from ls-tree':

        git ls-tree --name-only -r HEAD >current &&
        test_cmp expect.quoted current


fatal: Not a valid object name HEAD
not ok 7 - check fully quoted output from ls-tree
#
#
#               git ls-tree --name-only -r HEAD >current &&
#               test_cmp expect.quoted current
#
#

expecting success of 3902.8 'setting core.quotepath':

        git config --bool core.quotepath false


ok 8 - setting core.quotepath

expecting success of 3902.9 'check fully quoted output from ls-files':

        git ls-files >current && test_cmp expect.raw current


--- expect.raw  2020-05-04 19:14:39.000000000 +0000
+++ current     2020-05-04 19:14:40.000000000 +0000
@@ -1,11 +0,0 @@
-Name
-"Name and a\nLF"
-"Name and an\tHT"
-"Name\""
-With SP in it
-"=E6=BF=B1=E9=87=8E\t=E7=B4=94"
-"=E6=BF=B1=E9=87=8E\n=E7=B4=94"
-=E6=BF=B1=E9=87=8E =E7=B4=94
-"=E6=BF=B1=E9=87=8E\"=E7=B4=94"
-=E6=BF=B1=E9=87=8E/file
-=E6=BF=B1=E9=87=8E=E7=B4=94
not ok 9 - check fully quoted output from ls-files
#
#
#               git ls-files >current && test_cmp expect.raw current
#
#

expecting success of 3902.10 'check fully quoted output from diff-files':

        git diff --name-only >current &&
        test_cmp expect.raw current


--- expect.raw  2020-05-04 19:14:39.000000000 +0000
+++ current     2020-05-04 19:14:40.000000000 +0000
@@ -1,11 +0,0 @@
-Name
-"Name and a\nLF"
-"Name and an\tHT"
-"Name\""
-With SP in it
-"=E6=BF=B1=E9=87=8E\t=E7=B4=94"
-"=E6=BF=B1=E9=87=8E\n=E7=B4=94"
-=E6=BF=B1=E9=87=8E =E7=B4=94
-"=E6=BF=B1=E9=87=8E\"=E7=B4=94"
-=E6=BF=B1=E9=87=8E/file
-=E6=BF=B1=E9=87=8E=E7=B4=94
not ok 10 - check fully quoted output from diff-files
#
#
#               git diff --name-only >current &&
#               test_cmp expect.raw current
#
#

expecting success of 3902.11 'check fully quoted output from diff-index':

        git diff --name-only HEAD >current &&
        test_cmp expect.raw current


fatal: ambiguous argument 'HEAD': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
not ok 11 - check fully quoted output from diff-index
#
#
#               git diff --name-only HEAD >current &&
#               test_cmp expect.raw current
#
#

expecting success of 3902.12 'check fully quoted output from diff-tree':

        git diff --name-only HEAD^ HEAD >current &&
        test_cmp expect.raw current


fatal: ambiguous argument 'HEAD^': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
not ok 12 - check fully quoted output from diff-tree
#
#
#               git diff --name-only HEAD^ HEAD >current &&
#               test_cmp expect.raw current
#
#

expecting success of 3902.13 'check fully quoted output from ls-tree':

        git ls-tree --name-only -r HEAD >current &&
        test_cmp expect.raw current


fatal: Not a valid object name HEAD
not ok 13 - check fully quoted output from ls-tree
#
#
#               git ls-tree --name-only -r HEAD >current &&
#               test_cmp expect.raw current
#
#

# failed 11 among 13 test(s)
1..13
