From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] Document protocol capabilities extension
Date: Mon, 23 Feb 2015 19:12:40 -0800
Message-ID: <1424747562-5446-2-git-send-email-sbeller@google.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 04:14:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ5x6-0002Kl-LG
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 04:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbbBXDOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 22:14:17 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:51074 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbBXDOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 22:14:15 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so25752750igb.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 19:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nc3eymAFNm4ET14y19L95O67reaaIm/WUECZ8GyTs3k=;
        b=RiMMBDg5hvIBjXPolUe4tip2c8/cqmsnFLgBCBUmCttOnjSvWRIeI18QcRiC/A1F9V
         EDo+4xCkwPWGCxspJpe6OP/xRmLeGkQ9DH7N8PCe30jhoE55IS2m3op4FNSK+R3ow2DR
         +kQFuhIAg2i+XAwYP+8XyIgVogThE8Ytuu+ixp/xFFT06bbV3s8rEpjxOMltUQnubmkl
         VOMasKvE7VW8qunUCRh17DVTfApe1lxyqEB9JzM602/Kb+Blo5x/hR1cXNr1JABylwCT
         HMF1GnjyQ9Icn+lqSXmyQ1WKsfmOZ+iq8sRQ8CSmBYB3wMWdvMc8cluGL41t+0UCL761
         HQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nc3eymAFNm4ET14y19L95O67reaaIm/WUECZ8GyTs3k=;
        b=C+bYu9tCzZ8QqPxyfdqXZAkmTXUpJhtmm22FC2aPU8GQBPMz+Y59n2+9HwDs52nTrs
         mlld7qZw9DxLyubghaBoRNOaSFCTdlRltTaJHcctmITy/eoOzYSEqiqri8Lp8G09eNP7
         swUH3P6N7Ygfbk3CyeH9mpTVKJKrmBMyERQIh2iKLe+ma27ieiYV9q6VKiwt4ITFKifM
         fHVVLE5DbGUXTLEzIJZsB1Xa85F8ggtlHQQeUbmO/25uHtwA5bOu7diHYE/qg19aOaw7
         IFmO945pIb+UNTwximkZKYJDN3hvmpGwZ9QVxk9WeT9g0w2vzpcQ57uWlNf8pABn3qqa
         BzEA==
X-Gm-Message-State: ALoCoQlS7597A5DFTPa/atNUw0wGyqLBfm/Eh/J46m9uDgiPK2vyXTUmKM3qHQ3UHLP7L0zRaDXu
X-Received: by 10.50.109.228 with SMTP id hv4mr17548563igb.45.1424747655097;
        Mon, 23 Feb 2015 19:14:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:acce:8652:941a:5856])
        by mx.google.com with ESMTPSA id m132sm17615800ioe.33.2015.02.23.19.14.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Feb 2015 19:14:14 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1424747562-5446-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264308>

In the future we may want to have multiple different versions for
the transport protocol each optimized for a certain aspect of the
transport such as latency, bandwidth, CPU load etc. To make this
future proof document a possible way how to advertise the versions
such that the client can store it and use try to use such advertised
protocols later if the clients supports them.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/protocol-capabilities.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 4f8a7bf..6829668 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -268,3 +268,14 @@ to accept a signed push certificate, and asks the <nonce> to be
 included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
+
+versions
+--------
+
+If the server supports more than the standard protocol, this capability
+advertises the additional versions. It is a comma separated list of
+the names of extensions for the binaries (i.e. "v2" would result in
+the assumption that git-receive-pack-v2 as well as git-upload-pack-v2
+is available). The items are desired in desceding order by the server,
+i.e. the server would like the client to use the first advertised
+version most.
-- 
2.3.0.81.gc37f363
