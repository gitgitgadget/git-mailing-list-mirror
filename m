From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [RFC/PATCH 0/2] Fix "git reset" on unborn branch
Date: Thu, 29 Nov 2012 10:32:53 -0800
Message-ID: <1354213975-17866-1-git-send-email-martinvonz@gmail.com>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 19:33:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te8vN-0008Nm-Np
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 19:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417Ab2K2SdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 13:33:10 -0500
Received: from mail-vb0-f74.google.com ([209.85.212.74]:60469 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab2K2SdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 13:33:08 -0500
Received: by mail-vb0-f74.google.com with SMTP id s24so1831556vbi.1
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 10:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=Fxt5x1wjr36SD6kxKejLXyNXFyGLQl+Lyzg4IURgdGw=;
        b=j0dvzid+taE7nXn9YxIvvBB5MTNYuEpIqvB6MHFBFjoxFMGhxdZie3kwtJeXlnxoJn
         3O6WuwR1aJz6m9r1pjkTKNeLmM6SVpICNIuWTzpn6TBwTXxnHKx4RMl8DPpDcNSjUhRL
         GPpBecGCdQVQcltyk8Hni4a6FMO8bmRBh1s3fVDlC/fcsaYBwMj+Fn5v9K7+J2zEliUK
         IK0rC/TDwzLKCKhw5hm1Jy1GrZhAjbSK/h3z3U/vV7x298KOgNDt6A3Tc0ZXlWaD3mJZ
         mgVz2k5aMEdzrvQEo+UG9E5eb163WHoqAePfdAGdbiALYLbNdzi4QmON0xDgz2Gqevle
         JcHg==
Received: by 10.101.128.35 with SMTP id f35mr4002605ann.1.1354213985985;
        Thu, 29 Nov 2012 10:33:05 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i7si162176yhj.6.2012.11.29.10.33.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 29 Nov 2012 10:33:05 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id CD0FE100047;
	Thu, 29 Nov 2012 10:33:05 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 75326102B8D; Thu, 29 Nov 2012 10:33:05 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.240.ge8a1f5a
In-Reply-To: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQl3DlcAYwp9HvgQIR0yS++2lMp4os4sjhsA/RL/gtAEtA0gDNouGmORA5A/27LzuyU1ggQHTTmLxZbgTJT05c0ZuaSgCTA0eKNuSih386ALe2tPeOhrLlZtCvkFiaJu1L8AEgbtjDLXvizybmJqeiapklRQfWUs7GhWzvJuDiXxU/yWYwrd40ZOZtJb4bLFzPc9LKqX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210855>

I decided to address this before "cherry-pick on unborn branch". RFC
mostly because I'm not sure about the user interface. When we have
agreed on that, I will add documentation.

Martin von Zweigbergk (2):
  reset: learn to reset to tree
  reset: learn to reset on unborn branch

 builtin/reset.c                     | 73 ++++++++++++++++++++++---------------
 t/t1512-rev-parse-disambiguation.sh |  4 --
 t/t7102-reset.sh                    | 26 +++++++++++++
 t/t7106-reset-unborn-branch.sh      | 52 ++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 33 deletions(-)
 create mode 100755 t/t7106-reset-unborn-branch.sh

-- 
1.8.0.1.240.ge8a1f5a
