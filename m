From: Ilya Basin <basinilya@gmail.com>
Subject: filenames in repo are in CP1251; I have linux and UTF-8
Date: Tue, 2 Aug 2011 11:54:14 +0400
Message-ID: <1167098359.20110802115414@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 09:54:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo9nz-0003ca-Ir
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 09:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab1HBHyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 03:54:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57826 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab1HBHyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 03:54:18 -0400
Received: by fxh19 with SMTP id 19so5361689fxh.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=pEy4lkp7QeypiP17twq3UU5hPFrWqJH+ycnUMbaQ6Oo=;
        b=uh4Ztk7VDK+zKXZNogiyhG38O5/022hOCerQzOhYwiozoKW5ppUApxPJYCHnyHWf5H
         n5FVrTt1LD2rCv1dSUC0DU8LnqcJ/fKOQQnlT2CyBHzXR8dXu8qw8kKURUu9/3XglKWB
         S8TuHtOWUemvyQ5mzDIAy4n4i801Lc3cCvLWE=
Received: by 10.204.0.72 with SMTP id 8mr1563084bka.33.1312271657617;
        Tue, 02 Aug 2011 00:54:17 -0700 (PDT)
Received: from basin.reksoft.ru (gate.reksoft.ru [188.64.144.36])
        by mx.google.com with ESMTPS id n11sm1524148bkd.14.2011.08.02.00.54.16
        (version=SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 00:54:16 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178448>

Hi list! Most of our developers use msysgit which stores filenames in
CP1251 encoding. Two of us use cygwin and linux.

When checkout on both linux and cygwin, Russian filenames are garbled.

On Cygwin it even worse, because the conversion of invalid UTF-8 chars
to Unicode, made by Cygwin is irreversible, causing git to miss
the files it've just checked out. Workaround for Cygwin is to change
LANG from "C.UTF-8" to "ru_RU.CP1251". It fixes filenames, but brakes
everything else: log (fixed by i18n.logOutputEncoding), status, show,
diff

Unlike on Cygwin, LANG has no effect for git filenames on Linux. Good
thing, there's no conversion to unicode, so files aren't lost at
checkout.

Question: is there a way to tell git on Linux to use UTF-8 filenames
for the working tree, while storing them in CP1251?
