From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] Fixup test-lint error in git-p4 t9814 test
Date: Mon, 27 Apr 2015 23:20:27 +0100
Message-ID: <1430173228-22004-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 00:21:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmrOq-0002aJ-00
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 00:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965338AbbD0WVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 18:21:06 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34162 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965239AbbD0WVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 18:21:05 -0400
Received: by wicmx19 with SMTP id mx19so94487490wic.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BTUqcNA650xUSrx3r/n/5Gsxd2HTBxIgaQf1iM22hDA=;
        b=jDr6QMByir4vMy9pfti9aStoPmd1pH1TV7SdU6q7aGaM3KoSinn8Z+BmLCdfzUoYP0
         dwPthsCregaSobScY0vfJgzNTpFTP9a0G6ZzUoJiUo0gtXlHRyoHb4GuixdOsO6+2tlh
         ouvdrF+CkcYhx5kQ6X379nbhqvLW134TQILIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BTUqcNA650xUSrx3r/n/5Gsxd2HTBxIgaQf1iM22hDA=;
        b=PtKdDg13V71RRArqma9yjFmqqmvU9Wmr/M67RwHeUn7Mz3Afmxj9oT7NXzBBwrp/pi
         0y5ANaqxD7GS1FF57FTIq2IVCwQz2oBacwL30LIFg7Lx3GqFODJDGi+3eSFud1+dRyto
         hKe0U52z0KGrW/+aoHUe4PVOUN2CPc0Ago7UsgeZPXEXvaPP8Di5nd/QDBX7WHfIrEvz
         ZGIJ7kB3ABmh8gk5PRXf8EyEnBfuE760wVZyLbzLIlH7pWuHSvNs6ABJ8945FEYQvoRZ
         zhA+D3Q1nLWO0kkq688KKARUOBFeSBJXSbn5vrCD3FBEnLGplT12t90YY/oRFEYJmNGh
         jKFw==
X-Gm-Message-State: ALoCoQmcUraO47be/1nqVHNSP4J9MDn4PObp7eCFiVDFBuU9m6gqJex9G8ft7WG3O8x83TmBM5K8
X-Received: by 10.194.71.208 with SMTP id x16mr2507194wju.129.1430173264065;
        Mon, 27 Apr 2015 15:21:04 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id k2sm13477177wix.4.2015.04.27.15.21.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2015 15:21:03 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267884>

While running the git-p4 tests, I noticed that t9814 has started
failing due to the (very ingenious!) chain-lint detection introduced
in:

   bb79af9 t/test-lib: introduce --chain-lint option

I think that what's going on is that the chain-lint test is
getting itself confused by this test, which is designed to always
succeed, regardless of whether the individual sub-commands succeed
or not, since it's just setting up a pre-requisite for later use.

I've added an additional set of braces, which makes it clearer
to the --chain-lint code what's going on, but I'd be interested to
know if this is the right way to fix this.

Thanks,
Luke

Luke Diamand (1):
  git-p4: prevent --chain-lint failure

 t/t9814-git-p4-rename.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.3.4.48.g223ab37
