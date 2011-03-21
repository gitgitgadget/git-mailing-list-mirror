From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Mon, 21 Mar 2011 10:56:19 +0100
Message-ID: <1300701380.2583.13.camel@bee.lab.cmartin.tk>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
	 <1300371853-8965-1-git-send-email-cmn@elego.de>
	 <7vpqpoyjo3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 10:56:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1bqm-00007C-5U
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 10:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab1CUJ4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 05:56:31 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:39778 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab1CUJ4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 05:56:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 9D5611B4BAD;
	Mon, 21 Mar 2011 10:56:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4MteJvGHXd1t; Mon, 21 Mar 2011 10:56:20 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 1440D1B4BA9;
	Mon, 21 Mar 2011 10:56:20 +0100 (CET)
In-Reply-To: <7vpqpoyjo3.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169571>

On vie, 2011-03-18 at 00:25 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > +	ret =3D snprintf(buf, sizeof(buf), "%s/%s", prefix, path);
> > +	if (ret >=3D sizeof(buf))
> > +		die("system path too long for %s", path);
> > +	else if (ret < 0)
> > +		die_errno("encoding error");
>=20
> POSIX says snprintf() should set errno in this case, and your use of
> die_errno() would show that information, but what is "encoding error"=
?
>=20
> Just being curious, as I suspect that "snprintf() returned an error" =
may
> be more appropriate, if the answer is "I don't know what kind of erro=
r it
> is, but snprintf() found something faulty while encoding so I chose t=
o
> call it encoding error".


 My manpage says snprintf returns -1 if there was an output or encoding
error. As there couldn't be an output error because it's writing to
memory and we can't output what snprintf chocked on because whatever
die_errno uses will also choke on it, I just put "encoding error". I'd
put "error assembling system path" as the actual error message, I guess=
=2E

   cmn
