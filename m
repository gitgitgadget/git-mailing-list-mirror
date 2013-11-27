From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: How to pre-empt git pull merge error?
Date: Wed, 27 Nov 2013 20:06:59 +0100
Message-ID: <878uw9hdf0.fsf@thomasrast.ch>
References: <86d2llc1rs.fsf@gmail.com>
	<20131127194240.2abaff5575961b3d73e1970f@domain007.com>
	<vpq8uw9q1r4.fsf@anie.imag.fr>
	<CALWbr2wNODeLSmQ5ztQmKVxBSguNJ1bbSbvY66sdsP09dSUUgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Pete Forman <petef4+usenet@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 20:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlkS9-0000CP-Rq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 20:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117Ab3K0THJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 14:07:09 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:60635 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754778Ab3K0THI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 14:07:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 133A24D6572;
	Wed, 27 Nov 2013 20:07:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6hTkBwM6K2Em; Wed, 27 Nov 2013 20:06:58 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id BEBC74D64DE;
	Wed, 27 Nov 2013 20:06:57 +0100 (CET)
In-Reply-To: <CALWbr2wNODeLSmQ5ztQmKVxBSguNJ1bbSbvY66sdsP09dSUUgA@mail.gmail.com>
	(Antoine Pelisse's message of "Wed, 27 Nov 2013 17:38:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238455>

Antoine Pelisse <apelisse@gmail.com> writes:

>>> On Wed, 27 Nov 2013 15:17:27 +0000
>>> Pete Forman <petef4+usenet@gmail.com> wrote:
>>>
>>>> I am looking for a way of detecting up front whether a git pull or git
>>>> merge would fail. The sort of script I want to perform is to update a
>>>> server.
>>>>
>>>>     git fetch
>>>>     git okay
>>>>     stop server
>>>>     backup data
>>>>     git merge
>>>>     start server
>>>>
>> I don't know a simple way to do the pre-merge check without actually
>> doing the merge (other than patching git merge to add a --dry-run
>> option)
>
> Wouldn't that be a nice use-case for git-recursive-merge --index-only
> ($gmane/236753) ?

Possibly, but most of the use-cases for merge --dry-run are better
answered by the XY Problem question:

Can you step back and explain what the *underlying* goal is?

The above sounds a lot like a deployment script, and such scripts are
almost always better served by using an actual deployment tool, or
failing that, by using some form of checkout -f instead, to ensure that
they get whatever they are supposed to deploy.

(Using a merge to update is really terrible in the face of
non-fast-forward updates, especially when caused by rewriting history to
not include some commits.)

-- 
Thomas Rast
tr@thomasrast.ch
