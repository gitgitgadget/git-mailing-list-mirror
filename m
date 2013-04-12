From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Bug: git push crashing
Date: Fri, 12 Apr 2013 20:50:25 +0200
Message-ID: <201304122050.26471@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2276132.vuxxDAoVpX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 12 20:50:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQj3X-0007eF-05
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 20:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab3DLSue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 14:50:34 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:42069 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab3DLSuc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 14:50:32 -0400
Received: by mail-ee0-f41.google.com with SMTP id c1so1446529eek.28
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:user-agent:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=K4GmuAqnM9Ovt8pCw5Oft/5CG4DKYTCgX8WwBfzt8UQ=;
        b=Vpt+N8akQ8tEbfxdlQ42B51GanIe/55DbP9KPDbaTaz1ozS2qMiemKHX8d83gVWokF
         jMqdbjXrmEWl5V91n6OlFsfmJQZGm5seQ95OplbyuIcorE+8NZdhuFFKt+bKBRZs+iIA
         ku9xXYp91vQKjCTqnrlMqA/VsXNiZ7hZTdYbRCZjygFebnIv5/UNHRbcsYnVqQlLlRYZ
         VxcGyEUwUU2ZC1Vc1KDi+nTabCOK2FFWjyV0zBWINx+VJjTkBa5z2/9nHfpsHhs8Zdn8
         AjExGc7459zFlT9WiRUgVkoLtqpvU7dlltj8BQqv1qLc/Yzbx5izFk5W762pSqkFzxNN
         Kayg==
X-Received: by 10.14.210.132 with SMTP id u4mr30795611eeo.19.1365792630871;
        Fri, 12 Apr 2013 11:50:30 -0700 (PDT)
Received: from pali-elitebook.localnet (pali.kolej.mff.cuni.cz. [78.128.193.202])
        by mx.google.com with ESMTPS id u44sm12564707eel.7.2013.04.12.11.50.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 11:50:28 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/3.5.0-27-generic; KDE/4.10.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221011>

--nextPart2276132.vuxxDAoVpX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

when I'm trying to push one specific branch from my git repository
to server, git push crashing. Pushing branch is rejected by server
(because non fast forward), but local git app should not crash.

I'm using git from ubuntu apt repository (compiled myself for debug
symbols), version git_1.7.10.4-1ubuntu1 on amd64 ubuntu system:
http://packages.ubuntu.com/source/quantal/git

Here are gdb backtrace and valgrind outputs. I changed server, repo
and branch strings from output. It looks like that git crashing in
strcmp function because one of arguments is NULL.

If you need more info, I can send it. This crash occur always. I can
reproduce it again and again...

$ valgrind --leak-check=3Dfull git push server:~/repo branch=20
=3D=3D19381=3D=3D Memcheck, a memory error detector
=3D=3D19381=3D=3D Copyright (C) 2002-2011, and GNU GPL'd, by Julian Seward =
et al.
=3D=3D19381=3D=3D Using Valgrind-3.7.0 and LibVEX; rerun with -h for copyri=
ght info
=3D=3D19381=3D=3D Command: git push server:~/repo branch
=3D=3D19381=3D=3D=20
X11 forwarding request failed on channel 0
To server:~/repo
 ! [rejected]        branch -> branch (non-fast-forward)
