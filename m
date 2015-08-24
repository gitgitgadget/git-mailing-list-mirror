From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4] git-p4: fix faulty paths for case insensitive systems
Date: Mon, 24 Aug 2015 14:43:29 +0200
Message-ID: <FB860908-F176-4EA3-A2D1-962E97BD12F7@gmail.com>
References: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com> <CAE5ih7_zTP-5WFtPfEcgVsG-sV6k2BhfYh5Z_ttS0oVvJx4NgA@mail.gmail.com> <24F604FE-6052-4250-80CD-3C366FE5D8DC@gmail.com> <CAE5ih78P2-oiZTY-d_5NYgchG3mh4FVy8GaNmBhicmmceU2k8w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, ksaitoh560@gmail.com,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 14:43:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTr6F-0002uf-H0
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 14:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbbHXMne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 08:43:34 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36646 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183AbbHXMnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2015 08:43:33 -0400
Received: by wicja10 with SMTP id ja10so70831948wic.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RfpEv0X+aWW1PSWfE0jyKA1ZMDQw1MVWQvfrCr37a2o=;
        b=swq/IfDpT1V2jwaOItzog3V7J6q/rU1WOLK2hDroT8a7XviLOpQdlYpYVR82KScRq+
         tVeWAyJJM6tm+4DaS8SCVdfPVb0BlbzhLBwKJHk3Y2LiO3U9xaA3/XP/DBgs+D2cfiq6
         myQ3X44CLurf9TUHxZcVchEzTR2Ve/ANbJ95ZsSEgmvhEztTXehpj+JpKpNurFFlF53M
         Gg4QtFYwI2QkJ4N1vFgj+zehHTiI/M+tQFbB1VJSeWFc/MO+aNKY4jfmUXdacjd7HTIG
         RxrS02WCsFot5hJhVmAoKWNTKp1rIdzEODxxeKLPEw1D32Itaot+AV1sK5q/S6nuZY88
         qlfQ==
X-Received: by 10.194.92.143 with SMTP id cm15mr41177972wjb.17.1440420212262;
        Mon, 24 Aug 2015 05:43:32 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r8sm12195989wik.16.2015.08.24.05.43.31
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Aug 2015 05:43:31 -0700 (PDT)
In-Reply-To: <CAE5ih78P2-oiZTY-d_5NYgchG3mh4FVy8GaNmBhicmmceU2k8w@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276446>


>=20
> <snip>
>=20
>>=20
>> While I was working on the examples for this email reply I realized =
that the problem is only present for paths given in a client-spec. I ad=
ded a test case to prove that. That means I don=92t need to request *al=
l* paths. I *think* it is sufficient to request the paths mentioned in =
the client spec which would usually be really fast. Stay tuned for PATC=
H v5.
>=20
> I've just tried a small experiment with stock unaltered git-p4.
>=20
> - Started p4d with -C1 option to case-fold.
> - Add some files with different cases of directory (Path/File1,
> PATH/File2, pATH/File3).
> - git-p4 clone.
>=20
> The result of the clone is separate directories if I do nothing
> special (PATH/File1, Path/File2, etc). But if I set core.ignorecase, =
I
> get a single case-folded directory, Path/File1, Path/File2, etc. I'm
> still failing to get how that isn't what you need (other than being a
> bit obscure to get to the right invocation).
>=20
> I've put a script that shows this here:
>=20
> https://github.com/luked99/quick-git-p4-case-folding-test
As mentioned I realized that the problem occurs only if you use client =
specs. Can you take a look at this test case / run it?
https://github.com/larsxschneider/git/blob/d3a191cb5fb4d8f5f48ca9314c77=
2169d5dbf65b/t/t9821-git-p4-path-variations.sh#L112-L127

Does this make sense to you? If you want to I could also modify =93quic=
k-git-p4-case-folding-test=94 to show the problem.

Cheers,
Lars
