From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 10/11] gitweb.js: Add UI for selecting common timezone to display dates
Date: Sun, 10 Apr 2011 16:39:03 +0200
Message-ID: <201104101639.04466.jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com> <1302389366-21515-11-git-send-email-jnareb@gmail.com> <201104101136.58325.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 16:39:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8vnL-0006lD-QN
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 16:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab1DJOjO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 10:39:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46432 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab1DJOjN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 10:39:13 -0400
Received: by fxm17 with SMTP id 17so3106873fxm.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=waiBYuQe3hPGLsEcnNGzdwftP8rv+39D0G4uM3E6jLw=;
        b=q6CANyQioegmFc1fzLqi0zU+lt5u5C/zCZXB4FPq78GcIyVmb8dfJRv91K1QwXqjC7
         WXbjiQCVYsfP2TaHgfG6qI6nTxl/4e6147+r5LrBspH7cgI0IiEkkUMVdNTXduOeN0/K
         lVctRg5gnG6B6so4JglcScUprFEhBQWbPqJSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=e4RA2JOF+QU7oGaLoflrjjjxXpEOYvjkbS+aVrYiMFAA4edRgj8RF66dGkkSw1A6t0
         hRQtNjIBKHeOT4FRvQjGci82GxuLwSv7wHE05BQITCGA5n44tnoIKFF4kfXO1v60ePXx
         IXGJVJTmfw+fPIBzX6jXt7KIiVk0hebTq2oX4=
Received: by 10.223.76.147 with SMTP id c19mr1910357fak.55.1302446352686;
        Sun, 10 Apr 2011 07:39:12 -0700 (PDT)
Received: from [192.168.1.13] (abwa66.neoplus.adsl.tpnet.pl [83.8.224.66])
        by mx.google.com with ESMTPS id o17sm1362528fal.25.2011.04.10.07.39.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 07:39:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201104101136.58325.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171253>

Jakub Narebski wrote:
> Jakub Narebski wrote:
>=20
> > KNOWN BUGS:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > * In 'log' view menu is generated on the right side of whole page,
> > =A0 instead of at near date, as is the case with 'summary', 'commit=
',
> > =A0 'commitdiff', and 'tag' views.
>=20
> I'm not sure if it is behavior expected by CSS visual formatting mode=
l
> or not: the issue is with absolutely positioned block element
>=20
> =A0 div.popup { position: absolute; top: 0; right: 0; }
>=20
> inside relatively positioned _inline_ element
>=20
> =A0 span.marker { position: relative; }
>=20
> In this case 'top: 0; right: 0' refers somehow to parent block elemen=
t
> of inline element... at least that's what I think. =A0Note that also =
in
> the case of 'summary', 'commit', 'commitdiff' and 'tag' views the pop=
up
> position is not entirely what one could expect...
>=20
> What is strange is that 'top: 0; left: 0' works correctly (sic!).

This looks like a bug in Mozilla 1.7.12 (Gecko/20050923) I ordinarily u=
se.
Checking simplified test case with Konqueror 3.5.3 shows correct behavi=
or
for all combinations of absolute positioning, at least when

    span.marker { position: relative; display: inline-block; }

Without "display: inline-block;" the "top: 0; right: 0;" is displaced
compared to the end of marker.


Because vger anti-spam filter doesn't like HTML attachments, you can ch=
eck
test case here: https://gist.github.com/912389

Try it also with 'display: inline-block;' uncommented.

--=20
Jakub Narebski
Poland
