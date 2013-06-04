From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 1/6] send-email: fix suppress-cc=self on cccmd
Date: Tue, 4 Jun 2013 10:56:02 +0300
Message-ID: <1370332482-12329-2-git-send-email-mst@redhat.com>
References: <1370332482-12329-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 09:55:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujm5j-0004Dk-PA
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 09:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760071Ab3FDHzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 03:55:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54742 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759930Ab3FDHzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 03:55:32 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r547tTCd022917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 4 Jun 2013 03:55:29 -0400
Received: from redhat.com (vpn-203-14.tlv.redhat.com [10.35.203.14])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r547tRIq024503;
	Tue, 4 Jun 2013 03:55:27 -0400
Content-Disposition: inline
In-Reply-To: <1370332482-12329-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226326>

When cccmd is used, old-style suppress-from filter
is applied by the newer suppress-cc=self isn't.
Fix this up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

This makes one line a bit too long, but a follow-up patch
fixes this up.

 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bd13cc8..f366baa 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1462,7 +1462,7 @@ sub recipients_cmd {
 		$address =~ s/^\s*//g;
 		$address =~ s/\s*$//g;
 		$address = sanitize_address($address);
-		next if ($address eq $sanitized_sender and $suppress_from);
+		next if ($address eq $sanitized_sender and $suppress_cc{'self'});
 		push @addresses, $address;
 		printf("($prefix) Adding %s: %s from: '%s'\n",
 		       $what, $address, $cmd) unless $quiet;
-- 
MST
