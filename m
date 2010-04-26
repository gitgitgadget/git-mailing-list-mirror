From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] t4201 (shortlog): Test output format with multiple
 authors
Date: Mon, 26 Apr 2010 04:59:00 -0500
Message-ID: <20100426095900.GC31483@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com>
 <20100426095206.GA31483@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 11:58:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6L4z-0005wx-Mp
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 11:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab0DZJ6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 05:58:10 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37056 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0DZJ6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 05:58:08 -0400
Received: by pxi17 with SMTP id 17so1509866pxi.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uZEpTybotElPUTtfnVuGoUWtfQGYaKtARRvkiHDc6HQ=;
        b=PVWBCK0J/dmEZZVxGqTqzIlLEL7YKPPRFVLeQFG7O0eN+9NuSW++sV6x8A67CVVb3Q
         005xr6J/mfoA64tE96AoJ5yE0fnQnUPkXNaKQn4gunYJ6n3bHUhEDzXXQygzZBMxvDPG
         EnvIXoTIajSsgXJP1kPN9uKEZ/CC5il2FQamM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OrnaQQoGw6gTYGGTW46C/g7yi+w+wrxdxnlE4J/nXuz5fWuIAs8UGNRTALJPm2p7yZ
         3qE5ddSBx3ek9Yut20uXdLfWaQg51t9+zc5UYC069icFb5I1h0+FACYCRLJHOpeDyK6+
         52TjMTqdLkINDvGRCop8/0HyAz6EWulip0jj0=
Received: by 10.141.106.8 with SMTP id i8mr3181686rvm.275.1272275888292;
        Mon, 26 Apr 2010 02:58:08 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm3018840iwn.13.2010.04.26.02.58.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 02:58:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426095206.GA31483@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145803>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This could be squashed with patch 1, if you like.

 t/t4201-shortlog.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 438a826..6bfd0c0 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -36,6 +36,10 @@ test_expect_success 'setup' '
 
 	echo 5 >a1 &&
 	git commit --quiet -m "a								12	34	56	78" a1
+
+	echo 6 >a1 &&
+	git commit --quiet -m "Commit by someone else" \
+		--author="Someone else <not!me>" a1
 '
 
 test_expect_success 'shortlog wrapping' '
@@ -51,6 +55,9 @@ A U Thor (5):
       a								12	34
          56	78
 
+Someone else (1):
+      Commit by someone else
+
 EOF
 	git shortlog -w HEAD >out &&
 	test_cmp expect out
-- 
1.7.1.3.g5f1e.dirty
