Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB87C47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 08:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AB761090
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 08:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFFI7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 04:59:34 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60879 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhFFI7e (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 Jun 2021 04:59:34 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DABD95C01BB;
        Sun,  6 Jun 2021 04:57:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 06 Jun 2021 04:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=EyFiFL0aDLDT8
        xcOQdAtvKf/jxawY95FqesVxZGJMP8=; b=jmYfQHJOEgJvaQEbI6L1+enywb1HA
        uRu0bAFTIAodMDzuPazvHATnFxInpsqDoZMvP/wx6JUi7rr6itExHCo9VxEWTPsE
        XPZLMLn4Z0JL+HyZ/2lk0YD7ITkursZLnyj698yYm7Lfn+lzx/nWgnBgwZg14uuc
        2Yoz3SVsjtIlbMxlyHbrcsF5rMQBb2WhEUjcnRM03Tab2NDvEPgcHXsHlQc+0QQR
        323ECZoFVNXuuYUvCgeWEMHBahUKTad/4ztsz2qWPUueuOExUsRjW596s8h3bezj
        NQ4+v56Yy9l7mgPqoecnXHohDujZj4+xRAil4iH93nKl0Wc3Ra31/Xa8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=EyFiFL0aDLDT8xcOQdAtvKf/jxawY95FqesVxZGJMP8=; b=tpUo3aLN
        2rtwycGSWj60W7Da47SKF/sYgH9VO7K6ziaeLZPxg86gkSpwp96zhiA6K2O9tIoK
        5kvnqfy6LjvIehHk07sGWGKZ+Iz7M5ENFBgrWvHNU6tiRx+wE+mqkB5DwH5cGoMq
        sf2B1thJXtPMs4JldVgONXqKWxQ1WIfoKV95LGrKo9bNd3VFgEJu9iociRMfaIb4
        ffid065GlaxZdLMV0Bah+NwkDTYUhuliORf2OQAgZV7DumraYKGhVdJh28cZ/mkw
        +W635NMIRFYlmSTx9cO6pJZt/pyPlsZLwOXOWlpIBzhaTVdkWl1KJoRgmuddfB/0
        gBOZFVLvxQV7VQ==
X-ME-Sender: <xms:CI68YOnMQAcJygP1c6TLK_ipZNzzjO9AcOr9Z5aoFYYB5WNnV9OBwg>
    <xme:CI68YF2xcouzGyCmEMg7l1iSrbsulBFX18I4e0pmPM_AUORlSi_EJaYlhX7iP2AMk
    St5Je9gpBOF9dnGlt8>
X-ME-Received: <xmr:CI68YMpqS4oP6Tuh7mg6Wdg4huTrQUvpELpOwHVuqf091vD23At1PH9WZjPIpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedthedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepifhrvghgucfjuhhrrhgvlhhluceoghhrvghgsehhuhhrrhgv
    lhhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeutedvieffudeggeehudehtddufeelje
    ehtddttedvteefhfevkeeuudelhedtfeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgrhgvgheshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:CI68YClgKYdVzarSQ5l9dcXRQnaYy7SDhadYqBb2-EWiVMwI4r0IIA>
    <xmx:CI68YM2LEinoxZbbT-DS5c9TrQ6QEWgXLmDX9pGdsWIgW171oLWmhA>
    <xmx:CI68YJtQYk6Tx4_seCkHF1a_BlbEXRxBBvkf8IsIDaD1Un1CbYsTQg>
    <xmx:CI68YB9Xi7glGpYf6hyU9brPArx_puXMojsf8AFNpAhODClRfBhtdA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jun 2021 04:57:43 -0400 (EDT)
From:   Greg Hurrell <greg@hurrell.net>
To:     git@vger.kernel.org
Cc:     Greg Hurrell <greg@hurrell.net>
Subject: [RFC PATCH] gitweb: use HEAD as primary sort key in git_get_heads_list()
Date:   Sun,  6 Jun 2021 10:57:32 +0200
Message-Id: <20210606085732.15001-1-greg@hurrell.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210606085116.13739-1-greg@hurrell.net>
References: <20210606085116.13739-1-greg@hurrell.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to this commit, the "heads" section on a gitweb summary page would
list the heads in `-committerdate` order (ie. the most recently-modified
ones at the top).

In my own repos I have started to move from "master" towards "main", but
I keep "master" around and in sync with "main" so as not to break
existing clones. As such, they always point at the same commit.

This means that in the "heads" listing of a gitweb instance, the display
order ends up being determined by how `git for-each-ref` decides to
tie-break "master" and "main"

For example, right now on a sample repo, gitweb shows the heads in this
order, even though "master" and "main" reference the same commit. The
tie-breaking evidently isn't happening lexicographically:

- master
- main
- pu
- next

So, this commit adds another `--sort` parameter to the `git
for-each-ref` invocation in `git_get_heads_list()`, ensuring that the
`HEAD` ref always ends up getting sorted to the top:

- main
- master
- pu
- next

This seems to be a useful change, because I can't see anywhere else in
the gitweb UI where we actually indicate to the user what the "default"
branch is (ie. what they'll checkout if they run `git clone`).

Signed-off-by: Greg Hurrell <greg@hurrell.net>
---

Resending because I forgot the Signed-off-by the first time. Sorry for
the noise.

 gitweb/gitweb.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e09e024a09..e5270b0291 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3796,7 +3796,8 @@ sub git_get_heads_list {
 	my @headslist;
 
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
-		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
+		($limit ? '--count='.($limit+1) : ()),
+		'--sort=-committerdate', '--sort=-HEAD',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
 		@patterns
 		or return;
-- 
2.29.2

