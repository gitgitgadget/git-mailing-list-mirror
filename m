From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= 
	<jeremie.nikaes@ensimag.imag.fr>
Subject: Re: [PATCH] Add a remote helper to interact with mediawiki, pull &
 clone handled
Date: Tue, 7 Jun 2011 00:11:12 +0200
Message-ID: <BANLkTi=ABYYY7KwVa6=bY_DXXopKnzZOtg@mail.gmail.com>
References: <1307355635-5580-1-git-send-email-jeremie.nikaes@ensimag.imag.fr> <BANLkTi=nOa2B_KNfv-XkYFVr8Ngdd2msFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Sylvain_Boulm=E9?= <sylvain.boulme@imag.fr>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 00:11:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTi1K-0003DJ-Ha
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 00:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148Ab1FFWLd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 18:11:33 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34896 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756963Ab1FFWLc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 18:11:32 -0400
Received: by pxi2 with SMTP id 2so3137369pxi.10
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 15:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jumCsb9ElcCov7mvtlODoB+i8z6y7UugGGaS2FZhojc=;
        b=qKi5pb83VjcX4avHKXXFWpvEBgHd04Fz/Ef4tySqhbz923ovPQ66xfz1+4B5EC8dBP
         oJZa7Doco+tT2kXodBvindce0xfZQ2APBLdpm5vadXmGIVLzVC998sImzT1jSGnOFYRq
         SomRziC8VHCkQFSbkEp8WRdDFP2rJ4G9FDv5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=DW8HdCu+tceBaJbILectkhNRL/pm7iYRpYlqlWWAp8ruTDHOlw1sVmu0GbXZqVHpIW
         gpmDvvplVYHXjyHa9V1RBSU3CmxEYWL95pyALeb3XWEWcdioq6F9/hzTrwMQaHVvZH7n
         1S5BaTULVqQHqxP8udFBtZ5wKsMJdT4UxPZV8=
Received: by 10.142.250.6 with SMTP id x6mr826879wfh.243.1307398292075; Mon,
 06 Jun 2011 15:11:32 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Mon, 6 Jun 2011 15:11:12 -0700 (PDT)
In-Reply-To: <BANLkTi=nOa2B_KNfv-XkYFVr8Ngdd2msFA@mail.gmail.com>
X-Google-Sender-Auth: ThT28GdObulp6m2URolpNOZUF-Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175175>

> use warnings; ?

Thanks, added this, showed some uses of undefined variables now fixed.
Will figure in the next patch.
>
>> +use Switch;
>
> Ugh -- no. =A0This is terrible. =A0Look at this:
>
> [~]% corelist Switch
> Switch was first released with perl v5.7.3 and removed from v5.13.1
>
> Since you do not specify a minimum perl version you might be alright,
> but for those people on 5.14 -- they won't have this module, for good
> reason. =A0You can, if you wanted use "given/when" as alternate
> constructs to this.

Yes, as I said to Junio Hamano in my previous mail, that's a mistake
from my part, we don't use switch anymore. Sorry about that

>
>> +use MediaWiki::API;
>> +use Storable qw(freeze thaw);
>
> This might have problems transcending storable formats made on a 32bi=
t
> machine, and then trying to unpack them again on 64bit. =A0Do you rea=
lly
> need the need for these storable items to be encoded as binary?

Hmmm that is a leftover use from the script of Jeff King that we used.
We don't use this anymore, so that should not be a problem.

Thanks for your advices !

--
J=E9r=E9mie Nikaes
