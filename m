From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 02/22] refs-common.c: create a file to host all common refs code
Date: Fri,  8 Aug 2014 09:44:49 -0700
Message-ID: <1407516309-27989-3-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:47:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnJk-0000s3-0h
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114AbaHHQqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:46:37 -0400
Received: from mail-yk0-f201.google.com ([209.85.160.201]:40705 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170AbaHHQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:16 -0400
Received: by mail-yk0-f201.google.com with SMTP id 142so766227ykq.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A48EGr0AsXsqv43UrPbxoDG9pK8ernwQ+6EAUK+nXus=;
        b=AVEAjqMLtJCCgsqjkr3rYGxKFxgFXPcLHLY4TIlT2ujQMeeTXcLHOK8HTC7ktM6gor
         OEtOoQZoJriBv2K2k9BYDxEiYMJwRhPZO8tq6gf1BGETdp8AMVz4ZN1DpueBA63MlFLi
         h+B2p9M3VVxzc74NiSpUaH+IULYjYt7GbfrPSBKgIteuFtnyzxHmreqxIb8xNsKcBlaS
         fTDuQzNvtw7p3feiQgA7inSV5bsrw/TNiI1EatQQ1c5sIUa0/XonjtYokneAMniSsjnj
         oFLTSXQ1HDATpNeWlpdCAyiJSFqSISQ6mjGqiaH1Hu+DfopwQ9FeoqSjC88E+izpzKYh
         T/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A48EGr0AsXsqv43UrPbxoDG9pK8ernwQ+6EAUK+nXus=;
        b=j9oMftoChXUDI2mi7/GcCXnugmaa3nUBO5gXf/5uDWOr4VskXveVTL4Vj/FcghAePW
         K3xWtWP+PGrM/WexadJk5HVE4U7gtWwAw8s1zzf+DV8Qb7poAwScW1o5rKzmiWujR31f
         q6FQeAyg0bLrac9nO41BKGspC5lJgjLTtJ9I76Uz3V+IaEJV9InwfOZfzmCyCCCMqzi8
         a82IAOmeGx10t/tT6bbgWota0v/IAICv91XLE8PG4G/xm8HDlkufwf1ovZr/DTjj6Mxy
         S6n33yi+mdqEBn7JZtiqAgfVw+PIixQgtIP8t6P43oSYNhelfBfqchTPTP9WVxXX7WZq
         CAIA==
X-Gm-Message-State: ALoCoQkOH4Ey9V3HU6Cf/rfpnV2TtTn5Zyx7Lcx+YCG4MBczcV+15n2WMiJk5ACTvY/07k3Q6X0s
X-Received: by 10.52.163.231 with SMTP id yl7mr5380369vdb.1.1407516315566;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l23si505695yhg.1.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6421831C40F;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F35A9E0D73; Fri,  8 Aug 2014 09:45:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255043>

Create refs-common.c which will hold all backend agnostic refs code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Makefile      | 1 +
 refs-common.c | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 refs-common.c

diff --git a/Makefile b/Makefile
index 07ea105..7705136 100644
--- a/Makefile
+++ b/Makefile
@@ -858,6 +858,7 @@ LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
+LIB_OBJS += refs-common.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
diff --git a/refs-common.c b/refs-common.c
new file mode 100644
index 0000000..44d96d2
--- /dev/null
+++ b/refs-common.c
@@ -0,0 +1,2 @@
+/* common code for all ref backends */
+
-- 
2.0.1.553.geee1b3e
