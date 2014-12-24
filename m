From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 0/5] Fix the Visual Studio 2008 .sln generator
Date: Wed, 24 Dec 2014 10:47:09 +0000
Message-ID: <1419418034-6276-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Msysgit <msysgit@googlegroups.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 11:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3jTV-0004aY-Qz
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 11:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbaLXKrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 05:47:14 -0500
Received: from b216.a.smtp2go.com ([216.22.18.216]:60370 "EHLO
	b216.a.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaLXKrN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 05:47:13 -0500
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261802>

Potential Windows developers are likely to be using Visual Studio as
their IDE. The tool stack required for Windows can be tortuous as it
crosses the boundaries between platforms and philosophies. This patch
series seeks to maintain the tools that could assist such developers.
In particular, those tools that generate an initial Visual Studio
project (.sln ) file.

The .sln generator in contrib began to break when internationalisation
introduced an extra -o option. This recently worsened with the addition
of invalidcontinue.obj for 'improved POSIX compatibility'.

I hacked a bit when I first attempted to use the VS IDE and noticed the
i18n issue. I didn't completely solve all my issues because of further
issues with VS2010 Express, so no patches were submitted at the time.

Now, with a fresh copy of VS20008 Express, I saw the additional problem
of the addition of the invalidcontinue.obj reference causing the .sln
generation to fail.

The series has been tested against both recent git/git and msysgit/git.
Both produce good VS2008 .sln project files though only msysgit/git
compiles without error, both using the msysgit msvc-build script.
Those compile errors are not related to this patch series.

An initial RFC version was discussed on the msysgit list
https://groups.google.com/forum/#!topic/msysgit/3MQ_NMNM390 or
http://thread.gmane.org/gmane.comp.version-control.msysgit/21132.

The final patch adds a poorman's --verbose by a few carefully selected
commented out debug print statements to assist others in resolving
future breakages.

I've cc'd those who have contributed or patched the engine.pl, or
appear to be interested via a $gmane search, who can hopefully comment.


Philip Oakley (5):
  engine.pl: Fix i18n -o option in msvc buildsystem generator
  engine.pl: Properly accept quoted spaces in filenames
  engine.pl: ignore invalidcontinue.obj which is known to MSVC
  vcbuild/readme: Improve layout and reference msvc-build script
  engine.pl: provide more debug print statements

 compat/vcbuild/README          | 27 +++++++++++++++++++--------
 contrib/buildsystems/engine.pl | 27 +++++++++++++++++++++------
 2 files changed, 40 insertions(+), 14 deletions(-)

-- 
2.1.0
