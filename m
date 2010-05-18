From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] WIP: begin to translate git with gettext
Date: Tue, 18 May 2010 10:57:24 +0000
Message-ID: <AANLkTikK9LAd_pwTwB56Vpq19i00X5apy6qT-ZOpnLEp@mail.gmail.com>
References: <20100517160208.GA20842@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jeff Epler <jepler@unpythonic.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 18 12:57:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEKUM-0008NK-W8
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 12:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab0ERK50 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 06:57:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48799 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab0ERK5Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 06:57:25 -0400
Received: by iwn6 with SMTP id 6so1436517iwn.19
        for <git@vger.kernel.org>; Tue, 18 May 2010 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=nw/58BLt5qd66dEQM8FkqGJx3aKltMWGbC/vrcoVbOI=;
        b=a68tRvE+Rr5NRcICvsm3wOUTt3YLSnMYHQiLMq/tXuMqgX/7Npok0QWfjQCwaeoQ+n
         M9py9SvMQnowKGtuJ7oa/X0MtWSKXDCspuaL1yfkcOIVXnpMR7/GQR3vUt/39P8o1T1u
         S3p+KL7NYbIf0IzW859HoLTZY7KZToYiqTZyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=L4NQLOhlRIL9w2RDv6t/PmMZXAcCMKgGfwMNzcF5JbmpMB2ly5JyuRt2pDVOXuahyT
         A8ZaJUUoTr82oAVUosdASQxE6fb2q89vuZdYABgVEuor20yoDk139dhzMsuaF8APLIfl
         piNDScTtSRFACbNHMDuiZP49R0QoGq0WL8SGU=
Received: by 10.231.184.75 with SMTP id cj11mr1733360ibb.51.1274180244135; 
	Tue, 18 May 2010 03:57:24 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 18 May 2010 03:57:24 -0700 (PDT)
In-Reply-To: <20100517160208.GA20842@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147280>

On Mon, May 17, 2010 at 16:02, Jeff Epler <jepler@unpythonic.net> wrote=
:
> Signed-off-by: Jeff Epler <jepler@unpythonic.net>
> ---
> While I'm certain that there are a lot of things to object to in this
> patch, it shows 90% of what is needed to use gettext to translate
> the portions of git written in c, without involving undesired gnu
> infrastructure such as automake.
>
> Makefile adds necessary rules for generating git.pot and for building
> and installing compiled message catalogs (.mo) from text message
> catalogs (.po). =C2=A0It also adds a gettext support header and sourc=
e file.
>
> Minimal changes are made to git to use the requested LC_CTYPE and
> LC_MESSAGES, and some messages for 'git status' are marked for
> translation.
>
> When I provided a gibberish translation of a message:
> #: wt-status.c:87
> msgid "# Changed but not updated:"
> msgstr "# Changes not blah blah blah"
>
> running 'git status' used the translation:
> $ git status
> # On branch master
> # Your branch is ahead of 'origin/master' by 1 commit.
> #
> # Changes not blah blah blah
> ...
>
> I ran with 'make install' and prefix set in config.mak. =C2=A0It didn=
't seem
> to work when running from the source directory, and it may or may not
> work with runtime prefix.

Thanks a lot for this patch.

I'm having some trouble getting it to work though. I did:

    make pot

That made the po/git.pot file with all the relevant messages. Then I
made a po/is.po in poedit which has stuff like:

    #: wt-status.c:598
    msgid "On branch "
    msgstr "A greininni "

    #: wt-status.c:605
    msgid "Not currently on any branch."
    msgstr "Ekki =C3=A1 gr=C3=A6nni grein.

I did:

    make prefix=3D/usr all
    sudo make prefix=3D/usr install

But any invocation of my new git-status (I uninstalled my system git
first) with either LC_ALL, LC_MESSAGES or LC_CTYPE set to is, is_IS or
is_IS.UTF-8 doest't yield the desired results:

    $ strings /usr/share/locale/is/LC_MESSAGES/git.mo |grep grein
    nni grein.
    A greininni

it doesn't seem to spot the file:

    $ strace git status 2>&1|grep locale
    open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) =3D -1
ENOENT (No such file or directory)
    open("/usr/share/locale/locale.alias", O_RDONLY) =3D 3
    open("/usr/lib/locale/is/LC_MESSAGES", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
    open("/usr/share/locale-langpack/is/LC_MESSAGES", O_RDONLY) =3D 3
    open("/usr/share/locale-langpack/is/LC_MESSAGES/SYS_LC_MESSAGES",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
    open("/usr/lib/locale/is/LC_CTYPE", O_RDONLY) =3D -1 ENOENT (No suc=
h
file or directory)
    open("/usr/share/locale-langpack/is/LC_CTYPE", O_RDONLY) =3D -1
ENOENT (No such file or directory)
    open("share/locale/",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) =3D 5
    open("share/locale/.gitignore", O_RDONLY|O_LARGEFILE) =3D -1 ENOENT
(No such file or directory)
    open("share/locale/is/",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) =3D 6
    open("share/locale/is/.gitignore", O_RDONLY|O_LARGEFILE) =3D -1
ENOENT (No such file or directory)
    open("share/locale/is/LC_MESSAGES/",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) =3D 7
    open("share/locale/is/LC_MESSAGES/.gitignore",
O_RDONLY|O_LARGEFILE) =3D -1 ENOENT (No such file or directory)

And the UI remains untranslated.

I'm probably doing something very silly. I'd appreciate some help if
you can spot what it is, if I can get this working I can start
submitting some i18n patches.
