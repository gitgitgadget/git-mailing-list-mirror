From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: git log -S doesn't search stash WIPs
Date: Fri, 8 Feb 2008 10:46:08 +0000
Message-ID: <57518fd10802080246p4a929b62tc6e260a16d3587@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 11:46:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQkn-0001M7-W8
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360AbYBHKqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 05:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757425AbYBHKqL
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:46:11 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:15921 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058AbYBHKqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 05:46:10 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2517891rvb.1
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 02:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=bdr1JVKQ66lk8UErXIO4P2H/gEOUsGtaqitcgLbwVzc=;
        b=cLO4XPYFZLY/540dH9kDT0z5OwGz1VEh1ZJil2bYwcIhzlDN1liDZAJ7eNafTth3b+pKUYtyKW4AexDwgCBj4ZOTviheFap6V9Hgutt+JeNEfKTN6lyReZhE9wy5uGBfQTPYNHoS0jpeHJUQRYiEfz6G4eFtHpSJ9nR0u9gfatE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=LmtMcLjbDtqqOWR5lTpDU2S3sFxoc1/1cl86FzC4m6OgzJ1t3cJk2klmCoBvOlPJnKkC33AsZ45Hpyf1PHYjeq4zMqyEw5vLmXzTNkQPKhxJ/937cwxs/xAQlJjpBlmSwkuHSAaJu7dqUN0GSRVam3RA0fGtnqGDxlK3nz7EOSs=
Received: by 10.141.141.3 with SMTP id t3mr8437918rvn.52.1202467568798;
        Fri, 08 Feb 2008 02:46:08 -0800 (PST)
Received: by 10.141.86.15 with HTTP; Fri, 8 Feb 2008 02:46:08 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 35d9e46e88f86443
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73071>

"git log --all -Sfoo" doesn't find strings introduced in stash WIP
commits, only the stash index.  That is, if I do :

$ echo foo >> file
$ git add file
$ echo bar >> file
$ git stash
Saved working directory and index state "WIP on master: 00495fc... initial"
(To restore them type "git stash apply")
HEAD is now at 00495fc... initial
$ git log --all -Sfoo
commit a8834ce80ebdf84e6579280c1fc75cdb7b4ac7c9
Author: Jonathan del Strother <me@here.com>
Date:   Fri Feb 8 10:43:44 2008 +0000

    index on master: 00495fc... initial
$ git log --all -Sbar
<this space intentionally left blank>


Is this intentional?  Am I missing some git-log option that would
allow me to search the stash WIPs?
