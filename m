From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] Document pack v4 format
Date: Sat, 7 Sep 2013 15:05:05 +0700
Message-ID: <CACsJy8B_61-FPqhN-qsavgznpq2vWj47=dAQjHwSuNX_kx5+0Q@mail.gmail.com>
References: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <1378433643-15638-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309070043420.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 07 10:06:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIDWt-0005Jt-UG
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 10:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025Ab3IGIFl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 04:05:41 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:35892 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab3IGIFh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Sep 2013 04:05:37 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so4929714oag.14
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4rE7OZWlJYsMWGnXgeylh/dmDFnh1AWMUgGcNfpbReo=;
        b=ziQnG3elQ4YuqqyyxStPGVjStoN81eriK2DtK2TivG3iiJJ7V/1tJ4M8dr78sbPUyd
         uRImP6OWeTRIWjAFG6TfXI1OZhzykLGWgJ+QBp1Xw6T2C0bKfvwxMg/oWKJc6k38WoZR
         m7eTbbaZ3vUXHHBtZq10ttmSBrWegOaFNOo7SK/2j2WUJkw8Zc4wcksxXmDHOEVExfij
         BHhFIV/m83r7y4PqeWVXz8hLk88249wVzXAALdMuBZGSkh3xS7hyXQc+cBLafwLVKzAi
         lD+r+aHKqvfr+Hgn11QSD9ZzgTMK6Ig/D6qtgL2NvP/Attw51b48cZwj84S3DnSVoLbz
         AvvQ==
X-Received: by 10.60.51.41 with SMTP id h9mr8503oeo.49.1378541136093; Sat, 07
 Sep 2013 01:05:36 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Sat, 7 Sep 2013 01:05:05 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309070043420.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234116>

On Sat, Sep 7, 2013 at 11:52 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Fri, 6 Sep 2013, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Should be up to date with Nico's latest implementation and also cov=
er
>>  additions to the format that everybody seems to agree on:
>>
>>   - new types for canonical trees and commits
>>   - sha-1 table covering missing objects in thin packs
>
> Yes, I've tweaked the format again.  I've implemented the code needed=
 to
> carry canonical commit and tree objects in pack v4.  And things are m=
uch
> simpler if the canonical commit and tree types are identical to pack =
v2.
> Therefore the new types are used for the pack v4 optimized commit and
> tree representations.

Phew, index-pack finally produces .idx identical to packv4-create
output. Yeah using new types for v4 tree and commit should help. I
have a lot of "if (packv4 && type =3D=3D OBJ_TREE)" tests, now they bec=
ome
"if (type =3D=3D OBJ_PV4_TREE)". Now rebasing on your tree.. Next step:
thin pack support in index-pack, then export/move code in
packv4-create to support v4 in pack-objects.
--=20
Duy
