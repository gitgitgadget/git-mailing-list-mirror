From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT PATCH] Fix data corruption in DirCacheIterator when EmptyTreeIterator is used
Date: Tue, 12 May 2009 00:04:06 +0000 (GMT)
Message-ID: <5323.360.qm@web27801.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 12 02:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3fTo-0002ES-DP
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 02:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426AbZELAEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 20:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757230AbZELAEK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 20:04:10 -0400
Received: from web27801.mail.ukl.yahoo.com ([217.146.182.6]:21175 "HELO
	web27801.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754421AbZELAEJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 20:04:09 -0400
Received: (qmail 1486 invoked by uid 60001); 12 May 2009 00:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1242086647; bh=abhNIU0bMhR9CnOTl5loIYXBWv6F+EMRL4DHlQT1+qE=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=J/HVS1QhMsnRwO4jN/Ni2L7pLRpX8hbpS735PBOr5hjp3Oa+XuxmvU1kekAzpRLrkysjLpuQKk1unNs4BGubUO/zHb9SLPlL8riX1jvqrRo3L/T6EONG5Gxn31jAQRcQbWLTyM+gRxRGyFdAJua8PXmwXEYSfGfO8OX5kzY0nDE=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=32Xo13EwRcxQIFrg7AgKRpamjP2OohwDMlkyJSpPQTN0wgCwcsHlAOJI3ppLdAbfXUDTC5aCHvhO0fDWRnmTaL9qcpL/bnkVJQRYtq4fcSAiTdwEWU8cpzogGRohIBJgJsKoGEbiL/RnPOEOhi1dc5doHK2iWGwhrCoaX36QLpk=;
X-YMail-OSG: A5qbso0VM1lJI1mt4FO1pVuQhgLLM5K1NCMZVNtf8jxdowJqE7f0Ikgz8WHJh9aSYyohAPAnxwgyVgNZa2dm.34XnIP7mAwlE0CeU4wQtb7rGp_ATSZ49HsiqiBavRpHe6O0mbw3uuMz_x7Mwp1UKEyTloyyucoing0a1kndlR.Xg8TWve.k7elMBL4f1S_kTUUrRgBAYTR1wG305jTBWn6188.7i_VE8BwVdzeSTDPhREy_5fPLh4KBm.tgf1XKojJvJ2jEgg3ryUYKeNW0zlawnfZOm.DrCvmQHt_lZWZvpy7yYOjfbWhGPlhqr6oeUrK9
Received: from [194.24.158.8] by web27801.mail.ukl.yahoo.com via HTTP; Tue, 12 May 2009 00:04:06 GMT
X-Mailer: YahooMailClassic/5.3.9 YahooMailWebService/0.7.289.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118864>


Patch tested, jgit status now works on a repo which previously caused t=
he out of bounds exception.

txs and LieGrue,
strub

--- Shawn O. Pearce <spearce@spearce.org> schrieb am Mo, 11.5.2009:

> Von: Shawn O. Pearce <spearce@spearce.org>
> Betreff: Re: [JGIT PATCH] Fix data corruption in DirCacheIterator whe=
n EmptyTreeIterator is used
> An: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
> CC: "Mark Struberg" <struberg@yahoo.de>, git@vger.kernel.org
> Datum: Montag, 11. Mai 2009, 21:44
> Robin Rosenberg <robin.rosenberg.lists@dewire.com>
> wrote:
> >=20
> > Shouldn't we update some unit tests too? The dircache
> must be reliable.
>=20
> I see you ignored the remark I put in the cover letter
> below the ---.
>=20
> I think we should have unit tests too.=A0 I just can't
> come up with
> a way test the fix to prevent regression.=A0 And I don't
> have any
> more time for it probably the rest of this week.=A0 I'd
> rather have
> the corruption fix in the tree with no test than continue
> to have
> surprising corruption under certain cases.=A0 But if you
> or Mark can
> offer a test, I'd love to have it.
>=20
> --=20
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe
> git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20


     =20
