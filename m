From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git cvsimport and case-insensitive config
Date: Wed, 31 Mar 2010 08:54:50 +0200
Message-ID: <y2kcb7bb73a1003302354wea191dd4iced4360b95d31a2a@mail.gmail.com>
References: <hoscv7$hmn$1@dough.gmane.org> <7vy6h9vhuk.fsf@alter.siamese.dyndns.org> 
	<cb7bb73a1003301105v691624sdcdadf6809c50b89@mail.gmail.com> 
	<7vr5n1v74x.fsf@alter.siamese.dyndns.org> <cb7bb73a1003301517r29aed329j4a5f38fbc9b515ca@mail.gmail.com> 
	<7vd3yls8pi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 08:55:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwrph-0006is-KZ
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 08:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399Ab0CaGzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 02:55:13 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:44212 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931Ab0CaGzM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 02:55:12 -0400
Received: by ewy20 with SMTP id 20so1772249ewy.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 23:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EsXvYYLJsmpUdarcpcsnVldIx35hXw/NI584NGWj1BU=;
        b=LGf4tJnhaTGhDqbtdRaX0o1thw6hLw1P8epxSqdtwjgcYveYaybrIBMx3KPeUekf1x
         gIefxuK8YdZTbhcyr4hhScayWy8DYGpYCuwqSj6rnzmwa9MgsE/9ejRxsuVoqmlb/LRd
         /4qWgZO25X0/5ro3Z/CjvtoVwePI5fZE+2yss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JYcji17fI7229p4Sddq7V1Ug/UFrphRWB65u1l9AWNU1rQtFeyYgtZOdqe/1bYP3kw
         2kzF2FSazX4v12RpJppslevhUQS99PLSExK1Zp/Yjf0RMdDRkeyMRXic8aDIXD0Ktqe3
         /k4qWhaO0SIOpOgXjixCiwn1fcz5CnaOw8CYs=
Received: by 10.213.114.132 with HTTP; Tue, 30 Mar 2010 23:54:50 -0700 (PDT)
In-Reply-To: <7vd3yls8pi.fsf@alter.siamese.dyndns.org>
Received: by 10.213.37.9 with SMTP id v9mr4200913ebd.38.1270018510124; Tue, 30 
	Mar 2010 23:55:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143648>

On Wed, Mar 31, 2010 at 1:14 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> (-s likely has a single character, -S more than one. -S is likely to
>> have * or ?, -s not.)
>
> The value given to -S can just be 'tests', or even "\.", as the regex=
p
> match is not anchored on either side:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ($opt_S && $fn =3D~ m/$opt_S/) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "SKIPPING $fn v $rev\n";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
>
> And "-s" would likely be one or more (but not too many) non-alphanume=
ric
> characters.
>
> But a bigger question is if you can bet on that heuristics, and when =
the
> heuristics does not work, what you would do.

What I wonder is: when would the heuristics not work? Are there git
repositories that have a cvsimport configuration with both -s and -S
specified? I strongly suspect the answer is NO because such a
configuration would not work currently (at least not reliably as the
wrong value would be assigned to at least one of the keys.

>>> A bigger reason is that, if you have _any_ combination that you can=
not
>>> reliably guess, you would either need the user to ask for help, or =
you
>>> need to convert by reading the configuration file case-sensitively
>>> yourself to come up with a reliable conversion. =A0I opted for the =
latter.
>>
>> Would such a configuration work at all?
>
> What configuration?

One that specifies either of cvsimport.s and cvsimport.S, or any other
conflicting key, in a way that the present config reading doesn't get
too confused by. I think that for migration it would be sufficient to
just follow the value assignments currently done by the code. With a
big fat WARNING: notice, possibly.


--=20
Giuseppe "Oblomov" Bilotta
