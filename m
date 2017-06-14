Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB3361FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 02:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbdFNCRp (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 22:17:45 -0400
Received: from sunbase.org ([178.79.142.16]:52258 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbdFNCRn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 22:17:43 -0400
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1dKxsK-0000B7-UK; Wed, 14 Jun 2017 02:17:40 +0000
Date:   Wed, 14 Jun 2017 04:17:40 +0200
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: t1308-config-set.sh fails on current master
Message-ID: <20170614021739.erkdifufziwiqjxp@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170614011514.sh4euddp44hjbu4u@sunbase.org>
 <20170614012535.GU133952@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mcpmclmjyzm2unw2"
Content-Disposition: inline
In-Reply-To: <20170614012535.GU133952@aiede.mtv.corp.google.com>
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170609-18-9a0a4f (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mcpmclmjyzm2unw2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Jonathan, thanks for having a look at this.

On 2017-06-13 18:25:35, Jonathan Nieder wrote:
> =C3=98yvind A. Holm wrote:
> > t1308-config-set.sh fails on current master=20
> > (v2.13.1-449-g02a2850ad58e). The error is introduced by commit=20
> > e2d90fd1c33a ("config.mak.uname: set FREAD_READS_DIRECTORIES for=20
> > Linux and FreeBSD"). Reverting the commit results in a conflict, but=20
> > the test works on the commit before, 02912f477586.
> >
> > Tested on
> >
> >   Debian GNU/Linux 8.8 (jessie)
> >   Linux Mint 18 Sarah
>
> Interesting.  I'm not able to reproduce it, but of course that doesn't
> mean much.

I'll admit that I have a somewhat special build system, but it's been=20
working great since I created it 7 months ago, and I run the test suite=20
every time I install a new git. I'm using the Makefile located at

  https://gitlab.com/sunny256/src-other/blob/master/devel/git/Makefile

It's only doing regular stuff like "make configure", "./configure", etc,=20
but I'm mentioning it in case the Makefile reveals something=20
interesting. The git installation is in a non-standard location, the=20
newest version of git I've installed is for example located under=20
/usr/src-other/pool/git.master.v2.13.1-394-g41dd4330a121/ .

> What is the output of the following command?
>
> ./t1308-config-set.sh --run=3D1,23 -x -v -i

Initialized empty Git repository in /home/sunny/src/git/src-other/devel/git=
/git/t/trash directory.t1308-config-set/.git/
expecting success:=20
	cat >.git/config <<-\EOF
	[case]
		penguin =3D very blue
		Movie =3D BadPhysics
		UPPERCASE =3D true
		MixedCase =3D true
		my =3D
		foo
		baz =3D sam
	[Cores]
		WhatEver =3D Second
		baz =3D bar
	[cores]
		baz =3D bat
	[CORES]
		baz =3D ball
	[my "Foo bAr"]
		hi =3D mixed-case
	[my "FOO BAR"]
		hi =3D upper-case
	[my "foo bar"]
		hi =3D lower-case
	[case]
		baz =3D bat
		baz =3D hask
	[lamb]
		chop =3D 65
		head =3D none
	[goat]
		legs =3D 4
		head =3D true
		skin =3D false
		nose =3D 1
		horns
	EOF

+ cat
ok 1 - setup default config

skipping test: get value for a simple key=20
	check_config get_value case.penguin "very blue"

ok 2 # skip get value for a simple key (--run)

skipping test: get value for a key with value as an empty string=20
	check_config get_value case.my ""

ok 3 # skip get value for a key with value as an empty string (--run)

skipping test: get value for a key with value as NULL=20
	check_config get_value case.foo "(NULL)"

ok 4 # skip get value for a key with value as NULL (--run)

skipping test: upper case key=20
	check_config get_value case.UPPERCASE "true" &&
	check_config get_value case.uppercase "true"

ok 5 # skip upper case key (--run)

skipping test: mixed case key=20
	check_config get_value case.MixedCase "true" &&
	check_config get_value case.MIXEDCASE "true" &&
	check_config get_value case.mixedcase "true"

ok 6 # skip mixed case key (--run)

skipping test: key and value with mixed case=20
	check_config get_value case.Movie "BadPhysics"

ok 7 # skip key and value with mixed case (--run)

skipping test: key with case sensitive subsection=20
	check_config get_value "my.Foo bAr.hi" "mixed-case" &&
	check_config get_value "my.FOO BAR.hi" "upper-case" &&
	check_config get_value "my.foo bar.hi" "lower-case"

ok 8 # skip key with case sensitive subsection (--run)

skipping test: key with case insensitive section header=20
	check_config get_value cores.baz "ball" &&
	check_config get_value Cores.baz "ball" &&
	check_config get_value CORES.baz "ball" &&
	check_config get_value coreS.baz "ball"

ok 9 # skip key with case insensitive section header (--run)

skipping test: key with case insensitive section header & variable=20
	check_config get_value CORES.BAZ "ball" &&
	check_config get_value cores.baz "ball" &&
	check_config get_value cores.BaZ "ball" &&
	check_config get_value cOreS.bAz "ball"

ok 10 # skip key with case insensitive section header & variable (--run)

skipping test: find value with misspelled key=20
	check_config expect_code 1 get_value "my.fOo Bar.hi" "Value not found for =
\"my.fOo Bar.hi\""

ok 11 # skip find value with misspelled key (--run)

skipping test: find value with the highest priority=20
	check_config get_value case.baz "hask"

ok 12 # skip find value with the highest priority (--run)

skipping test: find integer value for a key=20
	check_config get_int lamb.chop 65

ok 13 # skip find integer value for a key (--run)

skipping test: find string value for a key=20
	check_config get_string case.baz hask &&
	check_config expect_code 1 get_string case.ba "Value not found for \"case.=
ba\""

ok 14 # skip find string value for a key (--run)

skipping test: check line error when NULL string is queried=20
	test_expect_code 128 test-config get_string case.foo 2>result &&
	test_i18ngrep "fatal: .*case\.foo.*\.git/config.*line 7" result

ok 15 # skip check line error when NULL string is queried (--run)

skipping test: find integer if value is non parse-able=20
	check_config expect_code 128 get_int lamb.head

ok 16 # skip find integer if value is non parse-able (--run)

skipping test: find bool value for the entered key=20
	check_config get_bool goat.head 1 &&
	check_config get_bool goat.skin 0 &&
	check_config get_bool goat.nose 1 &&
	check_config get_bool goat.horns 1 &&
	check_config get_bool goat.legs 1

ok 17 # skip find bool value for the entered key (--run)

skipping test: find multiple values=20
	check_config get_value_multi case.baz sam bat hask

ok 18 # skip find multiple values (--run)

skipping test: find value from a configset=20
	cat >config2 <<-\EOF &&
	[case]
		baz =3D lama
	[my]
		new =3D silk
	[case]
		baz =3D ball
	EOF
	echo silk >expect &&
	test-config configset_get_value my.new config2 .git/config >actual &&
	test_cmp expect actual

ok 19 # skip find value from a configset (--run)

skipping test: find value with highest priority from a configset=20
	echo hask >expect &&
	test-config configset_get_value case.baz config2 .git/config >actual &&
	test_cmp expect actual

ok 20 # skip find value with highest priority from a configset (--run)

skipping test: find value_list for a key from a configset=20
	cat >except <<-\EOF &&
	sam
	bat
	hask
	lama
	ball
	EOF
	test-config configset_get_value case.baz config2 .git/config >actual &&
	test_cmp expect actual

ok 21 # skip find value_list for a key from a configset (--run)

skipping test: proper error on non-existent files=20
	echo "Error (-1) reading configuration file non-existent-file." >expect &&
	test_expect_code 2 test-config configset_get_value foo.bar non-existent-fi=
le 2>actual &&
	test_cmp expect actual

ok 22 # skip proper error on non-existent files (--run)

expecting success:=20
	echo "Error (-1) reading configuration file a-directory." >expect &&
	mkdir a-directory &&
	test_expect_code 2 test-config configset_get_value foo.bar a-directory 2>o=
utput &&
	grep "^warning:" output &&
	grep "^Error" output >actual &&
	test_cmp expect actual

+ echo Error (-1) reading configuration file a-directory.
+ mkdir a-directory
+ test_expect_code 2 test-config configset_get_value foo.bar a-directory
Value not found for "foo.bar"
error: last command exited with $?=3D1
not ok 23 - proper error on directory "files"
#=09
#		echo "Error (-1) reading configuration file a-directory." >expect &&
#		mkdir a-directory &&
#		test_expect_code 2 test-config configset_get_value foo.bar a-directory 2=
>output &&
#		grep "^warning:" output &&
#		grep "^Error" output >actual &&
#		test_cmp expect actual
#=09


> Other diagnostics:
>
> - what is the output of "env"?

GIT_PS1_SHOWDIRTYSTATE=3D1
SSH_AGENT_PID=3D22038
XDG_SESSION_ID=3D31
DSN=3Dsvn+ssh://sunny256@developer.skolelinux.no/repos
TERM=3Dscreen-256color-bce
SHELL=3D/bin/bash
SSH_CLIENT=3D37.253.243.58 43994 22
GL=3Dgit@gitlab.com:sunny256
LC_NUMERIC=3DC
OLDPWD=3D/home/sunny/src/git/src-other/devel/git/git
AFVROOT=3D/home/sunny/afvroot
GH=3Dgit@github.com:sunny256
LNS=3Dsunny@sunbase.org:/home/sunny/src/git
SSH_TTY=3D/dev/pts/1
WHOIS_SERVER=3Dwhois.dotster.com
USER=3Dsunny
HISTFILESIZE=3D10000000
LS_COLORS=3Dno=3D00:fi=3D00:di=3D01;34:ln=3D01;36:pi=3D40;33:so=3D01;35:bd=
=3D40;33;01:cd=3D40;33;01:or=3D01;37;41:ex=3D01;32:*.bat=3D01;32:*.btm=3D01=
;32:*.cmd=3D01;32:*.com=3D01;32:*.csh=3D01;32:*.exe=3D01;32:*.sh=3D01;32:*.=
Z=3D01;31:*.arj=3D01;31:*.bz=3D01;31:*.bz2=3D01;31:*.cpio=3D01;31:*.deb=3D0=
1;31:*.gz=3D01;31:*.lzh=3D01;31:*.rpm=3D01;31:*.tar=3D01;31:*.taz=3D01;31:*=
=2Etgz=3D01;31:*.tz=3D01;31:*.z=3D01;31:*.zip=3D01;31:*.avi=3D01;35:*.bmp=
=3D01;35:*.gif=3D01;35:*.jpg=3D01;35:*.mov=3D01;35:*.mpg=3D01;35:*.png=3D01=
;35:*.ppm=3D01;35:*.tga=3D01;35:*.tif=3D01;35:*.xbm=3D01;35:*.xpm=3D01;35:*=
=2Ehtml=3D01;33:*.txt=3D01;33:*.utf8=3D01;33:*~=3D00;34:
MTOOLS_DATE_STRING=3Dyyyy-mm-dd
MTOOLS_TWENTY_FOUR_HOUR_CLOCK=3D1
SSH_AUTH_SOCK=3D/tmp/ssh-VdBkCiAwUqdc/agent.22035
TERMCAP=3DSC|screen-256color-bce|VT 100/ANSI X3.64 virtual terminal:\
	:DO=3D\E[%dB:LE=3D\E[%dD:RI=3D\E[%dC:UP=3D\E[%dA:bs:bt=3D\E[Z:\
	:cd=3D\E[J:ce=3D\E[K:cl=3D\E[H\E[J:cm=3D\E[%i%d;%dH:ct=3D\E[3g:\
	:do=3D^J:nd=3D\E[C:pt:rc=3D\E8:rs=3D\Ec:sc=3D\E7:st=3D\EH:up=3D\EM:\
	:le=3D^H:bl=3D^G:cr=3D^M:it#8:ho=3D\E[H:nw=3D\EE:ta=3D^I:is=3D\E)0:\
	:li#56:co#180:am:xn:xv:LP:sr=3D\EM:al=3D\E[L:AL=3D\E[%dL:\
	:cs=3D\E[%i%d;%dr:dl=3D\E[M:DL=3D\E[%dM:dc=3D\E[P:DC=3D\E[%dP:\
	:im=3D\E[4h:ei=3D\E[4l:mi:IC=3D\E[%d@:ks=3D\E[?1h\E=3D:\
	:ke=3D\E[?1l\E>:vi=3D\E[?25l:ve=3D\E[34h\E[?25h:vs=3D\E[34l:\
	:ti=3D\E[?1049h:te=3D\E[?1049l:us=3D\E[4m:ue=3D\E[24m:so=3D\E[3m:\
	:se=3D\E[23m:mb=3D\E[5m:md=3D\E[1m:mh=3D\E[2m:mr=3D\E[7m:\
	:me=3D\E[m:ms:\
	:Co#8:pa#64:AF=3D\E[3%dm:AB=3D\E[4%dm:op=3D\E[39;49m:AX:\
	:vb=3D\Eg:G0:as=3D\E(0:ae=3D\E(B:\
	:ac=3D\140\140aaffggjjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~..--++,,hhII=
00:\
	:po=3D\E[5i:pf=3D\E[4i:Km=3D\E[M:k0=3D\E[10~:k1=3D\EOP:k2=3D\EOQ:\
	:k3=3D\EOR:k4=3D\EOS:k5=3D\E[15~:k6=3D\E[17~:k7=3D\E[18~:\
	:k8=3D\E[19~:k9=3D\E[20~:k;=3D\E[21~:F1=3D\E[23~:F2=3D\E[24~:\
	:F3=3D\E[1;2P:F4=3D\E[1;2Q:F5=3D\E[1;2R:F6=3D\E[1;2S:\
	:F7=3D\E[15;2~:F8=3D\E[17;2~:F9=3D\E[18;2~:FA=3D\E[19;2~:kb=3D=7F:\
	:K2=3D\EOE:kB=3D\E[Z:kF=3D\E[1;2B:kR=3D\E[1;2A:*4=3D\E[3;2~:\
	:*7=3D\E[1;2F:#2=3D\E[1;2H:#3=3D\E[2;2~:#4=3D\E[1;2D:%c=3D\E[6;2~:\
	:%e=3D\E[5;2~:%i=3D\E[1;2C:kh=3D\E[1~:@1=3D\E[1~:kH=3D\E[4~:\
	:@7=3D\E[4~:kN=3D\E[6~:kP=3D\E[5~:kI=3D\E[2~:kD=3D\E[3~:ku=3D\EOA:\
	:kd=3D\EOB:kr=3D\EOC:kl=3D\EOD:km:
GR=3Dsunny@sunbase.org:/home/sunny/repos/Git
PAGER=3Dless -S
NCDU_SHELL=3Dmc
PATH=3D/home/sunny/bin/Local/sunbase:/home/sunny/bin:/usr/src-other/bin:/us=
r/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/s=
rc-other/prg/git/libexec/git-core:/opt/git-annex
MAIL=3D/home/sunny/mail/inbox
STY=3D21459.vanl
BC_ENV_ARGS=3D-l --quiet
LC_COLLATE=3DC
PP=3Dgit@github.com:piratpartiet
PWD=3D/home/sunny/src/git/src-other/devel/git/git/t
IRCSERVER=3Dirc.homelien.no
MAILDIR=3D/home/sunny/mail
BMS=3Dsunny@bellmann:/home/sunny/src/git
EDITOR=3Dv
SESS_UUID=3D,bash_profile/cf9306e4-e476-11e6-ab83-db5caa6d21d3,screen/e9db0=
984-e476-11e6-b0ae-db5caa6d21d3,ssh-agent/fc7d8b3e-e476-11e6-8155-db5caa6d2=
1d3,
LANG=3Den_GB.UTF-8
BB=3Dgit@bitbucket.org:sunny256
SUUID_LOGDIR=3D/home/sunny/uuids
TZ=3DCET
WHOIS_HIDE=3D1
SLX=3Dsvn+ssh://sunny256@svn.skolelinux.no/repos/skolelinux
SVN_SSH=3Dssh
PS1=3D\[\033[0m\033[1;33m\]$(date +"%Y-%m-%d %T") \[\033[01;31m\]\u\[\033[1=
;35m\]@\[\033[01;34m\]\h\[\033[m\]:\[\033[1;32m\]\w\033[1;33m\]$(__git_ps1 =
" (%s)")\[\033[m\]\n\$=20
GIT_PS1_SHOWUNTRACKEDFILES=3D1
IRCNAME=3Dsunny
HISTCONTROL=3Dignoreboth
BM=3Dsunny@bellmann:/home/sunny/repos/Git
NCURSES_NO_UTF8_ACS=3D1
HOME=3D/home/sunny
SHLVL=3D4
IRCNICK=3Dsunny256
LESSCHARSET=3Dutf-8
GIT_PS1_SHOWSTASHSTATE=3D1
SUUID_EDITOR=3Dvim
LOGNAME=3Dsunny
LESS=3D-RSX
WINDOW=3D2
CVS_RSH=3Dssh
GIT_PS1_SHOWUPSTREAM=3Dverbose
SSH_CONNECTION=3D37.253.243.58 43994 178.79.142.16 22
PROMPT_COMMAND=3Dhistory -a
CVSEDITOR=3D/home/sunny/bin/cvs-editor
TREE_CHARSET=3DUTF-8
XDG_RUNTIME_DIR=3D/run/user/1000
SR=3Dsvn+ssh://sunny@sunbase.org/home/sunny/repos/Svn
RSYNC_RSH=3Dssh
LC_TIME=3Den_DK.UTF-8
HISTTIMEFORMAT=3D%F %T=20
GHH=3Dhttps://sunny256@github.com/sunny256
_=3D/usr/local/bin/env


> - cat ../GIT-BUILD-OPTIONS

SHELL_PATH=3D'/bin/sh'
PERL_PATH=3D'/usr/bin/perl'
DIFF=3D'diff'
PYTHON_PATH=3D'/usr/bin/python'
TAR=3D'tar'
NO_CURL=3D''
NO_EXPAT=3D''
USE_LIBPCRE=3D''
NO_PERL=3D''
NO_PYTHON=3D''
NO_UNIX_SOCKETS=3D''
PAGER_ENV=3D'LESS=3DFRX LV=3D-c'
DC_SHA1=3D'YesPlease'
NO_GETTEXT=3D''
GETTEXT_POISON=3D''


> - if you run that under 'strace -f -o /tmp/strace.out', does the
>   strace.out say anything interesting?

In fact, when running the test under strace, another test fails too, and=20
it's also reproducible:

$ strace -f -o /tmp/strace.out ./t1308-config-set.sh
ok 1 - setup default config
[snip]
ok 22 - proper error on non-existent files
not ok 23 - proper error on directory "files"
#
#               echo "Error (-1) reading configuration file a-directory." >=
expect &&
#               mkdir a-directory &&
#               test_expect_code 2 test-config configset_get_value foo.bar =
a-directory 2>output &&
#               grep "^warning:" output &&
#               grep "^Error" output >actual &&
#               test_cmp expect actual
#
not ok 24 - proper error on non-accessible files
#
#               chmod -r .git/config &&
#               test_when_finished "chmod +r .git/config" &&
#               echo "Error (-1) reading configuration file .git/config." >=
expect &&
#               test_expect_code 2 test-config configset_get_value foo.bar =
=2Egit/config 2>output &&
#               grep "^warning:" output &&
#               grep "^Error" output >actual &&
#               test_cmp expect actual
#
ok 25 - proper error on error in default config files
ok 26 - proper error on error in custom config files
ok 27 - check line errors for malformed values
ok 28 - error on modifying repo config without repo
ok 29 - iteration shows correct origins
# failed 2 among 29 test(s)
1..29
$

I didn't see any red flags in the strace output, but I've put the file=20
for download at

  http://sunbase.org/strace.git-v2.13.1-449-g02a2850ad58e.out

Thanks,
=C3=98yvind

N 60.376=C2=B0 E 5.3334=C2=B0
OpenPGP fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5
6f7b6448-50a2-11e7-8259-db5caa6d21d3

--mcpmclmjyzm2unw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllAnMMACgkQ+wy+6JSlBuWz0wCfRX+DFKd41+jnZwwrtvsktleZ
434AnixdEOmDkcS4DVN+Lqaa35RCLq+H
=XYYq
-----END PGP SIGNATURE-----

--mcpmclmjyzm2unw2--
