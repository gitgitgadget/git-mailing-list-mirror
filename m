From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v4 4/8] imap-send: fix compilation-error on Windows
Date: Mon, 19 Oct 2009 17:42:05 +0200
Message-ID: <1255966929-1280-5-git-send-email-kusmabite@gmail.com>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com> <1255966929-1280-2-git-send-email-kusmabite@gmail.com> <1255966929-1280-3-git-send-email-kusmabite@gmail.com> <1255966929-1280-4-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Oct 19 17:43:50 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f162.google.com ([209.85.221.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuOV-0006N3-E7
	for gcvm-msysgit@m.gmane.org; Mon, 19 Oct 2009 17:43:35 +0200
Received: by mail-qy0-f162.google.com with SMTP id 34so3506781qyk.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 Oct 2009 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=nvcFTYpiySfOj1DI9izB493/3b4oro3wO2XolxRA3GU=;
        b=akxI+IAs/acY4bEdjylQ5/3ysrdp14LUq787C2jblsJKF6V4b6N+/6xrOqgTxZvZfZ
         /w1xoG93G4GfVE8hIQoiTpWlSDWeAW7NA5mb2Ka1epr+swRrpANmxYeZw7x+ESQx2o9e
         DrKhIpMkWCFHuvgRbrGEyHSm7VO8RH0nauO8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=5Y47dCQbp5dSaGJfNnuiBKBzLCUv+Kf/gwLmfnpRZaq1Nyf6roHnGeTl2nqmLn8ecm
         xo98u1P9glKGCzpogYVUx9CQX4rNTzT24JE48IeRdbrTJi/GFf/VdAI+/ixmsuh0KXGy
         odGXsukj3iYYh8rBxucg/N0NdskdC71iRYBnM=
Received: by 10.229.78.8 with SMTP id i8mr252820qck.8.1255967008583;
        Mon, 19 Oct 2009 08:43:28 -0700 (PDT)
Received: by 10.177.105.17 with SMTP id h17gr7450yqm.0;
	Mon, 19 Oct 2009 08:43:22 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.32.6 with SMTP id f6mr450270ebf.11.1255967001734; Mon, 19 Oct 2009 08:43:21 -0700 (PDT)
Received: by 10.210.32.6 with SMTP id f6mr450269ebf.11.1255967001706; Mon, 19 Oct 2009 08:43:21 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150]) by gmr-mx.google.com with ESMTP id 13si928510ewy.6.2009.10.19.08.43.20; Mon, 19 Oct 2009 08:43:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.150 as permitted sender) client-ip=74.125.78.150;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.150 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ey-out-1920.google.com with SMTP id 26so637939eyw.22 for <msysgit@googlegroups.com>; Mon, 19 Oct 2009 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=QfRXhxDNqJORAoazW6BPjxuDNSnNVPXfdGCY9fr/K4g=; b=NjfkILqmKRst5sEVWHwPDtq0+ir8XVesL12Y27sFUVmpTZHC5ZZ9SMs5XDHI+nnZbI rhEmkK3HTu2ncVx/5nZm5K3aDly/PoaGsS5LbojRi/iLwZ00tT1o89SOW17qAUu2X/CU Gtt396Jh5NhcDXhskP//ziLLVjoqjTQuWsTcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=lMmzniZSIOo2iA/LofQP6Evgq95eb5t2Qpl1MF3RjzOVqk0yQOQqllDMOaPvpkuHlX YndlGe4AgsMYeQHwhQvbK+7CehYnP1YW4orG5ODQWhxfcvkFCjjFhasoYwLU38Dvf7/C jYQspBfv4IoRYHtbf8ptIr++4FS/hm6/m1TGg=
Received: by 10.211.146.5 with SMTP id y5mr5730792ebn.41.1255967000546; Mon, 19 Oct 2009 08:43:20 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 23sm357880eya.4.2009.10.19.08.43.19 (version=TLSv1/SSLv3 cipher=RC4-MD5); Mon, 19 Oct 2009 08:43:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255966929-1280-4-git-send-email-kusmabite@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130706>


mmsystem.h (included from windows.h) defines DRV_OK to 1. To avoid
an error due to DRV_OK redefenition, this patch undefines the old
definition (i.e the one from mmsystem.h) before defining DRV_OK.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 72ed640..69e6142 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -94,6 +94,7 @@ struct msg_data {
 	unsigned int crlf:1;
 };
 
+#undef DRV_OK
 #define DRV_OK          0
 #define DRV_MSG_BAD     -1
 #define DRV_BOX_BAD     -2
-- 
1.6.5.15.g5f078
