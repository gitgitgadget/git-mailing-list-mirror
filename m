From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Wed, 29 May 2013 14:39:37 -0500
Message-ID: <CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
	<CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 21:39:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhmDn-0007D4-Kb
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966402Ab3E2Tjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 15:39:40 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62187 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966298Ab3E2Tji convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 15:39:38 -0400
Received: by mail-wi0-f178.google.com with SMTP id hj6so3857771wib.17
        for <git@vger.kernel.org>; Wed, 29 May 2013 12:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IiZMsW7QG23FmfyC0vxotY4gphRPMZNeocUm3Es/P/g=;
        b=HV/yOm9/f4Pj2Tab3noHFWd5fHCL0wyClua1T6Shg7GZibVIKEBecPHjCAitC4gZRM
         n8bemysEpUQUrvepwyAdX/p4L9Jm6BJXO4uHeAuSFGTpsH7Ko2gu3XFY2pNGx9YrL2RZ
         B53ptgR/FlUL5RkKKVrwZ/zJHjT++e486etHTaUY0qXfCsejqxD2nBpkKsMYirqQ6ToF
         YDeX+m4NhBU5m0q3uJ6/asNReWYZUUCg2DSYgKFZrkc/YIq3Ekv+scZi/4v0LC3RJCSC
         E1nxwFJZdv6LwEFZZMgq52pLh4w2Si6PjQrB2K7reyiB3IX65Ts2+s3T9BvjUJnErKWA
         pCDg==
X-Received: by 10.180.184.101 with SMTP id et5mr2186480wic.45.1369856377238;
 Wed, 29 May 2013 12:39:37 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 12:39:37 -0700 (PDT)
In-Reply-To: <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225877>

On Wed, May 29, 2013 at 1:11 PM, Br=C3=A1ulio Bhavamitra <brauliobo@gma=
il.com> wrote:
> ---------- Forwarded message ----------
> From: Br=C3=A1ulio Bhavamitra <brauliobo@gmail.com>
> Date: Wed, May 29, 2013 at 8:23 AM
> Subject: [git-users] Highlevel (but simple to implement) commands
> provided by default for git
> To: git-users@googlegroups.com

> One of the things I note about git is that is provides mostly
> low-level and strictly necessary commands.
> Many highlevel commands are then implemented as alias by users, after
> a deep search on the internet.
>
> Adding highlevel commands, even though it could be implemented by a
> simple alias, would put git in another level
> of user experience and create a new standard for newbie users.
> What git developers think about this?

Completely agree.

>   root =3D rev-parse --show-toplevel
>
>  upstream =3D !git for-each-ref --format=3D'%(upstream:short)' $(git
> symbolic-ref -q HEAD)

git rev-parse --abbrev-ref @{u}

>  upstream-remote =3D !git upstream | sed -e 's/\\/.*$//g'

git config branch.$(git rev-parse --abbrev-ref HEAD).remote

>  out =3D !git fetch `git upstream-remote` && git l `git upstream`..HE=
AD

'git fetch' without arguments is the same as git fetch `git upstream-re=
mote`

Junio: See? It's not the expected behavior for most of our user-base.

'git log @{u}..HEAD' does the same as 'git log `git upstream`..HEAD'

>  unmerged =3D !git ls-files --unmerged | cut -f2 | uniq
>  untracked =3D ls-files --other --exclude-standard
>  staged =3D ls-files --staged
>  modified =3D ls-files --modified
>  deleted =3D ls-files --deleted

I think we should have a user-friendly 'git ls' command.

>   head =3D !git l -1

Or 'git show --quiet'.

>  current =3D rev-parse --abbrev-ref HEAD

We should probably also add typical shortucts:

d =3D diff
l =3D log
f =3D fetch
p =3D push
r =3D reset
ci =3D commit
rb =3D rebase
co =3D checkout
st =3D status
pi =3D cherry-pick
mt =3D mergetool

--=20
=46elipe Contreras