=3D=3D19381=3D=3D Invalid read of size 1
=3D=3D19381=3D=3D    at 0x4C2C831: strcmp (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D19381=3D=3D    by 0x4DA2DD: transport_print_push_status (transport.c:=
747)
=3D=3D19381=3D=3D    by 0x4DAC19: transport_push (transport.c:1069)
=3D=3D19381=3D=3D    by 0x4515FC: push_with_options (push.c:191)
=3D=3D19381=3D=3D    by 0x451EF5: cmd_push (push.c:270)
=3D=3D19381=3D=3D    by 0x405787: handle_internal_command (git.c:308)
=3D=3D19381=3D=3D    by 0x404B91: main (git.c:513)
=3D=3D19381=3D=3D  Address 0x0 is not stack'd, malloc'd or (recently) free'd
=3D=3D19381=3D=3D=20
=3D=3D19381=3D=3D=20
=3D=3D19381=3D=3D Process terminating with default action of signal 11 (SIG=
SEGV)
=3D=3D19381=3D=3D  Access not within mapped region at address 0x0
=3D=3D19381=3D=3D    at 0x4C2C831: strcmp (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D19381=3D=3D    by 0x4DA2DD: transport_print_push_status (transport.c:=
747)
=3D=3D19381=3D=3D    by 0x4DAC19: transport_push (transport.c:1069)
=3D=3D19381=3D=3D    by 0x4515FC: push_with_options (push.c:191)
=3D=3D19381=3D=3D    by 0x451EF5: cmd_push (push.c:270)
=3D=3D19381=3D=3D    by 0x405787: handle_internal_command (git.c:308)
=3D=3D19381=3D=3D    by 0x404B91: main (git.c:513)
=3D=3D19381=3D=3D  If you believe this happened as a result of a stack
=3D=3D19381=3D=3D  overflow in your program's main thread (unlikely but
=3D=3D19381=3D=3D  possible), you can try to increase the size of the
=3D=3D19381=3D=3D  main thread stack using the --main-stacksize=3D flag.
=3D=3D19381=3D=3D  The main thread stack size used in this run was 8388608.
=3D=3D19381=3D=3D=20
=3D=3D19381=3D=3D HEAP SUMMARY:
=3D=3D19381=3D=3D     in use at exit: 7,672,224 bytes in 28,274 blocks
=3D=3D19381=3D=3D   total heap usage: 70,136 allocs, 41,862 frees, 108,300,=
058 bytes allocated
=3D=3D19381=3D=3D=20
=3D=3D19381=3D=3D 43 (24 direct, 19 indirect) bytes in 1 blocks are definit=
ely lost in loss record 23 of 59
=3D=3D19381=3D=3D    at 0x4C29E46: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D19381=3D=3D    by 0x4E4B28: xcalloc (wrapper.c:98)
=3D=3D19381=3D=3D    by 0x4BBCE9: parse_refspec_internal (remote.c:520)
=3D=3D19381=3D=3D    by 0x4BCE3E: match_push_refs (remote.c:653)
=3D=3D19381=3D=3D    by 0x4DAB3D: transport_push (transport.c:1047)
=3D=3D19381=3D=3D    by 0x4515FC: push_with_options (push.c:191)
=3D=3D19381=3D=3D    by 0x451EF5: cmd_push (push.c:270)
=3D=3D19381=3D=3D    by 0x405787: handle_internal_command (git.c:308)
=3D=3D19381=3D=3D    by 0x404B91: main (git.c:513)
=3D=3D19381=3D=3D=20
=3D=3D19381=3D=3D 2,404 (110 direct, 2,294 indirect) bytes in 1 blocks are =
definitely lost in loss record 46 of 59
=3D=3D19381=3D=3D    at 0x4C29E46: calloc (in /usr/lib/valgrind/vgpreload_m=
emcheck-amd64-linux.so)
=3D=3D19381=3D=3D    by 0x4E4B28: xcalloc (wrapper.c:98)
=3D=3D19381=3D=3D    by 0x4BC241: one_local_ref (remote.c:1643)
=3D=3D19381=3D=3D    by 0x4B7B8C: do_for_each_ref (refs.c:750)
=3D=3D19381=3D=3D    by 0x4BDEF3: get_local_heads (remote.c:1654)
=3D=3D19381=3D=3D    by 0x4DAAF0: transport_push (transport.c:1032)
=3D=3D19381=3D=3D    by 0x4515FC: push_with_options (push.c:191)
=3D=3D19381=3D=3D    by 0x451EF5: cmd_push (push.c:270)
=3D=3D19381=3D=3D    by 0x405787: handle_internal_command (git.c:308)
=3D=3D19381=3D=3D    by 0x404B91: main (git.c:513)
=3D=3D19381=3D=3D=20
=3D=3D19381=3D=3D LEAK SUMMARY:
=3D=3D19381=3D=3D    definitely lost: 134 bytes in 2 blocks
=3D=3D19381=3D=3D    indirectly lost: 2,313 bytes in 24 blocks
=3D=3D19381=3D=3D      possibly lost: 0 bytes in 0 blocks
=3D=3D19381=3D=3D    still reachable: 7,669,777 bytes in 28,248 blocks
=3D=3D19381=3D=3D         suppressed: 0 bytes in 0 blocks
=3D=3D19381=3D=3D Reachable blocks (those to which a pointer was found) are=
 not shown.
=3D=3D19381=3D=3D To see them, rerun with: --leak-check=3Dfull --show-reach=
able=3Dyes
=3D=3D19381=3D=3D=20
=3D=3D19381=3D=3D For counts of detected and suppressed errors, rerun with:=
 -v
=3D=3D19381=3D=3D ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 2 fr=
om 2)


$ gdb --args git push server:~/repo branch=20
GNU gdb (GDB) 7.5-ubuntu
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
=46or bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /usr/bin/git...done.
(gdb) r
Starting program: /usr/bin/git push server:\~/repo branch
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
X11 forwarding request failed on channel 0
To server:~/repo
 ! [rejected]        branch -> branch (non-fast-forward)

