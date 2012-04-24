From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 22:26:58 +0200
Message-ID: <4F970C92.3030704@web.de>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com> <m3hawjagw9.fsf@localhost.localdomain> <nng3983phhc.fsf@transit.us.cray.com> <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com> <201204171837.q3HIbbcW013784@no.baka.org> <CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com> <nng1unmnksx.fsf@transit.us.cray.com> <4F8EB157.5060707@web.de>        <nngbomh3uz0.fsf@transit.us.cray.com> <201204241759.q3OHxSbH017287@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: dag@cray.com, Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, greened@obbligato.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 22:37:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMmU6-0008Sx-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 22:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab2DXUhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 16:37:08 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:48034 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab2DXUhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 16:37:07 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Apr 2012 16:37:06 EDT
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7A0A91AD32406
	for <git@vger.kernel.org>; Tue, 24 Apr 2012 22:27:05 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.185.25]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LbIiI-1RyC9n3Epm-00kwPZ; Tue, 24 Apr 2012 22:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <201204241759.q3OHxSbH017287@no.baka.org>
X-Provags-ID: V02:K0:Mra1Xf6iry6Ngs3tPAZEJAHZyI4xTHF8FyCu8/wVeIi
 nWA7pKvf20zX1T0po2aSRzBmOe8mL9YpjEgHc7Kepa7RtKPAtw
 BILqG7xDj6mfAGb4s+eL/42U9RrlnJcUaIcItInHaKmorRkfZ1
 Y6hP4d1skU726yzhvSGhA8VRiRFVqFzEJ/9n12FrnpJ9GRGBRL
 6D7yKU6GSDujUWFF42HUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196248>

Am 24.04.2012 19:59, schrieb Seth Robertson:
> 
> In message <nngbomh3uz0.fsf@transit.us.cray.com>, dag@cray.com writes:
> 
>     > I agree and am willing to provide information about submodule use cases,
>     > advantages and problems, but I'm not a user of subtree so I can't really
>     > comment on it. Now that subtree is in git core, what about putting such
>     > a comparison under Documentation/subproject-support.txt?
> 
>     That would be great.  Do you want to start work on that?  I can
>     contribute some text about git-subtree.
> 
> I have a document I created for gitslave which I have cleaned up a bit
> and might be the start of such comparison.

Thanks for providing the input. Unfortunately I'll be pretty occupied for
the next three weeks, so I won't be able to put much work into that before
mid-May. But maybe we can get the ball rolling ...

In the end I'd like to see a document people can use to decide what
subproject support suits their needs best. Maybe it should start with
the basic concept behind each of them:

submodules: A submodule is a full fledged repository of which a certain
commit is recorded in a gitlink entry in each of the the superproject's
commits.
The emphasis lies on tightly coupling versions of both while keeping the
boundaries between superproject and submodules visible.
This leads to some extra cost when doing changes in a submodule but makes
it easy to evaluate and select new changes from upstream and push back
local changes to their respective upstream.

subtree: All subprojects become an integral part of the history of the
superproject.
The emphasis lies on incorporating the subtree and its history into the
superproject.
That adds some extra cost when it comes to pushing subtree changes back
to their upstream (starting with the need for careful commit planning for
local commits intended to be pushed out again) and less fine grained
control over importing changes from the subtrees upstream.

gitslave: This creates a federation of full fledged git repositories which
are operated on by the gits commands together (where a git command would
only operate on the superproject).
The emphasis lies on the simultaneous operation of gits commands on all
git repositories.
It does not provide any coupling of the commits in the superproject and the
slave repositories (but you can use tags to have that at some points in the
history).


What do you think? (Please point out anything I misrepresented in the last
two paragraphs, they are based solely on what I picked up on this list and
are not based on any actual experience ;-)

Then we could describe in a table what to do when to fetch new subproject
commits, how to "select" them in the superproject and how to push them
back to their respective upstream. Another interesting question could be
how a bug in a subproject that affects the superproject is handled in each
of the scenarios.
Does that sound like a start?
