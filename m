From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 4 Jun 2009 10:45:07 +0200
Message-ID: <200906041045.11328.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906032320.23559.jnareb@gmail.com> <alpine.LSU.2.00.0906032240300.31588@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Jun 04 10:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC8Zl-0001My-5L
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 10:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbZFDIpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 04:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755450AbZFDIpS
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 04:45:18 -0400
Received: from mail-bw0-f226.google.com ([209.85.218.226]:40735 "EHLO
	mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172AbZFDIpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 04:45:15 -0400
Received: by bwz26 with SMTP id 26so581023bwz.7
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 01:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AKkw6WlxfOMi93Oi8MNYcfiQjshPv1qlR5OuU0OrSpg=;
        b=q5ptbexxE8g2FlKPhVBB2zf4+wfTrcEfmHg4m6W2bQkWIhJuU6ySb0TlG84Z10cxIo
         VIwY5OMQOb2xPME6q694Rj1OBQr/xEv829L4XZ4IrAGwZz4Q0vOfC1JR3EE3bOgcvxNi
         lAzs2WSn0/ePnicqCpg1iYZm0QW4ZdS7v1It8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MSVJ7CFz5Se/00D/ETzcEOj9QAAkCXqXDht49SaAct0VUQC7Xe17nven298hQr8me5
         E+t5Y9ZYFYrJ9oymfYHiMZ/AQ7337g+93JnpphU83SdTR7uBlQVQCKzY9o3rDSrDAfvL
         6x1VGOxDbKy0Tpr8UkLG076vjMyMKJEonM8PM=
Received: by 10.103.212.2 with SMTP id o2mr93715muq.18.1244105116230;
        Thu, 04 Jun 2009 01:45:16 -0700 (PDT)
Received: from ?192.168.1.13? (absh69.neoplus.adsl.tpnet.pl [83.8.127.69])
        by mx.google.com with ESMTPS id e8sm3632529muf.6.2009.06.04.01.45.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 01:45:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.2.00.0906032240300.31588@hermes-2.csi.cam.ac.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120686>

Dnia =B6roda 3. czerwca 2009 23:53, Tony Finch napisa=B3:
> On Wed, 3 Jun 2009, Jakub Narebski wrote:
> >
> > Actually git accepts both lowercase and uppercase in HEXDIG (at lea=
st
> > for pkt-length), but it prefers lowercase.
>=20
> You should ensure that all hex digit strings follow the same rule.
> Are SHA-1 object names case insensitive too?
>=20
> Case insensitivity has a history of being awkward. SMTP has always ha=
d
> case-insensitive commands, though the RFCs have always written them i=
n
> upper case and implementations have pretty much all emitted them in u=
pper
> case. See http://tools.ietf.org/html/rfc5321#section-2.4 especially t=
he
> caveat about broken case-sensitive implementations.

There should be no problem with pkt-length being case insensitive, as
standard conversion routines (strtol, sprintf) accept 0-9a-fA-F for=20
base 16 / hexadecimal conversion.  The requirement here is that client
and server SHOULD use lowercase, but MUST accept mixed case (do case
insensitive parsing of hex4).

I think SHA-1 is lowercased, so mixed case should work there. Well, at
least "git show 6096D7" (note the uppercase 'D' in shortened SHA-1 name=
)
works as expected.


But I do not know what are, or what should be protocol requirements.
Should SHA-1 use lowercase, or be case insensitive? Should commands suc=
h
as "have", "want", "done" use lower case or be case insensitive? Should
status indicators "ACK" and "NAK" be upper case, or should be case
insensitive? Should capabilities be case sensitive, and should they be
compared case sensitive or not?

--=20
Jakub Narebski
Poland
