From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC PATCH 0/2] submodule update continue
Date: Sun, 15 May 2011 14:42:19 +0200
Message-ID: <cover.1305462132.git.iveqy@iveqy.com>
Cc: jens.lehmann@web.de, hvoigt@hvoigt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 14:42:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLaeY-0004e6-F1
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 14:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab1EOMmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 08:42:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44526 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab1EOMmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 08:42:22 -0400
Received: by eyx24 with SMTP id 24so1045471eyx.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer;
        bh=rTd8ve8QC+9u1IJTX5ihg3YJa+NKjjNvm597bgWGqzc=;
        b=RxqI9LdfjR4SWnlJJ1LipT/z4fTeVU+L0Nlnp+xnXcU1bmk5XdtQC11BNwTGAP/6z6
         x6CVFsrP9MreVLL2sCFIluFLiETd4r34B5uotE3KPDzGuGwpXzAd8QcQqpTsiVL49W10
         iQjCRH+Ubj8Iv19Lfwp/bQserk3qh6i0VQETM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=nn33PnZHmWfgBo76k94Gpum6xXOCzuO9DGd1YlH5xf+TFwau7lbt/Ed3CRL5VmSegn
         v4W/yQUKHTMHcff3esY0q3ce5EuTXHQQ9uMoljrcp07cuo96a/E9KpwOJfiaHu8s8hSI
         +S+lCOYFnokpwXDqiNdpjFyVRtomhVmVNPgKg=
Received: by 10.213.26.82 with SMTP id d18mr1391426ebc.123.1305463340474;
        Sun, 15 May 2011 05:42:20 -0700 (PDT)
Received: from kolya (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id y10sm2314740eeh.17.2011.05.15.05.42.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 May 2011 05:42:19 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QLaeL-0005CD-Ox; Sun, 15 May 2011 14:42:21 +0200
X-Mailer: git-send-email 1.7.5.1.219.ge2152.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173629>

When running submodule update git dies after the first error. This is
inconvenient if a submodule is unavailable. Therefore this patch series
makes git continue with the next submodule if a submodule is
unavailable.

This does only apply to checkout errors, rebase and merge errors will
result with a direct exit with code 2.

A checkout error makes git continue to the next submodule and when done
with all submodules exit with code 1.

Still missing are three tests (recursive checkout, merge and recurive rebase).

This is the second iteration of this patch series. The first can be
found on:
http://thread.gmane.org/gmane.comp.version-control.git/171895

Fredrik Gustafsson (2):
  sh-setup: Make die take the error code as param.
  submodule update: continue when a checkout fails

 git-sh-setup.sh             |    6 +++++-
 git-submodule.sh            |   42 ++++++++++++++++++++++++++++++++++++------
 t/t7406-submodule-update.sh |   29 +++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 7 deletions(-)

-- 
1.7.5.1.219.ge2152.dirty
