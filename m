From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for prompting
 passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Tue, 03 Jan 2012 11:25:31 +0100
Message-ID: <4F02D79B.1020002@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de> <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 11:25:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri1Yl-00051y-Bg
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 11:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab2ACKZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 05:25:31 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:10974 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752313Ab2ACKZa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2012 05:25:30 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id F017D2991D7;
	Tue,  3 Jan 2012 11:25:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=//eUobhOaKvfDQZs61Tn1B1O7E0=; b=MXdNiUht0q86OSGhAGB8tXBeL3Zb
	Lnt3Tjsj83TMfhQFnzZnDPQqlHQFCN06eUK7PTSm9hB/ou42hV+y5QZQDVSLxkEp
	Ge34XSHHDQ6YocCIM0EOSqkx3GfVLAXmsBYXL9HUouOHyvMiGSGdvJn0RQlxTM5O
	IdHjgfVdPSD/cTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=TjUmg92tNL9apah1SllcPWlhFIxkpAhKBVJBjyABq/Wvnmuapad4KS7
	eiI7IXSiQPFDSZuGWUYFIIhrM7ji+cBiLcPwK1z6hdsoTIcRNEFE3VZTHxhxrwbG
	gsfwuNKmo4Vu56CsCT/576960b/alnsINdSaiCodw1ElA4FiSfyw=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id CC5E929915D;
	Tue,  3 Jan 2012 11:25:28 +0100 (CET)
Received: from [139.174.4.12] (account sstri@tu-clausthal.de [139.174.4.12] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25641666; Tue, 03 Jan 2012 11:25:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187857>

Am 03.01.2012 11:17 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> +       $ret =3D <$fh>;
>> +       $ret =3D~ s/[\012\015]//g; # strip \n\r, chomp does not work=
 on all systems (i.e. windows) as expected
>=20
> Urm yes it does. \n in Perl is magical and doesn't mean \012 like it
> does in some languages. It means "The Platform's Native
> Newline".
>=20
> Which is \012 on Unix, \015\012 on Windows, and was \015 on Mac OS
> until support for it was removed. This is covered in the second
> section of "perldoc perlport".
>=20
> Can you show me a case where it fails, and under what environment
> exactly? Maybe it's e.g.s some Cygwin-specific peculiarity, in which
> case we could check for that platform specifically.

I'm using msys perl (shipped with msysgit) and there just using chomp()
did not work.

--=20
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
