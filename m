Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D551F404
	for <e@80x24.org>; Wed, 18 Apr 2018 14:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbeDROFF (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 10:05:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbeDROFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 10:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oIeqDwvLLagf0I4mmfFKKRHNu3PjlPJvp0EA1sI7frs=; b=A8yNfEQ/o23eGCbvlyKpDet3xk
        V/j7L196dtrb+m19KL1ENBpBwMksSBSvb4iNp+rAIqBr3NteReVQzkrkEaNxHbfdUMNDseM3h1vOU
        KNCbIEaKenmkq3JRLp8zObRXyHoIquDh2jODXMROt3yPdOlUVt0ASfgDluB4BYV8K1owVVdKE13ES
        Q0gk7hgqpDkCDYLt/erp8RSk59ngtoBiBt/XLZksxPvlH2LnHLYHMiBtO1N8m7iVp3kxBM0VLrO/Z
        RK8vXh8AFh3Do0vbodARWrq+AApbX/s9RKAmuj1QF3Y0JZDbQJErkF6Qer45P/Mfb7c4qjFxqcO/6
        W73X4EZQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1f8nhn-0004xZ-NA; Wed, 18 Apr 2018 14:05:03 +0000
Date:   Wed, 18 Apr 2018 07:05:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     git@vger.kernel.org
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] git-send-email: Cc more people
Message-ID: <20180418140503.GD27475@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Several of my colleagues (and myself) have expressed surprise and
annoyance that git-send-email doesn't automatically pick up people who
are listed in patches as Reported-by: or Reviewed-by: or ... many other
tags that would seem (to us) to indicate that person might be interested.
This patch to git-send-email tries to pick up all Foo-by: tags.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

diff --git a/git-send-email.perl b/git-send-email.perl
index 2fa7818ca..926815329 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1665,7 +1665,7 @@ foreach my $t (@files) {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^(Signed-off-by|Cc): (.*)/i) {
+		if (/^([A-Z-a-z]*-by|Cc): (.*)/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			# strip garbage for the address we'll use:

