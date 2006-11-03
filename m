X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] gitweb: Remove extra "/" in path names for git_get_project_list
Date: Fri, 03 Nov 2006 10:41:45 +0530
Message-ID: <454ACF91.50601@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070902060209070505090401"
NNTP-Posting-Date: Fri, 3 Nov 2006 05:12:11 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=KULrCbcZz26yaZs7K/oKTP3zjtVIz+T4UGHeRwpRpHRUCbu4HNNNXbMocauvDdDRsEmwIIGIZgxPK8jjBl19wLDj6gqQjDEnXC/OA9BU0U953oR4vP1K4ayNTWGMcqrgTfhvbgGu/4GmU87fAXnF2MQBBjhsVNOb3gw28xoe/30=
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30784>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfrLb-0005E2-EO for gcvg-git@gmane.org; Fri, 03 Nov
 2006 06:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752635AbWKCFL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 00:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbWKCFL4
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 00:11:56 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:15665 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1752635AbWKCFLz
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 00:11:55 -0500
Received: by wx-out-0506.google.com with SMTP id s14so326191wxc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 21:11:54 -0800 (PST)
Received: by 10.70.69.11 with SMTP id r11mr2313899wxa.1162530714869; Thu, 02
 Nov 2006 21:11:54 -0800 (PST)
Received: from ?217.156.221.183? ( [156.153.255.234]) by mx.google.com with
 ESMTP id h18sm616183wxd.2006.11.02.21.11.53; Thu, 02 Nov 2006 21:11:54 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------070902060209070505090401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------070902060209070505090401
Content-Type: text/plain;
 name*0="0001-gitweb-Remove-extra-in-path-names-for-git_get_project_list.";
 name*1="txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-gitweb-Remove-extra-in-path-names-for-git_get_project_l";
 filename*1="ist.txt"


Without this change we get a wrong $pfxlen value and the check_export_ok()
checks with with a wrong directory name. Without this patch the below
$projects_list fails with gitweb

$projects_list = "/tmp/a/b/";

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 gitweb/gitweb.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7710cc2..a0a9aaf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -897,6 +897,8 @@ sub git_get_projects_list {
 	if (-d $projects_list) {
 		# search in directory
 		my $dir = $projects_list;
+		# remove the trailing "/"
+		$dir =~ s!/+$!!;
 		my $pfxlen = length("$dir");
 
 		File::Find::find({
-- 
1.4.3.3.gc954-dirty


