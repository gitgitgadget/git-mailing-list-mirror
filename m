From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] strbuf: Correct documentation for strbuf_read_once
Date: Thu,  5 Nov 2015 10:17:19 -0800
Message-ID: <1446747439-30349-3-git-send-email-sbeller@google.com>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, tboegi@web.de,
	j6t@kdbg.org, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 19:17:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuP6L-0004qf-65
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 19:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162310AbbKESR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 13:17:27 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35227 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162233AbbKESRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 13:17:25 -0500
Received: by pasz6 with SMTP id z6so97963213pas.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mx0GICHtuKQ397XvEzcty4I+x30WaekoDVRJ5WImcqY=;
        b=mOwbmpKG1G1+onV79rbd97YNuGsn1/eCWqvfYinJL7qCnQ65rHd7x6HVoVYbuvUvfO
         uzthuy8NpTBbhY8L/tJNag17j8rthHHS0K859NQl1EtFC9nDsxwTRamsv2jJInxck84u
         DDQO0sjaxWnT4YcTd+HyCHiq/OZyNoaPr7kYt23dISYgJVPhZxCnClbWiN8DJ5isRwk/
         JdgaYvTYXv8gSNwiKaXVhWjEQlOA8q123Sw5kwkDmMoKXYroHo2Sx+2mcthCksoubQde
         FQXhsLwFObjs+5gXQaEx6lA75OPzxn8DwCbvuN+KUiCbcoe3NEqZIM5dIrQbwKC6uScW
         zQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mx0GICHtuKQ397XvEzcty4I+x30WaekoDVRJ5WImcqY=;
        b=dTlr6VZWsARVB0V9USnPgd9i4IKCdXi4GjeHcGJ8OvEOS/IvjqcnOpOYGG1buy66Ha
         XFJPKQoBm1ws88OxSRp0Qpg30d4kLJXwiBu2oaT/ymcsOk5gFeDt/GEcYGcHTKrkYgij
         AaAIY1ZlE8quly9v+ZRZQUdtwmlvn7jjCRT1eQxI9dOIh168Vpg7sBXQFaV2fZzxqSwT
         LVXKQSmjlek+Q0ZMCwDrH1qcTPZ6/SLygnme5Cmfmoi8RE8/Xv0NHhmhbYp06AJ9E/7J
         nx4anCNO6dnf0crppT6uy+ktUU69miC3n57E2bWOcJ/HdfR8KTfqu8H4h8e9DZD3sMm9
         FFXw==
X-Gm-Message-State: ALoCoQnTJE2x0o33JkIHaAjxWksX6+X6LsgETKQpNHEYOVd0/IxMhsGXqAFXTY1Eknc95w7adUFb
X-Received: by 10.68.179.228 with SMTP id dj4mr11098085pbc.112.1446747444714;
        Thu, 05 Nov 2015 10:17:24 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8805:9922:277f:8125])
        by smtp.gmail.com with ESMTPSA id qf2sm9196236pbb.3.2015.11.05.10.17.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 05 Nov 2015 10:17:24 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446747439-30349-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280928>

No need to document the O_NONBLOCK. We will read just once and return.
In case the read blocks, this works too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 strbuf.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index ea69665..7a08da4 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,8 +367,7 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 
 /**
- * Read from a file descriptor that is marked as O_NONBLOCK without
- * blocking.  Returns the number of new bytes appended to the sb.
+ * Returns the number of new bytes appended to the sb.
  * Negative return value signals there was an error returned from
  * underlying read(2), in which case the caller should check errno.
  * e.g. errno == EAGAIN when the read may have blocked.
-- 
2.6.1.247.ge8f2a41.dirty
