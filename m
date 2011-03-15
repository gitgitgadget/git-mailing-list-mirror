From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/3] tests: unsetting variables that influence the outcome
Date: Tue, 15 Mar 2011 01:49:33 -0500
Message-ID: <20110315064909.GA25738@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Petr Onderka <gsvick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 07:50:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzO4x-000684-T7
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 07:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560Ab1COGtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 02:49:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49666 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab1COGtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 02:49:53 -0400
Received: by gwaa18 with SMTP id a18so111465gwa.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=ynVF2+wMoyCz76wEW7OYM68kScwXDeKjXblY3fGvJH4=;
        b=dBaG02V4p/R3pQcf4y6a98/HRHpKLeMCO6v4rXbVZIkg5F9Xvmq/6RD1aJu9vTSkpd
         jOnu/fmwLz5Eb6xSGWsmxFoNWbU0Vw5JFL6AC3TX2QgAJpW6Q/WDSgNyx2pIc47Aih8u
         z9pS/3UslKl4oNwS6G8A0HxKorhQ7WMru8Im0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=yBXIMvHRNVgR1an6Ef93nx5OXUXGqWkEZuEKtCTxh7sRC67grmcQ0hefYeOageTLCq
         L+0HBJ7vlbL0GgY8hiSObSIqy1yfXP92r5Vxjti8x8N/EFZXE/IC962MO3Kn51+uw5Nz
         6szMxaK2Cm9TQZM4Spm5CC0UC96rlaqFmYOIA=
Received: by 10.236.116.136 with SMTP id g8mr7485602yhh.298.1300171792268;
        Mon, 14 Mar 2011 23:49:52 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id 57sm5909455yhl.20.2011.03.14.23.49.50
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 23:49:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169045>

Hi,

These patches were rotting in my tree so I thought I should
try sending them out.  Maybe they can be useful.

The theme: settings from the inherited environment like GIT_PAGER can
break tests in undesirable ways.  For example,

 GIT_PAGER=more sh t5400-send-pack.sh -v -i

hangs.

Jonathan Nieder (3):
  tests: protect against GIT_ATTR_NOGLOBAL from environment
  tests: suppress global and system gitattributes
  tests: scrub environment of GIT_* variables

 t/t0003-attributes.sh |    1 +
 t/test-lib.sh         |   36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletions(-)
