From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 18:44:21 +0100
Message-ID: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 18:44:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbbpb-0000iS-Cm
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 18:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760275Ab1LPRoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 12:44:23 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63663 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760267Ab1LPRoV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 12:44:21 -0500
Received: by yhr47 with SMTP id 47so3074434yhr.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 09:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=OQb4U0kfM/CXPvwCPUZ+kXdPC/6j0h+jdW5iFCjZfgk=;
        b=jHcQPVRJq1QPXXk78HjH8R99iaWjwJgZ4pNkSwadAAZ8YNhNCkV6CsF/Z1zd4a6NJN
         EzMCyk6wpxsVqSPgEaSoSX5O5SSxO6t7/fTKSmDcgtf2SCEoNOibS6zsF8Pad316JzPU
         BtT5dIdKeh75pYtPUR848GvWqR2oP/3pfJKRc=
Received: by 10.101.101.6 with SMTP id d6mr4057128anm.8.1324057461261; Fri, 16
 Dec 2011 09:44:21 -0800 (PST)
Received: by 10.147.22.19 with HTTP; Fri, 16 Dec 2011 09:44:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187290>

There's a bug in git-1.7.8 if you use the attribute "eol" with "crlf".

Steps to reproduce:
- add and commit a text file which uses 0d0a for line breaks
7465 7374 0d0a 0d0a 7465 7374 0d0a       test....test..
- add ".gitattributes" with "*.txt eol=crlf"
- change a line in the file
- execute "git checkout [file]"

The result is:
7465 7374 0d0d 0a0d 0d0a 7465 7374 0d0d  test......test..

0d0a was replaced by 0d0d0a.
