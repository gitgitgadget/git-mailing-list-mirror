From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 0/3] Testing: XDG config files: Fix broken tests
Date: Tue, 17 Jul 2012 17:25:49 -0000
Message-ID: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
Cc: Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:43:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrBnn-0006ou-0V
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 19:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab2GQRnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 13:43:09 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53000 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab2GQRnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 13:43:08 -0400
Received: by wibhm11 with SMTP id hm11so4007407wib.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id;
        bh=DqeyymPq43e3HTf0z23yz4QEb3tNASQx1YlCfBsURg8=;
        b=KOWCerlPb5Qw/mBgdN43xNzAFopp+JnktY0W8VIqz8Tqdyi5wH6lxOUCxO2D4dFr19
         ROBxiSCs3fHiIp7X5JJI72nGC5LbhUu3IowXTy4rGw1iQZYhNLbGUASBeaPbsXZXGcNj
         kFqitA3nwfjrsT/i5LD7yUjyU0ul6R7S3VhYfW/avHJiu/7a03l2i1rGVq3SR05/oPU+
         LdrAfbrG6VXGU+Z8nalTs6GZp1wxr9w9BN17ZqahVGV6jBvucxzDLINr1VIiztsHzXjk
         7OL0a4/8/A/lPPn3zkMqHwJJael53fXGPelFWJLNMs/AhLyvkcWlKEhJkUVZNOUBhAwj
         pMmQ==
Received: by 10.216.226.78 with SMTP id a56mr1840363weq.133.1342546985978;
        Tue, 17 Jul 2012 10:43:05 -0700 (PDT)
Received: from gmail.com (saito.countshockula.com. [65.183.151.13])
        by mx.google.com with ESMTPS id el6sm28032146wib.8.2012.07.17.10.43.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 10:43:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201609>

The tests for the new XDG config file code are broken because the
environoment variable `XDG_CONFIG_HOME' is never set properly,
and the tests themselves do not use `XDG_CONFIG_HOME' or `HOME'
explicitly.

The following patch series corrects this brittleness (and the
failures to which it has led):

  t/t1306-xdg-files.sh | 69 +++++++++++++++++++++++++++-------------------------
  t/test-lib.sh        |  3 +++
  2 files changed, 39 insertions(+), 33 deletions(-)

  [1] Export a suitable `XDG_CONFIG_HOME' environment variable
  [2] Use "$HOME" and "$XDG_CONFIG_HOME" explicitly
  [3] Trivial: `xdg' -> `XDG'


-- 
1.7.11.1.29.gf71be5c
