From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Fri, 22 Oct 2010 00:04:32 +0200
Message-ID: <AANLkTinsKoYupt=yO9eVkpufzNDnke865UfMLKWSS6J1@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com> <7vhbgphf25.fsf@alter.siamese.dyndns.org>
 <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
 <7vbp6vduly.fsf@alter.siamese.dyndns.org> <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
 <20101018163134.GA6343@burratino> <AANLkTik3Di=dcC=CxW+Lou515E2wXq8_OaR99mghC+vF@mail.gmail.com>
 <AANLkTi=ydzrvy6_PbFLpA_qcHzF-8s3xbu3XvU5GnQ_k@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 00:06:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P93Gs-0000by-9Y
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 00:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915Ab0JUWFx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 18:05:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47935 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932902Ab0JUWFu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 18:05:50 -0400
Received: by fxm16 with SMTP id 16so109602fxm.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 15:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=vlHemB6qd2s1MtKvQtpN7ubcwi09Gkoky3oRRtz6zK0=;
        b=Fpe55wTclWmTh27tC2r4MHal/RFscU+D/F1fF+zTg/p7cNMLFc7ytuxI2AxMc/KpBV
         ojOQZhY9Ratjas7OSx9Ywh0peqH1+2qnm4jh4wVGvCVFGjzcBRVemwVtPVQcQMY7EHTT
         qzs977uOXIhoAivBJWTHjvm2erfLjNPovzGh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=tUqQdkJV8U6eMhD0Y5aVYgrPU7u8MoMzQAtlSaTlqxkWnMA28sYzXO3IN8xQI2+Mab
         z09YR83Mimq5LKwWwDT/pXCrRUTfQ7/K7MrNCHfm5FKIRiXV/SHgPiA4Ydt+AWJVaNtO
         cemOo+Wtt/82Z/HdkX66a+xJP67vkz0FpQELA=
Received: by 10.103.219.10 with SMTP id w10mr2169155muq.64.1287698749552; Thu,
 21 Oct 2010 15:05:49 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Thu, 21 Oct 2010 15:04:32 -0700 (PDT)
In-Reply-To: <AANLkTi=ydzrvy6_PbFLpA_qcHzF-8s3xbu3XvU5GnQ_k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159578>

On Fri, Oct 22, 2010 at 12:00 AM, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
> =A0 =A0 =A0 =A0if (user_name) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pass =3D getpwnam(user_name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pass)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct credentials c;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cred =3D &c;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 c->pass =3D getpwnam(user_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!c->pass)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("user not found - =
%s", user_name);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!group_name)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gid =3D pass->pw_gid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c->gid =3D pass->pw_gid=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 group =3D getgrnam(grou=
p_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct group *group =3D=
 getgrnam(group_name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!group)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("g=
roup not found - %s", group_name);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gid =3D group->gr_gid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c->gid =3D group->gr_gi=
d;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}

Sorry for the noise, but this is clearly incorrect and won't compile.
I guess replacing "c->" with "c." should do the trick :)

If I got this way, I'll obviously make sure it compiles! ;)
