From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for prompting
 passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Tue, 03 Jan 2012 14:18:33 +0100
Message-ID: <4F030029.40006@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de> <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com> <4F02D79B.1020002@tu-clausthal.de> <CACBZZX6iMobuU90skpbNPaGQFxYNOAjmZ6ceO4PGqfZSMkgePQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 14:18:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri4GH-0005w1-MK
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 14:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab2ACNSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 08:18:37 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:54035 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab2ACNSe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 08:18:34 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 6D551422054;
	Tue,  3 Jan 2012 14:18:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=bRw9cqy0JKvrByCdYm5cxqTPpzo=; b=md1T0606qh0jrukm9J314NSySrPT
	1mFZw55F0p+OCnFk6w2GAI+xZmeH1qFpCIIGKKgscQqeE+4RHx8O52M3GG1tbCpH
	nww/0tTRYTITQr3MJVdBNA5Nd9xKyl7NIZeQFeMMWrtJ9MgedrGNmdFa7ztUCpk+
	Gkum8E5KaST4t44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=plol/pRXS93CM9cgoEI5l7zcDZuhOQhHhi+IVnJOIXnRmxSJUrHCPP2
	Jr3w6L4UELWITSbsRVZ9WA8LR+gnENtZRwkUbBWEvs0DhYjjZZjUc4sUm37U4IU7
	Kggehy+dZffer54p3uWSvM74cPfaArAbNppqdL61mJ27+j7SDOKY=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 3001542203C;
	Tue,  3 Jan 2012 14:18:31 +0100 (CET)
Received: from [139.174.4.12] (account sstri@tu-clausthal.de [139.174.4.12] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25647725; Tue, 03 Jan 2012 14:18:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <CACBZZX6iMobuU90skpbNPaGQFxYNOAjmZ6ceO4PGqfZSMkgePQ@mail.gmail.com>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187861>

Am 03.01.2012 13:03 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> I'm using msys perl (shipped with msysgit) and there just using chom=
p()
>> did not work.

But why not drop all \n and \r, since we only accept and wait for a
single line?

chomp($str =3D <STDIN>) works as expected, but for some reason the line=
 I
got from the ASKPASS tool isn't. Btw. the askpass tool provides a strin=
g
followed with \n (c++).

> That's odd, what does this print:
>=20
>     perl -MData::Dumper -MFile::Temp=3Dtempfile -we 'my $str =3D
> "moo\015\012"; my ($fh, $name) =3D tempfile(); print $fh $str; close
> $fh; open my $in, "<", $name or die $!; my $in_str =3D <$in>; chomp(m=
y
> $cin_str =3D $in_str); print "in_str:<$in_str> cin_str:<$cin_str>
> END\n"'
>=20
> And how about this:
>=20
>     perl -MData::Dumper -MFile::Temp=3Dtempfile -we 'my $str =3D
> "moo\015\012"; my ($fh, $name) =3D tempfile(); print $fh $str; close
> $fh; open my $in, "<:crlf", $name or die $!; my $in_str =3D <$in>;
> chomp(my $cin_str =3D $in_str); print "in_str:<$in_str>
> cin_str:<$cin_str> END\n"'
>=20
> It could be that there's some bug in either perl or mingw's build of
> perl where it won't turn on the :crlf IO layer by default.

I get an error in both cases "Das System kann die angegebene Datei nich=
t
finden".

--=20
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
