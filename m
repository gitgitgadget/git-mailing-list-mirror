From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 8 Dec 2009 17:08:22 +0100
Message-ID: <20091208160822.GA1299@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 17:08:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI2c6-0003ko-ND
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 17:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbZLHQIW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 11:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbZLHQIV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 11:08:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:60549 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932403AbZLHQIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 11:08:20 -0500
Received: (qmail invoked by alias); 08 Dec 2009 16:08:26 -0000
Received: from i59F55883.versanet.de (EHLO atjola.homenet) [89.245.88.131]
  by mail.gmx.net (mp060) with SMTP; 08 Dec 2009 17:08:26 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX181wANoof01tNxE650IERsvRhB2whlLWUyyr35IoP
	mVr2zDd1YYsdTX
Content-Disposition: inline
In-Reply-To: <20091208144740.GA30830@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134890>

On 2009.12.08 16:47:42 +0200, Michael S. Tsirkin wrote:
> Add --revisions flag to rebase, so that it can be used
> to apply an arbitrary range of commits on top
> of a current branch.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=20
> I've been wishing for this functionality for a while now,
> so here goes. This isn't yet properly documented and I didn't
> write a test, but the patch seems to work fine for me.
> Any early flames/feedback?

This pretty much reverses what rebase normally does. Instead of "rebase
this onto that" it's "'rebase' that onto this". And instead of updating
the branch head that got rebased, the, uhm, "upstream" gets updated.

Also, AFAICT this needs to be called like this:
git rebase --revisions foo..bar HEAD

Changing the meaning of the <upstream> argument and relying on the fact
that <newbase> defaults to <upstream>. If such a thing gets added, it
should rather work like --root, not using <upstream> at all, but --onto
<newbase> only. Maybe defaulting to HEAD for <newbase> and making --ont=
o
optional, as it's reversed WRT what it does compared to the usual
rebase.

But generally, I'd say it would be better to add such a range feature t=
o
cherry-pick than abusing rebase for that.

Bj=F6rn
