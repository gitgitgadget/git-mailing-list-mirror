X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Kir Kolyshkin <kir@openvz.org>
Subject: [PATCH] gitweb: make HTML links out of http/https URLs in changelogs
Date: Tue, 21 Nov 2006 23:02:36 +0100
Message-ID: <4563777C.4050108@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 22:03:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0rc6 (sacred.ru [62.205.161.221]); Wed, 22 Nov 2006 01:00:05 +0300 (MSK)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32043>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmdhS-0002Wn-MF for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031166AbWKUWCh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 17:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031223AbWKUWCh
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:02:37 -0500
Received: from [62.205.161.221] ([62.205.161.221]:28557 "EHLO sacred.ru") by
 vger.kernel.org with ESMTP id S1031166AbWKUWCf (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 17:02:35 -0500
Received: from [10.1.11.22] (darnet.ru [213.152.157.70] (may be forged))
 (authenticated bits=0) by sacred.ru (8.13.7/8.13.7) with ESMTP id
 kALM04jl022318 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO) for <git@vger.kernel.org>; Wed, 22 Nov 2006 01:00:05 +0300
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

It is a common practice to put links to bugzillas, mailing lists, etc. 
in git log entries. The fact that gitweb doesn't make HTML links out of 
that URLs makes following those URLs inconvenient. This patch fixes that 
problem, trying to address cases when URL is enclosed in round or square 
brackets.

Slightly tested on http://git.openvz.org/. Applicable to git-1.4.4.

Signed-off-by: Kir Kolyshkin <kir@openvz.org>
---
 gitweb/gitweb.perl |    2 ++
 1 file changed, 2 insertions(+)

--- git-1.4.4/gitweb/gitweb.perl	2006-11-15 08:22:27.000000000 +0100
+++ git-1.4.4-my/gitweb/gitweb.perl	2006-11-21 22:49:14.000000000 +0100
@@ -828,6 +828,8 @@
 			$line =~ s/$hash_text/$link/;
 		}
 	}
+	# make HTML links out of http(s) URLs
+	$line =~ s/(http[s]?:\/\/[^[:space:]\]\)]+)/<a href="\1">\1<\/a>/g;
 	return $line;
 }
 

