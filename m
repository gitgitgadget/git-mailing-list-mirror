From: Marc Haber <mh+git@zugschlus.de>
Subject: Re: How to check repository/working tree status from a script
Date: Wed, 20 May 2009 13:10:28 +0200
Message-ID: <20090520111028.GA15453@torres.zugschlus.de>
References: <20090519143537.GA23505@torres.zugschlus.de> <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk> <20090519160031.GB23505@torres.zugschlus.de> <alpine.LFD.2.01.0905190915050.3301@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 13:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6jgy-0006by-Tn
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 13:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZETLK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 07:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbZETLK1
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 07:10:27 -0400
Received: from torres.zugschlus.de ([85.214.68.41]:50694 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbZETLK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 07:10:27 -0400
Received: from mh by torres.zugschlus.de with local (Exim 4.69)
	(envelope-from <mh+git@zugschlus.de>)
	id 1M6jgq-00044S-Ew
	for git@vger.kernel.org; Wed, 20 May 2009 13:10:28 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0905190915050.3301@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119601>

On Tue, May 19, 2009 at 09:18:12AM -0700, Linus Torvalds wrote:
> On Tue, 19 May 2009, Marc Haber wrote:
> > On Tue, May 19, 2009 at 04:34:47PM +0100, Tony Finch wrote:
> > > On Tue, 19 May 2009, Marc Haber wrote:
> > > > I would like to check in a script whether there (a) are uncommitted
> > > > changes (as in "working tree differs from local repository")
> > > 
> > > # check working tree is not different from the index
> > > git diff --quiet
> > > # check that the index is not different from the head
> > > git diff --quiet --cached
> > 
> > $ git diff --quiet; echo $?
> > 0
> > $ git diff --quiet --cached; echo $?
> > 0
> > $ touch keks
> > $ git diff --quiet; echo $?
> > 0
> > $ git diff --quiet --cached; echo $?
> > 0
> > $
> > 
> > Am I missing something?
> 
> If "keks" is already something you know about, then 'touch' wouldn't have 
> changed it, so diff won't show it.

keks didn't exist previously, so the touch generated a new empty 0 byte
file.

> And if what you want to know about is whether there are _new_ files you 
> might want to check, then you need a third check: 'git ls-files'. You 
> won't see it in the error code, but you can do
> 
> 	others=$(git ls-files -o --exclude-standard)
> 
> and then check it 'others' is empty or not.

So parsing the output is both the canonical and only way to do so
since there is no meaningful exit code? Can I assume that the
formatting of git output is not subject to change?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 3221 2323190
