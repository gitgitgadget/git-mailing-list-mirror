From: Serhat Sevki Dincer <jfcgauss@gmail.com>
Subject: multiple branch shallow clones and object sharing
Date: Sun, 6 Mar 2011 22:00:55 +0200
Message-ID: <AANLkTimo-Ba8dt5p7aDG8X1VJC=tQfricD=iJvcUw7_y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 21:01:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwK8Y-00064R-AD
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 21:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab1CFUA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 15:00:58 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64906 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab1CFUA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 15:00:57 -0500
Received: by bwz15 with SMTP id 15so3369906bwz.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 12:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=j9UIUIoLkun6Q6jOAXQymDUTOeVGtZdxsk89JqC46po=;
        b=iwb4AnfuSX9jTGCa7wOy7nqw8T6C7LYJwzjbF7nB1c3hX7zA4F6ulLDH6VTwq3c4FK
         eZSaZJBnJUrdRAevEDSP0F/1xddphFMMLvkDmxnyNBWLY4ixPdWK9KGZQ0j1FRwJlwe2
         1vQibLOd3Sps3uPQCFRR3uQdOqh5BrEm5cWRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=k+kbCYDjnsVeP9hHbbRLUAufVwVIvwsxXJH+X9ggYxyS19FZArdYnIyUG7h+Kvexn4
         zB1e8Rqf2dAijKCCa/i8Ohak4WYVenJata0a2IhMLkTh5/XtQbgitP4SEM/bMTuwrJKO
         ACn8N4m/nC2eYTopdvPW6QR1RJic4PqGYiQ0I=
Received: by 10.204.74.85 with SMTP id t21mr2626420bkj.128.1299441655043; Sun,
 06 Mar 2011 12:00:55 -0800 (PST)
Received: by 10.204.124.5 with HTTP; Sun, 6 Mar 2011 12:00:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168529>

Hi,
Say, I would like to get just the recent history of two branches of a
big project with, for example:
git clone -b REL-1_10_0_PATCHES --depth  99
git://git.postgresql.org/git/pgadmin3.git pgadmin-1.10
git clone -b REL-1_12_0_PATCHES --depth 299
git://git.postgresql.org/git/pgadmin3.git pgadmin-1.12

If the 1st one were not a shallow clone, we could have --referenced it
in the 2nd command to avoid unnecassary downloads of many objects, but
since the history of the project is very big we just want some recent
history. Is the following commandline syntax too absurd/naive for a
new feature of git :?

git clone -b REL-1_10_0_PATCHES --depth 99 -b REL-1_12_0_PATCHES
--depth 299 git://git.postgresql.org/git/pgadmin3.git pgadmin-1.10
pgadmin-1.12

this is supposed to download the two branches simultaneously into two
respective local directories, making any possible download savings
along the way.

Thanks,
Serhat
