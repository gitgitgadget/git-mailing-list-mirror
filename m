Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6DEC47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583B76139A
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 08:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFFIxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 04:53:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57237 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhFFIxO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 Jun 2021 04:53:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5031B5C00DB;
        Sun,  6 Jun 2021 04:51:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 06 Jun 2021 04:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=QPRoLESEbRDymuPZdpZmw4ENJn
        N3YEwNsnOYs+0ZNDI=; b=PUykPaVIIg7r14U+uK2btQejCpMl3ZZFxuvs4rzTqh
        VP97qHqsdRHv3L4So44UseJFmfKHXZXdY/f7FufDg+1585V6onrcxqoj0nfLjoAq
        Yi1tV+cJrcmFJ76Cp2UmzY0LVlsMFY9HGzHx26SzAl1eUx2Oe5DkQHYlB/nDN3up
        7CYDHfzkQRyKyriQAd2MEoBUMThaBfb+SfZX7WaOxs1sMwk1dZJRfjPw7/wDscv3
        dysVQi/syuavTZBwKOLvnUAhQprYXrGf4jouXdA9Q+X0Qja0CQspWgha57dJJqw5
        /hV2JcG+gh2jeh59PIDxS+M2JGLGbv0TMkAbLMZ39Dcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QPRoLESEbRDymuPZd
        pZmw4ENJnN3YEwNsnOYs+0ZNDI=; b=AAOBJEQk1zRaL3qXxxlRN0PojODPJ2Yk4
        elHHr3BHKIwkAadew7AJaTYepYT1tFP864JiYMiBrEWNQs5/nYQDwqmfF64tpA7R
        +eh9Ly/68VKLIX8f6ZtCLCJjn4PCbRmy5CH2TyXes3gTrCETv9eWO88hR5DNSsRI
        4VunVJMl4nJKf1QMHb9yjZiTTqQ4ic5rJ6HcqQewh2IhEkazc7jLJSke/NNKVkDz
        BYvZtuZHpT3DH16zXvCPzhZQ3DOPhgViwiy6l1majhDOOAT37qCxq/rZMzq7dvlq
        veRZRRBSQ0/TxJb+irfxwxsnpw2sStt9AIchIip834aZjKrMbUTOQ==
X-ME-Sender: <xms:jYy8YPtBEiUYlzCtmZml_7LVH6assPJS9rQVSPALHbN3oG7SMOHKiA>
    <xme:jYy8YAe2Z_WjBBG-Vn8y26qv84CwSWVWdGGysnNP_Ta0qFbb5mzEROrc5yB3DgJGz
    duOkKl-ihhWajaUXxw>
X-ME-Received: <xmr:jYy8YCwjh4IHk9s5IY8z7Qeb5QmTlNl0bXSlZPOkzKS0Pd9jxk9OuDDoU3LhjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedthedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepifhrvghgucfjuhhrrhgvlhhluceoghhrvghgsehhuhhrrhgvlhhl
    rdhnvghtqeenucggtffrrghtthgvrhhnpeduhfeftddvleekuedvuddtffegueefvdefue
    eglefhhefhveekfffhvdelgfdtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgrhgvgheshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:jYy8YOPtltYQyUb_qGgE9L6wQj5Tk1SVi7UlJqQkvPsRsvG4d6_ONA>
    <xmx:jYy8YP__hFsFWf_4EVKz4WxaxYgzdiksPeZDhkZvqhmpa3ldIS2nEg>
    <xmx:jYy8YOW1mhc-d-a4Z82gGo0Zqm4s3F4RlFFg0OQFwHmHL1QYQrwpBw>
    <xmx:jYy8YMH57FPtosa_tU4zvHfQDRxmSDTee_HTZ8Hx1ApIexJSgNjOjw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jun 2021 04:51:24 -0400 (EDT)
From:   Greg Hurrell <greg@hurrell.net>
To:     git@vger.kernel.org
Cc:     Greg Hurrell <greg@hurrell.net>
Subject: [RFC PATCH] gitweb: use HEAD as primary sort key in git_get_heads_list()
Date:   Sun,  6 Jun 2021 10:51:16 +0200
Message-Id: <20210606085116.13739-1-greg@hurrell.net>
X-Mailer: git-send-email 2.29.2
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
---
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

