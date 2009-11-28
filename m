From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/3] format-patch: improve pathspec usage
Date: Sat, 28 Nov 2009 13:40:26 +0200
Message-ID: <1259408429-5685-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 12:40:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELfa-0006w7-VN
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbZK1Lkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 06:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbZK1Lkj
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:40:39 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:38892 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbZK1Lki (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 06:40:38 -0500
Received: by bwz27 with SMTP id 27so1602122bwz.21
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=iU0ZIXT5m1q3sMCS4tNaJh1Iqi8K/YRIMgUEGsAQNCg=;
        b=x5+bFsxxatIAyPXs2cXUP3wLX3M9mO1d73RwlgFzoOun10hKP3sVKXXODg6eTtid/J
         b8gRiNwWkevaGbMvkjl5+P3D15jbc/pWAgHPDADSov0lrBuiEEr+9yvw9RscLsgrvVuD
         B71U/69rmz4d0Rqjcff9amGDt9bQ4q7DIJHCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BXMt4qddja3C0S4Tg4Zq5rKD/p+RyGOaxIh5v/sbiRWUDpKoDdmaVcWDqIdJFIk0qk
         cbpGBuGdObxCZyIvrNrcpkSp4rqWY0yfuRLs+nAX4RxLhYXm7TVEVLeRhIwRdZcCn0ta
         ytHVjFewmAOr7uyBYUwFjxZtlm+xSLoJ5EkVI=
Received: by 10.204.10.18 with SMTP id n18mr2138325bkn.152.1259408443549;
        Sat, 28 Nov 2009 03:40:43 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 16sm615049bwz.7.2009.11.28.03.40.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 03:40:42 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.61.geeb75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133958>

Even though it's not documented, users still can make use of pathspecs in 'git
format-patch'. This patch series improves the way it works.

First, parse_options must not eat the '--', then, full-diff is the only way
pathspecs make sense.

This is v2, after comments from Junio. Still pending are the improvements in
documentation to explain how pathspecs make sense.

Felipe Contreras (3):
  format-patch: fix dashdash usage
  format-patch: make full-diff enabled by default
  format-patch: add test for dashdash

 builtin-log.c           |    4 +++-
 t/t4014-format-patch.sh |    4 ++++
 2 files changed, 7 insertions(+), 1 deletions(-)
