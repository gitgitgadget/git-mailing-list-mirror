From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 12/23] transport.c::get_refs_via_curl(): do not leak
 refs_url
Date: Sat, 6 Jun 2009 00:04:51 +0800
Message-ID: <20090606000451.262b7711.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzG-00053w-OE
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbZFEQIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbZFEQIx
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:53 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43072 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755507AbZFEQIw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:52 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so944213pzk.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=dzxotrO+l9eOlfYk6wZQAnfns6qx2tF9NqUQlFOyGKA=;
        b=fIcnG5hR/3zT+wPsGEyect/PgBV6lGasxlzsk/CwV7wiAx6B5dUwR/fVcMClZ5RPz+
         dFU7H0ISsAPuph2o6VZkg4rZrFvGBWRTajhkjDADymKDbZfzDVOd+70R/2jnRgreT8Y5
         QCn/aNOU6FQ1cE0WdGExk+vF5JsutF/slopy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=CUg3SLaWBnVvlhGr59QXK7E7+Sw1L8f9sl7M6k10mOMmU7ZlxeqSvf4ydQV+vHGh7f
         qJ1BW/6b9gzGtYZWSD02rQF07EO2IHJrF3j4dCWxt2wSqKHQGwuBVEMEBPn55E6ml8qo
         WV/7aXIZ+ZKL4THw9br3ZQ3JKPYnXLychj110=
Received: by 10.142.82.13 with SMTP id f13mr1240044wfb.290.1244218134499;
        Fri, 05 Jun 2009 09:08:54 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 30sm442271wff.9.2009.06.05.09.08.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:54 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120793>

From:	Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 02/12] Some cleanup in get_refs_via_curl()
Date:	Sun, 18 Jan 2009 09:04:27 +0100

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index efecb65..9edd5aa 100644
--- a/transport.c
+++ b/transport.c
@@ -519,6 +519,7 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 		free(ref);
 	}

+	free(refs_url);
 	return refs;
 }

--
1.6.3.1
