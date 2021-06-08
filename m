Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43B8C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 21:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C7561375
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 21:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhFHVR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:17:29 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34279 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhFHVR2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Jun 2021 17:17:28 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DAC8A5C0085;
        Tue,  8 Jun 2021 17:15:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 08 Jun 2021 17:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=nLuBs/rUxNZ6Y
        wMfDlpy6fS8ea8IB0FuHpmyD5MNjFg=; b=nGkNJMshy/AdKVhZHHiwvBwrCigQy
        akgDS3JaikZeov3B3VnoOAuv8X23yw3Ooiw4sh4vp4bxB5Ug+7j+0r5mTRyzzA5D
        4ZK/UpI874bkLWPo3Gq0tQ6wlU81O3amTl1pJcyyDKAKl7ozOIGJRmnWDWYOi7Hg
        M3bDzQrM6uTWucFDgEQ2zkl7n5WmOS80woPrK1Xy7w7oljeiP0Alf8rXtKb7VZVb
        DIvpJ5WOe1eFa34TiHSbmepqorKjkRQTb1wJNe8GZSeq089mC7PSymzSPL+5irqw
        9tQedARmDrBvhZUXUyOlUpCtk6879Zr1tVri+CSWUHqzmzORM3CwpVnBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=nLuBs/rUxNZ6YwMfDlpy6fS8ea8IB0FuHpmyD5MNjFg=; b=CwumzmpX
        MgJI0iKpo9G5HJvnoEgE7VHVHfNqwk28vxWKEo1s2zDpOPdMVKYmnyGD77tkE8IR
        1Ptj3HeBiyZtr26IIFONMgeovKfgFiHhZblQQEGDl5DRjZkUmXrzw2Y8eewXaMCc
        5G6o/Ke+0icdBBIRURu3GVjqSLowrlJSSbXYENPrxH5WIrBlDIP2C+yYaj9s69Ja
        ee7iYqx6CRbFohkGVUrWMJYlHWBFTl2XU3Qlh7Hs9+UtkDVjlMY2BqnoGZN6K/l+
        sxlBvT/0qn5xbZ2BCk1aftgpGhycSbkQ8WxlMyJckmWZw3gU+gsaqC7cTXDr9ezS
        +o7XkFE1ZuyN5Q==
X-ME-Sender: <xms:9t2_YK7hvl3Z7uhinQqKy8Nr4pLG29hXBw4klhHnS5Nw7GlzY9Mqrg>
    <xme:9t2_YD6HZqHq02wmNXPBpAPiyiLAfFtR9odVm4K0vVr5IYZz8R_xzdXIbTcxQVWgX
    rzkTv8jp__hw0Fer-E>
X-ME-Received: <xmr:9t2_YJehsT5W230fMunJ_iL1-BQOewePKmzX1hrHlux1hk_t1rf1NUGrVNMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtledgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirhgvghcujfhurhhrvghllhcuoehgrhgvgheshhhurhhr
    vghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepueetvdeiffdugeegheduhedtudefle
    ejhedttdetvdetfefhveekueduleehtdefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:9t2_YHLj5naT8ojm8EedG98tb9LCZdXW7uCU96etVkH6irXlAfdn_A>
    <xmx:9t2_YOIHA9bsemo1KqZykv7bwex6GKfd2uBg4vFkwKrGYaM7h4LenA>
    <xmx:9t2_YIwDnplVsdiPWEmM90UhOChCXfEOHhu8M0N9UrcF-Qi2BmKiew>
    <xmx:9t2_YIy6YrToQRfqfaVhp8r9oXivizJ5bts3mmk3x3UjkYfkxsxVdQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jun 2021 17:15:33 -0400 (EDT)
From:   Greg Hurrell <greg@hurrell.net>
To:     git@vger.kernel.org
Cc:     Greg Hurrell <greg@hurrell.net>
Subject: Re: [RFC PATCH] gitweb: use HEAD as primary sort key in git_get_heads_list()
Date:   Tue,  8 Jun 2021 23:14:40 +0200
Message-Id: <20210608211440.37985-1-greg@hurrell.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <f04ffea4-ff37-432a-a0c6-abe11721060b@www.fastmail.com>
References: <f04ffea4-ff37-432a-a0c6-abe11721060b@www.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to this commit, the "heads" section on a gitweb summary page would
list the heads in `-committerdate` order (ie. the most recently-modified
ones at the top), tie-breaking equal-dated refs using the implicit
`refname` sort fallback.

This commit adds another `--sort` parameter to the `git for-each-ref`
invocation in `git_get_heads_list()`, ensuring that the `HEAD` ref
always ends up getting sorted to the top, seeing as it is typically the
"primary" line of development in some sense.

This seems to be a useful change, because I can't see anywhere else in
the gitweb UI where we actually indicate to the user what the "default"
branch is (ie. what they'll checkout if they run `git clone`).

Signed-off-by: Greg Hurrell <greg@hurrell.net>
---

On Tue, Jun 8, 2021, at 11:02 AM, Greg Hurrell wrote:
> On Tue, Jun 8, 2021, at 10:34 AM, Jeff King wrote:
> >   1. break ties by name, like:
> > 
> >        git for-each-ref --sort=refname --sort=-committerdate
> > 
> >   2. emphasize the HEAD branch, even if it isn't the newest:
> > 
> >        git for-each-ref --sort=refname --sort=-committerdate --sort=-HEAD

I was wracking my brains over this one trying to figure out why
it wasn't already doing the right thing based on what I see in
ref-filter.c.  It sure looks like the `--sort=refname` fallback should
be automatic, but I wasn't seeing it happen in my gitweb instance.

Turns out there was a bug that you fixed in 7c5045fc180ed09ed4cb5 which
made it in soon after v2.20.4 fixing a problem. I was seeing different
behavior on gitweb running on Amazon Linux AMI, because that's still
using Git v2.18.5.

So, that means "1" isn't necessary. "2" is the only possibly interesting
bit. I've reworded the commit text accordingly, still labeled as "RFC"
to see if there is any consensus on this being a good idea or not.

Greg

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

