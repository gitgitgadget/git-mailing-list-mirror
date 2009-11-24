From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3] remote-curl.c: fix rpc_out()
Date: Tue, 24 Nov 2009 10:31:30 +0800
Message-ID: <20091124103130.e1bdf09f.rctay89@gmail.com>
References: <20091124095508.d6312ab0.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	paulfred <paul.fredrickson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 03:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NClC4-0004I8-0N
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 03:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbZKXCbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 21:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757507AbZKXCbe
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 21:31:34 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53181 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757410AbZKXCbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 21:31:34 -0500
Received: by yxe17 with SMTP id 17so5311822yxe.33
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 18:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=QNix701sQtNNj046bZBdjR07r4exARV7gLEDCNu8W/g=;
        b=jBCScaXMU+/udBhRILCkKhKnYqJirG9YOL0qDU4E8SbTJlOlDBBA5FbOqEzO0SJvQk
         wjvEJxGFbrV3SkYr8N0GNmX2lZSoMMRbrfTKa5M4+qEPg8T3+6rNfm8Qdjme20jTpu9T
         ruy/I4Xd98IbWZthh598+/0T4ZxCpM21BFPkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=JXWsFHp9CrwyyGqQHTVDzDeU2BvRC5CcyBKzHj+AFG7OBKeR8eybpTxY2AWHX01L4a
         gO0+XUYFV5YTpBpX9ElKwo0HI+AmTpRm2LqhRDJmkN06Yk3rrB3gLAlk8g3u30f12i2R
         jpfkSj0fFtQX4y3gxwArbosM/bMLnUm0NVOZQ=
Received: by 10.91.19.13 with SMTP id w13mr7413610agi.120.1259029900632;
        Mon, 23 Nov 2009 18:31:40 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id 4sm2186998yxd.52.2009.11.23.18.31.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 18:31:40 -0800 (PST)
In-Reply-To: <20091124095508.d6312ab0.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133556>

Remove the extraneous semicolon (';') at the end of the if statement
that allowed the code in its block to execute regardless of the
condition.

This fixes pushing to a smart http backend with chunked encoding.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Reworded the part on code execution, so that it doesn't say "the code
  doesn't execute", but rather "the code always executes".

  Thanks to Paul for spotting that.

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
