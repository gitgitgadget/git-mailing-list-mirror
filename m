Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57F8C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 23:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AAD22CB3
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 23:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbhAWXCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 18:02:45 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:51300 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbhAWXCn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 18:02:43 -0500
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10NN1rjM000675
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jan 2021 18:01:54 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10NN1rjM000675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611442914; bh=zFAiKRSb7xtA/5tWdkQ6ie8bEa2K6UA4kwTeslybqew=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=FqfiuMfheGg/oZ2HYzAoLPQJInAgWsvsQb8PWnwHg8mUJga2CglENyLMk5ettYMFY
         GxVmMtPWgcZqc9WT9aHkPdfnBa4JtiR444vWNm1MmHhnhHV4c9DC32QosGIXy6fvBw
         wuPcSGTyN9154RqmMI3o4YakASZVTqtVF7u4+s/Fl5IHTn4Z2ikO7DUpYs/omi/l1x
         plcAXy2ViESsrvoM2E0Vq1NUtcdGD1cioMunyqHkReu6lS/ZvmwMwOXe2EL636zC0r
         +DsbfiCWIvAlgnni0CYbOMcRiN49gtdQdTCSbe4/T/Mf1JJv9lwkvw9nZbgdz82fcP
         +4RbIAt/yMXKw==
Reply-To: <git@vger.kernel.org>,
          "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
          "'Kyle Marek'" <kmarek@pdinc.us>,
          "Junio C Hamano" <gitster@pobox.com>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
        "'Kyle Marek'" <kmarek@pdinc.us>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>        <20210117110337.429994-1-kmarek@pdinc.us>        <20210117110337.429994-2-kmarek@pdinc.us>        <xmqq7dobmfrq.fsf@gitster.c.googlers.com>        <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>        <xmqqwnwajbuj.fsf@gitster.c.googlers.com>        <xmqqr1mij88k.fsf@gitster.c.googlers.com>        <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us>        <xmqq1reginnq.fsf@gitster.c.googlers.com>        <460257a2-478a-eb4c-f6fa-b1cc55384cd5@pdinc.us>        <xmqqo8hkgl4h.fsf@gitster.c.googlers.com>        <01fd01d6ef3e$92e43b10$b8acb130$@pdinc.us>        <xmqq35yvff98.fsf@gitster.c.googlers.com>        <009a01d6ef80$326572d0$97305870$@pdinc.us> <xmqqh7n74jdt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7n74jdt.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH 1/2] revision: Denote root commits with '#'
Date:   Sat, 23 Jan 2021 18:02:04 -0500
Organization: PD Inc
Message-ID: <057b01d6f1db$c46d7d50$4d4877f0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJHGJacgXqgwI3Z8mKvOOtpVC9QaQIPWPTxAWqKtJ0CjS/zDwIOmFXbAj4EO1oBSKUeLQJMhZdkAgqPsIIBueaIOAHxr5jOAbl0TYoB42v/AgFWk/VJARzJfs2oiAfF0A==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: Saturday, January 23, 2021 1:07 PM
>=20
> "Jason Pyeron" writes:
>=20
> > Summary: --graph used with --oneline sometimes produces ambiguous
> > output when more than one commit has no parents and are not yet
> > merged
> > ...
> >> "(branch name)" in the output, instead of painting the commit in =
the
> >> graph by replacing the '*' node with something else.
> >>
> >> And how often do you really need to see commits near the root, say
> >> the earliest 100 commits, in the 35k+ commit history?  Is it really
> >> necessary to tell which among these 100 is the root?
> >
> > Yes, and the assumption that they are at the beginning is flawed =
too.
> >
> > $ git log --oneline --graph --all | cat -n | egrep $(git rev-list =
--max-parents=3D0 --all | cut -c 1-8
> | tr '\n' '|' | head -c -1)
> >     87  | | * be2c70b7 bug 2252 test case (e.g. for tomcat 9 with =
unpackWARs=3Dfalse)
> >   2161  | | * 8ef73128 Add migrate-from-blackfat.sql
> >   2164  | | * 5505e019 initial
> >   2235  | | | | | | | | | | | | | * 83337c67 intial
> >   2921  | | | | * ca14dc49 Initial commit
> >   2931  | | | * cbdce824 initial commit
> >   2963  | | * 8f1828c1 Base applet
> >   2971  | * 658af21f parrent pom
> >   3026  * 8356af31 Initial commit from Create React App
> >
> > git log --oneline --graph produces 3026 lines in this example.
>=20
> Hmph.  Are you saying that you have 3000+ root commits in the 35k+
> history?
>=20

I think you misread the specific example of 9 roots in 3026 commits, =
distributed throughout history.

> Whether we add '[root]' decoration to the true roots (like
> '(branchname)' decoration we add to branch tips), or painted '*' in
> a different color (like '#'), you do not have to look for 'initial',
> so having that many roots will not be a problem per-se with respect
> to the "log" output, but there must be something strange going on.
>=20
> I am not going to ask you why you need so many roots, because I
> suspect that I will regret asking ;-).
>=20
> By the way, I sense that your problem description is flip-flopping
> again and I can no longer keep track of.  The way I read the message
> I got from Kyle was, even when a graph has two commits that have no
> parents in the visible part of the history, either Kyle wanted (or
> Kyle got an impression after talking to you that you wanted) to see
> these differently if one of them is a root and the other is non-root
> (but happens to have none of its parents shown due to A..B range).
> And that is why I started asking how meaningful to special case only
> "root".
>=20

I may be having trouble with my writing, apologies.

Here is the issue (bug):

1. I never want to see a commit implied to be the parent of an unrelated =
commit.
2. I never want to see a commit implied to be the child of an unrelated =
commit.

--graph --oneline is broken with regards to the man page and my desire =
to not be confused by the implication of relationship for =
inappropriately connected nodes on the graph.

| | * 1234567 commit child of 2345678
| | * 2345678 the first commit, having no parent
| | * 9876543 an unrelated commit and child of 8765432
| | * 8765432 ...

> Now the message from you I am responding to in the "Sumary" above
> says that it is not "root" but is about the placement of graph
> nodes.
>=20

One and the same issue. Placing an * directly above another * is the =
issue.

Solution #1

| | * 1234567 commit child of 2345678
| | # 2345678 the first commit, having no parent
| | * 9876543 an unrelated commit and child of 8765432
| | * 8765432 ...

Or

Solution #2

| | * 1234567 commit child of 2345678
| | * 2345678 the first commit, having no parent
| |
| | * 9876543 an unrelated commit and child of 8765432
| | * 8765432 ...

Or

Solution #3

| | * 1234567 commit child of 2345678
| | \
| |  * 2345678 the first commit, having no parent
| | * 9876543 an unrelated commit and child of 8765432
| | * 8765432 ...

All of these solutions will solve the bug. #1 seems to be the easiest =
and becomes searchable. You have indicated that #3 others have failed to =
do so. #2 is very much aligned to the --graph without --oneline

> So, I dunno, with changing the description of the goalpost.  Now it
> is that "root" is so not special at all and we only care about that
> the a commit, none of whose parents are in the part of the shown
> history, is shown in such a way that the user can tell that any
> unrelated commits shown in the graph near it are not parents of such
> a commit?  Or do you still want to show such a commit in two ways,
> one for root and one for the ones above the boundary?

A commit without a parent is special - it has no parent. This means it =
has no history beyond that point. Something special happened at that =
time - the birth of new source code in source control.

Hopefully, I have cleared up the ambiguous wording.

