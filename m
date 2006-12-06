X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: bug: git-sh-setup should not be in $PATH
Date: Wed, 06 Dec 2006 13:14:27 +0100
Message-ID: <el6c6o$oa7$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 12:14:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 33
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33437>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrvfV-00085I-Pe for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760534AbWLFMOa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760543AbWLFMOa
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:14:30 -0500
Received: from main.gmane.org ([80.91.229.2]:46447 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760534AbWLFMOa
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 07:14:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrvfQ-00048T-9M for git@vger.kernel.org; Wed, 06 Dec 2006 13:14:28 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 06 Dec 2006 13:14:28 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006 13:14:28
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Hello,

I often install tools locally so I can run SVN/CVS/etc versions 
in my own account. To do this, I install into

  $HOME/usr/pkg/PACKAGE

and a script that generates scripts in $HOME/usr/bin/ (which is in my $PATH)
like

 #!/bin/sh

 exec /home/lilydev/usr/pkg/git/bin/git-prune "$@"
 # generated: update-pkgs 


this breaks with git-sh-setup; all sh scripts are broken with this
setup.

git-sh-setup isn't a 'normal' binary, in that it should be called by
bash only and not run in a subshell. Therefore I propose that it

- be installed in <prefix>/share/git/

- be invoked with an explicit path, i.e.

  . <prefix>/share/git/



--
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
