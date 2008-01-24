From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/4] --diff-opts in config file
Date: Thu, 24 Jan 2008 09:06:54 +0100
Message-ID: <20080124075935.25525.24416.stgit@yoghurt>
References: <20080124074827.GA29572@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 09:07:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHx7o-0005mn-5g
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 09:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYAXIHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 03:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbYAXIHP
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 03:07:15 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4362 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbYAXIHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 03:07:13 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JHx76-0005J9-00; Thu, 24 Jan 2008 08:07:08 +0000
In-Reply-To: <20080124074827.GA29572@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71599>

This is first two cleanup patches, followed by one patch that makes
"stg show" handle diff options like the other commands, and last a
patch that reads diff opts from the config file.

The first two patches are in kha/safe, but the latter two are in
kha/experimental because -- as Yann pointed out -- it's good to make
sure the design is OK before committing to it.

I've solved the problem of overriding the config on the command line
by making --diff-opts=3D'--foo --bar' _add_ options, and special-cased
--diff-opts=3D'' to clear all options, including those from the config
file, since appending no options makes no sense.

We'll still have to consider if and how to support different options
for different tools.

Oh, and Jon: is this what you wanted, by the way? :-)

---

Karl Hasselstr=C3=B6m (4):
      Read default diff options from the user's config
      Let "stg show" use the unified --diff-opts handling
      Refactor --diff-opts handling
      Remove unused default values


 examples/gitconfig       |    4 ++++
 stgit/commands/diff.py   |   14 ++++----------
 stgit/commands/edit.py   |   14 +++-----------
 stgit/commands/export.py |   12 +++---------
 stgit/commands/files.py  |   13 ++++---------
 stgit/commands/mail.py   |   12 +++---------
 stgit/commands/show.py   |   13 ++++---------
 stgit/commands/status.py |   17 +++++------------
 stgit/utils.py           |   13 +++++++++++++
 9 files changed, 43 insertions(+), 69 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
