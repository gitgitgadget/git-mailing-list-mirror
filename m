Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71DD41F935
	for <e@80x24.org>; Sat, 24 Sep 2016 22:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965367AbcIXWdB (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 18:33:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38579 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751485AbcIXWdA (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Sep 2016 18:33:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DF9920395;
        Sat, 24 Sep 2016 18:32:59 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Sat, 24 Sep 2016 18:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        cc:date:from:in-reply-to:message-id:references:subject:to
        :x-sasl-enc:x-sasl-enc; s=mesmtp; bh=qZv88fZYLvgfDgE10BQZ0TSlw3E
        =; b=FxAGM6IOB59m7KxyumrMdgtwn5Dv4LQ6wrxv0k4PuA/eOiPaU5hr6jdc8I3
        PpUXQx7EripN67ISs7MwicP8tU63CJmx68IEpt4Gikj9pVxh3NcOC7QUqq73bqbI
        rojabAKCZ98lt2MqKonsKTRThSxd2y98inLRYnwISBYcmLSc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=qZv8
        8fZYLvgfDgE10BQZ0TSlw3E=; b=bQGJPCsl9kWhOgTdyuD5PT2vOY1Z9lckHhhr
        xnj3mDFtaYO35OpBdolcPXY4bzyNjUY/8cKLXjXT+Q84u53vbnTds2Zg9BqK73UM
        6NNEY01R8OvLXtPEIv9zrvqcJ3ADZBL6H7jeK7l9oRPIu8YbD4ZRW075Y99bDUo2
        VzHdWYE=
X-Sasl-enc: w0LiojtDqyVb5BdIdQ1V3DudPQN0Jr+88o46Ys95o4Dt 1474756378
Received: from treetowl.lan (c-73-53-70-213.hsd1.wa.comcast.net [73.53.70.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC1C5CCEAD;
        Sat, 24 Sep 2016 18:32:58 -0400 (EDT)
Received: by treetowl.lan (Postfix, from userid 1000)
        id 0C5511C4E42; Sat, 24 Sep 2016 15:32:58 -0700 (PDT)
From:   Ian Kelling <ian@iankelling.org>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com
Subject: [PATCH v4 1/2] gitweb: remove unused guess_file_syntax() parameter
Date:   Sat, 24 Sep 2016 15:32:57 -0700
Message-Id: <20160924223258.9449-1-ian@iankelling.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160923090846.3086-2-ian@iankelling.org>
References: <20160923090846.3086-2-ian@iankelling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ian Kelling <ian@iankelling.org>
---

Notes:
    The only change from v3 is a more descriptive commit message

 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 33d701d..6cb4280 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3913,7 +3913,7 @@ sub blob_contenttype {
 # guess file syntax for syntax highlighting; return undef if no highlighting
 # the name of syntax can (in the future) depend on syntax highlighter used
 sub guess_file_syntax {
-	my ($highlight, $mimetype, $file_name) = @_;
+	my ($highlight, $file_name) = @_;
 	return undef unless ($highlight && defined $file_name);
 	my $basename = basename($file_name, '.in');
 	return $highlight_basename{$basename}
@@ -7062,7 +7062,7 @@ sub git_blob {
 	$have_blame &&= ($mimetype =~ m!^text/!);
 
 	my $highlight = gitweb_check_feature('highlight');
-	my $syntax = guess_file_syntax($highlight, $mimetype, $file_name);
+	my $syntax = guess_file_syntax($highlight, $file_name);
 	$fd = run_highlighter($fd, $highlight, $syntax)
 		if $syntax;
 
-- 
2.9.3

