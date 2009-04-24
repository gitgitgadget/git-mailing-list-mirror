From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add an option not to use link(src, dest) && unlink(src) 
	when that is unreliable
Date: Fri, 24 Apr 2009 07:44:18 +0200
Message-ID: <81b0412b0904232244l15cd7347n23702d92b38ab7e5@mail.gmail.com>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
	 <81b0412b0904231239qf317c02xbfa548d0011a0302@mail.gmail.com>
	 <alpine.DEB.1.00.0904232358520.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 07:45:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxEEV-0004LB-GS
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 07:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbZDXFoU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 01:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbZDXFoU
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 01:44:20 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:64998 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbZDXFoT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 01:44:19 -0400
Received: by ewy24 with SMTP id 24so870841ewy.37
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 22:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F7iu/PZnJypfWaQ+Lvm/xp5A1i/3hZsaI6SnNJUpKk0=;
        b=hZ2Pu9P8A06x8hpMaWywVqJHGs6UtjDcIrNpTc5IrxpwuQKrPgUPePz9Qx9EXLZ+Xa
         5f0z0PvxCllETORa5qTVgXFBwS6cZwArbGVPMZZCL7W/OQfRGf49B+KrlSHh7hJlr5GR
         cgD8KmIxVG5LvjEVOkGU6Swg6tX7GDlHB3Z/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C4BILU5+R6kJoS6qBEfc9P9MVJP03/QlN/5kXV3dc3L76/wwt1exicFEFZhEtl1GmF
         qRXiyvGkVNIh87DTBwT89ct2VTxt0Cf4YGL0OG4thYnL1Mfhjn7BmGTheRnzJoOiOikB
         ujfv4yi+hyqUffI4MB764/co2f8bo0r1AWvhc=
Received: by 10.210.139.15 with SMTP id m15mr1881970ebd.38.1240551858385; Thu, 
	23 Apr 2009 22:44:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904232358520.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117411>

2009/4/23 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Thu, 23 Apr 2009, Alex Riesen wrote:
>
>> 2009/4/23 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> > - =C2=A0 =C2=A0 =C2=A0 if (link(tmpfile, filename))
>> > + =C2=A0 =C2=A0 =C2=A0 if (unreliable_hardlinks)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ~EEXIST=
;
>>
>> It is more like "broken_hardlinks" or even "no_hardlinks"!
>
> Wrong. =C2=A0As I wrote, single-stepping (i.e. leaving enough time be=
tween
> link() and unlink()) works as expected. =C2=A0So it is not even that =
the
> hardlinks are broken. =C2=A0Just the serialization between the operat=
ions.
>

Since when does link(2) involve file _data_?
