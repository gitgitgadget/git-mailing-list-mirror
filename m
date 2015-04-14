From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: Requesting `git stash --cached` or something similar
Date: Mon, 13 Apr 2015 21:44:35 -0400
Message-ID: <20150414014435.GC8601@tsaunders-iceball.corp.tor1.mozilla.com>
References: <37E34942-ACEB-48BC-ABFF-C7248DA6607E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Quinn Taylor <quinntaylor@mac.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 03:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhpu9-0002CR-1V
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 03:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbbDNBol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2015 21:44:41 -0400
Received: from tbsaunde.org ([66.228.47.254]:58670 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbbDNBoj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 21:44:39 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id E0FE2C07C;
	Tue, 14 Apr 2015 01:44:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <37E34942-ACEB-48BC-ABFF-C7248DA6607E@mac.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267107>

On Mon, Apr 13, 2015 at 02:24:04PM -0700, Quinn Taylor wrote:
> I'm still fairly new to git (coming from svn) and have found `git sta=
sh` to be really useful for storing in-progress work to resume later, a=
s one might otherwise do with diff/patch files. (With the git tools I u=
se, I find `git stash pop` to be more convenient and reliable than crea=
ting and applying diffs, partially because the changes remained tied to=
 my repository and easily accessible.)
>=20
> Since `git stash` defaults to stashing ALL local modifications, I'd l=
ike to request there be an easy way to stash *only* the changes I've al=
ready staged in the index. (The reason I suggested --cached is due to t=
he similarity with `git diff --cached`, but I don't doubt there would b=
e a better name for this option.)

Ok, so this git stash --cached will save the state of the index in the
stash, and reset the index to the state in HEAD.  What happens to the
working tree?

> I tried staging everything *except* what I want to stash and using `g=
it stash save --keep-index <message>`, but it isn't intended to support=
 this case, and doesn't work when I have new untracked files. Instead, =
it stashes *all* local (tracked) changes =E2=80=94 both staged and unst=
aged =E2=80=94 but leaves the staged changes intact in the index.

What do you want this new command to do with untracked files?

I would expect the answers to be it sets the working directories state
to the state in HEAD, and leaves untracked files alone.  If that's what
you want you can do git commit -m <message>; git reset --hard; git rese=
t
--soft; git stash save to get the effect you want I believe.  That said
it seems like a kind of odd thing to want to do, what are you actually
trying to do?

Trev

>=20
> I understand that git's branching model is powerful and flexible, and=
 that an experienced git user would generally create a private branch a=
nd commit to that, then merge the changes to mainline sometime later. H=
owever, for those like me for whom having many branches is generally mo=
re confusing than helpful, it would be fantastic to have more flexibili=
ty with `git stash`.
>=20
> Thanks in advance for considering my request.
>=20
> Regards,
>  - Quinn
