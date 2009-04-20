From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RESEND] gitweb: Fix snapshots requested via PATH_INFO
Date: Mon, 20 Apr 2009 02:52:48 -0700 (PDT)
Message-ID: <m3iqkzps96.fsf@localhost.localdomain>
References: <20090414104648.GA36554444@CIS.FU-Berlin.DE>
	<7vvdp6xvv3.fsf@gitster.siamese.dyndns.org>
	<200904151934.10253.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	=?iso-8859-15?q?Holger_Wei=DF?= <holger@zedat.fu-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 11:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvqCn-0006Ev-26
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 11:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbZDTJww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 05:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753984AbZDTJwv
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 05:52:51 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:15196 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbZDTJwv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 05:52:51 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1819644rvb.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=mo0X0Sc2wQUmtRgNTr24zq1XgO3myGTBtJ4FO20O0gM=;
        b=Qo+KfeB/LqlyQR95Elg2tRcm59Ecd7CRE9BqUV8px6PwFs9v1LihXfDpB2ld4uQ6xk
         RDVd7uJ+vYpF3CXD6XCzckw9d2eUaky3oeo3nnTamqoYGzQpGQK487ltGymRiH4TjPQf
         x1IaxYjzoljrAC52DfrQtCdyrgLHyOXc0n7SE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=vFomAgRo4GwQ+IzdebVrhVwiWMvDK8U5byh+ypAwpj73Ai4ZHs25a2OKkVFGNY2gu7
         lTYL8UCYkuGlHKBPHqblipyWNRNH0gKArdRJW1yuXyaKcX65eC9dx9ltnAuUbz02ZuJJ
         VWylkEn3orPKQWUkjnBFvLzhfeUIlFs3QqVdI=
Received: by 10.142.58.20 with SMTP id g20mr1165831wfa.20.1240221169376;
        Mon, 20 Apr 2009 02:52:49 -0700 (PDT)
Received: from localhost.localdomain (abwc215.neoplus.adsl.tpnet.pl [83.8.226.215])
        by mx.google.com with ESMTPS id 31sm16506588wff.15.2009.04.20.02.52.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 02:52:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3K9q5qK002760;
	Mon, 20 Apr 2009 11:52:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3K9pnCW002756;
	Mon, 20 Apr 2009 11:51:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200904151934.10253.jnareb@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116955>

I'm sorry for resend, but I forgot to quote non-ASCII in 'Cc:'
and vger anti-SPAM filter rejected message...

Jakub Narebski <jnareb@gmail.com> writes:
> On Wed, 15 April 2009, Junio C Hamano wrote:
>> Holger Wei=DF <holger@zedat.fu-berlin.de> writes:
>>=20
>>> Fix the detection of the requested snapshot format, which failed fo=
r
>>> PATH_INFO URLs since the references to the hashes which describe th=
e
>>> supported snapshot formats weren't dereferenced appropriately.
>>>
>>> Signed-off-by: Holger Wei=DF <holger@zedat.fu-berlin.de>
>>> ---
>>> I guess this one got lost.  Without this patch, snapshots won't wor=
k if
>>> Gitweb is configured to generate PATH_INFO URLs.  (Original Message=
-ID:
>>> <20090331161636.GV30233737@CIS.FU-Berlin.DE>).
>>=20
>> The patch looks obviously correct; "our %known_snapshort_formats" ma=
ps a
>> name to a hashref, but the current code makes a nonsense assignment,
>> essentialy doing ($fmt, %opt) =3D ($name, $hashref), but what would =
I
>> know...  I am not using gitweb actively.
>>=20
>> These lines come from 1ec2fb5 (gitweb: retrieve snapshot format from
>> PATH_INFO, 2008-11-02) by Guiseppe.
>>=20
>> Judging from the "git shortlog -n -s --grep=3DPATH_INFO gitweb" outp=
ut, I
>> think I should have heard from either Guiseppe and Jakub by now if t=
his
>> patch is desired.  Pinging them...
>=20
> This change looks correct, and is very much desired.  Thanks for
> catching this.

Ping!  This is quite straighforward bugfix for a new feature...

> By the way, if there was check added for full path_info snapshot URL =
in
> existing t/t9500-gitweb-standalone-no-errors.sh it would caught this
> bug thanks to the
>   "Odd number of elements in hash assignment ..."
> warning that Perl throws in this case.=20

=2E.. or are you waiting for test case?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
