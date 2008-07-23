From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 16:06:08 +0200
Message-ID: <20080723140608.GC11679@atjola.homenet>
References: <20080723130518.GA17462@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLezo-00050y-MU
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbYGWOGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbYGWOGM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:06:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:40690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751817AbYGWOGL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:06:11 -0400
Received: (qmail invoked by alias); 23 Jul 2008 14:06:09 -0000
Received: from i577BBDAB.versanet.de (EHLO atjola.local) [87.123.189.171]
  by mail.gmx.net (mp043) with SMTP; 23 Jul 2008 16:06:09 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/f2VtCpDnfdX9SE28+UmiTNaB+IkOvL+6v8IwjaD
	+sA5m0CfTQG5PN
Content-Disposition: inline
In-Reply-To: <20080723130518.GA17462@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89658>

On 2008.07.23 15:05:18 +0200, Ingo Molnar wrote:
>=20
> I've got the following, possibly stupid question: is there a way to=20
> merge a healthy number of topic branches into the master branch in a=20
> quicker way, when most of the branches are already merged up?
>=20
> Right now i've got something like this scripted up:
>=20
>   for B in $(git-branch | cut -c3- ); do git-merge $B; done=20

Not yet in any release (AFAICT), but with git.git master, you could use=
:

for B in $(git branch --no-merged); do git-merge $B; done


Or with earlier versions, this should work, but it's a lot slower:

for B in $(git branch | cut -c3- ); do
	[[ -n "$(git rev-list -1 HEAD..$B)" ]] && git merge $B;
done

Bj=F6rn
