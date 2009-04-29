From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] diff -c -p: do not die on submodules
Date: Thu, 30 Apr 2009 00:19:58 +0200
Message-ID: <81b0412b0904291519m41035200n408b6ab409eed127@mail.gmail.com>
References: <gt7err$3m4$1@ger.gmane.org>
	 <7v4ow8my1u.fsf@gitster.siamese.dyndns.org>
	 <20090428211257.GA31191@pvv.org> <20090429084209.GA24064@localhost>
	 <7v8wljcmvk.fsf_-_@gitster.siamese.dyndns.org>
	 <7vy6tj8aur.fsf_-_@gitster.siamese.dyndns.org>
	 <81b0412b0904291450w3d292ed5i3b2ab5164c0ae0f4@mail.gmail.com>
	 <alpine.DEB.1.00.0904300011140.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 30 00:20:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzI8R-0000BC-KM
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 00:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbZD2WUD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 18:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbZD2WUB
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 18:20:01 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:55484 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbZD2WUA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 18:20:00 -0400
Received: by bwz7 with SMTP id 7so1466345bwz.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ha9zIZHtmspnLfsFcZgyTCNyN4FQOioJUXttyrOuSwQ=;
        b=UWed1csDkc7Z0ehbUaXBuxhxxzKIrIlKRnX5NaoEulvkfkxr139w8kCNBYd6Np9Xzp
         CObvv/K9xWXC5OptUTSal4ubESg7+wqswKYpcP7zjCBnRVrGc4kCkfFuMTjF4KdNjKA+
         KyeQ6MCnzadX0lRj7cfb3iv8CkY509naslwqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D8yr7jurDL4loSKb9UzoGJXroYQPfFo0NfvCfAfDRrWVP2/ql4J65Pphkw0XavuEUg
         ZDkBm6emHTMOmy/sBaKKzP+L5oem5vNrWrVwwIrdhlYcevFOWICpu9zsX4E6y1OgcaQT
         Lrw7Hsph3+ahD7Rc2AkpE7K9ffdOX7urL/rIw=
Received: by 10.204.120.70 with SMTP id c6mr752684bkr.144.1241043598911; Wed, 
	29 Apr 2009 15:19:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904300011140.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117965>

2009/4/30 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Wed, 29 Apr 2009, Alex Riesen wrote:
>
>> 2009/4/29 Junio C Hamano <gitster@pobox.com>:
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 if (S_ISGITLINK(mode)) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob =3D xmallo=
c(100);
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size =3D snpri=
ntf(blob, 100,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Subproject commit %s\n", =
sha1_to_hex(sha1));
>>
>> snprintf returns a signed value. It also has a bad record of returni=
ng
>> negative values for obscure reasons (on obscure platforms, admittedl=
y).
>>
>> For this particular case,
>>
>> =C2=A0 strcpy(blob, "Subproject commit ");
>> =C2=A0 strcat(blob, sha1_to_hex(sha1));
>> =C2=A0 strcat(blob, "\n");
>> =C2=A0 *size =3D strlen(blob); /* that's a constant */
>>
>> could be considered.
>
> Actually, we know _exactly_ the size of the thing. =C2=A0It is 18+40+=
1. =C2=A0But I
> think that *size wants to have the size, not the length. =C2=A0So add=
 1.
>
> In any case, I don't think that we have to jump through hoops here:
> snprintf() is _most_ unlikely to return something negative here. =C2=A0=
So I'd
> say that readability trumps paranoia here.
>

http://www.google.com/search?q=3Dsnprintf+negative+return+value

=46irst link: http://bytes.com/groups/c/590845-snprintf-return-value

Look for "(Windows, mingw)"
