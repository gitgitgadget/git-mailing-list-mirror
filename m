From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2 00/12] Support customizable label decorations
Date: Wed, 11 Feb 2009 19:40:02 +0100
Message-ID: <1234377614-23798-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:42:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK22-0005RI-5p
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778AbZBKSjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:39:43 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756851AbZBKSjm
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:39:42 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:1116 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756501AbZBKSjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:39:40 -0500
Received: by fg-out-1718.google.com with SMTP id 16so108715fgg.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=/EAUOpfxqyIJpXAbNfLz3MH5AvmewAGQxkEpA7ng14A=;
        b=ILMFK1VybwE1GLsJKsp5gkgUtotAO/xdiTPW9JQJoTDFUYqyusN9E2q0CmixPPZeh6
         6tkIiNlQ0pQPWDtc9U9Vf9Vsj1HB6MsR0CVc4LaixUl8XoJYEw0cyd5rb8ktqVia7qWy
         neGOsTMl/SRP3zBg9AmR7p8XLxicGQjHJ8d54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VIfctTVv6DpQqgbRXa9hFcAJQ0edg1BhhRBQXqa5dBDNdaVJ1iGP0TswIJiJ7ac4bF
         XGpKHE9U+e0LTPU78zNu7Ao6KbHXS9blgS3z4ogH8E4bNjl0UtA6N9L5IIqA4WwcTW0L
         KrSJS85WAqBCs3owinD1kVkAReLe6GMuvO1VQ=
Received: by 10.86.91.3 with SMTP id o3mr838259fgb.77.1234377579424;
        Wed, 11 Feb 2009 10:39:39 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id d6sm4913720fga.49.2009.02.11.10.38.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 10:38:52 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id CB8B8468001; Wed, 11 Feb 2009 19:40:14 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109487>

This series adds support for customizable label decorations, which
is usefull for hiding selected decorations, or tweaking the format
of the decoration text.

Changes in v2:

  - Fixed layout issues in preference dialog
  - Icons replaced to match established conventions
  - 'Assume unchanged' icon is back
  - Added tooltips in the preference dialog
  - 'Added and dirty' is now decorated appropriately
  - Refactored container decorations. Now shares code path with
    files for more accurate results, and to allow inheritance

Decorations are edited using the new Team->Git->Label Decorations
preference page, which is based off similar functionality from the
existing CVS and SVN team providers.

Icons can be enabled and disabled individually, and text can be
customized by reordering and editing the set of mapped variables.
Boolean variables like 'dirty' and 'staged' can be customized by
postfixing the variable name with a colon and a selected string
that should be insert if the variable evaluates to true.

The two general options control traversal of child and parent
elements during decoration. The first, 'Also re-decorate...',
controls whether or not ancestor elements of the current decorated
elment will also be scheduled for re-recoration. The second,=20
'Maximum number of levels...', controls how deep the container
decoration algorithm will recurse when trying to determine the
state (dirty, staged, etc.) of a container.

Tweaking these options will improve performance for large trees.

The code should work fairly well for most usecases, but I may have
missed cases where the decorations will fail misserably. If so,=20
please let me know.=20

Known issues are:

  - If a project has a repository more than one level above the
    project directory decorations will fail.

  - When a Java resource is dirty, each package in the package
    hierarcy will appear dirty, also when the layout is set
    to 'flat', which can be confusing.

These are on my list for features to add on top of these series,
but I consider them non-blocking. This also goes for online help,
which will be added when things stabilize some more.

I've also sprinkled the code with TODOs where I found possible=20
future improvments. One such improvment is performance, where for
example refactoring to use one shared status cache should help.

Tor Arne