Program received signal SIGSEGV, Segmentation fault.
__strcmp_sse42 () at ../sysdeps/x86_64/multiarch/strcmp-sse42.S:163
163     ../sysdeps/x86_64/multiarch/strcmp-sse42.S: Adres=C3=A1r alebo s=C3=
=BAbor neexistuje.
(gdb) bt
#0  __strcmp_sse42 () at ../sysdeps/x86_64/multiarch/strcmp-sse42.S:163
#1  0x00000000004da2de in transport_print_push_status (dest=3D0x7fffffffe20=
b "server:~/repo", refs=3D<optimized out>,=20
verbose=3Dverbose@entry=3D0, porcelain=3Dporcelain@entry=3D0,=20
    nonfastforward=3Dnonfastforward@entry=3D0x7fffffffd6fc) at transport.c:=
747
#2  0x00000000004dac1a in transport_push (transport=3Dtransport@entry=3D0x7=
9cbd0, refspec_nr=3D<optimized out>,=20
refspec=3D<optimized out>, flags=3Dflags@entry=3D0, nonfastforward=3Dnonfas=
tforward@entry=3D0x7fffffffd6fc) at transport.c:1069
#3  0x00000000004515fd in push_with_options (transport=3D0x79cbd0, flags=3D=
flags@entry=3D0) at builtin/push.c:191
#4  0x0000000000451ef6 in do_push (flags=3D0, repo=3D<optimized out>) at bu=
iltin/push.c:270
#5  cmd_push (argc=3D<optimized out>, argv=3D<optimized out>, prefix=3D<opt=
imized out>) at builtin/push.c:346
#6  0x0000000000405788 in run_builtin (argv=3D0x7fffffffde50, argc=3D3, p=
=3D0x744dc8 <commands.11293+1704>) at git.c:308
#7  handle_internal_command (argc=3D3, argv=3D0x7fffffffde50) at git.c:467
#8  0x0000000000404b92 in run_argv (argv=3D0x7fffffffdce0, argcp=3D0x7fffff=
ffdcec) at git.c:513
#9  main (argc=3D3, argv=3D0x7fffffffde50) at git.c:588
(gdb) bt full
#0  __strcmp_sse42 () at ../sysdeps/x86_64/multiarch/strcmp-sse42.S:163
No locals.
#1  0x00000000004da2de in transport_print_push_status (dest=3D0x7fffffffe20=
b "server:~/repo", refs=3D<optimized out>,=20
verbose=3Dverbose@entry=3D0, porcelain=3Dporcelain@entry=3D0,=20
    nonfastforward=3Dnonfastforward@entry=3D0x7fffffffd6fc) at transport.c:=
747
        ref =3D 0x79e740
        n =3D 1
        head_sha1 =3D " \315y\000\000\000\000\000P\314y\000\000\000\000\000=
\377\377\377\377"
        head =3D 0x0
#2  0x00000000004dac1a in transport_push (transport=3Dtransport@entry=3D0x7=
9cbd0, refspec_nr=3D<optimized out>,=20
refspec=3D<optimized out>, flags=3Dflags@entry=3D0, nonfastforward=3Dnonfas=
tforward@entry=3D0x7fffffffd6fc) at transport.c:1069
        remote_refs =3D 0x79cd20
        local_refs =3D <optimized out>
        verbose =3D 0
        porcelain =3D 0
        push_ret =3D -1
        ret =3D -1
        match_flags =3D 0
        quiet =3D 0
        pretend =3D 0
#3  0x00000000004515fd in push_with_options (transport=3D0x79cbd0, flags=3D=
flags@entry=3D0) at builtin/push.c:191
        err =3D <optimized out>
        nonfastforward =3D <optimized out>
#4  0x0000000000451ef6 in do_push (flags=3D0, repo=3D<optimized out>) at bu=
iltin/push.c:270
        transport =3D <optimized out>
        i =3D <optimized out>
        errs =3D <optimized out>
        remote =3D 0x79c700
        url =3D <optimized out>
        url_nr =3D 0
