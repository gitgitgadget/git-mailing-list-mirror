From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/8] bundle_create: Do not exit when given no revs to bundle
Date: Sat, 26 Jun 2010 01:31:58 -0500
Message-ID: <20100626063158.GI15881@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, 554682@bugs.debian.org,
	Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 08:32:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOw3-0001gK-Jp
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 08:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0FZGcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 02:32:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47886 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0FZGcK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 02:32:10 -0400
Received: by iwn41 with SMTP id 41so2716281iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 23:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tSao5lA9QFCA95hxK45ef4qSOrVU4BTy8j9nIo4Rgn0=;
        b=XaeEkD0rGu0dGNI0xV1JgACawjFPtFMSCsAMGJ5tyQNnjMAf99NOrkceP7b/loPgnm
         2dPG1i053sYGwDj/5NaNUDHoz20t4x48zoCrTDlcmmIZ0m+SvcliDMJR2AgfO3moX2EK
         cBsW7WmoEPry3yj9YEf4ciLdZus3CRuIp3txo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IGeBXz2iia3nKFauQRrabXVcdAW+HqjActw2UPIsYxb5NYn3QPMiX3jJN94wIIIPHJ
         wzXOOnBA/oc3lrAIaFHsyMDUeIWBOTFGwec1ns6ycFHkt49P+9jHSex4OqBpSj3LyD5p
         X/8K6+ZAl8zmE42XxxH1hmrnJuYhCmBPMgAyE=
Received: by 10.231.176.74 with SMTP id bd10mr1863547ibb.38.1277533929986;
        Fri, 25 Jun 2010 23:32:09 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v23sm4341093ibp.15.2010.06.25.23.32.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 23:32:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626061735.GA15881@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149736>

Return an error instead to help with the libification effort.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That=E2=80=99s the end of the series.  Thanks for reading.

I was a bit torn about whether to present this as a request for
comment or a patch series ready for application.  On one hand it fixes
a bug; on the other hand, I have very little confidence that it works
well in the presence of arbitrary rev-list options.  Thoughts and
testing would be very welcome.

Good night,
Jonathan

 bundle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bundle.c b/bundle.c
index 7aff369..7dd3f65 100644
--- a/bundle.c
+++ b/bundle.c
@@ -349,7 +349,7 @@ static int bundle_list_refs(int bundle_fd, struct r=
ev_info *revs)
 		free(ref);
 	}
 	if (!ref_count)
-		die("Refusing to create empty bundle.");
+		return error("Refusing to create empty bundle.");
 	return 0;
 }
=20
--=20
1.7.1.198.g8d802
