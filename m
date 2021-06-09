Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3F2C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CD4613F5
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhFITa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:30:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43627 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhFITa2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Jun 2021 15:30:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F336C5C019C;
        Wed,  9 Jun 2021 15:28:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Jun 2021 15:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Bx32nAmDHDLD1
        otnyO3WDyJXJIoJ4cVzL5fNuBY1b+Q=; b=IAIuVF9UIdsygrnzsuk3TAOrfwV31
        lhuPyY0ktK/KN9uCD5IgMVEbU7cGJYQyoiUQcgZFGU0OiDQcXSMvDWOXn/zZvQtx
        Om9WL+dX0XT4irK+wyMrwF0dnUAAi1GaX4mNT9n89hO4zsM0iklLHggPjrZ5tT7h
        76AvFcPNzyNVHjen6hU0IM9hTELpUCAEJTcwt8xtW95mOlvrZ2N7L84oa2aR0Owf
        rWpaDrgcOLoI3v8F9NVORTkwgU2BulKUXOKrxjVkzLIAJ/8G1dSiNx43bTDglTk8
        03zGu1zVkhZtTtZCSfmCyh9zsbgJwMQ0XhXqci1UYvvLT7i7WogKYDS5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Bx32nAmDHDLD1otnyO3WDyJXJIoJ4cVzL5fNuBY1b+Q=; b=legxlEU8
        ZeDkrcM/tBvH19AnhZB9iyZ4cHl2UL+kaYxlN/wDBx4VpMbtUJD3ZkbuTAqR0Q3Z
        UmQIE75oKtVjV2HGLMI3+qsOLX8tw45c3JQS+G0hNGMy3CmXFW7OKAFTR05wAc/X
        BfGL0MaM+xwIIg/DTMGEQ9zqBt2R0GHh2LvHYlItZBX5ujIdyCfoxhTH+8q0aKjH
        EWq69fxbJv5UVdGbym3xRtOatEPqxs7qTVc/jJrShSZDW7jqETV/69DG0L25oGnx
        RGEteF6uNb7UAOurwaqfi6Z6acMM5fWo23iFlnUps9+9uQiz86JYpIi9ztnNU8LM
        9YS84ucBCq232Q==
X-ME-Sender: <xms:VxbBYOHhYdxl-MrL7aSvQxixDbmpmrCbbntAENmxJhHIVAsTHzXgJg>
    <xme:VxbBYPVu_2dlMIGFZIidi6mhsdxxrgXDGmNGg7EEY0BClXXvLJus1jZgPUi1BNOel
    avmwOywFXmzU2hUDjE>
X-ME-Received: <xmr:VxbBYIK0rnyVrdocBwPtx0iw9H2YkYFTcndB6kfs4iwKcC5aDv3uqBTjJWZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduuddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirhgvghcujfhurhhrvghllhcuoehgrhgvgheshhhurhhr
    vghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepueetvdeiffdugeegheduhedtudefle
    ejhedttdetvdetfefhveekueduleehtdefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:VxbBYIETS3UD5aGT-e3Jx53a1Y_9Y78JiF060StIKBIi-V1RSe65sQ>
    <xmx:VxbBYEX4rHmngbPIvYKJT0bqeB7GpuY4AhIUSy544p3iTtnWkYg3OQ>
    <xmx:VxbBYLNPNmziAJ2Z0gYZBz09gXCmWRJECYOUhjHJINfmYO-RRoNFrg>
    <xmx:VxbBYPetxsuxRfNVEX-au8W_2yDlCi74QrBefatXLJXRXgv4xpWPNg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 15:28:23 -0400 (EDT)
From:   Greg Hurrell <greg@hurrell.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Greg Hurrell <greg@hurrell.net>
Subject: [PATCH v2] gitweb: use HEAD as secondary sort key in git_get_heads_list()
Date:   Wed,  9 Jun 2021 21:28:06 +0200
Message-Id: <20210609192806.45406-1-greg@hurrell.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <xmqqpmwviinb.fsf@gitster.g>
References: <xmqqpmwviinb.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "heads" section on the gitweb summary page shows heads in
`-committerdate` order (ie. the most recently-modified ones at the
top), tie-breaking equal-dated refs using the implicit `refname` sort
fallback. This recency-based ordering appears in multiple places in the
UI, such as the project listing, the tags list, and even the
shortlog and log views.

Given two equal-dated refs, however, sorting the `HEAD` ref before
the non-`HEAD` ref provides more useful signal than merely sorting by
refname. For example, say we had "master" and "trunk" both pointing at
the same commit but "trunk" was `HEAD`, sorting "trunk" first helps
communicate its special status as the default branch that you'll check
out if you clone the repo.

Add `-HEAD` as a secondary sort key to the `git for-each-ref` call
in `git_get_heads_list()` to provide the desired behavior. The most
recently committed refs will appear first, but `HEAD`-ness will be used
as a tie-breaker. Note that `refname` is the implicit fallback sort key,
which means that two same-dated non-`HEAD` refs will continue to be
sorted in lexicographical order, as they are today.

Signed-off-by: Greg Hurrell <greg@hurrell.net>
---

As per list discussion, this is an easier sell than the prior version
of this patch (which made `HEAD` the _primary_ sort key). I'm dropping
the RFC qualifier accordingly.

Sorry for the back-and-forth on this one. Using `HEAD` is the
tie-breaker is what I wanted to do originally, but because I was
testing on an ancient Git version with a sorting bug, the
straightforward approach didn't work (:facepalm:), and I went off into
the weeds.

 gitweb/gitweb.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e09e024a09..fbd1c20a23 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3796,7 +3796,8 @@ sub git_get_heads_list {
 	my @headslist;
 
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
-		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
+		($limit ? '--count='.($limit+1) : ()),
+		'--sort=-HEAD', '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
 		@patterns
 		or return;
-- 
2.29.2

