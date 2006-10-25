X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: [PATCH] git-fetch.sh printed protocol fix
Date: Wed, 25 Oct 2006 12:03:06 +0200
Message-ID: <4ac8254d0610250303n60a6006bsa4d77aba7255485f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 10:03:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rhRzAjH5PTi2MfFt6P82QmXeBAGmlQI8D2DXdUKuPsOQRJZLfY9IpF/6lJsjYkr7EVPTGeaqnZkio7GvAgKERhU5qeerXf2Dl1zMfPvGC+/eOocSG3sIsIuY4xPeQIvNSoirSLzrWHRwYRXzFLlKm2BD4KPCizLrVXNHBrO+rMI=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30046>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcfbi-0004R4-Fm for gcvg-git@gmane.org; Wed, 25 Oct
 2006 12:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423179AbWJYKDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 06:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423180AbWJYKDP
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 06:03:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:58489 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423179AbWJYKDI
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 06:03:08 -0400
Received: by ug-out-1314.google.com with SMTP id 32so49424ugm for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 03:03:07 -0700 (PDT)
Received: by 10.78.204.1 with SMTP id b1mr151720hug; Wed, 25 Oct 2006
 03:03:06 -0700 (PDT)
Received: by 10.78.106.14 with HTTP; Wed, 25 Oct 2006 03:03:06 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

As a feature I wished for (ftp:// support in git-fetch) was added in 1.4.3
I tested that feature and found a minor logging issue. The mini-patch
below fixes that.  AFAIK the pattern expansion feature I've used should
be available in any current /bin/sh. If not we will have to find another
way to print the protocol part of the used fetch URL.

--- git-core-1.4.3.2/git-fetch.sh	2006-10-24 07:29:47.000000000 +0200
+++ git-core-1.4.3.2.tma/git-fetch.sh	2006-10-25 11:44:34.000000000 +0200
@@ -310,7 +310,7 @@
 	  done
  	  expr "z$head" : "z$_x40\$" >/dev/null ||
 	      die "Failed to fetch $remote_name from $remote"
-	  echo >&2 Fetching "$remote_name from $remote" using http
+	  echo >&2 Fetching "$remote_name from $remote" using ${remote%%:*}
 	  git-http-fetch -v -a "$head" "$remote/" || exit
 	  ;;
