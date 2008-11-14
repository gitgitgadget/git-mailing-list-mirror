From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] sha1_file: make sure correct error is propagated
Date: Fri, 14 Nov 2008 20:50:09 +0100
Message-ID: <491DD671.8070801@op5.se>
References: <1226647174-15844-1-git-send-email-sam@vilain.net> <1226655681.17731.4.camel@maia.lan> <7vfxlu9lhs.fsf@gitster.siamese.dyndns.org> <200811142009.51803.fg@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org
To: Francis Galiegue <fg@one2team.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 20:51:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L14hf-0006Uc-Ju
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 20:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYKNTuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 14:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYKNTuY
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 14:50:24 -0500
Received: from mail.op5.se ([193.201.96.20]:42240 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbYKNTuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 14:50:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 433C01B80090;
	Fri, 14 Nov 2008 20:44:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KEtmOcFBg2Zj; Fri, 14 Nov 2008 20:44:52 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id AE92E1B80088;
	Fri, 14 Nov 2008 20:44:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <200811142009.51803.fg@one2team.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101008>

=46rancis Galiegue wrote:
> Le Friday 14 November 2008 20:05:19 Junio C Hamano, vous avez =E9crit=
 :
> [...]
>>>  	fd =3D mkstemp(buffer);
>>> -	if (fd < 0 && dirlen && (errno !=3D EPERM)) {
>>> +	if (fd < 0 && dirlen && (errno !=3D EACCESS)) {
>> Is this accepting the two as equivalents???
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> Well, looking at mkdir(2), it says:
>=20
>        EPERM  The file system containing pathname does not support th=
e=20
> creation of directories.
>=20
> Hmm, err... git would fail at an earlier point anyway, wouldn't it? E=
ven git=20
> init would fail there.
>=20

Not necessarily. .git could be mounted erroneously from via a networked
filesystem but without write permissions. Yes, other things would fail
then too, but both EPERM and EACCESS are valid and possible return code=
s.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
