From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT] maven build fails on OS X
Date: Fri, 6 Feb 2009 22:07:00 +0100
Message-ID: <200902062207.00941.robin.rosenberg@dewire.com>
References: <320075ff0902060708m5ec566b9g755829c25c7727d8@mail.gmail.com> <20090206153155.GL26880@spearce.org> <320075ff0902061208l6671c2a0m3d4b07b97025b53a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 22:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVXwJ-0002pi-Kr
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 22:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbZBFVHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 16:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZBFVHF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 16:07:05 -0500
Received: from mail.dewire.com ([83.140.172.130]:11392 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbZBFVHD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 16:07:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 18F0D147E89E;
	Fri,  6 Feb 2009 22:07:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dkAveQewVVK9; Fri,  6 Feb 2009 22:07:01 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7C3CA147E896;
	Fri,  6 Feb 2009 22:07:01 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <320075ff0902061208l6671c2a0m3d4b07b97025b53a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108784>

fredag 06 februari 2009 21:08:18 skrev Nigel Magnay:
> > I've looked at it and gave up.  I don't know what Maven is doing he=
re
> > on the Mac.  Maybe fresh eyes will have a better chance at fixing i=
t.
> >
> > My experience with Maven is it works about 5% of the time, and the
> > other 95% of the time you have to work around it by skipping tests,
> > or by writing massive blocks of XML in your pom.xml file, or by
> > redesigning your entire project directory structure and revision
> > control system to use SVN instead of Git.
>=20
> Ok. It's not (just) a Maven problem as I can get the same tests to
> fail in Eclipse by setting the Console Encoding to MacRoman (which is
> the default Charset.defaultCharset() when running a java app on OS X)=
=2E

Ok you found it. I just sent a reply...

> However, I'm slightly confused - possibly because I don't know what
> /should/ be the case. In
>=20
>  exp.replace("\303\205ngstr\303\266m", "\u00c5ngstr\u00f6m")

The text is "=C5ngstr=F6m".

> is \303\205 really meant to represent U+00C3 and U+0085 ? Shouldn't
> the replace be being done on bytes rather than strings?

Yes, but we fake the RAW strings by only really using the lower byte of
each code point. arrays of bytes are really hard to read in source code=
=2E=20
The MacRoman is the problem. What encoding does C Git on Mac use?
Isn't that UTF-8, in which case our use of platform default as fallback=
 is
wrong. Gah...

-- robin
