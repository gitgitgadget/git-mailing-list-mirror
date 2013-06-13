From: benoit.person@ensimag.fr
Subject: [PATCH/RFC V2 0/4] git-remote-mediawiki: new tool to preview local changes without pushing
Date: Thu, 13 Jun 2013 12:07:15 +0200
Message-ID: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 12:07:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un4RV-0007rX-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 12:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758388Ab3FMKHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 06:07:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36227 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060Ab3FMKHl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 06:07:41 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5DA7WCN025732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 12:07:32 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5DA7Xpd011000;
	Thu, 13 Jun 2013 12:07:33 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5DA7Waa026514;
	Thu, 13 Jun 2013 12:07:33 +0200
X-Mailer: git-send-email 1.8.3.GIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 13 Jun 2013 12:07:32 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227711>

From: Benoit Person <benoit.person@ensimag.fr>

The #7 issue on git-mediawiki's issue tracker [1] states that the ability to
preview content without pushing would be a nice thing to have.

This serie is a second attempt to achieve it:
  - It adds a new GitMediawiki.pm package to share code between the new tool and 
    `git-remote-mediawiki.perl`. (PATCH 1 & 2)
  - It creates a new "meta"-command `git mw` with subcommand handling (PATCH 3)
  - It adds a new subcommand named `preview` to `git mw` (PATCH 4)

changes from the V0:
  - add new package GitMediawiki
    - move some of git-remote-mediawiki functions into the package
    - update git-remote-mediawiki to use those "moved" functions
    - add a hacky-way to install it in the Makefile
    - use it in the new git mw tool
  - add a way to give to the preview tool blobs as argument
  - add a fallback when the upstream's branch remote is not a mediawiki remote
  - update the `autoload` option to use `git web--browse` and not `xdg-open`
  - update the way we find the upstream's branch remote name

For now, this PATCH/RFC is based on the 'next' branch merged with the 
bp/mediawiki-credential patch. For the final version, I will try 
to rebase it on celestin's work with perlcritic.

[1] https://github.com/moy/Git-Mediawiki/issues/7

Benoit Person (4):
  git-mw: Introduction of GitMediawiki.pm
  git-mw: Moving some functions from git-remote-mediawiki.perl to
    GitMediawiki.pm
  git-mw: Adding git-mw.perl script
  git-mw: Adding preview tool in git-mw.perl

 contrib/mw-to-git/GitMediawiki.pm           |  94 +++++++++++
 contrib/mw-to-git/Makefile                  |  22 ++-
 contrib/mw-to-git/git-mw.perl               | 247 ++++++++++++++++++++++++++++
 contrib/mw-to-git/git-remote-mediawiki.perl |  80 ++-------
 4 files changed, 373 insertions(+), 70 deletions(-)
 create mode 100644 contrib/mw-to-git/GitMediawiki.pm
 create mode 100644 contrib/mw-to-git/git-mw.perl

-- 
1.8.3.GIT
