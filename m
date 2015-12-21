From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: -C option with pull doesn't seem to be respected in aliases in
 git 2.6.4.
Date: Mon, 21 Dec 2015 08:17:26 +0700
Message-ID: <CACsJy8D=a4NUi+zWj=DVrzRdCxzWA6hp8kCaPAN_Cwv7H7Ohkg@mail.gmail.com>
References: <96FA4EE3-B68F-49B9-896F-38F37E12676D@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Tan <pyokagan@gmail.com>
To: Cameron Esfahani <dirty@apple.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 02:18:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAp6y-0000PR-Lk
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 02:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbbLUBR7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2015 20:17:59 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34804 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbLUBR6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Dec 2015 20:17:58 -0500
Received: by mail-lf0-f67.google.com with SMTP id l133so10265636lfd.1
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 17:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2nttS2gRkoMXGHN9Dilvq0ll6hMXaGGqdoAfqNgaekQ=;
        b=e2fgKC7oWHwmEx6u3rzMr4uocJpbY8ZMIsk2Xx+BQ8oQTmGJorL9jFfHdHyrN8paRs
         2kbnUsTus6fdN2PjdjTIpZvxPPusHOSf+oHVRTHbzu7FJ1SLlIXt4zXligB5u0NhQ2p4
         XKS3RLgx/QdgSwaN8xpTryNPB1IsL0jqDR+ad7IU4S+hLkswDdBwp/BNRqmKWQZDRwru
         AmFBm7d9CaUxEB54KTPBcGuhGQCdOoX32LwKDGHufp4OQKeLEjvdBupf3YNIFMUgQ50g
         HMCsrlTnzZApDdrs7YSNBE3EsDuLDnNk4p9dxiwQ4w+Oem7NXTaSsDT6gGSWs4iB7DGk
         gcfQ==
X-Received: by 10.25.168.6 with SMTP id r6mr5352457lfe.94.1450660676516; Sun,
 20 Dec 2015 17:17:56 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Sun, 20 Dec 2015 17:17:26 -0800 (PST)
In-Reply-To: <96FA4EE3-B68F-49B9-896F-38F37E12676D@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282780>

On Fri, Dec 18, 2015 at 8:35 AM, Cameron Esfahani <dirty@apple.com> wro=
te:
> I have git project checked out at ~/llvm.  Inside of there, inside of=
 a =E2=80=9Ctools=E2=80=9D directory, I have another project checked ou=
t as =E2=80=9Clldb=E2=80=9D:
>
> ~/llvm/tools/lldb
>
> I wrote an alias which would help me update all my projects:
>
>         all =3D !find . -type d -name .git | sed 's:/.git::' | xargs =
-I{} -t git -C {} $1 && :
>
> This would allow me to be inside of ~/llvm and type "git all pull" an=
d get all my projects updated.
>
> It seems that at some point this broke.  If try to use this alias und=
er git 2.6.4, it only updates the llvm project.
>
> The interesting thing is that if I pass fetch, instead of pull: "git =
all fetch", then it seems to work correctly.

It would help if you could bisect this to the first broken commit (or
at least one version that works). git-pull was rewritten in C in
2.6.0, so this could be a regression. If you try a version before that
and the problem remains, then it's not the git-pull rewrite. Another
suspect is c056261 (git potty: restore environments after alias
expansion - 2014-06-08), since v2.1.0.
--=20
Duy
