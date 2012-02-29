From: Tim Schumacher <schumact@gmail.com>
Subject: Building GIT on older systems.
Date: Wed, 29 Feb 2012 13:22:21 -0700
Message-ID: <CAFqtsHd=b=Ey8j1zTCC4-fut7rno3daQ2Q3HMs3k2SHFvE4dSQ@mail.gmail.com>
References: <CAFqtsHfrk89qHexg8VwMZnKwgWDqbseJNNKFSUkwDtVKX_t=5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 21:22:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2q2d-0006yS-2l
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 21:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab2B2UWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 15:22:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44528 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab2B2UWV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 15:22:21 -0500
Received: by iagz16 with SMTP id z16so190275iag.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 12:22:21 -0800 (PST)
Received-SPF: pass (google.com: domain of schumact@gmail.com designates 10.50.135.66 as permitted sender) client-ip=10.50.135.66;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of schumact@gmail.com designates 10.50.135.66 as permitted sender) smtp.mail=schumact@gmail.com; dkim=pass header.i=schumact@gmail.com
Received: from mr.google.com ([10.50.135.66])
        by 10.50.135.66 with SMTP id pq2mr2060275igb.32.1330546941309 (num_hops = 1);
        Wed, 29 Feb 2012 12:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=KqluiT2gfGcE27hXzSVGnigIiwPU9UOlMREc49uEmPM=;
        b=oQjV5hdOwrHBNv1g2+C2UmF86Nn7CNQx7TOpq2B4Q/0KJFeD9iwVsUj2VZg/I0vSgt
         f6ZSJJ+Y+NbJ7nWqVU2YWSqmV3dXKW9BOFi73+oPvmhCznI7KsaDt3gDulzQVpv3sLxx
         r+cMeDPYIJiVumZ3kaVjkI6SVGRhrsbVwF2wg=
Received: by 10.50.135.66 with SMTP id pq2mr1697429igb.32.1330546941271; Wed,
 29 Feb 2012 12:22:21 -0800 (PST)
Received: by 10.50.111.132 with HTTP; Wed, 29 Feb 2012 12:22:21 -0800 (PST)
In-Reply-To: <CAFqtsHfrk89qHexg8VwMZnKwgWDqbseJNNKFSUkwDtVKX_t=5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191852>

Hi All,

After a long battle trying to get git to compile on my dev boxes I am
seeking help from the gurus...=A0 I have an old system, redhat linux
7.3, with a 2.4.18 kernel with gcc 2.96 toolchain.=A0 Unfortuneatly,
upgrading is not currently an option.

I have figured out so far that I can run the command

make NO_NSEC=3Dtrue

to get past the time struct compile error.

After that, I was able to hand edit the Makefile to set

BASIC_LDFLAGS =3D -ldl

so linking the git-imap-send program succeeds (was failing to link
against this library for some reason...).=A0 I tried to run configure
with these options, but it did not seem to take, only setting
NO_NSEC=3Dtrue to the make command line seems to work.

Anyway, now I get to the point in the build where it goes into the
perl subdir and fails with:

=A0=A0 SUBDIR perl
/bin/sh: -c: line 3: syntax error near unexpected token
`"s<\Q++LOCALEDIR++\E></'
/bin/sh: -c: line 3: `=A0=A0=A0=A0=A0=A0=A0 -e "pm_to_blib({qw{Git/I18N=
=2Epm
blib/lib/Git/I18N.pm private-Error.pm blib/lib/Error.pm Git.pm
blib/lib/Git.pm}},'blib/lib/auto','/usr/bin/perl -pe
"s<\Q++LOCALEDIR++\E></usr/local/git-1.7.9.2/share/locale>"')"'
make[2]: *** [pm_to_blib] Error 2
make[1]: *** [all] Error 2
make: *** [all] Error 2

A couple questions I have so far:
(1)=A0 how can I make make output the actual command it is executing so
I can try to debug things more quickly?
(2)=A0 how can I configure the Makefile to automatically set -ldl as
well as the NO_NSEC flag?
(3)=A0 My perl -v output: This is perl, v5.6.1 built for i386-linux.=A0=
 Is
this sufficient?

Any help is greatly appreciated!

Thanks,
Tim
