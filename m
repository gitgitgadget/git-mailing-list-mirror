From: Matthias Urlichs <matthias@urlichs.de>
Subject: Shallow clones with explicit history cutoff?
Date: Thu, 21 Aug 2014 15:39:13 +0000 (UTC)
Message-ID: <loom.20140821T171416-31@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 17:39:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKUSc-0000RE-E2
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 17:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbaHUPja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 11:39:30 -0400
Received: from plane.gmane.org ([80.91.229.3]:58133 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120AbaHUPj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 11:39:29 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XKUST-0000Mi-PB
	for git@vger.kernel.org; Thu, 21 Aug 2014 17:39:25 +0200
Received: from netz.smurf.noris.de ([213.95.21.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 17:39:25 +0200
Received: from matthias by netz.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 17:39:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.95.21.43 (Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0 Iceweasel/30.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255619>

Hi,

use case: I am packaging the FOO program for Debian. FOO is maintained in
git but it has a bunch of problems (e.g. because somebody mistakenly checked
in a huge blob which would give the ).

The current workflow for this is to create a new branch, remove the
offending bits if necessary, create a FOO-clean.tar.xz file, and ship that
as "original source". I find that to be suboptimal.

What I would like to have, instead, is a version of shallow cloning which
cuts off not at a pre-determined depth, but at a given branch (or set of
branches). In other words, given

            +-J--K  (packaged)
           /    /
  +-F--G--H----I    (clean)
 /       /
A---B---C---D---E   (upstream)

a command "git clone --shallow-until upstream $REPO" (or however that would
be named) would create a shallow git archive which contains branches
packaged+clean, with commits FGHIJK. In contrast, with --single-branch and
--depth 4 I would get CGHIJK, which isn't what I'd want.

As I have not spent too much time with the git sources lately (as in "None
at all"), some pointers where to start implementing this would be
appreciated, assuming (a) this has a reasonable chance of landing in git and
(b) nobody beats me to it. ;-)

-- 
-- Matthias Urlichs
