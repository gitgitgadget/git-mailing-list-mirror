From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: failed to lock
Date: Thu, 15 Apr 2010 15:13:12 -0400
Message-ID: <k2j76718491004151213xdb223ff8kd43f170eaf3a470a@mail.gmail.com>
References: <j2o76718491004141349l53b53347v7f4c0edcab69e4c2@mail.gmail.com>
	 <t2i76718491004141402h33bb2044g155ef1715c63904e@mail.gmail.com>
	 <k2x76718491004142100v6e1ece6djc62aa540e51eed5@mail.gmail.com>
	 <7vd3y0k0c6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:13:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2UV5-0006fY-2j
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab0DOTNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 15:13:16 -0400
Received: from mail-iw0-f199.google.com ([209.85.223.199]:44623 "EHLO
	mail-iw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730Ab0DOTNN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 15:13:13 -0400
Received: by iwn37 with SMTP id 37so476159iwn.15
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q2xsbM+1XRXTiUoCjNyrYtmthGX1Y4W2w3gzOc1PIxo=;
        b=D62/V5g6JMdBkm7s0STcODDS9fSxitKPbWar+BlgWLO1dAyg7xJAnHeLh5hSGbG8ui
         n595rFhReJvW2BhqQ58E5YZfiY0p7h3D8FSKlI6PQRoytWKC1iZX5AnMZa6nsI7CSSuD
         Uqd0N2Y/qtE6KA33Gg7Bhg27rcPxIcR7oZ8t8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sI3KhxNJ1Gu5ZkzFMdHtcBoVrqLXHDdTOVkT84PH0r5ghJkSAdU5QC9JfMlC82LZ3A
         iHaJVAsCVcb+bMdsbHWI+tH8u5rxMxiEbj3lg4I4VZWCj5ABA6GD0CSSglAGbgKZMcAJ
         7DJ2YVRYuYFZGsCglWYQZs53skl8Pu6F7VOBk=
Received: by 10.231.36.9 with HTTP; Thu, 15 Apr 2010 12:13:12 -0700 (PDT)
In-Reply-To: <7vd3y0k0c6.fsf@alter.siamese.dyndns.org>
Received: by 10.231.157.68 with SMTP id a4mr197645ibx.78.1271358792973; Thu, 
	15 Apr 2010 12:13:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145011>

On Thu, Apr 15, 2010 at 3:00 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> I would rather think that "git push" should notice that */HEAD is a s=
ymref
> and refrain from pushing it. =C2=A0Stated more precisely,
>
> =C2=A0- It is perfectly fine to do this:
>
> =C2=A0 $ git push there HEAD:somebranch
>
> =C2=A0- But it does not make sense to push a symref via
>
> =C2=A0 [remote "there"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0push =3D refs/*:refs/*
>
> =C2=A0 to a bare repository that is used as a back-up mirror by inclu=
ding
> =C2=A0 refs/HEAD:refs/HEAD in the result of wildcard expansion.

But nothing prevents the destination repo from having arbitrary
symrefs. And there is no way for the source to know which destination
refs may be symrefs and which are not.

So it seems safer to me that the destination should ignore duplicates
in the received list.

No?

j.
