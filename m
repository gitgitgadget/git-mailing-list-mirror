From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 0/7] Prepare git-remote-helpers series for hg support
Date: Wed, 28 Oct 2009 23:40:19 -0700
Message-ID: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:49:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Op1-0005WG-0q
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505AbZJ2GtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 02:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756502AbZJ2GtG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:49:06 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63668 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498AbZJ2GtF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 02:49:05 -0400
Received: by mail-pw0-f42.google.com with SMTP id 9so1254429pwj.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=DeIvGl8lvvBbB9q7sg0H4AoaGia+nL4F3pE7x3Exub0=;
        b=Ksx+jQkNlaNHkBDzxXewuri1qB05v8lenNMKmZY7wQWNkb/04vwKJwwhez8jdbIVry
         PDORQg22+cH0dpPXOqPSmkOwIAn1DwwM51eC0DEs+yby/5ECF8c1MwJkE3iFNh1hAf/V
         qLwj/TX5THrDZkVZ+Be1uebsYu11iZu9+UGAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=mZgT7r3y9P3yvzGhYnYcahgurvAuuiJxdqL8Kw7xoryAjiDF464AMy+ljhL/IoVu4D
         /7K3nQEMAIetA82nURn6gPj+xYMHglfDSjOJCp0DjrpZToccyTxLqArr/ApCfW32+xNh
         8w6+J8PMTCsIaSoY8CohhmjFTN+Hs5w2WUbZM=
Received: by 10.115.81.24 with SMTP id i24mr9863936wal.194.1256798481234;
        Wed, 28 Oct 2009 23:41:21 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm401242pxi.1.2009.10.28.23.41.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 23:41:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131564>

This series does not add hg support, but it does do all the
refactoring that is needed to make it possible. With this series
applied actually adding full-fledged hg support is a matter of adding
the git-remote-hg file.
The reason the git-remote-hg file is not included in this series is
that while I have finished support for 'git clone hg::/path/to/hg' as
well as 'git fetch hg::/path/to/hg' and 'git fetch hgremote',
currently it does a full export on each run (that is, incremental
fetch is not supported).
Nevertheless, I think it is vital that this is included in the series
before we do anything serious with it. I hope to have the
git-remote-hg bit done tomorrow before I get on my airplane, but no
promises there.

Junio, I can try to re-roll the entire series after I finish
git-remote-hg, or I can just send it in on top of this series.

Based on abdcdc5c [More fixes to the git-remote-cvs...].

Johannes Schindelin (1):
      Finally make remote helper support useful

Sverre Rabbelier (5):
      .gitignore: add git-remote-cvs
      Add notify and warn to util.py
      Allow both url and foreign vcs in remote config
      When updating refs after a fetch, resolve the symref if set
      Factor ref updating out of fetch_with_import

 .gitignore                 |    1 +
 builtin-clone.c            |    7 +++++++
 builtin-fetch.c            |    4 ++++
 git_remote_helpers/util.py |    8 ++++++++
 remote.c                   |    2 +-
 transport-helper.c         |   22 +++++++++++++++-------
 transport.c                |   10 ++++++++++
 transport.h                |    7 +++++--
 8 files changed, 51 insertions(+), 10 deletions(-)
