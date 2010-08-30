From: strk <strk@keybit.net>
Subject: git-add creates broken submodules
Date: Mon, 30 Aug 2010 11:09:45 +0200
Message-ID: <20100830090945.GB13729@keybit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 11:22:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq0ZI-0002MF-TS
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 11:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab0H3JVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 05:21:04 -0400
Received: from host147-8-static.59-217-b.business.telecomitalia.it ([217.59.8.147]:4023
	"EHLO freek.keybit.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897Ab0H3JU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 05:20:59 -0400
X-Greylist: delayed 669 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Aug 2010 05:20:58 EDT
Received: (from strk@localhost)
	by freek.keybit.net (8.11.1/8.11.1) id o7U99jn28011;
	Mon, 30 Aug 2010 11:09:45 +0200 (CEST)
	(envelope-from strk@keybit.net)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154779>

Hi there,
with help of doener (#git on freenode) I found
the root cause of a misconfigured git repository
being in the way 'git add <path>' behaves when 
<path> contains a .git repository.

Example:
$ (mkdir foo; cd foo; git init; git commit --allow-empty -m ini); \
  git add foo
$ git submodule status
No submodule mapping found in .gitmodules for path 'foo'

Such commit ended up in our centralized repository so that all
clones now have this 'submodule' w/out entries in .gitmodules
and .git/config.

Should 'git-add' simply consider any .git as a normal entry
instead ? (that's what I'd expect) 
Or, if not, should it warn about the presence of
a .git directory and refuse to continue suggesting
'git submodule add' instead.

NOTE: this happens with git version 1.6.0.2


--strk; 

  ()   Free GIS & Flash consultant/developer
  /\   http://strk.keybit.net/services.html
