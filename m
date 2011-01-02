From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: how to update a submodule?
Date: Sun, 02 Jan 2011 18:30:17 +0100
Message-ID: <4D20B629.8000107@web.de>
References: <20101231222438.GA28199@cs-wsok.swansea.ac.uk> <201012312342.oBVNg1lx021930@no.baka.org> <20110101203957.GC26920@cs-wsok.swansea.ac.uk> <4D2061C7.5050405@web.de> <20110102155514.GB32745@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Sun Jan 02 18:30:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZRld-0007GW-Ak
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 18:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab1ABRa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 12:30:29 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:60754 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558Ab1ABRa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 12:30:28 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 33B7A192DDA6C;
	Sun,  2 Jan 2011 18:30:27 +0100 (CET)
Received: from [93.240.108.214] (helo=[192.168.178.53])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PZRlC-0003iF-00; Sun, 02 Jan 2011 18:30:27 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110102155514.GB32745@cs-wsok.swansea.ac.uk>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19VSLtHQ+D+e0v8Zl98Wlxlrviwqo011O/gvjTw
	m/INWtf2T24/u7Nt/BWfnDatviztvFvnAE16gV/d0AsN//suIB
	Uo3qZiJuUXDZ9LvhD53Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164421>

Am 02.01.2011 16:55, schrieb Oliver Kullmann:
> On Sun, Jan 02, 2011 at 12:30:15PM +0100, Jens Lehmann wrote:
>> Am 01.01.2011 21:39, schrieb Oliver Kullmann:
>>> On Fri, Dec 31, 2010 at 06:42:01PM -0500, Seth Robertson wrote:
>>> As far as I see that, this doesn't concern the problem how to I update
>>> one repository with submodules from another repository with "these" submodules
>>> (as the same paths)?
>>
>> I'm not sure I completely understand your use case, but submodules are
>> repositories of their own, so they don't get updated by just pulling
>> a superproject into another containing the same submodule. The submodule
>> changes have to be pushed to its own parent repository and can then be
>> fetched from there into another superproject's submodule.
> 
> I know that --- but if there wouldn't be any savings possible (in terms of using it),
> then submodules would be pointless, and so the question is *how* to use them.

No, they aren't pointless at all. But if you want to collaborate using
submodules they IMO work best if all your coworkers are able to access
the same submodule repos you are pushing to. Otherwise you'll have to
transport all submodule changes additionally to those of the superproject
(which might be more of a hassle than not using submodules in the first
place). Then you might be better off pulling the modules into your repo
using "git subtree" or "gitslave".

A possibility to put all submodule commits in the object directory of
the superproject has been discussed some time ago on this list [1] and
at the last GitTogether. That might be just what you need, but I am not
aware of any work done in that direction yet.

> The good thing with Git is that there are no central repositories.
> That's exactly what I want to use, but again and again the automatic
> assumptions of "central repositories" are made, which should be actually alien to Git.

No, Git works perfectly fine with central repositories too (and that is
a feature :-). But I think I understand where your impression comes from.
Submodules don't work very well when you change URLs (that can result
in forcing your coworkers to do a "git submodule sync" in their repo
every time they switch to a commit with a changed URL). But while that
somehow works not being able to access a submodules repo doesn't work at
all. So the constraint for submodules is to have a repo which is visible
for the people you work with.

But submodules don't really force you into the centralized model, as you
can modify the .gitmodules file e.g. in a downstream fork and let it point
to your own forked version of the submodules repos where you can do your
own development independent of the submodules upstream.

> Puuuh, I really really tried hard now to make my use-case clear :-|. Hopefully
> now the picture emerges.

Yep, thanks for sharing that!


[1] http://thread.gmane.org/gmane.comp.version-control.git/151473/
