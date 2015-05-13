From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 0/2] teach git pull to handle --log=<n>
Date: Wed, 13 May 2015 17:17:39 +0800
Message-ID: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:18:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSnr-0006uZ-P0
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933309AbbEMJSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:18:07 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34400 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933291AbbEMJSE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:18:04 -0400
Received: by pacyx8 with SMTP id yx8so44711142pac.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XgaVig6D41wMHyPe/X0GPWwpE6F4cVHkaKA0+qGVNxM=;
        b=xk2XH1BxVIIHdn10Q18u9fEVj5+f7cHeaDM0FJ0n5uap6udC2qaOfOgQoOQetfuyLT
         f4jd1saA1x/bpmiDofif5YXoVcSGOLg4JEeFzM+d+Y/pHkfUXMz/IazMDNaeMltzUeuj
         2PEsJy2HWfLy36yHxBjvMDRSCMKbqyuGrjZMp4OlKnUWWrlfdbtc8+d4dlspQLRSwhyP
         X60tCn7WZvMNQYVEvSrsYp/sKvPMziE2GEZwoCq3aTq3RLJOPAI+LfLR33omUDvf7N5T
         5aheg8BMQd1C98I2XEYD5xszUdtasKZ6WpZHraeu3AfZHjuRkaIdKCj15p6AojsSo+a1
         cb1Q==
X-Received: by 10.66.254.67 with SMTP id ag3mr35032716pad.45.1431508684475;
        Wed, 13 May 2015 02:18:04 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kh6sm18632898pbc.50.2015.05.13.02.18.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:18:03 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268961>

Since efb779f (merge, pull: add '--(no-)log' command line option,
2008-04-06) git-pull supported the (--no-)log switch and would pass it
to git-merge.

96e9420 (merge: Make '--log' an integer option for number of shortlog
entries, 2010-09-08) implemented support for the --log=<n> switch, which
would explicitly set the number of shortlog entries. However, git-pull
does not recognize this option, and will instead pass it to git-fetch,
leading to "unknown option" errors.

This patch series implements a failing test that demonstrates the above,
and teaches git-pull to handle the switch --log=<n>.

Paul Tan (2):
  t5524: test --log=1 limits shortlog length
  pull: handle --log=<n>

 git-pull.sh         |  4 ++--
 t/t5524-pull-msg.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.1.4
