From: Anthony Foiani <anthony.foiani@gmail.com>
Subject: Re: [PATCH] Improve errors from 'git diff --no-index'.
Date: Sun, 22 May 2011 22:05:36 -0600
Message-ID: <BANLkTi=Uf8X+Bkd+CZ9qz0wXhHn8wwYzrA@mail.gmail.com>
References: <4dd98da1.1bf98e0a.4eb4.6fc5@mx.google.com>
	<7vlixyw4cx.fsf@alter.siamese.dyndns.org>
	<BANLkTinKpSP5oEms914TWD7Tsjab1B87QQ@mail.gmail.com>
	<7vhb8mw1e6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 06:05:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOMOl-0004zO-Ub
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 06:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057Ab1EWEFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 00:05:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55181 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1EWEFi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 00:05:38 -0400
Received: by bwz15 with SMTP id 15so4377331bwz.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 21:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DYIMEit0Rpnso7LTrhY8eKzMv6YI7h22/WF1BcpKFVY=;
        b=xn3URfzt9q7zebBXPwJtpSXONnq5aVO03ZEPXwGTee6FS3MRysaVmXZZ6JUaW7WrHc
         kcvqVFEDA6yizrh7lF7Mn+IIJ/AcdpcqY6fn0zuAM1jhToSxMQd84UiliUg+AZvQAiBa
         ZiFjM3IIJnWUnqyK6WBUTqeQHTSWNfuVuou04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hXdsQRtKdlNAsEW86gcRN1k8oZOAbdUa3h+pWM2zzlYNU5VAbOUFieiZADw41GEKeb
         P+/zbBYP2AL6Yj7E7LLlrJ1SmAOC6FPDCiDty2yguxehx+PoykDnwkt7B70iY7avFrmD
         vC+uzJMNnWuc//AV3JfeWleEEfZe8QbGROyXQ=
Received: by 10.204.83.7 with SMTP id d7mr1567781bkl.206.1306123536588; Sun,
 22 May 2011 21:05:36 -0700 (PDT)
Received: by 10.204.181.68 with HTTP; Sun, 22 May 2011 21:05:36 -0700 (PDT)
In-Reply-To: <7vhb8mw1e6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174223>

Junio --

On Sun, May 22, 2011 at 9:18 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> No, it was only your 'I tried to use "git diff"' that was confusing t=
o me.

Apologies!

> With pathspecs or any other options, it is understandable that you we=
re
> confused, for example from an output like this:
>
>> $ git diff -b main.c
>> usage: git diff [--no-index] <path> <path>
>
> At that point we are committed to no-index codepath, so probably a go=
od
> thing to do is to update that confusing usage message a bit better.
>
> It already does change the behaviour when --no-index is not given by =
the
> end user, so perhaps it would be sufficient to change this part:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc !=3D i + 2)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usagef("git di=
ff %s <path> <path>",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0no_index ? "--no-index" : "[--no-index]");
>
> to something like (caution: I am not typing this in my MUA):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc !=3D i + 2) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (no_index)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0warning("Assuming '--no-index'; you are in no repository"=
);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usagef("git di=
ff %s <path> <path>",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0no_index ? "--no-index" : "[--no-index]");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> without changing anything else.
>
> That would be just a patch with 1 line removed, 4 lines added, no?

The "no_index" variable purely indicates whether or not "--no-index"
was given on the command line; for this particular warning, you want
"nongit" instead.

Alternately, you could simply do this above the "if (argc..." condition=
:

if (!no_index)
        warning("Assuming '--no-index'");

It wouldn't explain *why*, but would at least provide some sort of a
hint to the user that they're maybe not doing what they thought they
were doing.

If that's more to your taste, then I'd rather see this than nothing.  :=
)

You might also want to account for the fact that, even within a git
repo, if "git diff" is invoked on two paths that are both outside the
repo, then --no-index is forced. E.g.:

$ cd linux-2.6-stable/
$ git log -1 --pretty=3Dshort
commit 831d52bc153971b70e64eccfbed2b232394f22f8
Author: Suresh Siddha <suresh.b.siddha@intel.com>

    x86, mm: avoid possible bogus tlb entries by clearing prev
mm_cpumask after switching mm

$ ls -al /tmp/{foo,bar}
-rw-rw-r--. 1 tony tony 0 May 22 10:09 /tmp/bar
-rw-rw-r--. 1 tony tony 0 May 22 10:00 /tmp/foo

$ # current git tip:
$ git diff /tmp/{foo,bar}

$ # with my patch:
$ ../git/git-diff /tmp/{foo,bar}
warning: neither '/tmp/foo' nor '/tmp/bar' are tracked, forcing --no-in=
dex

Although I apparently did break something...

$ touch bar
$ git diff bar /tmp/foo
$ ../git/git-diff bar /tmp/foo
fatal: '/tmp/foo' is outside repository

Given that I broke things, and that a +100/-25 patch is a bit
excessive, consider it retracted.

Thanks once again!

Best regards,
Tony
