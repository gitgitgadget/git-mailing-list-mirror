From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 03:32:35 +0200
Message-ID: <20090910013235.GA9980@atjola.homenet>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brendan Miller <catphive@catphive.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 03:32:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlYWq-0004GF-1J
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 03:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbZIJBcn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2009 21:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbZIJBcn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 21:32:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:57580 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752679AbZIJBcm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 21:32:42 -0400
Received: (qmail invoked by alias); 10 Sep 2009 01:32:38 -0000
Received: from i59F54B57.versanet.de (EHLO atjola.homenet) [89.245.75.87]
  by mail.gmx.net (mp055) with SMTP; 10 Sep 2009 03:32:38 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19zKT5gDXlzpQq+8X0e5ClNeUjkqJYLIjtfz/YytP
	KhO70/VD24pV4x
Content-Disposition: inline
In-Reply-To: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: -0.07000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128095>

On 2009.09.09 14:27:56 -0700, Brendan Miller wrote:
> 8. There's no obvious way to make a remote your default push pull
> location without editing the git config file. Why not just something
> like
>=20
> git remote setdefault origin

Because "git remote" is the wrong tool. The default remote for
fetch/push is configured per branch head, not globally.

> or even
>=20
> git remote add --default origin http://somegiturl.org/

Because that would likely mean changing all the existing branch head
configurations, quite possibly making them invalid, because the
branch.<name>.merge value suddenly makes no sense anymore.

> This come up in the use case where I:
> 1. set up a remote bare repo
> 2. push from my local repo, and thence forth want to keep local and
> remote in sink.

Maybe you want something like this?
http://thread.gmane.org/gmane.comp.version-control.git/107671

> Right now I have to modify .git/config to do this.

You can also do:
git config branch.<name>.remote <remote>

which does the config editing for you.

And maybe:
git config branch.<name>.merge <ref>

if you also want just "git pull" to work, or use push.default =3D track=
ing.


There's also still my old "retrack" hack, which John Wiegley extended:
http://github.com/jwiegley/git-scripts/blob/6ba3184d7b9f6dae3d10379a6ba=
c29a01ceef190/git-retrack

That's a bit more comfortable, but probably doesn't work for a lot of
"non-standard" setups.

Bj=F6rn
