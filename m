From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 00/12] Reroll of the remote-vcs-helper series
Date: Fri,  6 Nov 2009 23:52:34 +0100
Message-ID: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:53:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Xgm-000813-Ns
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759940AbZKFWxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 17:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbZKFWxa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:53:30 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:48718 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbZKFWx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:53:27 -0500
Received: by ewy3 with SMTP id 3so1557918ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=NTIbmXFFZzaW2XaUXs/eVCRSoHG2qmYAyHP14XrHkm0=;
        b=TNNSWbUU3m3WkR2OwSHm3ixV/gxt8y6+KsWX9seJrY5Q2SuAPrtr70rtDg2/dMgNva
         9vqtu8esgZcr7xCAUTByiJN2pnI5+cGm9HGAVdjZiiZSd0iEIrfDgfbGe4ghSWeoQ0pb
         AIM3Y70xBOJh1uP8AX9Iku+08makDo/hc2ups=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=hzRFlk68nDFoPwDhhxphDwVBqRdNb8wbL0OGfzi8msskRWnYSLFeoAYj1Y5XJPpFnp
         BwHx0Uj83tugVTKwrQurvD3Q59WEDp7B+Y1iVSQrCGn9lN2h8u/q0+Wi6PPuVcsTrfQi
         LLt9IWaP5VhwVteKAcd0TQW/4S/88dsBK9A0c=
Received: by 10.213.100.167 with SMTP id y39mr1708347ebn.59.1257548011364;
        Fri, 06 Nov 2009 14:53:31 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 7sm1501175eyb.40.2009.11.06.14.53.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:53:30 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.158.g6dacb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132328>

My helper is fully functional now so I think after one more round
this will be ready for next (we need some more documentation).

Daniel Barkalow (8):
      Fix memory leak in helper method for disconnect
      Allow programs to not depend on remotes having urls
      Use a function to determine whether a remote is valid
      Allow fetch to modify refs
      Add a config option for remotes to specify a foreign vcs
      Add support for "import" helper command
      Allow helper to map private ref names into normal names
      Allow helpers to report in "list" command that the ref is unchanged

Johan Herland (1):
      Basic build infrastructure for Python scripts

Johannes Schindelin (1):
      Allow specifying the remote helper in the url

Sverre Rabbelier (2):
      Allow helpers to request the path to the .git directory
      Add Python support library for remote helpers

 Documentation/config.txt             |    4 +
 Documentation/git-remote-helpers.txt |   14 +-
 Makefile                             |   51 +++
 builtin-clone.c                      |    3 +-
 builtin-fetch.c                      |    7 +-
 builtin-ls-remote.c                  |    4 +-
 builtin-push.c                       |   68 ++--
 configure.ac                         |    3 +
 git_remote_helpers/.gitignore        |    2 +
 git_remote_helpers/Makefile          |   35 ++
 git_remote_helpers/__init__.py       |   16 +
 git_remote_helpers/git/git.py        |  678 ++++++++++++++++++++++++++++++++++
 git_remote_helpers/setup.py          |   17 +
 git_remote_helpers/util.py           |  194 ++++++++++
 remote.c                             |   32 ++-
 remote.h                             |    5 +
 t/test-lib.sh                        |   10 +
 transport-helper.c                   |  117 ++++++-
 transport.c                          |   31 ++-
 transport.h                          |   41 ++-
 20 files changed, 1285 insertions(+), 47 deletions(-)
