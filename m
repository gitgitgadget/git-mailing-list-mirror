From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: HTTP trees trailing GIT trees
Date: Thu, 24 May 2007 12:44:45 +0000 (UTC)
Message-ID: <loom.20070524T142358-608@post.gmane.org>
References: <loom.20070523T154909-285@post.gmane.org> <20070523140552.GN4489@pasky.or.cz> <loom.20070523T161537-175@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 14:45:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrChM-0005ot-MS
	for gcvg-git@gmane.org; Thu, 24 May 2007 14:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbXEXMpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 24 May 2007 08:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756425AbXEXMpc
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 08:45:32 -0400
Received: from main.gmane.org ([80.91.229.2]:39788 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756248AbXEXMpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 08:45:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrCgl-0006pJ-No
	for git@vger.kernel.org; Thu, 24 May 2007 14:45:07 +0200
Received: from edm-005.edm.uhasselt.be ([193.190.10.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 May 2007 14:45:07 +0200
Received: from takis.issaris by edm-005.edm.uhasselt.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 May 2007 14:45:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.190.10.5 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20061201 Firefox/2.0.0.3 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48254>

Hi,

Panagiotis Issaris <takis.issaris <at> uhasselt.be> writes:
> Petr Baudis <pasky <at> suse.cz> writes:
> > On Wed, May 23, 2007 at 04:01:33PM CEST, Panagiotis Issaris wrote:
> > > I reported this to the person who had setup the repository:
> > > http://article.gmane.org/gmane.comp.video.ffmpeg.devel/51151
> > >=20
> > > But unfortunately, the problem seems to remain.
> > >=20
> > > Is this a known problem, or might this be a bug or misconfigurati=
on?
> >=20
> >   did any push happenned since the post-update hook was enabled? It
> > takes effect only after the next push. So far,
> >=20
> > 	http://git.mplayerhq.hu/ffmpeg/info/refs
> >=20
> > and
> >=20
> > 	http://git.mplayerhq.hu/ffmpeg/refs/heads/master
> >=20
> > is still out-of-sync (keeping this in sync is what is the job of th=
e
> > post-update hook, or git-update-server-info respectively).
> >=20
>=20
> Yes, I'd think so, as M=C3=A5ns stated that he had enabled the hook o=
n
> 2007-05-22 20:43:27. The last commit shown on http://git.mplayerhq.hu=
/
> through gitweb occurred 25 minutes ago ("Wed, 23 May 2007 13:46:11 +0=
000").
>=20
> Thanks for your fast reply.

I've checked both protocols from the same network now, unfortunately
without any improvements.

=46urthermore, I've also started tracing, hoping to figure out what
the problem might be (or getting a hint from someone regarding
the possible cause).

The host which is involved:
nslookup 213.144.138.186
186.138.144.213.in-addr.arpa    name =3D natsuki.mplayerhq.hu

Parts of the trace -f:
=2E..
connect(4, {sa_family=3DAF_INET, sin_port=3Dhtons(80),
sin_addr=3Dinet_addr("213.144.138.186")}, 16) =3D -1 EINPROGRESS=20
(Operation now in progress)
=2E..
send(4, "GET /ffmpeg/info/refs HTTP/1.1\r\n
User-Agent: curl/7.15.5
(i486-pc-linux-gnu) libcurl/7.15.5 OpenSSL/0.9.8c zlib/1.2.3
libidn/0.6.5\r\n
Host: git.mplayerhq         .hu\r\nAccept: */*\r\nPragma:
no-cache\r\n\r\n", 188, MSG_NOSIGNAL) =3D 188
=2E..
recv(4, "HTTP/1.1 200 OK\r\nDate: Thu, 24 May 2007 12:27:05 GMT\r\n
Server: Apache/2.2.3 (Debian) mod_python/3.2.10 Python/2.4.4\r\n
Last-Modified:  Thu, 24 May 2007          04:25:50 GMT\r\n
ETag: \"2c01f-79-ad720f80\"\r\nAccept-Ranges:
bytes\r\nContent-Length: 121\r\nContent-Type:
text/plain\r\n\r\nc30fa83981290671ed972835297fbe93ef9d1e58\t
refs/heads/master\nc30fa83981290671ed972835297fbe93ef9d1e58\t
refs/remotes/git-svn\n",
16384, MSG_NOSIGNAL) =3D 381


So, we're asking for /ffmpeg/info/refs, and the server is=20
returning c30fa8391812..., but, using GitWeb one can see=20
that c30fa839812... is  not the last commit, this one is:
http://git.mplayerhq.hu/?p=3Dffmpeg;a=3Dcommit;
h=3D47d7dcb5a7d89f413064e7ef1b54d77e59fb8375


When using the git protocol, the trace shows this:
=2E..
connect(3, {sa_family=3DAF_INET, sin_port=3Dhtons(9418),
sin_addr=3Dinet_addr("213.144.138.186")}, 16) =3D 0
dup(3)                            =3D 4
write(4, "0032git-upload-pack /ffmpeg\0host=3Dgit.mplayerhq.hu\0",
50) =3D 50
read(3, "007c", 4)                =3D 4
read(3, "47d7dcb5a7d89f413064e7ef1b54d77e59fb8375 HEAD\0multi_ack
thin-pack side-band side-band-64k ofs-delta shallow no-progress\n",
120) =3D 120
read(3, "003f", 4)                =3D 4
read(3, "47d7dcb5a7d89f413064e7ef1b54d77e59fb8375=20
refs/heads/master\n", 59)=20
=3D 59
read(3, "0042", 4)                =3D 4
read(3, "47d7dcb5a7d89f413064e7ef1b54d77e59fb8375=20
refs/remotes/git-svn\n", 62)=20
=3D 62
read(3, "0000", 4)                =3D 4
=2E..

So, here, I'd guess it's also asking for the latest revision and=20
apparantly receiving 47d7dcb5a... as the hash, which is correct (and=20
the same as GitWeb shows).
=20
And hints? Any other info I can provide?

I've upgrade GIT hoping it solve the problem, but it doesn't. Some=20
versions, I've tried are git version 1.5.2.35.ga334 and git=20
version 1.5.2.

With friendly regards,
Takis

=20
