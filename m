From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Wed, 6 Jan 2016 10:58:37 -0800
Message-ID: <CAPc5daX+uGQfKEteT2dqax-m9dR76Gkg1YeiFjVU9dsTqnHDmw@mail.gmail.com>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
 <20160105150602.GA4130@sigill.intra.peff.net> <CACsJy8AQ9s4VkFn+TNJLD55xJc40+-54BTYbC4Os71uSkL1QSA@mail.gmail.com>
 <5E517AD0-CD4E-4F85-8FEB-89B7A0183967@mikemcquaid.com> <CACsJy8CvPqYGRXB845+4fHjkXH_kSAWG684CoxtWAnXE-gM6ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike McQuaid <mike@mikemcquaid.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 19:59:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGtIU-00031l-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 19:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbcAFS67 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2016 13:58:59 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:35483 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcAFS65 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2016 13:58:57 -0500
Received: by mail-io0-f176.google.com with SMTP id 77so196658898ioc.2
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=jYW4pMyDOECeU/9mZlPLqbHii7DbL8bykvTyxLS1ucY=;
        b=N8I4tfJgiQY0Y8ZUJBtXQOiTB1tCfvzLioftFopdxOEvoq/kZLVbzDZDtnNgIhoOAY
         XNdKMeAPBgQzKhp1/PAZsReSlAMF7qA7o5vfH8o6xbp1LaxGPvKDTEMq4kLQ9kptMzm/
         HCzMWJyLTKOD2XGbGcjNqsYyn4URSxF87TdBJ7Rvx1PS+BHWcLYfdgYA8MU7XqThoteS
         J0XtmjFjwAzLjkacfH+UTDzZ74yX4ei2vS4cD4w4JheYz6MYvMBDPIYUBws0Ra0+AIv7
         +WXYVkoLRlneCVg/wtPnOgJDorxaJQHTuTl+hBrTnjN8mtYG8360UIXspfVUx/DsvRyT
         p6Uw==
X-Received: by 10.107.165.197 with SMTP id o188mr93103071ioe.132.1452106737303;
 Wed, 06 Jan 2016 10:58:57 -0800 (PST)
Received: by 10.36.52.137 with HTTP; Wed, 6 Jan 2016 10:58:37 -0800 (PST)
In-Reply-To: <CACsJy8CvPqYGRXB845+4fHjkXH_kSAWG684CoxtWAnXE-gM6ag@mail.gmail.com>
X-Google-Sender-Auth: Okdllm84AeAoaNjpR8BK3fH4pIQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283451>

On Wed, Jan 6, 2016 at 2:03 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Jan 6, 2016 at 4:50 PM, Mike McQuaid <mike@mikemcquaid.com> w=
rote:
> > it=E2=80=99s also a big area where libgit2 was inconsistent with Gi=
t=E2=80=99s behaviour on either of those versions too.
>
> Yeah.. it looks like libgit2's gitignore support was written new, not
> imported from C Git, so behavior differences (especially in corner
> cases) and even lack of some feature ("**" support comes to mind). Fo=
r
> isolated features like gitignore, perhaps we can have an option to
> replace C Git code with libgit2 and therefore can test libgit2 agains=
t
> C Git test suite. It could be a good start for libgit2 to invade C
> Git. Not sure if anybody's interested in doing it though.

Yup, an area that is reasonably isolated from the remainder of the syst=
em like
this might be a good starting point. But I suspect that the invasion ne=
eds to
happen in the opposite direction in this particular case before it happ=
ens.
That is, if libgit2's implementation does not behave like how we do, it=
 needs to
be fixed, possibly by discarding what they did and instead importing co=
de from
us. After the behaviour of libgit2 is fixed, we can talk about the
invasion in the
opposite direction.

Thanks.
