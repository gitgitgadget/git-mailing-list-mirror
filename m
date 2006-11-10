X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] FIX git pull failure with shallow clone changes
Date: Fri, 10 Nov 2006 11:57:10 +0530
Message-ID: <45541BBE.4070303@gmail.com>
References: <4552A865.5000201@gmail.com> <45541503.4020604@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030008090708000400020600"
NNTP-Posting-Date: Fri, 10 Nov 2006 06:27:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type;
        b=MvtlGJqK85sCQZS52x1W0GOfQzZeP/k/i6Mivg17lAqCQ2664HnePxATwxP+yhmSJF1Dr5aOPAi3iPZTcoAh4lIc/LBIgBAbdq4EQ4lR3OVPuRg3b+Mt5UkAzuPnr21eAQ2ei3e0UTrxEHQQOw7Tjb5jdyXhMRX2ECVofhs0AI4=
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
In-Reply-To: <45541503.4020604@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31205>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiPrV-0002cI-Qv for gcvg-git@gmane.org; Fri, 10 Nov
 2006 07:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424369AbWKJG1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 10 Nov 2006
 01:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966099AbWKJG1Y
 (ORCPT <rfc822;git-outgoing>); Fri, 10 Nov 2006 01:27:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:28518 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966097AbWKJG1X
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2006 01:27:23 -0500
Received: by ug-out-1314.google.com with SMTP id m3so445194ugc for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 22:27:21 -0800 (PST)
Received: by 10.78.21.7 with SMTP id 7mr2194919huu.1163140041491; Thu, 09 Nov
 2006 22:27:21 -0800 (PST)
Received: from ?217.156.218.183? ( [156.153.255.234]) by mx.google.com with
 ESMTP id 30sm2565724hub.2006.11.09.22.27.19; Thu, 09 Nov 2006 22:27:21 -0800
 (PST)
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------030008090708000400020600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------030008090708000400020600
Content-Type: text/plain;
 name*0="0001-I-was-using-the-pu-branch-i-tried-to-update-the-git-reposit";
 name*1="ory-and-i.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-I-was-using-the-pu-branch-i-tried-to-update-the-git-rep";
 filename*1="ository-and-i.txt"

I was using the pu branch i tried to update the git repository and i
got this error.

walk 9e950efa20dc8037c27509666cba6999da9368e8
walk 3b6a792f6ace33584897d1af08630c9acc0ce221
* refs/heads/origin: fast forward to branch 'master' of
http://repo.or.cz/r/linux-2.6
old..new: 3d42488..088406b
Auto-following refs/tags/v2.6.19-rc5
shallow clone with http not supported

This repository was not cloned with -depth. I only updated the git
tools using the pu branch

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 git-fetch.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 8b46e73..14ba4b2 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -314,9 +314,9 @@ fetch_main () {
 	      noepsv_opt="--disable-epsv"
 	  fi
 	  max_depth=5
-	  depth=0
+	  cur_depth=0
 	  head="ref: $remote_name"
-	  while (expr "z$head" : "zref:" && expr $depth \< $max_depth) >/dev/null
+	  while (expr "z$head" : "zref:" && expr $cur_depth \< $max_depth) >/dev/null
 	  do
 	    remote_name_quoted=$(@@PERL@@ -e '
 	      my $u = $ARGV[0];
@@ -325,7 +325,7 @@ fetch_main () {
 	      print "$u";
 	  ' "$head")
 	    head=$(curl -nsfL $curl_extra_args $noepsv_opt "$remote/$remote_name_quoted")
-	    depth=$( expr \( $depth + 1 \) )
+	    cur_depth=$( expr \( $cur_depth + 1 \) )
 	  done
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
 	      die "Failed to fetch $remote_name from $remote"
-- 
1.4.4.rc1.g368c-dirty


