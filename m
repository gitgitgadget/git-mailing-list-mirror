From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add macro REALLOCARRAY
Date: Mon, 15 Sep 2014 20:04:37 -0700
Message-ID: <CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com>
References: <5415C89C.4090509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 05:05:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTj4h-0003Ny-QV
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 05:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbaIPDE7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2014 23:04:59 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35696 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbaIPDE7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2014 23:04:59 -0400
Received: by mail-lb0-f170.google.com with SMTP id c11so5729542lbj.15
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 20:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=g9V0CVhw3TGfz/ZbJuUGMnGZopnvq49y7JPGktdiAl4=;
        b=LzzoTt+fCXhqcSzQQeFdDGUJbw5I8KTYRQeS3jJVqJTS9ZIMeXhzehP68yJFRAnxUJ
         QH9na8UGOsF7cpbEHh7h9ieBKergbi8tIpS9TBjbu67HfpGtMKAlkaUiretrpytC5Yj2
         Q4IDWze13Dzz0LJ3TrR/j6nvU/mSkXe9iQRX0bcGYuBUYSyFev3s1VU4nBrjzDgrzlD5
         nNAFOlhSxETfp7WHfXh2QDCp95H/+OkJsbF22071GTgY7C/7orS3dtwWvMmqndasH/Yh
         2NaY9Kg7a7HkQV2P/Y7txxmtDKVH+2z6WLb9dbFb5UX+5Bdfadv/hxv56g/pHNOHbR4C
         gdAg==
X-Received: by 10.112.149.2 with SMTP id tw2mr20714551lbb.21.1410836697518;
 Mon, 15 Sep 2014 20:04:57 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Mon, 15 Sep 2014 20:04:37 -0700 (PDT)
In-Reply-To: <5415C89C.4090509@web.de>
X-Google-Sender-Auth: L-x1PKAuNEmon8S4EZmRHODmWbE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257122>

On Sun, Sep 14, 2014 at 9:55 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> +#define REALLOCARRAY(x, alloc) x =3D xrealloc((x), (alloc) * sizeof(=
*(x)))

I have been wondering if "x" could be an expression that has an operato=
r
that binds weaker than the assignment '=3D'.  That may necessitate the =
LHS
of the assignment to be somehow marked as bound the tightest, i.e.

#define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), (alloc) * sizeof(=
*(x)))

Or am I being overly silly?
