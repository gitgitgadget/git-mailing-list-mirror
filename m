From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
 the history
Date: Sun, 06 Nov 2005 21:22:33 -0500
Message-ID: <436EBA69.6000900@michonline.com>
References: <436E85DA.1080904@michonline.com> <7vll01ut6j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEB914880F98123D0762A509A"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 03:23:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYweu-0002fo-GD
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 03:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVKGCWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 21:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVKGCWn
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 21:22:43 -0500
Received: from mail.autoweb.net ([198.172.237.26]:39366 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932407AbVKGCWn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 21:22:43 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EYweg-0002hI-8h; Sun, 06 Nov 2005 21:22:42 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EYwef-0005UN-00; Sun, 06 Nov 2005 21:22:41 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1EYweb-0002u6-E4; Sun, 06 Nov 2005 21:22:37 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll01ut6j.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11248>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB914880F98123D0762A509A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> 
>>I've written a tool that will take a single commit, add it as a parent
>>of another commit, and recreate the history above that second commit in
>>a fully compatible manner.
> 
> 
> I think the procedure is reproducible, which is a very nice
> property to have for a tool like this, but I am not sure what
> you mean by "in a fully compatible manner".  What are you
> compatible with?

Well, what I meant was, "It creates a history that is purely a superset
of the old history, so merges should work cleanly from the pre-graft
subhistory to the fully merged history."

But clearly I was too ... terse.

IOW, this should work perfectly, assuming neither tree has been pulled
into since the history was merged into historical-graft tree:

$ cd linux-head
$ git branch -b ryan-hacking HEAD
$ quilt push -a
$ git commit -a -m "Apply quilt tree"

$ cd ../linux-historical-graft/
$ git pull ../linux-historical-graft/

> Also another rhetorical, tongue-in-cheek question.  What is your
> plan to ripple the graft through to update signed tags?  ;-)

:) Well, since I can't resist answering your rhetorical question:

They signed a specific DAG.  I'm providing a richer, more complete DAG
that is a pure-superset of the one they signed.  It is not, however,
equivalent, so their signature is not related to the superset DAG I have
created.  In practice, however, I don't expect that any tag-signers
would state that there is a meaningful difference between the two DAGs,
from the perspective of their signature.

FYI - I don't think merging the trees like this is a good idea, from the
perspective of something like gitk - gitk took long enough to startup
and display something on my merged tree here that I gave up and killed
it off.


--------------enigEB914880F98123D0762A509A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDbrpsfhVDhkBuUKURAsVUAJ4xIpbAiXkEUO8RqPXl0AezqiQUEACfSgTQ
4iOtWRQhPkmmMhDdLfmbsAw=
=t2QH
-----END PGP SIGNATURE-----

--------------enigEB914880F98123D0762A509A--
