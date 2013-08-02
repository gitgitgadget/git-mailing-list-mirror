From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] hooks/post-receive-email: set declared encoding to utf-8
Date: Fri, 2 Aug 2013 16:24:17 -0700
Message-ID: <20130802232417.GE2963@elie.Belkin>
References: <20130802232118.GB2963@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Shumkin <alex.crezoff@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Alexander Gerasiov <gq@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 01:24:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Ohu-0003zl-7Q
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 01:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550Ab3HBXYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 19:24:22 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:44697 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab3HBXYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 19:24:22 -0400
Received: by mail-pd0-f175.google.com with SMTP id 5so1153798pdd.20
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=L6qCZURPvDgnCN6oygfAI1S1iBEvl1ouaGhQ7rt0xt0=;
        b=QWUp9NEQm4xdFQ/mNk+0M2Lj4ykNt2WT79r9VUK86CQrAb9D1NeFOLi0aVtjfTt13q
         tcGQUpfKXZGThroCCQCzbL0/2e4kO0Aw6L5jowqdP2TisKQWMdyZYMERoD1WWxUZYB9f
         VE9lCBX9x3YlB8t3o4c/am1I2CkZHlBjxVo62z/YmxcqVorB/u/FcX4skmQvRD8qlSn/
         Ok1bP35jyMJuvOaR0miHie2NrMJa9rcI2gd9ZGQuWSOdG0Q5Nw8SidUqKdzvToQj5tPi
         gxtAVtmFUkr1oKWfpSOHuB7578UndGlzUQFBCYNMPHoxtRS3L1ihNZLDV5B86CU/Nr6C
         tRvA==
X-Received: by 10.66.25.102 with SMTP id b6mr12667670pag.129.1375485861558;
        Fri, 02 Aug 2013 16:24:21 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id oe6sm9577548pbb.20.2013.08.02.16.24.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 16:24:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130802232118.GB2963@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231547>

From: Gerrit Pape <pape@smarden.org>
Date: Thu, 11 Dec 2008 20:27:21 +0000

Some email clients (e.g., claws-mail) display the message body
incorrectly when the charset is not defined explicitly in a
Content-Type header.  "git log" generates logs in UTF-8 encoding by
default, so add a Content-Type header declaring that encoding to
the emails the post-receive-email example hook sends.

[jn: also setting the Content-Transfer-Encoding so MTAs know what
 kind of mangling might be needed when sending to a non 8-bit clean
 SMTP host]

Requested-by: Alexander Gerasiov <gq@debian.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.

 contrib/hooks/post-receive-email | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index ba93a0d8..8ee410f8 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -242,6 +242,9 @@ generate_email_header()
 	cat <<-EOF
 	To: $recipients
 	Subject: ${emailprefix}$projectdesc $refname_type $short_refname ${change_type}d. $describe
+	MIME-Version: 1.0
+	Content-Type: text/plain; charset=utf-8
+	Content-Transfer-Encoding: 8bit
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
-- 
1.8.4.rc1
