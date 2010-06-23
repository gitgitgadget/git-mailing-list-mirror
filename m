From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/3] teach git-checkout -B WAS builtin/checkout: DWIM with -f -b
Date: Thu, 24 Jun 2010 03:28:57 +0800
Message-ID: <1277321340-4000-1-git-send-email-rctay89@gmail.com>
References: <1277140782-4064-1-git-send-email-rctay89@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVdQ-0001aN-Uj
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab0FWT3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:29:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40028 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0FWT3P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 15:29:15 -0400
Received: by pwj8 with SMTP id 8so1543963pwj.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BrSAd5wsAp55UifVYYollpRnrnA10VmkaOI168SdWko=;
        b=vTjiJBYB6PLBdMSMMqIgnDbU/pbpP9sYi/Ud+RkReFYc8ygO/yZKrsVeJtDbO9O1T7
         YCHYb/fAL84N28hNxNaUC+hrK2auY5LFcy1G0m0dDBLZeChkb/a0zktL854sr0BP5wLj
         OnK4W8blHMBxpJssQjWs4ZSDU3NcxBotMNtYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Mvbcx4HIOJ3dYqbY7LrgKMbhwfKlPfO8M8/VEU0BPBp5hPCmuaTpA1c1Vzzo69v+d7
         ifvcKORLmKEAI1yBM3jYSzdoyChWvkiA9LXfGDrLB7V8GEimqozuMQNoItyoa+Um7veN
         sooAakL6EYvZW25VpET0Uwl6EQsjffM8ljhKY=
Received: by 10.142.151.11 with SMTP id y11mr7806912wfd.77.1277321354820;
        Wed, 23 Jun 2010 12:29:14 -0700 (PDT)
Received: from localhost.localdomain (cm156.zeta152.maxonline.com.sg [116.87.152.156])
        by mx.google.com with ESMTPS id p1sm570577rvq.0.2010.06.23.12.29.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 12:29:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <1277140782-4064-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149534>

Right now, the -f/--force in git-checkout doesn't carry over to -b
operations - ie. you can't do git checkout -b branch on an existing
branch.

This patch allows you to do this with the -B option, so that one can do

  git checkout -B branch ref

which is equivalent to

  git branch -f branch ref && git checkout branch

Changes from v1:
 - reworked option handling
 - don't replace <new_branch> with <branch> in documentation

Contents:
[PATCH v2 1/3] add tests for checkout -b
[PATCH v2 2/3] builtin/checkout: reword hint for -b
[PATCH v2 3/3] builtin/checkout: learn -B

 Documentation/git-checkout.txt |   21 +++++-
 builtin/checkout.c             |   32 ++++++--
 t/t2018-checkout-branch.sh     |  166 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+), 8 deletions(-)
 create mode 100755 t/t2018-checkout-branch.sh
