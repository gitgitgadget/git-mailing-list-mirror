From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 10:43:34 -0700
Message-ID: <20080828174334.GF21072@spearce.org>
References: <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm> <20080828172853.GE21072@spearce.org> <alpine.DEB.1.10.0808281033070.2713@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Aug 28 19:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlY4-0005aG-VE
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169AbYH1Rnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 13:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755928AbYH1Rng
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:43:36 -0400
Received: from george.spearce.org ([209.20.77.23]:56791 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153AbYH1Rnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2008 13:43:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 66FC638375; Thu, 28 Aug 2008 17:43:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0808281033070.2713@asgard.lang.hm>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94099>

david@lang.hm wrote:
> On Thu, 28 Aug 2008, Shawn O. Pearce wrote:
>> david@lang.hm wrote:
>>> On Thu, 28 Aug 2008, Shawn O. Pearce wrote:
>>>>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>>>
>>>> Yes, I really did mean for this part of the protocol to be in bina=
ry.
>>>
>>> except that HTTP cannot transport binary data, if you feed it binar=
y data
>>> it then encodes it into 7-bit safe forms for transport.
>>
>> So then how does it transport a GIF file to my browser?  uuencoded?
=2E..
> I could be wrong, but I'm pretty sure I'm not. to test this yourself =
find=20
> a webserver with an image file and retrieve it via telnet (telnet=20
> hostname 80<enter>GET /path/to/file HTTP/1.0<enter><enter>) and what =
will=20
> come back will be text.

  $ telnet www.google.com 80
  Trying 74.125.19.104...
  Connected to www.google.com (74.125.19.104).
  Escape character is '^]'.
  GET /intl/en_ALL/images/logo.gif HTTP/1.0
 =20
  HTTP/1.0 200 OK
  Content-Type: image/gif
  Last-Modified: Wed, 07 Jun 2006 19:38:24 GMT
  Expires: Sun, 17 Jan 2038 19:14:07 GMT
  Cache-Control: public
  Date: Thu, 28 Aug 2008 17:40:44 GMT
  Server: gws
  Content-Length: 8558
  X-Google-Backends: /bns/pq/borg/pq/bns/gws-prod/staticweb.staticfront=
end.gws/16:9836,dauf30:80
  X-Google-Service: static
  X-Google-GFE-Request-Trace: dauf30:80,/bns/pq/borg/pq/bns/gws-prod/st=
aticweb.staticfrontend.gws/16:9836,dauf30:80
  Connection: Close
 =20
  GIF89a	=01n=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=CE=AD	=EF=BF=BD=EF=BF=BD=EF=BF=BD=18E=EF=BF=BD=18I=EF=BF=BD=104=EF=BF=
=BD=10<=EF=BF=BD=EF=BF=BD=18=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=10=C6=BE=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=18M=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BD=BE=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD$c!Y=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=18Q=CE=9C=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDe=D6=AEc=
=EF=BF=BD=EF=BF=BD1e=EF=BF=BDJ}<=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BDs=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD9=
q=EF=BF=BDk

Very funny.  It trashed my tty.  Even reset won't restore the
settings.  Anyway.

I chose the Google logo on the Google homepage because I know we
try really hard to conform to standards, so we can have the biggest
possible user base.  Micro$oft or Yahoo! probably would have come
out the same way.  Or some image on kernel.org.

Anyway, I didn't send any browser data, so the server had to assume
the dumbest f'ing browser on the planet, and I got back binary data.

--=20
Shawn.
