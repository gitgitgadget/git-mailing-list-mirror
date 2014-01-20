From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/WIP v2 02/14] read-cache: new extension to mark what file
 is watched
Date: Mon, 20 Jan 2014 08:38:25 +0700
Message-ID: <CACsJy8C5z1AoVKCD-w967O+TbXk0-dUJ2AP34JTAsjfeqWhmrg@mail.gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com> <1389952060-12297-3-git-send-email-pclouds@gmail.com>
 <87fvojewaf.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Jan 20 02:39:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W53pO-0007z6-06
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 02:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbaATBi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jan 2014 20:38:57 -0500
Received: from mail-qe0-f45.google.com ([209.85.128.45]:62133 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbaATBi4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jan 2014 20:38:56 -0500
Received: by mail-qe0-f45.google.com with SMTP id 1so237413qec.4
        for <git@vger.kernel.org>; Sun, 19 Jan 2014 17:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Mfm6GElsFw4UL6BydafAds6uxpq6dgg5m+ag51/TGd8=;
        b=n9Afx8nEUVEc23uFVRLi+BjnA8Esg8H2TUhQw7WM2wXHiGk2QRau2EY5+ue12l6jzz
         hGlD0XZ1dw6bCYfp+kuQiddhPPvtJecXLs8SVEjKYCQ6c3ngbpV9IkbwdjIwlTalXkE7
         0Gw3kEhY3g1E23HN9SaY7B4mo129xIA3ZLSTEc99pUTEDORG1/drQXgabSfO1KTFiHfY
         DbwuLO7Nu5CZCxo0N896AmV1v3dMoYsvfbt3z/aON3InoVBlOabLFSVMys+lbWwZ0tFy
         M+2kKPePk/lUHLsl1ceRtHA3ocMIGJ5Ci8vSmikTM8b9iG+RBWynb0Ach8AcDa3Wevrf
         LpwA==
X-Received: by 10.224.123.15 with SMTP id n15mr23678378qar.78.1390181935971;
 Sun, 19 Jan 2014 17:38:55 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 19 Jan 2014 17:38:25 -0800 (PST)
In-Reply-To: <87fvojewaf.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240706>

On Mon, Jan 20, 2014 at 12:06 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> If an entry is "watched", git lets an external program decide if the
>> entry is modified or not. It's more like --assume-unchanged, but
>> designed to be controlled by machine.
>>
>> We are running out of on-disk ce_flags, so instead of extending
>> on-disk entry format again, "watched" flags are in-core only and
>> stored as extension instead.
>
> I wonder if this would be a good use-case for EWAH bitmaps?  Presumab=
ly
> most users would end up having only a few large ranges of files that =
are
> being watched.  Quite possibly most users would watch *all* files.

Oh yeah. I edited my commit message locally to this a while ago

    On webkit.git with
    182k entries, that's 364k more to be SHA-1'd on current index
    versions, compared to 22k in this format (and even less when
    jk/pack-bitmap ewah graduates and we can use ewah compression)
--=20
Duy
