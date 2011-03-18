From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH v3 1/3] gitweb: fix #patchNN anchors when path_info is enabled
Date: Fri, 18 Mar 2011 08:25:24 -0700
Message-ID: <AANLkTi=pe-ystbXhFLoOKRoCvY1axS8D9XuVyU+GxQPC@mail.gmail.com>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost>
	<201103181359.46600.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 16:25:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0bYk-00029L-Mt
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 16:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920Ab1CRPZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 11:25:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51414 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756911Ab1CRPZk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 11:25:40 -0400
Received: by fxm17 with SMTP id 17so3795779fxm.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y5czNGk4hPzv8jE0+In88R33+NX4McWWOfG6B4JrnVw=;
        b=wR/ENW8M5ThiiapJ2hXd1ws6a3yveG67f2qu3oVq5s6QY1gDaqjRYIBNBR6c0pUmHE
         bnXn2bmdoUIwVQ80Uq9rCrZzJOAcJECBD2EyslE51ddJDlxgiG5eovMOJ5eeqep+juVP
         W6dAduXCIkAnZC23SB15Booh15927+jcVLQww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xbeN+IMKZOPmHUDr0VXh6z94PXyRzsISwSBQuByayQBk40ds+XzCahalsDTARiDUgK
         RwNcjmmkXuTD/PXPgSH8f7WZiiZwQITf5iRq/cjnn5kny+mOEz9K+se7m0nyo1Vf+e6f
         2dEDNmnyARGNpuStdwp1Qa0bhEaS4vlRqyPqM=
Received: by 10.223.6.11 with SMTP id 11mr1351231fax.98.1300461924107; Fri, 18
 Mar 2011 08:25:24 -0700 (PDT)
Received: by 10.223.61.83 with HTTP; Fri, 18 Mar 2011 08:25:24 -0700 (PDT)
In-Reply-To: <201103181359.46600.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169334>

On Fri, Mar 18, 2011 at 5:59 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$params{'project'} =3D $project unless exi=
sts $params{'project'};
>
> + =C2=A0 =C2=A0 =C2=A0 # implicit -replay
> + =C2=A0 =C2=A0 =C2=A0 $params{-replay} =3D 1 if (keys %params =3D=3D=
 1 && $params{-anchor});

If this test occurs after $params{'project'} is set, it needs to count
both 'project' and '-anchor':

> +       $params{-replay} =3D 1 if (keys %params =3D=3D 2 && $params{-=
anchor});
