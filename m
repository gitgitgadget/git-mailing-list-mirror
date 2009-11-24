From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/2] remote-curl.c: fix rpc_out()
Date: Tue, 24 Nov 2009 09:55:08 +0800
Message-ID: <20091124095508.d6312ab0.rctay89@gmail.com>
References: <20091124095021.93942a56.rctay89@gmail.com>,
 <20091124094810.797341d4.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 02:55:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCkcl-0001b4-HR
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 02:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503AbZKXBzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 20:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbZKXBzL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 20:55:11 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:43197 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbZKXBzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 20:55:10 -0500
Received: by yxe17 with SMTP id 17so5289930yxe.33
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 17:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=+hFu/gUbmCJrp9v+vzRzHELwjMyL1u/HzPt6m9BbUdw=;
        b=lW/UsjUlMzSVvVqJRiTcs5nJ8Eo6FGMIZTmdqyQoFbX0dMVeJxv3pxO8uH2WPkP7M5
         yrgRZ/v4W11wpBY345A9WlvlE7PWzMqj7ykgi3O04949BPQD19+DFvDYKP+McnuiOPre
         mQjujY2BMRagFeolnf1A1uAiIvSzXaPuKToP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=gJHtGFSAAxpkhzxen+d/8Z5K0RNS1HnsKW5IkodqjYDs9ZnSpupoDDGscc1rrUqPSB
         Ro+JEop/8YAAH3J3BM3pQTJzH3R274aEJezlactLTFMT4Iu3bLOlo0II5v/SAAx1Cz9k
         zHzTERDVHunMtVZyVJKNI6yHhrmc1ghracnsk=
Received: by 10.151.5.1 with SMTP id h1mr9990028ybi.27.1259027716046;
        Mon, 23 Nov 2009 17:55:16 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id 8sm1692079ywg.19.2009.11.23.17.55.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 17:55:15 -0800 (PST)
In-Reply-To: <20091124095021.93942a56.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133555>

Remove the extraneous semicolon (';') at the end of the if statement,
that prevented code in its block from executing.

This fixes pushing to a smart http backend with chunked encoding.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 remote-curl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 69eaf58..a331bae 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -307,7 +307,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 		rpc->len = avail;
 	}

-	if (max < avail);
+	if (max < avail)
 		avail = max;
 	memcpy(ptr, rpc->buf + rpc->pos, avail);
 	rpc->pos += avail;
--
1.6.4.4
