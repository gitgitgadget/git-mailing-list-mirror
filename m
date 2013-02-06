From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCH 1/4] Git.pm: Allow command_close_bidi_pipe() to be called as method
Date: Wed,  6 Feb 2013 21:47:03 +0100
Message-ID: <01fceaac7a7d961cc7e0355b9c3175e0ba68cd0f.1360183427.git.mina86@mina86.com>
References: <cover.1360183427.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:47:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3BuM-0005mO-DP
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758626Ab3BFUrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 15:47:22 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:37270 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758625Ab3BFUrV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:47:21 -0500
Received: by mail-ee0-f47.google.com with SMTP id e52so1014629eek.20
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 12:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=5z0p4pxjnKGadUYaPe3iPhb1MyqHqr17Wp7S8mKqt2c=;
        b=JSO8ZwyRPChfjX9mvvktKMhAFIz83aITJOSNutDBvBC+YI5s+ilAHtNibMxOWb6KCy
         dDIvJW311nDdUBNmdG1ot2aiUOkWI6zl6FhfE7MMxiqczJPbcnht6nozR89b3D+PStEH
         dWk1X7BSaZJ4T4dS192einFCptupIRzu725GYb4LYxvXiLp8XCgqb2R46p6fzlxQRoSv
         gnzQ4jrysjGfSPNfsly3uqUeEXG9BsoKWMmkFDEjWfOvW4E9Ppw6s9OdS8HPrNaVwSMx
         vcUN7TbxPsi8n4FQJhRSThJztHZNM96ki0/bi+HwJ4+DhQn9F3bWniwNQ1auu7oqXsYu
         DaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=5z0p4pxjnKGadUYaPe3iPhb1MyqHqr17Wp7S8mKqt2c=;
        b=nc8Te+h0zrXdeQL5uqhsLBiJ/7R7RT6kTgB/HaJT2sNy0RFuLLQi8N87ValOHNxvkn
         0XbEFDo4FieUFkBvrzG50XqWFXhYzSSpM0gEC+J7o25oTUGhJFG75YN/IB+5jv8/mjCO
         jpZ5/6F6lp5BJV2kbNLmSGifRmmA4wNwN9cFp7GAf4XcrRvQWFcGpRICWf+bAu1dcnJR
         KcsFSeXmZcnzKxWmr9i6P2DY4pq/NOEz/D71NHgGrqlwOspL7zDy3xw0jgogjqX5pjgD
         aellNwfzceM2Xoha9qybRlvgKN7UgTgTYkslWK+pv9x73jCutvNfStsSMY7I5LekzKEc
         v4Nw==
X-Received: by 10.14.225.133 with SMTP id z5mr102612786eep.15.1360183639944;
        Wed, 06 Feb 2013 12:47:19 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:e809:df2d:46af:f661])
        by mx.google.com with ESMTPS id z5sm294639eep.16.2013.02.06.12.47.18
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 12:47:19 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.549.g1d13f9f
In-Reply-To: <cover.1360183427.git.mina86@mina86.com>
In-Reply-To: <cover.1360183427.git.mina86@mina86.com>
References: <cover.1360183427.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQnw+9Cfjrn1Wh2RSkSmYFZixBEBzQq/3pGqGwLsP5Guiip7lTL/iH3Yzwb51XQFLfiI7luE+tzHsWnQkJSl+wOMVrbVc7ijcjsi7oOrwKcxXgHI1i7c6/POUy2aPXNeFO3cZxjpcyH3x6ItPVXU7HGv3QPXvxsFkDLDSmR4L1TH54MYyveIcp8Q5ijwfypWGNBIsCJc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215640>

From: Michal Nazarewicz <mina86@mina86.com>

The documentation of command_close_bidi_pipe() claims that it can
be called as a method, but it does not check whether the first
argument is $self or not assuming the latter.  Using _maybe_self()
fixes this.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 931047c..bbb753a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -430,7 +430,7 @@ have more complicated structure.
 
 sub command_close_bidi_pipe {
 	local $?;
-	my ($pid, $in, $out, $ctx) = @_;
+	my ($self, $pid, $in, $out, $ctx) = _maybe_self(@_);
 	foreach my $fh ($in, $out) {
 		unless (close $fh) {
 			if ($!) {
-- 
1.8.1.2.549.g4fa355e
