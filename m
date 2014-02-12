From: Mike Hommey <mh@glandium.org>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 08:03:38 +0900
Message-ID: <20140212230338.GA7208@glandium.org>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <robbat2-20140212T015847-248245854Z@orbis-terrarum.net>
 <CACsJy8AStrZBtSqRiwBtonfW5y0ar=9Z371fE2Krwj=P-w7ERw@mail.gmail.com>
 <52FB5443.8030200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 00:28:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDjDi-0001GU-UH
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 00:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbaBLX1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 18:27:41 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:37254 "EHLO
	zenigata.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752878AbaBLX1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 18:27:40 -0500
Received: from glandium by zenigata.glandium.org with local (Exim 4.82)
	(envelope-from <glandium@glandium.org>)
	id 1WDiqA-0002CE-GQ; Thu, 13 Feb 2014 08:03:38 +0900
Content-Disposition: inline
In-Reply-To: <52FB5443.8030200@gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242034>

On Wed, Feb 12, 2014 at 12:00:19PM +0100, Karsten Blees wrote:
> Am 12.02.2014 04:43, schrieb Duy Nguyen:
> > On Wed, Feb 12, 2014 at 9:02 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> >> On Tue, Feb 11, 2014 at 05:54:51PM -0800,  Stefan Zager wrote:
> >>> We in the chromium project have a keen interest in adding threading to
> >>> git in the pursuit of performance for lengthy operations (checkout,
> >>> status, blame, ...).  Our motivation comes from hitting some
> >>> performance walls when working with repositories the size of chromium
> >>> and blink:
> >> +1 from Gentoo on performance improvements for large repos.
> >>
> >> The main repository in the ongoing Git migration project looks to be in
> >> the 1.5GB range (and for those that want to propose splitting it up, we
> >> have explored that option and found it lacking), with very deep history
> >> (but no branches of note, and very few tags).
> > 
> > From v1.9 shallow clone should work for all push/pull/clone... so
> > history depth does not matter (on the client side). As for
> > gentoo-x86's large worktree, using index v4 and avoid full-tree
> > operations (e.g. "status .", not "status"..) should make all
> > operations reasonably fast. I plan to make "status" fast even without
> > path limiting with the help of inotify, but that's not going to be
> > finished soon. Did I miss anything else?
> > 
> 
> Regarding git-status on msysgit, enable core.preloadindex and core.fscache (as of 1.8.5.2).
> 
> There's no inotify on Windows, and I gave up using ReadDirectoryChangesW to
> keep fscache up to date, as it _may_ report DOS file names (e.g. C:\PROGRA~1
> instead of C:\Program Files).

You can use GetLongPathNameW to get the latter from the former.

Mike
