From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: [PATCH] Make feed title valid utf8
Date: Sun, 27 Nov 2011 23:37:44 +0100
Message-ID: <CAKD0UuxFVtCRT+hqO5vkDRanaX3Gvwf9MAFqNUwAiFA+wEwxXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 23:39:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUnNd-0004pE-85
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 23:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab1K0WiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 17:38:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50341 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1K0WiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 17:38:07 -0500
Received: by wwp14 with SMTP id 14so7733058wwp.1
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 14:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=iuuNXJqhZrVz0bFMZfTxzv9zLykJT0bJZSx1M2LAb58=;
        b=hUTIFKynifYCShW+KlDCRxcBQx7Y2azPD7hyTIHLhM4awv1sMbCU7jNOR65YHAf/lC
         rkLjmrZzYJo8kyKhU9GhoZAQX/XtCWqJ4fb7u9A1la78XYg6Yh2LxiGTDYFTM0qZtPcy
         Q23E5J3QbEN1wGoKoJo7IA2mGDTbPq/g5BdUs=
Received: by 10.180.24.65 with SMTP id s1mr42393556wif.59.1322433485073; Sun,
 27 Nov 2011 14:38:05 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Sun, 27 Nov 2011 14:37:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185992>

gitweb doesn't properly handle UTF8 site names when generating feed titles.

Signed-off-by: Juergen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..a2838c3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7482,7 +7482,7 @@ sub git_feed {
 	return if ($cgi->request_method() eq 'HEAD');

 	# header variables
-	my $title = "$site_name - $project/$action";
+	my $title = to_utf8($site_name) . " - " . to_utf8($project) . "/$action";
 	my $feed_type = 'log';
 	if (defined $hash) {
 		$title .= " - '$hash'";
-- 
1.7.5.4
