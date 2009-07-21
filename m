From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/12] Cleanup Config class
Date: Tue, 21 Jul 2009 13:19:18 -0700
Message-ID: <1248207570-13880-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLps-0001jT-A8
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbZGUUTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756101AbZGUUTc
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:32 -0400
Received: from george.spearce.org ([209.20.77.23]:59235 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbZGUUTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:31 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8CF9038200; Tue, 21 Jul 2009 20:19:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 10AE2381FD;
	Tue, 21 Jul 2009 20:19:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123693>

Misc. cleanups of the Config class (aka the base class for
RepositoryConfig) to make the code easier to follow.  I came
about this series because I started to do improvements to the
Config class to better support submodule introspection from a bare
repository... and I realized this code was a mess.

This series (or at least the first patch of it) applies on top of
my prior 11 patch series for alternate object database improvements.

Shawn O. Pearce (12):
  Use NB.readFully(File) to slurp complete file contents
  Correct name of fileRead member of Config class
  Add setLong to Config
  Fix Config setInt(..., 0) to store "0" not "0 g"
  Rename Config.unsetString to just unset()
  Remove pointless null assignments in Config
  Clarify section and subsection values in Config code
  Don't subclass PrintWriter when writing the Config
  Use a Java 5 style iteration over the Config entries list
  Match config subsection names using case sensitive search
  Cleanup Config's MAGIC_EMPTY_VALUE to be more safe
  Remove unreferenced REMOTE_SECTION from RepositoryConfig

 .../src/org/spearce/jgit/lib/Config.java           |  196 +++++++++++---------
 .../src/org/spearce/jgit/lib/FileBasedConfig.java  |    7 +-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   15 +-
 .../src/org/spearce/jgit/lib/ReflogReader.java     |   32 +---
 .../src/org/spearce/jgit/lib/RepositoryCache.java  |   20 +-
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    4 -
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   15 +--
 .../org/spearce/jgit/transport/RemoteConfig.java   |    2 +-
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   52 +++++
 9 files changed, 195 insertions(+), 148 deletions(-)
