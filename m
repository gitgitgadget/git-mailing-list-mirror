From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
Subject: [PATCH 0/7] perl/Git.pm: a bunch of fixes for Windows
Date: Wed, 30 Jan 2013 15:22:56 -0200
Message-ID: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
Cc: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 18:23:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0bNk-0006Wu-AY
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab3A3RXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:23:10 -0500
Received: from mail-ye0-f174.google.com ([209.85.213.174]:34616 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab3A3RXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:23:08 -0500
Received: by mail-ye0-f174.google.com with SMTP id m3so300746yen.19
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 09:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=IDvubykrQulWGuB9TUW8TnzihnNForSG+Pl+bcdrkw8=;
        b=JzIaw/OppBVbsGTuRFaaA7DzbzpkU4hPUo1lNmNNNhsRUTAoyKkrTSiU6Utz0oQK6B
         32ROH991T4VXbz21lZQNV1TS27iFdXbMqQtRvav/nFsEPHf5WYCmCR+KEcEXubSILpFB
         UN6quwwC0JNdcj+VU8r3EuTcuv3V8brAK2A+V/dxpts25YRG7vhcUVJ55R1728legaVR
         JxGUEwitNrPXptohkbsjHrLrZ9qxqKeiH7caq0QZ/P0Z3m2r8neNMqW4Tq5RYQa3tFJs
         c1Qi6TDSg91yoMing52TS40DV9XVcpWNbkx3XTibYHX8vnBBfLWVeDU+9dMo0aL9G7JC
         To5Q==
X-Received: by 10.236.131.211 with SMTP id m59mr6448648yhi.49.1359566587780;
        Wed, 30 Jan 2013 09:23:07 -0800 (PST)
Received: from gnu.cpqd.com.br (fw-cpqd.cpqd.com.br. [189.112.183.66])
        by mx.google.com with ESMTPS id q11sm1689802anp.13.2013.01.30.09.23.05
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 09:23:06 -0800 (PST)
X-Mailer: git-send-email 1.7.12.464.g83379df.dirty
X-Gm-Message-State: ALoCoQmTZNxaiVaD6rqlucb2xPOxxM7OQ+iQ4dzCDj47TprgGkwQX+mq1yB0Cli8oB7dDuoT2x6V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215034>

From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>

I'm working on Git::Hooks, a Perl module to facilitate the
implementation of git hooks. (http://search.cpan.org/dist/Git-Hooks/)

Git::Hooks uses the Git module implemented in perl/Git.pm and
distributed with git.

While working on porting Git::Hooks to Windows I stumbled upon a few
problems in the Git module, problems specific to the Windows
environment. In the following sequence of patches I try to fix them.

For the record, I'm using Strawberry Perl on Windows.

This is my first patch submission to git. I tried to follow all the
project conventions but I may have done it wrong. If so, please, help
me learn it.

Thanks!

Gustavo L. de M. Chaves (7):
  perl/Git.pm: test portably if a path is absolute
  perl/Git.pm: set up command environment on Windows
  perl/Git.pm: fix _cmd_close on Windows
  perl/Git.pm: escape external command's arguments on Windows
  perl/Git.pm: simplify Git::activestate_pipe
  perl/Git.pm: make command pipe work in slurp-mode on Windows
  perl/Git.pm: rename 'ActiveState' to 'Windows'

 perl/Git.pm | 63 +++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

-- 
1.7.12.464.g83379df.dirty