Tor Arne Vestb=C3=B8 (12):
  Add support code to handle plugin property changes
  Use Set instead of array to keep track of change listeners
  Add a specialized team exception for Git
  Add new class ExceptionCollector for grouping exceptions
  Add new class SWTUtils with helper-methods for creating controls
  Implement basic customizable label decorations with preferences
  Add binding for name of the current branch
  Add icon decoration for tracked and untracked resources
  Implement icon and text decorations of various resource states
  Don't decorate every single resource on repository change
  Expose the underlying resource entries in ContainerTreeIterator
  Implement label decorations for folders and projects

 org.spearce.egit.core/META-INF/MANIFEST.MF         |    5 +-
 .../spearce/egit/core/ContainerTreeIterator.java   |   23 +-
 .../src/org/spearce/egit/core/GitException.java    |  168 ++++
 .../core/internal/util/ExceptionCollector.java     |  128 +++
 .../spearce/egit/core/project/GitProjectData.java  |   40 +-
 org.spearce.egit.ui/icons/ovr/assume_valid.gif     |  Bin 0 -> 85 byte=
s
 org.spearce.egit.ui/icons/ovr/assumevalid.gif      |  Bin 64 -> 0 byte=
s
 org.spearce.egit.ui/icons/ovr/conflict.gif         |  Bin 64 -> 194 by=
tes
 org.spearce.egit.ui/icons/ovr/pending_add.gif      |  Bin 64 -> 0 byte=
s
 org.spearce.egit.ui/icons/ovr/pending_remove.gif   |  Bin 111 -> 0 byt=
es
 org.spearce.egit.ui/icons/ovr/shared.gif           |  Bin 106 -> 0 byt=
es
 org.spearce.egit.ui/icons/ovr/staged.gif           |  Bin 0 -> 114 byt=
es
 org.spearce.egit.ui/icons/ovr/staged_added.gif     |  Bin 0 -> 169 byt=
es
 org.spearce.egit.ui/icons/ovr/staged_removed.gif   |  Bin 0 -> 176 byt=
es
 org.spearce.egit.ui/icons/ovr/untracked.gif        |  Bin 0 -> 79 byte=
s
 org.spearce.egit.ui/plugin.properties              |    1 +
 org.spearce.egit.ui/plugin.xml                     |   12 +-
 .../src/org/spearce/egit/ui/Activator.java         |   68 ++
 .../egit/ui/PluginPreferenceInitializer.java       |   15 +
 .../src/org/spearce/egit/ui/UIIcons.java           |   21 +-
 .../src/org/spearce/egit/ui/UIPreferences.java     |   21 +
 .../src/org/spearce/egit/ui/UIText.java            |   99 ++-
 .../src/org/spearce/egit/ui/internal/SWTUtils.java |  595 ++++++++++++
 .../egit/ui/internal/actions/BranchAction.java     |    4 +-
 .../egit/ui/internal/actions/Disconnect.java       |    4 +-
 .../egit/ui/internal/actions/ResetAction.java      |    4 +-
 .../decorators/DecoratableResourceAdapter.java     |  391 ++++++++
 .../decorators/GitLightweightDecorator.java        |  653 ++++++++++++=
++
 .../internal/decorators/GitResourceDecorator.java  |  454 ----------
 .../internal/decorators/IDecoratableResource.java  |  100 ++
 .../preferences/GitDecoratorPreferencePage.java    |  949 ++++++++++++=
++++++++
 .../src/org/spearce/egit/ui/uitext.properties      |   38 +-
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |    9 +
 33 files changed, 3310 insertions(+), 492 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/Git=
Exception.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/int=
ernal/util/ExceptionCollector.java
 create mode 100644 org.spearce.egit.ui/icons/ovr/assume_valid.gif
 delete mode 100644 org.spearce.egit.ui/icons/ovr/assumevalid.gif
 delete mode 100644 org.spearce.egit.ui/icons/ovr/pending_add.gif
 delete mode 100644 org.spearce.egit.ui/icons/ovr/pending_remove.gif
 delete mode 100644 org.spearce.egit.ui/icons/ovr/shared.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/staged.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/staged_added.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/staged_removed.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/untracked.gif
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/SWTUtils.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/DecoratableResourceAdapter.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/GitLightweightDecorator.java
 delete mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/GitResourceDecorator.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/IDecoratableResource.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/preferences/GitDecoratorPreferencePage.java
