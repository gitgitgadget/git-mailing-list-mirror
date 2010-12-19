From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] builtin/rm.c: Use ALLOC_GROW instead of alloc_nr and xrealloc.
Date: Sun, 19 Dec 2010 10:02:39 +0700
Message-ID: <AANLkTim4GE0mnCBqz6QubpL6g9Bz5U-jHoOw=_MR5-1j@mail.gmail.com>
References: <ffd7b63f3ef5e409775a0d730691efdaf4e41592.1292291262.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 19 04:07:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU9cc-0003ZB-Mo
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 04:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225Ab0LSDDN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Dec 2010 22:03:13 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55280 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab0LSDDM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Dec 2010 22:03:12 -0500
Received: by wwa36 with SMTP id 36so1917034wwa.1
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 19:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rqv79MnpwGY05A0d9AMqy1ywKmSLzDeTxZ2m8wSVHZM=;
        b=xeqmepz390Dm32tCOZDB1rQRdvC21xg7hfaQsVhBH1icXWP5jHLhis/7cbde0FkzKx
         cQC6XGwDxzGPGioHPdTX6rOM/NNKavX9wf1Hy4sPnpDkjqVQgitxNMveHphFGXRdpoyd
         2ltUEB5z3dJO9g7yYIVV0BHtL6uz5w+i9ZKow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TwXPDcSnwV4jFFz0kK0pgpHUwmIKVyBP4QRn2aX8Dn+lUd2rMo55KR083ctXrhQg8a
         37uvyVjUDoq/PzZdemKFFAR6FnklQ1Gj+XeYoE2L/PQqX0Bxzc/69rY6BJvAYiRoZlzw
         1ldpVExQxd1fXOYzg4NxA95uYTq9nKeGU9Ixk=
Received: by 10.216.30.144 with SMTP id k16mr5923914wea.19.1292727789829; Sat,
 18 Dec 2010 19:03:09 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Sat, 18 Dec 2010 19:02:39 -0800 (PST)
In-Reply-To: <ffd7b63f3ef5e409775a0d730691efdaf4e41592.1292291262.git.tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163949>

On Tue, Dec 14, 2010 at 8:48 AM, Thiago Farina <tfransosi@gmail.com> wr=
ote:
> =C2=A0static void add_list(const char *name)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 if (list.nr >=3D list.alloc) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list.alloc =3D all=
oc_nr(list.alloc);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list.name =3D xrea=
lloc(list.name, list.alloc * sizeof(const char *));
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(list.name, list.nr + 1, list.alloc)=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0list.name[list.nr++] =3D name;
> =C2=A0}

add_list() is only used at one place, why not remove it and put the
code back in cmd_rm()?
--=20
Duy
