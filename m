From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 08/20] remote-curl: accept empty line as terminator
Date: Mon, 4 Jul 2011 16:11:22 +0200
Message-ID: <CAGdFq_ioz+MW8SuWUZAyeia979odTHGEsmyMrc00o1ZwbywUbA@mail.gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-9-git-send-email-srabbelier@gmail.com> <20110619224216.GF23893@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 16:12:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qdjsv-0003aW-DX
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 16:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab1GDOMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jul 2011 10:12:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63404 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab1GDOMC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2011 10:12:02 -0400
Received: by pvg12 with SMTP id 12so4396511pvg.19
        for <git@vger.kernel.org>; Mon, 04 Jul 2011 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NmxP68RVA+cPECUoycaZ0TblJacPcivXup4lEqWPu6k=;
        b=H7oKSQNdQdgJf8xh7jvX1cPbUU0c4lQoEZuXCcGMfFlkAroWWeF2F+6f8+qZwgVtP+
         EFuaF479FJWgqrL76H+9hBxGaZjIasqUEEOCHmmR0/R97+FaHCHvVyt8FQmOIG9UqP6Q
         8hqi1Pf4yXDWVmCto62XteLKK6zupMG5xMrAQ=
Received: by 10.68.22.101 with SMTP id c5mr7107842pbf.502.1309788722099; Mon,
 04 Jul 2011 07:12:02 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Mon, 4 Jul 2011 07:11:22 -0700 (PDT)
In-Reply-To: <20110619224216.GF23893@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176600>

Heya,

On Mon, Jun 20, 2011 at 00:42, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Thanks. =C2=A0I wonder if that first "if" should be something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strbuf_getline(&buf, stdin, '\n') =3D=3D=
 EOF) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ferror(std=
in))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0fprintf(stderr, "Error reading command stream\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0fprintf(stderr, "Unexpected end of command stream\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> to catch I/O errors (e.g., the transport-helper exiting early).

Good idea, done. Tests still pass too ;).

--=20
Cheers,

Sverre Rabbelier
