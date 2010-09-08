From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] sha1_name: allow to add @{...} alias via config
Date: Wed, 8 Sep 2010 11:45:29 +0200
Message-ID: <AANLkTimK6MwJHYafAAYNn+h3HD1f0H-BHsQYph4qbCrJ@mail.gmail.com>
References: <1283918641-3662-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 11:45:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtHE3-0003zj-B5
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 11:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758583Ab0IHJpv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 05:45:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39839 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004Ab0IHJpt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 05:45:49 -0400
Received: by iwn5 with SMTP id 5so6218452iwn.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 02:45:49 -0700 (PDT)
Received: by 10.231.169.10 with SMTP id w10mr9617391iby.106.1283939149123;
 Wed, 08 Sep 2010 02:45:49 -0700 (PDT)
Received: by 10.231.30.193 with HTTP; Wed, 8 Sep 2010 02:45:29 -0700 (PDT)
In-Reply-To: <1283918641-3662-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155776>

2010/9/8 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> This allows users to add new @{..} alias via ref-at.* config
> variables. The rewrite rule is printf-alike.
>
> My itch is I usually work on a topic and only want to see commits in
> that topic. So I make a tag to the topic's base, then do
>
> git log base/my-topic..
>
> That is a lot of keystrokes, and my mind is small enough sometimes I
> don't even remember the topic name, stucking at "base/ =C2=A0what?"
>
> Now I have "ref-at.base =3D base/%(tip)" in my gitconfig and I only n=
eed
> to do "git log @{base}..".

I like the idea, but I would like something more generic, a ref
transformation or expression (ref-exp?). Currently you can't say
%(tip)@{1}, neither %(tip)^, nor origin/master..origin/%(tip).

Another issue is that it can shadow builtin @{}s, like @{upstream}.

Why %(tip) and not %(branchname), in line with other %() modifiers.

In particular I have a use case for this @{name}. I would like somethin=
g like:

ref-exp.last =3D %(tip)@{1}..%(tip)@{0}

so I could do:

git log @{last}
git log origin/master@{last}

Although another way to get it could be:

git log @{1..0}
git log origin/master@{1..0}

Thanks,
Santi
