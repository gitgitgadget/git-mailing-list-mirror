From: Vitor Antunes <vitor.hda@gmail.com>
Subject: git fast-import : How to change parent during import?
Date: Tue, 8 Mar 2011 01:21:45 +0000
Message-ID: <AANLkTikiEfUSdNqqTjuYy_JLJnEyCizmusSucYsEHC2r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 02:23:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwle8-000669-Lq
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 02:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab1CHBX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 20:23:26 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39117 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab1CHBXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 20:23:25 -0500
Received: by vxi39 with SMTP id 39so4295003vxi.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 17:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=7iYU9/YH+EO7lE3LFDBiMfnj3dyvN9i9Y4SPYopzw60=;
        b=TI1dTXHZA1SZVi9q61tSchrmBwZZlr42J3mYdS3AC3nqhv191McZj1kMBGn10dpuKN
         Bl83NpiRPtaF18Qtm77FDr+Gxly4rZY84Ah98/6IzWGFCT2J1L4uEWL74g0os32ewvRw
         +Uk6zda1h5/ZwGsmueXVWzD3pUjxDsbKF2Z+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=NxVgOx0cNQxsEhjq+4AOejis7mKj9DdnhVs+np58ABDk8Qlr9kovbt6xRN2xAKzaUl
         EJouFdjOWl79/1MbblXKGnHJjfL1WL+PWNgmgE/uEUUK/LfNTH5TY+NJiZestREaXc//
         3HX4Q87uJ5Bg5rdeSBaOhntOjZ7PgcXwYV9Bw=
Received: by 10.52.74.66 with SMTP id r2mr6405788vdv.263.1299547335198; Mon,
 07 Mar 2011 17:22:15 -0800 (PST)
Received: by 10.220.178.130 with HTTP; Mon, 7 Mar 2011 17:21:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168629>

Hi everyone,

Is it possible to change the parent of a commit during fast import?
I've tried using "reset" command and making a new commit pointing to a
new parent, but in both cases I get a "new tip ... does not contain
..." error message.

Providing a bit of context. I'm trying to improve git-p4 to detect the
parent commit of a new branch. Unfortunately, in Perforce a branch is
nothing more than a copy of a bunch of files into a new location.
Because the origin of the copy can be any past commit and there is no
information about which commit was used it is very difficult to
identify a parent of a new branch. But if we assume that in this copy
process no file is modified then it should be possible to identify the
parent commit simply by comparing their SHA-1.
To achieve this I used the checkpoint command to flush the list of
imported commits to disk and then used standard rev-list and diff-tree
commands to make find the parent commit. I am now at a point where I
am able to correctly identify the parent commit, but when trying to
update the from information I get the above message.

Thanks in advance for your help,
-- 
Vitor Antunes
