From: Thibault Kruse <tibokruse@googlemail.com>
Subject: Bug: git-gui stops showing untracked files when invalid .git file is
 present in a subfolder
Date: Sun, 21 Dec 2014 20:23:44 +0100
Message-ID: <CAByu6UUtuTjXgJpH3GE1qCRvQTBefm3zO2cfa+cR_ej1UqJ3mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 20:23:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2m6Y-0006dQ-Hn
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 20:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbaLUTXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 14:23:46 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:59346 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbaLUTXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 14:23:45 -0500
Received: by mail-oi0-f49.google.com with SMTP id a141so6994381oig.8
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 11:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ovVnaC6mblBYB2z17gNphx357+Y8D10P0JQmK9W6U2Y=;
        b=hjzWJPdj2sqBXyALev1e12Dj+zEhu7r6Dqeu9hMLjcjMJuucXTvzgV6w6HlYOmMJOX
         ozrFWsxSRLgIBN4c1Sf8lO6xIOa8vlUxd6/9T28bBAYm6gDWgZqi5kmIjl3MWRR+uu/z
         AQ0Bviu0AR/1dLJkh7vIJYRaDHB1PnxxLII78WjTd4IGT+qvloRtff6If01NI4PBvMrd
         5RaFPU5ARN7zN5rqUT63Yx5nKZT6fz9GLXYXCNlGw7DKHYPrjznNTLWyG32NMfw0Bmqw
         Dxa6xNIEhoz2Ept/450b4+YYwELrDsKJPk7taYA91TYqC4qJkFqCjgOD6Qdv1iocTJrj
         56jA==
X-Received: by 10.202.93.135 with SMTP id r129mr10370620oib.53.1419189824989;
 Sun, 21 Dec 2014 11:23:44 -0800 (PST)
Received: by 10.182.40.74 with HTTP; Sun, 21 Dec 2014 11:23:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261623>

To reproduce:

git init testrepo
cd testrepo
touch test.txt
mkdir sub
echo 'gitdir: path/to/nowhere' >> sub/.git
git gui


Displays no files/changes, no error message.
Should display test.txt in git-gui. Or possibly fail with error
(though git status does not fail).
Shell should display error message.


Observed on Ubuntu 13.10 using
git version 1.8.3.2
git-gui version 0.17.0

Note the same happens when writing rubbish like 'xyz' into that .git
file (Violating gitfile format).

Note that when trying to launch git gui from that subfolder, I get a
valid error message:
fatal: Not a git repository: path/to/nowhere
same as when running git status

I guess that git-gui tries to do something with submodules, but some
failure is not handled well.

regards,
  Thibault
