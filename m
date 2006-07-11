From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: Re : 2 questions on git-send-email usage
Date: Tue, 11 Jul 2006 12:08:19 +0200
Message-ID: <44B37893.5090501@innova-card.com>
References: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 12:03:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0F5g-0008L4-8l
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 12:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWGKKDf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 06:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWGKKDf
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 06:03:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:32556 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750907AbWGKKDe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 06:03:34 -0400
Received: by ug-out-1314.google.com with SMTP id a2so4244308ugf
        for <git@vger.kernel.org>; Tue, 11 Jul 2006 03:03:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=HXZu9gvwGiGfDw4mEdEoClUqLMbO7rf5xWHWJTQD3hD0WR6+aJA/1/JusFKlX0R/CqO3gznJALfg2jtuQroE8T48DQ80vJOewZ5g8eJp32+akNPMEf6Ir3NdFqCMKX6/isqS7NeCXUV4x4yqCdHSFWlo7zk6wr7WFDu+dDEFWt4=
Received: by 10.66.220.17 with SMTP id s17mr834011ugg;
        Tue, 11 Jul 2006 03:03:33 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id h1sm4071978ugf.2006.07.11.03.03.28;
        Tue, 11 Jul 2006 03:03:32 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: moreau francis <francis_moreau2000@yahoo.fr>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23701>

moreau francis wrote:
> 2 RETs is missing. One after the Subject line and the other before the 
> Signed-off-by line. If I add the first missing RET, all works fine.  I guess
> it's missing because of git-cherry-pick command. But I don't understand
> why the last RET is missing
> 
> Can anybody tell me why ?
> 

Maybe that patch does what you want.

-- >8 --

Subject: [PATCH] Add a newline before appending "Signed-off-by:"

It looks nicer.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 log-tree.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index ebb49f2..2551a3f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -19,7 +19,7 @@ static int append_signoff(char *buf, int
 	char *cp = buf;
 
 	/* Do we have enough space to add it? */
-	if (buf_sz - at <= strlen(signed_off_by) + signoff_len + 2)
+	if (buf_sz - at <= strlen(signed_off_by) + signoff_len + 3)
 		return at;
 
 	/* First see if we already have the sign-off by the signer */
@@ -34,6 +34,7 @@ static int append_signoff(char *buf, int
 			return at; /* we already have him */
 	}
 
+	buf[at++] = '\n';
 	strcpy(buf + at, signed_off_by);
 	at += strlen(signed_off_by);
 	strcpy(buf + at, signoff);
-- 
1.4.1.g35c6-dirty
