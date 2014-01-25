From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: 'git diff' command doesn't honor utf8 symbol boundaries, and
 doesn't use actual terminal width
Date: Sat, 25 Jan 2014 11:02:12 +0700
Message-ID: <CACsJy8Cgz+18F85408vKL-pBHPOLjxJjsbTF+pL4D2k=DbU0-g@mail.gmail.com>
References: <52E330CC.10400@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Yuri <yuri@rawbw.com>
X-From: git-owner@vger.kernel.org Sat Jan 25 05:03:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6uST-0006gm-NR
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 05:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbaAYECp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 23:02:45 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:44816 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaAYECo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 23:02:44 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so4863898qap.16
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 20:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=uaEI1sCI9RxUjp+kk8DbDOmfbXg1iCZVaPeHZwoZuEg=;
        b=yexh814ldw+JoIwf9QYm7eZO9sVmjSLSCiTTX/td1vK1EMV4tkH0VI7LYsXvTZkLug
         ngFhIdyfm83Zu+3ioh0K3oxn0meF/NC9uAE+C0YbimonbyFlR0Y6abM/rh4GizAO+XWW
         owKtp5rILgZIXPscnUith2qgBkhgVzYBrBM32wgMQUjlPStpSB/REo38OoGKQquzBLwM
         VxL8w3yt9OYrSsSHUwgKsNGghBxQsC0HaqXI/IcBPp47yT326CG7IbAO8L8UB2S79Izk
         f0VyS327ndwYjhYJ7Q09NeJyVmoigBhiFoWFVxcJPzKdB4CABmF+Uj241kTFTGCBABz/
         cJqA==
X-Received: by 10.140.96.17 with SMTP id j17mr2521858qge.112.1390622563866;
 Fri, 24 Jan 2014 20:02:43 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Fri, 24 Jan 2014 20:02:12 -0800 (PST)
In-Reply-To: <52E330CC.10400@rawbw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241060>

On Sat, Jan 25, 2014 at 10:34 AM, Yuri <yuri@rawbw.com> wrote:
> The fragment of 'git diff' output looks like this:
> - <translation>=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: =D0=B0=D0=B4=D1=80=
=D0=B5=D1=81 %1 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=B7=
=D0=B0=D0=BF=D1=80=D0=B5=D1=89=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=81=D0=B8=
=D0=BC=D0=B2=D0=BE=D0=BB=D1=8B. =D0=9F=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=
=B9=D1=81=D1=82=D0=B0,
> =D0=BF=D0=B5=D1=80=D0=B5=D0=BF=D1=80=D0=BE=EF=BF=BD
> + <translation>=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: =D0=B0=D0=B4=D1=80=
=D0=B5=D1=81 %1 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=B7=
=D0=B0=D0=BF=D1=80=D0=B5=D1=89=D1=91=D0=BD=D0=BD=D1=8B=D0=B5 =D1=81=D0=B8=
=D0=BC=D0=B2=D0=BE=D0=BB=D1=8B. =D0=9F=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=
=B9=D1=81=D1=82=D0=B0,
> =D0=BF=D0=B5=D1=80=D0=B5=D0=BF=D1=80=D0=BE=EF=BF=BD
>
> Two issues here:
> 1. Cyrilic text in utf8 got truncated not at utf8 boundary, causing t=
his
> garbage symbol in the end
> 2. Truncation is done at somewhat ~70% of the actual screen width. gi=
t could
> go all the way to the whole screen with, but it didn't. Shrinking ter=
minal
> width causes the output truncation limit to shrink in the same propor=
tion.
> So some bad decision about truncation size is made somewhere in 'git =
diff'
> command.
>
> Suggested behavior:
> 1. git should respect utf8, and in case of truncation it should add =E2=
=80=A6
> symbol.
> 2. truncation algorithm should read current terminal width and trunca=
te at
> width-1 length to allow for the above-mentioned symbol

I don't think git diff truncates its output (it does truncate @@
lines, but not the real diff). Perhaps your pager did that?
--=20
Duy
