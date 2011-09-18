From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH] Prevent users from adding the file that has all-zero SHA-1
Date: Sun, 18 Sep 2011 19:06:06 +0200
Message-ID: <CAHYJk3TRHu0whbdPQXzs2ELpoiEqZPxeWmz_V4HQzj5XfAJDBA@mail.gmail.com>
References: <1316259574-1291-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 19:06:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Koo-000787-Pw
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 19:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab1IRRGJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 13:06:09 -0400
Received: from mail-vw0-f42.google.com ([209.85.212.42]:63823 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653Ab1IRRGI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 13:06:08 -0400
Received: by vwl1 with SMTP id 1so10038614vwl.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lpwTYyV4oHxxdYXgq9tRYfpzqlReJ0+JpiUQPFGKwVo=;
        b=gHKZZJTPe4HFen44cinMzzyWGzThOcf7BqBoTDlxXQkDnAlAgu1QblAYNKQGypfzHN
         Nq5pNzeYRM3ourJscGz/hoIsQC3Grb/HvGDMKaaObCVQWsNM+bjJ3tsXfNaSF2ZKQixq
         t+I+LlzQTI/tfEMod4BwG++YIbXBHBvNAE3aA=
Received: by 10.52.34.80 with SMTP id x16mr458824vdi.88.1316365566811; Sun, 18
 Sep 2011 10:06:06 -0700 (PDT)
Received: by 10.52.157.72 with HTTP; Sun, 18 Sep 2011 10:06:06 -0700 (PDT)
In-Reply-To: <1316259574-1291-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181615>

2011/9/17 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> This particular SHA-1 has special meaning to git, very much like NULL
> in C. If a user adds a file that has this SHA-1, unexpected things ca=
n
> happen.
>
> Granted, the chance is probably near zero because the content must
> also start with valid blob header. But extra safety does not harm.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Another way than die() is to detect this situation and update header=
 a
>  little to give different SHA-1 (for example a leading 0 in object
>  size in header). Older git versions may not be happy with such an
>  approach.
>
>  The same check can be added to commit, tree, tag creation and fsck.
>  Maybe I'm too paranoid.
>
>  By the way, are any other SHA-1s sensitive to git like this one?

Bad things will happen if you get an object with the same hash as any
already existing one, and AFAIK, there are no checks for this. I don't
think there's much point in treating 000...0 more specially than
HEAD^0 for example. The only two hashes that mean something in an
empty repo I guess are this one and the empty tree hash though.

PS there's a typo in your error message, "unluckly".

--=20
Mikael Magnusson