#5  cmd_push (argc=3D<optimized out>, argv=3D<optimized out>, prefix=3D<opt=
imized out>) at builtin/push.c:346
        flags =3D 0
        tags =3D 0
        rc =3D 0
        repo =3D 0x7fffffffe20b "server:~/repo"
        options =3D {{type =3D OPTION_CALLBACK, short_name =3D 118, long_na=
me =3D 0x4f5a0a "verbose", value =3D 0x7673a0 <verbosity>,=20
argh =3D 0x0, help =3D 0x4fab02 "be more verbose", flags =3D 2,=20
            callback =3D 0x4aa900 <parse_opt_verbosity_cb>, defval =3D 0}, =
{type =3D OPTION_CALLBACK, short_name =3D 113, long_name =3D=20
0x5028aa "quiet", value =3D 0x7673a0 <verbosity>, argh =3D 0x0, help =3D 0x=
4fab12 "be more quiet",=20
            flags =3D 2, callback =3D 0x4aa900 <parse_opt_verbosity_cb>, de=
fval =3D 0}, {type =3D OPTION_STRING, short_name =3D 0, long_name =3D=20
0x4f75fc "repo", value =3D 0x7fffffffd738, argh =3D 0x4f633d "repository",=
=20
            help =3D 0x4f633d "repository", flags =3D 0, callback =3D 0x0, =
defval =3D 0}, {type =3D OPTION_BIT, short_name =3D 0, long_name =3D=20
0x4fcac6 "all", value =3D 0x7fffffffd730, argh =3D 0x0, help =3D 0x5083a3 "=
push all refs",=20
            flags =3D 2, callback =3D 0x0, defval =3D 1}, {type =3D OPTION_=
BIT, short_name =3D 0, long_name =3D 0x50cada "mirror", value =3D=20
0x7fffffffd730, argh =3D 0x0, help =3D 0x5083b1 "mirror all refs", flags =
=3D 2, callback =3D 0x0,=20
            defval =3D 10}, {type =3D OPTION_COUNTUP, short_name =3D 0, lon=
g_name =3D 0x509491 "delete", value =3D 0x7673a4 <deleterefs>,=20
argh =3D 0x0, help =3D 0x5083c1 "delete refs", flags =3D 2, callback =3D 0x=
0, defval =3D 0}, {
            type =3D OPTION_COUNTUP, short_name =3D 0, long_name =3D 0x50de=
98 "tags", value =3D 0x7fffffffd734, argh =3D 0x0, help =3D=20
0x508488 "push tags (can't be used with --all or --mirror)", flags =3D 2, c=
allback =3D 0x0, defval =3D 0},=20
          {type =3D OPTION_BIT, short_name =3D 110, long_name =3D 0x4ff33b =
"dry-run", value =3D 0x7fffffffd730, argh =3D 0x0, help =3D 0x4f59ff=20
"dry run", flags =3D 2, callback =3D 0x0, defval =3D 4}, {type =3D OPTION_B=
IT, short_name =3D 0,=20
            long_name =3D 0x51d610 "porcelain", value =3D 0x7fffffffd730, a=
rgh =3D 0x0, help =3D 0x4fb848 "machine-readable output", flags =3D=20
2, callback =3D 0x0, defval =3D 16}, {type =3D OPTION_BIT, short_name =3D 1=
02,=20
            long_name =3D 0x4ff35e "force", value =3D 0x7fffffffd730, argh =
=3D 0x0, help =3D 0x5083cd "force updates", flags =3D 2, callback =3D=20
0x0, defval =3D 2}, {type =3D OPTION_CALLBACK, short_name =3D 0,=20
            long_name =3D 0x4ff366 "recurse-submodules", value =3D 0x7fffff=
ffd730, argh =3D 0x50c7b7 "check", help =3D 0x5084c0 "controls=20
recursive pushing of submodules", flags =3D 1,=20
            callback =3D 0x451510 <option_parse_recurse_submodules>, defval=
 =3D 0}, {type =3D OPTION_COUNTUP, short_name =3D 0,=20
long_name =3D 0x4fefd4 "thin", value =3D 0x7673a8 <thin>, argh =3D 0x0, hel=
p =3D 0x5083db "use thin pack",=20
            flags =3D 2, callback =3D 0x0, defval =3D 0}, {type =3D OPTION_=
STRING, short_name =3D 0, long_name =3D 0x50ca97 "receive-pack", value=20
=3D 0x7673b0 <receivepack>, argh =3D 0x50ca97 "receive-pack",=20
            help =3D 0x5083e9 "receive pack program", flags =3D 0, callback=
 =3D 0x0, defval =3D 0}, {type =3D OPTION_STRING, short_name =3D 0,=20
long_name =3D 0x4f7601 "exec", value =3D 0x7673b0 <receivepack>, argh =3D 0=
x50ca97 "receive-pack",=20
            help =3D 0x5083e9 "receive pack program", flags =3D 0, callback=
 =3D 0x0, defval =3D 0}, {type =3D OPTION_BIT, short_name =3D 117,=20
long_name =3D 0x4f879d "set-upstream", value =3D 0x7fffffffd730, argh =3D 0=
x0,=20
            help =3D 0x5084f0 "set upstream for git pull/status", flags =3D=
 2, callback =3D 0x0, defval =3D 32}, {type =3D OPTION_SET_INT,=20
short_name =3D 0, long_name =3D 0x500799 "progress", value =3D 0x7489b4 <pr=
ogress>, argh =3D 0x0,=20
            help =3D 0x4fab20 "force progress reporting", flags =3D 2, call=
back =3D 0x0, defval =3D 1}, {type =3D OPTION_BIT, short_name =3D 0,=20
long_name =3D 0x50a386 "prune", value =3D 0x7fffffffd730, argh =3D 0x0,=20
            help =3D 0x5083fe "prune locally removed refs", flags =3D 2, ca=
llback =3D 0x0, defval =3D 128}, {type =3D OPTION_END, short_name =3D 0,=20
long_name =3D 0x0, value =3D 0x0, argh =3D 0x0, help =3D 0x0, flags =3D 0, =
callback =3D 0x0,=20
=2D--Type <return> to continue, or q <return> to quit---
            defval =3D 0}}
