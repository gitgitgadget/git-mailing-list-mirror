From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 12:15:38 +0000
Message-ID: <AANLkTilK_8wVQG6s8pUrscwd7ZnvgGyjOjJP41uXYfEl@mail.gmail.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
	<AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com>
	<4C4BFAA3.3050700@digium.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com>
	<AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F99A@CORPUSMX100A.corp.emc.com>
	<AANLkTilhoF670uZ1WbosZP9TNbXect2A3gELRJL0ZZIn@mail.gmail.com>
	<m2d3ubojfr.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: lynn.lin@emc.com, kpfleming@digium.com, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Jul 25 14:15:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od07O-0001qQ-09
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 14:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab0GYMPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 08:15:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59928 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab0GYMPj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 08:15:39 -0400
Received: by iwn7 with SMTP id 7so1865828iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Gc9PfxjbvqEV5/b7k6vUVfjKxx/+Iq+K76nze9fi18s=;
        b=uA7U2yfCgLzJv6lJ1Zl01/xE0HYo9pnxPJlpcoF9wZVy4lRRSl6HcFPhCgHvrsUh9l
         JxiqAwM0nw5ClHxHBB1gKXzAt3bhH1xfEoYOzH8BFZkiR6yTHwYhlUXiRLZ3Hs7x1OI/
         EUXKlBILEdSBE8oqZfZ82hciQGOQyaWx5gdMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uyvOrZqw2c9vZ8fpZTUsJulpP5+XXRScC/CTNZ9ulbvQIJJiyG/4lu9JruStc9peT3
         M8JqYmToCyyJnRAE+9VerhCEEzcD2Rl+P4oYobThWJUw9wMkLnKUZXK/MSAB2eUW6Dvg
         bFfcqMqkyeDiOHyhyHXC8tduz7+ANgEUUqMrY=
Received: by 10.231.170.79 with SMTP id c15mr7010373ibz.82.1280060138698; Sun, 
	25 Jul 2010 05:15:38 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 25 Jul 2010 05:15:38 -0700 (PDT)
In-Reply-To: <m2d3ubojfr.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151732>

On Sun, Jul 25, 2010 at 12:05, Andreas Schwab <schwab@linux-m68k.org> w=
rote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Makefile targets aren't triggered by the include directive.
>
> Umm, yes they are, see (make) Remaking Makefiles.

Ah, yes. But it was being included in more places than just that
-include directive, so I didn't spot the difference:

Without that directive, still generated on make clean:

    $ git diff -U0 | cat
    diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
    index e88f50c..f29406b 100755
    --- a/GIT-VERSION-GEN
    +++ b/GIT-VERSION-GEN
    @@ -2,0 +3,2 @@
    +echo MOO > /tmp/moo
    +
    diff --git a/Makefile b/Makefile
    index b6975aa..5edfeca 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -241 +240,0 @@ GIT-VERSION-FILE: FORCE
    --include GIT-VERSION-FILE
    $ rm -v /tmp/moo; make clean > /dev/null; cat /tmp/moo
    removed `/tmp/moo'
    GIT_VERSION =3D 1.7.2.6.g65a0d3.dirty
    GITGUI_VERSION =3D 0.12.0.64.g89d61-dirty
    MOO

Deleted the rule, not generated, but other things are still calling
the rule:

    $ git diff -U0 | cat
    diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
    index e88f50c..f29406b 100755
    --- a/GIT-VERSION-GEN
    +++ b/GIT-VERSION-GEN
    @@ -2,0 +3,2 @@
    +echo MOO > /tmp/moo
    +
    diff --git a/Makefile b/Makefile
    index b6975aa..1a189da 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -239,4 +238,0 @@ all::
    -GIT-VERSION-FILE: FORCE
    -       @$(SHELL_PATH) ./GIT-VERSION-GEN
    --include GIT-VERSION-FILE
    -
    $ rm -v /tmp/moo; make clean > /dev/null; cat /tmp/moo
    removed `/tmp/moo'
    make[2]: *** No rule to make target `GIT-VERSION-FILE'.  Stop.
    make[2]: *** No rule to make target `GIT-VERSION-FILE'.  Stop.
    make[2]: *** No rule to make target `GIT-VERSION-FILE'.  Stop.
    GITGUI_VERSION =3D 0.12.0.64.g89d61-dirty
    cat: /tmp/moo: No such file or directory
