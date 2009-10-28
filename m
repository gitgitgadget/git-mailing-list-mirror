From: Peter =?utf-8?b?T2TDqXVz?= <peter.odeus@gmail.com>
Subject: Re: From 200 to 404 to 407.
Date: Wed, 28 Oct 2009 16:10:42 +0000 (UTC)
Message-ID: <loom.20091028T170227-957@post.gmane.org>
References: <82fd2c5d0910270318wc30bc44tfd3362933d3f62cf@mail.gmail.com>  <32541b130910270953w6bd35ddctd471e682830b8f62@mail.gmail.com>  <82fd2c5d0910280138r52baff98p3f4ff65e968b0d37@mail.gmail.com> <32541b130910280850t5b4baa91p90b31b4c1c467e94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 17:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3B7B-0006pr-F4
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 17:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbZJ1QLC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 12:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754892AbZJ1QLC
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 12:11:02 -0400
Received: from lo.gmane.org ([80.91.229.12]:34955 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754874AbZJ1QLA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 12:11:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N3B70-0006j5-K5
	for git@vger.kernel.org; Wed, 28 Oct 2009 17:11:02 +0100
Received: from 41.202.216.81.static.g-bn.siw.siwnet.net ([81.216.202.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 17:11:02 +0100
Received: from peter.odeus by 41.202.216.81.static.g-bn.siw.siwnet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 17:11:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.216.202.41 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/532.3 (KHTML, like Gecko) Chrome/4.0.223.11 Safari/532.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131478>

Avery Pennarun <apenwarr <at> gmail.com> writes:

>=20
> On Wed, Oct 28, 2009 at 4:38 AM, Peter Od=C3=A9us <peter.odeus <at> g=
mail.com>=20
wrote:
> > * Re-using existing connection! (#0) with host proxyserver.acme.com
> > * Connected to proxyserver.acme.com (192.71.145.9) port 8080
> > > GET
>=20
http://gitrepo.outside.com/git/gitrepo.git/objects/6b/132a9e81161e58812=
902d7f735
a38bf5ee1583 HTTP/1.1
> > Proxy-Authorization: Basic cmQva3F3Zzc2MjptYW1tYW1pYQ=3D=3D
> > User-Agent: git/1.6.5.2
> > Host: gitrepo.outside.com
> > Accept: */*
> >
> > * The requested URL returned error: 404
>=20
> So this git object didn't exist, apparently.  Can you confirm that th=
e
> object shouldn't be there?  (on the server: git cat-file -p
> 6b132a9e81161e58812902d7f735a38bf5ee1583)  Does git-fsck report
> anything weird on the server repository?
>=20
> > * Closing connection #0
> > * Couldn't find host gitrepo.outside.com in the .netrc file, using =
defaults
> > * About to connect() to proxyserver.acme.com port 8080
> > * =C2=A0 Trying 192.71.145.9... * connected
> > * Connected to proxyserver.acme.com (192.71.145.9) port 8080
> > > GET http://gitrepo.outside.com/git/gitrepo.git/objects/info/http-
alternates HTTP/1.1
> > User-Agent: git/1.6.5.2
> > Host: gitrepo.outside.com
> > Accept: */*
> > Pragma: no-cache
> >
> > < HTTP/1.1 407 Proxy Authentication Required ( The ISA Server requi=
res
> > authorization to fulfill the request. Access to the Web Proxy servi=
ce
> > is denied. =C2=A0)
>=20
> This error seems to happen because the Proxy-Authorization line was
> not included in this request like it was included in prior ones.
> Probably the authorization key was forgotten when the first connectio=
n
> closed.  If there hadn't been a 404, the connection wouldn't have
> closed and this wouldn't have happened, which is presumably why you
> haven't seen this problem before.
>=20
> This is where my expertise ends, since I've never messed with either
> libcurl or git's usage of it.  I couldn't tell you if this is a
> libcurl bug or a git bug.  (Proxies are relatively rare nowadays, so
> this code path is likely to be rarely tested.)
>=20
> Hopefully someone else on the list can assist.
>=20
> ** WARNING: the username/password sent in the Proxy-Authorization lin=
e
> is not encrypted and you've posted a trace of it to a public mailing
> list.  You need to change your password immediately. **
>=20
> Good luck,
>=20
> Avery
>=20

If you wouldn't have posted the base64-encoded password it would have n=
ever hit=20
the gmane list ;-)=20

Don't worry about it, because I tried to submit the console output myse=
lf all=20
day. But to no avail.

Is it enough to replace greater-than-signs to something else, btw?

Anyway. Behind these corporate walls, the proxy is a reality to deal wi=
th, so=20
hopefully someone else can bring us closer to a solutiuon.

Thanks for your input.

:D

/Peter=20
