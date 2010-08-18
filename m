From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [FreeBSD? BUG]: t1304-default-acl.sh fails on FreeBSD 8.1-STABLE
Date: Wed, 18 Aug 2010 19:14:50 +0000
Message-ID: <AANLkTin5wc4+N5yhs=RipxVnY0aiX-5ptQKDL-z__Jyt@mail.gmail.com>
References: <AANLkTikTu2vSCMPqtFvD964XsURayf2MNGSVW1nAaY1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 18 21:15:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olo6E-0001WR-0Y
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 21:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab0HRTOx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 15:14:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47863 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab0HRTOv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 15:14:51 -0400
Received: by fxm13 with SMTP id 13so539975fxm.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=LBME/SsZgHVgsDWELCRNEpEpCVSJB0c57A2FWoQdWXY=;
        b=Wubl8q3qh0oSkB4GFuiTDaLPl2vk6xhtziUWu1g0SfJjKh7SmdGkvVudnJ2Ha0T6L5
         0DrIpqoz3Z8WwlDVu/qT6YJp5pyt9KYegHSMAo0ACRFB7141GWp/JiIXiJ1QSh4jY6nw
         UUnLWf6Dp/nut4QnNs++geSoAOpPCUxV1FYOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=rOosfjGYFhajznGLZNJNTZXLdFgZNZR8iOPPK9V1/lq7xpqhaFfDePjQVi4pwfDPnf
         XXHluGt8F2V9BmAcZ6paGI0seT1haVFM+bxoEE3vbcFSGeJwSSIwNQ2JV+hVqa3uyWVj
         BDOnTsgfmfemfW6zEJ3ApPLPYXd/GTv2dr0f8=
Received: by 10.223.111.206 with SMTP id t14mr8313014fap.32.1282158890383;
 Wed, 18 Aug 2010 12:14:50 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 18 Aug 2010 12:14:50 -0700 (PDT)
In-Reply-To: <AANLkTikTu2vSCMPqtFvD964XsURayf2MNGSVW1nAaY1d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153877>

On Tue, Aug 17, 2010 at 03:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> t/t1304-default-acl.sh fails on FreeBSD, seemingly because setfacl on
> FreeBSD doesn't have a meaningful return code:
>
> =C2=A0 =C2=A0$ setfacl -m u:root:rwx . ; echo $?
> =C2=A0 =C2=A0setfacl: .: acl_get_file() failed: Operation not support=
ed
> =C2=A0 =C2=A00
>
> But on Linux:
>
> =C2=A0 =C2=A0$ setfacl -m u:root:rwx . ; echo $?
> =C2=A0 =C2=A0setfacl: .: Operation not supported
> =C2=A0 =C2=A01
>
> The Solaris setfacl also behaves.
>
> The FreeBSD manpage says this:
>
> =C2=A0 =C2=A0EXIT STATUS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 The setfacl utility exits 0 on success, a=
nd >0 if an error occurs.
>
> Anyone here know more about FreeBSD to shed light on this?

I sent this upstream with a patch:
http://www.freebsd.org/cgi/query-pr.cgi?pr=3D149780