#6  0x0000000000405788 in run_builtin (argv=3D0x7fffffffde50, argc=3D3, p=
=3D0x744dc8 <commands.11293+1704>) at git.c:308
        status =3D <optimized out>
        help =3D <optimized out>
        st =3D {st_dev =3D 140737341403408, st_ino =3D 140737488346288, st_=
nlink =3D 0, st_mode =3D 4214692, st_uid =3D 0, st_gid =3D=20
4294958656, __pad0 =3D 32767, st_rdev =3D 4294967296, st_size =3D 0, st_blk=
size =3D 140737488346968,=20
          st_blocks =3D 7979280, st_atim =3D {tv_sec =3D 140737488346288, t=
v_nsec =3D 0}, st_mtim =3D {tv_sec =3D 4214692, tv_nsec =3D=20
140737488346688}, st_ctim =3D {tv_sec =3D 140737488347654, tv_nsec =3D 0}, =
__unused =3D {5056825,=20
            140737488350098, 4790338}}
        prefix =3D <optimized out>
#7  handle_internal_command (argc=3D3, argv=3D0x7fffffffde50) at git.c:467
        p =3D 0x744dc8 <commands.11293+1704>
        cmd =3D <optimized out>
        commands =3D {{cmd =3D 0x50a441 "add", fn =3D 0x405e70 <cmd_add>, o=
ption =3D 9}, {cmd =3D 0x4f51e5 "annotate", fn =3D 0x406990=20
<cmd_annotate>, option =3D 1}, {cmd =3D 0x4f5a57 "apply", fn =3D 0x40da30 <=
cmd_apply>, option =3D 2}, {
            cmd =3D 0x4f7566 "archive", fn =3D 0x40e800 <cmd_archive>, opti=
on =3D 0}, {cmd =3D 0x4f51ee "bisect--helper", fn =3D 0x40ea10=20
<cmd_bisect__helper>, option =3D 1}, {cmd =3D 0x4f51fd "blame", fn =3D 0x41=
0920 <cmd_blame>,=20
            option =3D 1}, {cmd =3D 0x50a618 "branch", fn =3D 0x413cc0 <cmd=
_branch>, option =3D 1}, {cmd =3D 0x4faa45 "bundle", fn =3D=20
0x415250 <cmd_bundle>, option =3D 2}, {cmd =3D 0x4f5203 "cat-file", fn =3D =
0x415550 <cmd_cat_file>,=20
            option =3D 1}, {cmd =3D 0x4f520c "check-attr", fn =3D 0x415fc0 =
<cmd_check_attr>, option =3D 1}, {cmd =3D 0x4f5217 "check-ref-
format", fn =3D 0x416380 <cmd_check_ref_format>, option =3D 0}, {cmd =3D 0x=
4fab48 "checkout",=20
            fn =3D 0x417a00 <cmd_checkout>, option =3D 9}, {cmd =3D 0x4f522=
8 "checkout-index", fn =3D 0x416a80 <cmd_checkout_index>,=20
option =3D 9}, {cmd =3D 0x51adf8 "cherry", fn =3D 0x43abb0 <cmd_cherry>, op=
tion =3D 1}, {
            cmd =3D 0x51ae17 "cherry-pick", fn =3D 0x45eda0 <cmd_cherry_pic=
k>, option =3D 9}, {cmd =3D 0x4f5237 "clean", fn =3D 0x41a070=20
<cmd_clean>, option =3D 9}, {cmd =3D 0x4f523d "clone", fn =3D 0x41b030 <cmd=
_clone>, option =3D 0}, {
            cmd =3D 0x4fb693 "commit", fn =3D 0x41ee70 <cmd_commit>, option=
 =3D 9}, {cmd =3D 0x4f5243 "commit-tree", fn =3D 0x41c550=20
<cmd_commit_tree>, option =3D 1}, {cmd =3D 0x4f542f "config", fn =3D 0x420e=
20 <cmd_config>, option =3D 2}, {
            cmd =3D 0x4f524f "count-objects", fn =3D 0x4215f0 <cmd_count_ob=
jects>, option =3D 1}, {cmd =3D 0x4f525d "describe", fn =3D=20
0x4227c0 <cmd_describe>, option =3D 1}, {cmd =3D 0x51328b "diff", fn =3D 0x=
423870 <cmd_diff>,=20
            option =3D 0}, {cmd =3D 0x4f5266 "diff-files", fn =3D 0x422de0 =
<cmd_diff_files>, option =3D 9}, {cmd =3D 0x4f5271 "diff-index", fn =3D=20
0x423020 <cmd_diff_index>, option =3D 1}, {cmd =3D 0x4f527c "diff-tree",=20
            fn =3D 0x4231b0 <cmd_diff_tree>, option =3D 1}, {cmd =3D 0x51e3=
ea "fast-export", fn =3D 0x424cb0 <cmd_fast_export>, option =3D=20
1}, {cmd =3D 0x4faaac "fetch", fn =3D 0x42a0a0 <cmd_fetch>, option =3D 1}, {
            cmd =3D 0x4f5286 "fetch-pack", fn =3D 0x4277c0 <cmd_fetch_pack>=
, option =3D 1}, {cmd =3D 0x4f5291 "fmt-merge-msg", fn =3D=20
0x42b920 <cmd_fmt_merge_msg>, option =3D 1}, {cmd =3D 0x4f529f "for-each-re=
f",=20
            fn =3D 0x42d5e0 <cmd_for_each_ref>, option =3D 1}, {cmd =3D 0x4=
f52ac "format-patch", fn =3D 0x439170 <cmd_format_patch>,=20
option =3D 1}, {cmd =3D 0x51480e "fsck", fn =3D 0x42e820 <cmd_fsck>, option=
 =3D 1}, {
            cmd =3D 0x4f52b9 "fsck-objects", fn =3D 0x42e820 <cmd_fsck>, op=
tion =3D 1}, {cmd =3D 0x500a98 "gc", fn =3D 0x42f480 <cmd_gc>,=20
option =3D 1}, {cmd =3D 0x4f52c6 "get-tar-commit-id", fn =3D 0x465970 <cmd_=
get_tar_commit_id>,=20
            option =3D 0}, {cmd =3D 0x500f09 "grep", fn =3D 0x430700 <cmd_g=
rep>, option =3D 2}, {cmd =3D 0x4f52d8 "hash-object", fn =3D=20
0x432400 <cmd_hash_object>, option =3D 0}, {cmd =3D 0x4f4fc6 "help", fn =3D=
 0x4330b0 <cmd_help>,=20
            option =3D 0}, {cmd =3D 0x4f52e4 "index-pack", fn =3D 0x434880 =
<cmd_index_pack>, option =3D 2}, {cmd =3D 0x4fac0c "init", fn =3D=20
0x436fe0 <cmd_init_db>, option =3D 0}, {cmd =3D 0x4f52ef "init-db", fn =3D =
0x436fe0 <cmd_init_db>,=20
            option =3D 0}, {cmd =3D 0x519de7 "log", fn =3D 0x439090 <cmd_lo=
g>, option =3D 1}, {cmd =3D 0x4f52f7 "ls-files", fn =3D 0x43b6d0=20
<cmd_ls_files>, option =3D 1}, {cmd =3D 0x4f5300 "ls-remote", fn =3D 0x43c8=
90 <cmd_ls_remote>,=20
            option =3D 2}, {cmd =3D 0x4f530a "ls-tree", fn =3D 0x43d080 <cm=
d_ls_tree>, option =3D 1}, {cmd =3D 0x4f5312 "mailinfo", fn =3D=20
0x43e9b0 <cmd_mailinfo>, option =3D 0}, {cmd =3D 0x4f531b "mailsplit",=20
            fn =3D 0x43fce0 <cmd_mailsplit>, option =3D 0}, {cmd =3D 0x5055=
1f "merge", fn =3D 0x441da0 <cmd_merge>, option =3D 9}, {cmd =3D=20
0x4f5325 "merge-base", fn =3D 0x443b90 <cmd_merge_base>, option =3D 1}, {
            cmd =3D 0x4f5330 "merge-file", fn =3D 0x443ed0 <cmd_merge_file>=
, option =3D 2}, {cmd =3D 0x4f533b "merge-index", fn =3D=20
0x444610 <cmd_merge_index>, option =3D 1}, {cmd =3D 0x4f5347 "merge-ours",=
=20
            fn =3D 0x444820 <cmd_merge_ours>, option =3D 1}, {cmd =3D 0x4f5=
352 "merge-recursive", fn =3D 0x4448b0=20
<cmd_merge_recursive>, option =3D 9}, {cmd =3D 0x4f5362 "merge-recursive-ou=
rs", fn =3D 0x4448b0 <cmd_merge_recursive>,=20
            option =3D 9}, {cmd =3D 0x4f5377 "merge-recursive-theirs", fn =
=3D 0x4448b0 <cmd_merge_recursive>, option =3D 9}, {cmd =3D=20
0x4f538e "merge-subtree", fn =3D 0x4448b0 <cmd_merge_recursive>, option =3D=
 9}, {
            cmd =3D 0x4f539c "merge-tree", fn =3D 0x4450a0 <cmd_merge_tree>=
, option =3D 1}, {cmd =3D 0x4f53a7 "mktag", fn =3D 0x445410=20
<cmd_mktag>, option =3D 1}, {cmd =3D 0x4f53ad "mktree", fn =3D 0x4459a0 <cm=
d_mktree>, option =3D 1}, {
            cmd =3D 0x4f53b4 "mv", fn =3D 0x446110 <cmd_mv>, option =3D 9},=
 {cmd =3D 0x4f53b7 "name-rev", fn =3D 0x447010=20
<cmd_name_rev>, option =3D 1}, {cmd =3D 0x506456 "notes", fn =3D 0x4488e0 <=
cmd_notes>, option =3D 1}, {
            cmd =3D 0x510a0f "pack-objects", fn =3D 0x44cb90 <cmd_pack_obje=
cts>, option =3D 1}, {cmd =3D 0x4f53c0 "pack-redundant", fn =3D=20
0x44f430 <cmd_pack_redundant>, option =3D 1}, {cmd =3D 0x4f53cf "pack-refs"=
,=20
            fn =3D 0x450460 <cmd_pack_refs>, option =3D 1}, {cmd =3D 0x4f53=
d9 "patch-id", fn =3D 0x450530 <cmd_patch_id>, option =3D 0},=20
{cmd =3D 0x4f53e2 "peek-remote", fn =3D 0x43c890 <cmd_ls_remote>, option =
=3D 2}, {
            cmd =3D 0x4f53ee "pickaxe", fn =3D 0x410920 <cmd_blame>, option=
 =3D 1}, {cmd =3D 0x50a386 "prune", fn =3D 0x450ec0=20
<cmd_prune>, option =3D 1}, {cmd =3D 0x4f53f6 "prune-packed", fn =3D 0x450c=
a0 <cmd_prune_packed>, option =3D 1}, {
            cmd =3D 0x51ddc8 "push", fn =3D 0x451730 <cmd_push>, option =3D=
 1}, {cmd =3D 0x4f5403 "read-tree", fn =3D 0x452350=20
<cmd_read_tree>, option =3D 1}, {cmd =3D 0x50ca97 "receive-pack", fn =3D 0x=
453960 <cmd_receive_pack>,=20
            option =3D 0}, {cmd =3D 0x4f884c "reflog", fn =3D 0x4562b0 <cmd=
_reflog>, option =3D 1}, {cmd =3D 0x50a234 "remote", fn =3D 0x4577e0=20
<cmd_remote>, option =3D 1}, {cmd =3D 0x4f540d "remote-ext", fn =3D 0x45a74=
0 <cmd_remote_ext>,=20
            option =3D 0}, {cmd =3D 0x4f5418 "remote-fd", fn =3D 0x45a8e0 <=
cmd_remote_fd>, option =3D 0}, {cmd =3D 0x4f5422 "replace", fn =3D=20
0x45acb0 <cmd_replace>, option =3D 1}, {cmd =3D 0x4f542a "repo-config",=20
            fn =3D 0x421590 <cmd_repo_config>, option =3D 2}, {cmd =3D 0x4f=
5436 "rerere", fn =3D 0x45af10 <cmd_rerere>, option =3D 1}, {cmd=20
=3D 0x50433e "reset", fn =3D 0x45b890 <cmd_reset>, option =3D 1}, {cmd =3D =
0x4f543d "rev-list",=20
            fn =3D 0x45c6e0 <cmd_rev_list>, option =3D 1}, {cmd =3D 0x4f544=
6 "rev-parse", fn =3D 0x45d020 <cmd_rev_parse>, option =3D 0},=20
{cmd =3D 0x4f5450 "revert", fn =3D 0x45ed10 <cmd_revert>, option =3D 9}, {c=
md =3D 0x4f5457 "rm",=20
            fn =3D 0x45ee20 <cmd_rm>, option =3D 1}, {cmd =3D 0x4f545a "sen=
d-pack", fn =3D 0x460100 <cmd_send_pack>, option =3D 1}, {cmd =3D=20
0x4f5464 "shortlog", fn =3D 0x461440 <cmd_shortlog>, option =3D 6}, {cmd =
=3D 0x4f546d "show",=20
            fn =3D 0x438be0 <cmd_show>, option =3D 1}, {cmd =3D 0x4f5472 "s=
how-branch", fn =3D 0x4620d0 <cmd_show_branch>, option =3D 1},=20
{cmd =3D 0x4f547e "show-ref", fn =3D 0x463af0 <cmd_show_ref>, option =3D 1}=
, {cmd =3D 0x4f5487 "stage",=20
            fn =3D 0x405e70 <cmd_add>, option =3D 9}, {cmd =3D 0x50c9c4 "st=
atus", fn =3D 0x41ec40 <cmd_status>, option =3D 9}, {cmd =3D=20
0x4f548d "stripspace", fn =3D 0x463e90 <cmd_stripspace>, option =3D 0}, {cm=
d =3D 0x4f5498 "symbolic-ref",=20
            fn =3D 0x463f50 <cmd_symbolic_ref>, option =3D 1}, {cmd =3D 0x5=
1d96d "tag", fn =3D 0x464920 <cmd_tag>, option =3D 1}, {cmd =3D=20
0x4f54a5 "tar-tree", fn =3D 0x4657e0 <cmd_tar_tree>, option =3D 0}, {cmd =
=3D 0x4f54ae "unpack-file",=20
            fn =3D 0x465a50 <cmd_unpack_file>, option =3D 1}, {cmd =3D 0x4f=
54ba "unpack-objects", fn =3D 0x466440 <cmd_unpack_objects>,=20
option =3D 1}, {cmd =3D 0x4f54c9 "update-index", fn =3D 0x468400 <cmd_updat=
e_index>, option =3D 1}, {
            cmd =3D 0x4f54d6 "update-ref", fn =3D 0x468f00 <cmd_update_ref>=
, option =3D 1}, {cmd =3D 0x4f54e1 "update-server-info", fn =3D=20
0x469190 <cmd_update_server_info>, option =3D 1}, {cmd =3D 0x4f755f "upload=
=2Darchive",=20
            fn =3D 0x469490 <cmd_upload_archive>, option =3D 0}, {cmd =3D 0=
x4f54f4 "upload-archive--writer", fn =3D 0x4692d0=20
<cmd_upload_archive_writer>, option =3D 0}, {cmd =3D 0x4f550b "var", fn =3D=
 0x4696b0 <cmd_var>, option =3D 2}, {
            cmd =3D 0x4f550f "verify-pack", fn =3D 0x4697b0 <cmd_verify_pac=
k>, option =3D 0}, {cmd =3D 0x4f551b "verify-tag", fn =3D 0x469b60=20
<cmd_verify_tag>, option =3D 1}, {cmd =3D 0x5167b6 "version", fn =3D 0x497a=
30 <cmd_version>,=20
            option =3D 0}, {cmd =3D 0x4f5526 "whatchanged", fn =3D 0x438ae0=
 <cmd_whatchanged>, option =3D 1}, {cmd =3D 0x50f5d5 "write-
tree", fn =3D 0x469dc0 <cmd_write_tree>, option =3D 1}}
=2D--Type <return> to continue, or q <return> to quit---
        i =3D <optimized out>
#8  0x0000000000404b92 in run_argv (argv=3D0x7fffffffdce0, argcp=3D0x7fffff=
ffdcec) at git.c:513
        done_alias =3D 0
#9  main (argc=3D3, argv=3D0x7fffffffde50) at git.c:588
        done_help =3D 0
        was_alias =3D 0
        cmd =3D 0x7fffffffe206 "push"
(gdb) quit


=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2276132.vuxxDAoVpX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlFoV3IACgkQi/DJPQPkQ1J9+wCfatFUXFbuAVVc8OVLcmu1nUkT
+CYAnR5niQRiRcfunT1XYVKLZyJ0TXGN
=SiLU
-----END PGP SIGNATURE-----

--nextPart2276132.vuxxDAoVpX--
