From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Sat, 5 Jul 2014 02:09:57 +0200
Message-ID: <CAA787rmf36V1=Sd8TZrc7DboTkeJDYKuEGgCe90mZLLKSp6=tw@mail.gmail.com>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
	<1404505370.3109.15.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 02:10:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3DYM-0003Db-0H
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jul 2014 02:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760352AbaGEAKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2014 20:10:00 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:54680 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760294AbaGEAJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jul 2014 20:09:59 -0400
Received: by mail-la0-f44.google.com with SMTP id ty20so1522819lab.3
        for <git@vger.kernel.org>; Fri, 04 Jul 2014 17:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=+rONh6Pe/cZJzXPXufKenVeaHbeTswfhZplyq7KoQMc=;
        b=yEj5EsDS3iBhblGI6Q07QOtG2IDQ7yBFN1Abjoeq0+6b8ffOCR2xwFpZM2wPvcnfME
         FpTCliRkZbLbffrFU794fi5lCm8fQYKhh+zLWGW536BzsPX9cwR4chCm6KX25offwCQY
         vr6ufGtfG/QXvLckUNvIlFt3RiXTpjWtAPfFAJemV02rUDO+D2z/ddox1+yDkgY7qNtV
         DwJ5pZXZvAbFP53A/zrGd6Lx7O0+3SOVBB2JUW7xWbl9jJBg4MfFrvQRw5bNxiwdNyr3
         oOPQ3VE95yYa6leq3+LfSu49POsRZnc6wsZOrLNcsf4Ch0c9iUl+C7PFIFSIYXGze2N4
         ERBQ==
X-Received: by 10.112.173.201 with SMTP id bm9mr9996088lbc.16.1404518997774;
 Fri, 04 Jul 2014 17:09:57 -0700 (PDT)
Received: by 10.112.142.7 with HTTP; Fri, 4 Jul 2014 17:09:57 -0700 (PDT)
In-Reply-To: <1404505370.3109.15.camel@stross>
X-Google-Sender-Auth: cDiBY7iO7-1VCsD4dSzGuRKa4rY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252912>

On 4 July 2014 22:22, David Turner <dturner@twopensource.com> wrote:
> On Thu, 2014-07-03 at 23:55 +0200, =C3=98yvind A. Holm wrote:
> > When compiling newest master (v2.0.1-472-g6f92e5f) on Debian 7.5
> > (64-bit), t5150-request-pull.sh fails when compiling with
> >
> > $ make configure
> > $ ./configure
> > --prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f92e5f
> > $ make prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f92e5f
> > $ make
> > $ cd t
> > $ ./t5150-request-pull.sh
>
> Are you sure you're not running under valgrind? I can reproduce the
> test failures when I run under valgrind because I didn't add the righ=
t
> stuff to the suppression files (patch to follow).

Nope, no valgrind involved here, it's not even installed on those two
servers. The two server setups differ quite much, one of them I use for
all kind of things, the other is a dedicated web server with not much
else except Apache and some essential stuff I can't live without
installed.

> I also just went ahead and got a Linode running Debian 7.5 (64-bit),
> and I still can't reproduce the problem.

Now that's what I call commitment. :)

> Do you have any additional reproduction info that I need here?

I build new gits pretty much every time Junio pushes new stuff to
kernel.org, and I'm using this script which takes care of everything:

  https://github.com/sunny256/utils/blob/master/build-git

I have a README at

  https://github.com/sunny256/utils/blob/master/README.build-git.md

where I have listed all packages I install from apt-get before I build
the thing. The script I used to test with git bisect is at

  https://github.com/sunny256/utils/blob/testfail.t5150-fail-g6f92e5f/t=
estfail

, it simulates what the "build-git" script does.

The test works if I run a plain "make" using the standard Makefile
without ./configure .

Hm, interesting. When I don't use --prefix as mentioned above, just a

  $ make configure
  $ ./configure
  $ make
  $ cd t
  $ ./t5150-request-pull.sh

The test works. Seems as there's something fishy about the use of
--prefix in this specific commit (v2.0.1-472-g6f92e5f).

I'll dig more into this thing now to see what's going on.

=D0=A1=D0=B5=D0=BD=D1=81=D0=BE=D1=80=D0=BD=D0=BE =D0=92=D0=B0=D1=88,
=C3=98yvind
