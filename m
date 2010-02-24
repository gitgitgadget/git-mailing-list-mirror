From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 0/6] repo-local env vars handling
Date: Wed, 24 Feb 2010 08:23:10 +0100
Message-ID: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:23:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBao-0003RH-EZ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab0BXHX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 02:23:29 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:43618 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab0BXHX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 02:23:28 -0500
Received: by wwf26 with SMTP id 26so1156644wwf.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 23:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NQAkvBrOltElGGdyD935ctB995R+UOK9EeRaaazHoF4=;
        b=ZwBlweU5SKQIPTY5nh8O2PyI8bhc8qrCOjhmdyCXiqUgWAf3MqgAQnK4DbIHSD5K40
         FznXrf+W0sqxAOnq9AtxYLItBFxW4Sy6UxnqF/1+j8I2XgHWUzwh+bXGNnUiPhaPuVO1
         aec9ntSS7kqj3RjKLb7e/69dOVdozkuIXy6go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CTpQjlNvwQ6oMD2YPi18+VoaDE8IrIVg6lUrOCo2nz/Me9ofzug4mBvM2ilZ0tGBp2
         S+ZlrPnc8CYFzEKn6wnGCoL0DQ3fZbJ1HS7iVlZeSWhPy8ap2aQwsPV0ZHr2SI/7n8VV
         5yKoMV8o5y0rpPHqlkno1qVCD3ExXe1v6FGWY=
Received: by 10.216.86.129 with SMTP id w1mr3039152wee.174.1266996206982;
        Tue, 23 Feb 2010 23:23:26 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id g11sm21492066gve.23.2010.02.23.23.23.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 23:23:26 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g4e217.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140907>

Changes from the previous iteration:

* moved the static list to environment.c, per Junio's suggestion
* added a local_repo_env_size constant. It's cheap, and it helps
  prevent some horrible gimmicks when the list size needs to be known
  without walking it
* a variation on Junio's variation on Jens' patch for submodule.c,
  using the static list _and_ the size constant.

Giuseppe Bilotta (6):
  environment: static list of repo-local env vars
  connect: use static list of repo-local env vars
  rev-parse: --local-env-vars option
  shell setup: clear_local_git_env() function
  submodules: ensure clean environment when operating in a submodule
  is_submodule_modified(): clear environment properly

 Documentation/git-rev-parse.txt |    6 ++++++
 builtin-rev-parse.c             |    8 ++++++++
 cache.h                         |    3 +++
 connect.c                       |   13 +------------
 environment.c                   |   15 +++++++++++++++
 git-sh-setup.sh                 |    7 +++++++
 git-submodule.sh                |   20 ++++++++++----------
 submodule.c                     |   23 +++++++++++++----------
 8 files changed, 63 insertions(+), 32 deletions(-)
