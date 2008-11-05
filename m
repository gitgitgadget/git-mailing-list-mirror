From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3 v2] bisect: add "git bisect replace" subcommand
Date: Wed, 5 Nov 2008 18:51:11 +0100
Message-ID: <200811051851.11376.chriscool@tuxfamily.org>
References: <20081104183506.bb9af13a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 18:50:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxmWU-0000KP-3Y
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 18:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbYKERsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Nov 2008 12:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYKERsy
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 12:48:54 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:49911 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbYKERsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2008 12:48:53 -0500
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id AF6E632AC0E;
	Wed,  5 Nov 2008 18:48:47 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp8-g19.free.fr (Postfix) with ESMTP id DCCA532A93D;
	Wed,  5 Nov 2008 18:48:44 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081104183506.bb9af13a.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100168>

Le mardi 4 novembre 2008, Christian Couder a =E9crit :
> This subcommand should be used when you have a branch or a part of a
> branch that isn't easily bisectable because of a bug that has been
> fixed latter.
>
> We suppose that a bug as been introduced at some point, say A, and
> that it has been fixed latter at another point, say B, but that
> between these points the code is not easily testable because of the
> bug, so it's not easy to bisect between these points.
>
> In this case you can create a branch starting at the parent of A, say
> O, that has a fixed history. In this fixed history for example, there
> could be first a commit C that is the result of squashing A and B
> together and then all the commits between A and B that have been
> cherry picked.
>
> For example, let's say the commits between A and B are X1, X2, ... Xn
> and they have been cherry picked after C as Y1, Y2, ... Yn:
>
>         C--Y1--Y2--...--Yn
>       /
> ...--O--A--X1--X2--...--Xn--B--...
>
> By design, the last cherry picked commit (Yn) should point to the sam=
e
> tree as commit B.
>
> So in this case you can say:
>
> $ git bisect replace B Yn
>
> and commit B will be tagged with a special name like:
> "bisect-replace-with-Yn"
>
> (A branch that points to commit Yn will also be created with a name
> like: "bisect-replace-B")

It occured to me that perhaps only the branch is needed and we can get =
rid=20
of the tag. This should remove the need to check that the branch still=20
exists when we are creating grafts.

I will see what I an come up with.

Regards,
Christian.
