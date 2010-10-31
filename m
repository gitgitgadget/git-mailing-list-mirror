From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/10] t1400 (update-ref): use test_must_fail
Date: Sun, 31 Oct 2010 02:36:19 -0500
Message-ID: <20101031073619.GF11483@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
 <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 08:36:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSSx-0005Vr-AP
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167Ab0JaHgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:36:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62287 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab0JaHg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:36:29 -0400
Received: by gwj21 with SMTP id 21so2669932gwj.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qNeVVeH+bDFZL+/B2jP7kPxfsle4ps3pfx1CVkjZua4=;
        b=fIjHl03kqlF6e+m4G3FZU2Xbm6w5wgiH06EFEt/HzUNYOXZ2UUdK3GolwQEMRyvD5R
         tQGVLEidYH/bMw55yzWLwGmrIFlpCS1VfjRD8Gowr+U/KeEpw8fsH3jCDFfT294dZidv
         bIr9EvMdyWGQu9PVkkxHivR4y32XJqM4Chbc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bl+Hbv7Kr7gabVki34tL7TaO+QttgHEmFbn2T2NEGoB8C4ncZxC7JafStlFt3YNRzB
         RuDt0589I9fnYA4/5A+uz/JP7SACUhc+DKZF8lnX93zW1fKlbXk3PilwhXAXyH3RQ8J0
         qKXDPl1bAa/SVQ22UdecP82TM7ODNMapSnzQE=
Received: by 10.150.11.16 with SMTP id 16mr25986225ybk.299.1288510589142;
        Sun, 31 Oct 2010 00:36:29 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id 50sm3803993yhl.41.2010.10.31.00.36.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:36:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031072640.GA11483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160424>

As t/README explains:

	When a gitcommand dies due to a segfault, test_must_fail
	diagnoses it as an error; "! git <command>" treats it as
	just another expected failure, which would let such a bug
	go unnoticed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1400-update-ref.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d17551e..ff747f8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -52,9 +52,8 @@ rm -f .git/$m
 
 test_expect_success \
 	"fail to create $n" \
-	"touch .git/$n_dir
-	 git update-ref $n $A >out 2>err"'
-	 test $? != 0'
+	"touch .git/$n_dir &&
+	 test_must_fail git update-ref $n $A >out 2>err"
 rm -f .git/$n_dir out err
 
 test_expect_success \
-- 
1.7.2.3.557.gab647.dirty
