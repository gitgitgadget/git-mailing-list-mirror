Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D49F1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 14:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395084AbfJYODD (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 10:03:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:36643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395077AbfJYODC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 10:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572012172;
        bh=/YFHUo49f8N5reif8pJgrnd8V8BSEphnzCLBdJ5lgzM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RyC140inbOsWmw+5D2Z92wyZmxdO6Ir2uMlG3G+QJBLiIWzZ69ypaUGPI5+5whxzj
         e5yl4qaPuY4jyHrfZeiPtKDFOrf+O84wVNTmBCWhDA/3igGCYHqs3py0Nko4fdf3/l
         uLqUjY3EwkhC9f2oGgeyEKQJuJQEmh7iBVm2hwaI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lY1-1iNBEN1BWV-000vtB; Fri, 25
 Oct 2019 16:02:52 +0200
Date:   Fri, 25 Oct 2019 16:02:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
In-Reply-To: <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com>
Message-ID: <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com> <pull.407.v2.git.1571755538.gitgitgadget@gmail.com> <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
 <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yHaJVjs69KGNURKRLzoTEtVtavzhlGYHEAhVSeKi1kMNsKvGItk
 zgLWu/3NR8c+/0wFwK/NGc9r17kQhRb04zPxzqGbSP13giOdOS3mru+3rK195QrSrWUhKdF
 iU2VlJdK//fNM93QDHF8XW/w3WU+eOcUNUvVhFZSwD/+YV/xAfL2jes23DPdFM/kqfF3u+8
 YncLiX4AY4ZDNCZlj+V5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u1anMKoCk54=:m52fo8k9TX769HB2y1CozP
 hEFS/mNSzKNIVAD62oWRlyXQTbG8K5/R1SaPZzy6y7vVHYIGNzmYk6z/edq6XfaPhtYnALMXc
 Tzv7LUjU5JPfrI+MIv5r/NzznoeGMq1wJTpuFUQYPz7yZgRjaReO4/y92uaM012pHEvcMwIa8
 ToVOHRkrIBCu1a276IBC7DfxPMMo0kaCozssBOZs9pDn50NM5zU9XJv0hL8xXbn6R1PVqpg3t
 2KE/dSZrcFMTfRotlRoSTQdhy7jkjXZEzF3Elrbakkjd9R0oXO9bvpNeLI4Pirq4L2W03yZkp
 9nRXeUhMZNViRevwT1GQLIM/Hgf+gS9N2fcI6CH6pnCeU0goTlgkuv6GbaCpIbM55EyQirmZf
 AyG8n0/yNnBYBwNkp8hrojwU1X6wCmp43O/CA6eopfEnOHYQQYj9d0raHgZFKBCP4ChXUC3M7
 +FXBBSrDG45jE03V7xfJguFZFQaeC5MmpSn155wc9ppYhLQBzJU948GNvDllv4+JsfVX6jmyt
 5mJqncvisTaE0QSt071aA2oqMzwX3JZ0jioT5zk9Cup0fBhem076oSmbtahYJMUXVz59ZWr9i
 uXKqThoYIfROGg0zdM9bQ4XH+fGtNYg3xbd76Jhm0RKcD/NBPPqsIalM/6CnisW7NXZrgbOlU
 iwsYfxYF/PMFLiFJWWBKTC7eyMK79TtqC/E7kRPbGBuyEfI5OAFce5tt/QBJ07qbndhyhkd47
 B+fBu+8436sAM0PF6FsXEfiTVjCFZDxZWsE64NPhfq5XysTNs2PKn9lneElLRoIRQibt1B/07
 HV+P2pqa0Rczv63FWN1T7EJmqFNpN/QJGmpYe/2AI60XitxewB2z5wpQAa+N2Z+clUTbiGKSE
 47YVbFnSbzkqFSoW39oDAB0RVMZYJktiw2vz5KzLrBiwbbFxgyTtiyHC5opcAuuYX5BHDtmtS
 qrT5aEn9zkbISTRtFSyItSTn+YdJkl39oKoo7iZXZ1RQbWdPPMjZL69QGfVcBAasDlb0dIlAw
 hGVMIKzwJJZJ5w5Ba49Sozxqghlc1cPWtUeIw2Tj7zc9CYXYihSgVy+wSB5mjsaYNNkc/ktsb
 SnGfwcmJLqpArC5Mz2e/toJI1CtfbSuqyIJrQq3d6/7WHDWWlGmB9o3pIHt9bw3JMxhEgGK29
 VGpwUMYUwjW3WkG0UsNpgaReXbvmRdPccRiPfhgoURVAQhRsg20fHio1RF2XwvOKBH5USG3Vc
 CAHAJlRmSDxtM09uC1DCVvA9fkvkEmyYS3rllOZpppLyHgoy+xNHq9EohCIg=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Fri, 25 Oct 2019, Alexandr Miloslavskiy wrote:

> > Maybe this could do with an example?
>
> I myself observed results like this when running t5516:
> ------
> fatal: git fatal: remote errouploar: upload-pack: not our ref
> 64ea4c133d59fa98e86a771eda009872d6ab2886d-pack: not o
> ur ref 64ea4c133d59fa98e86a771eda009872d6ab2886
> ------
>
> Do you want me to add this garbled string to commit message?

I think that would make things a lot more relatable ;-)

My example is even worse (read: more convincing), though:

fatal: git uploadfata-lp: raemcokte :error:  upload-pnot our arcef k6: n4o=
t our ea4cr1e3f 36d45ea94fca1398e86a771eda009872d63adb28598f6a9
8e86a771eda009872d6ab2886

So maybe you want to use that?

> > > +	buf =3D malloc(buf_size);
>
> > Why not `alloca()`?
>
> Allocating large chunks on stack is usually not recommended. There is a =
funny
> test "init allows insanely long --template" in t0001 which demonstrates =
that
> sometimes vreportf() can attempt to print very long strings. Crashing du=
e to
> stack overflow doesn't sound like a good thing.

Indeed. A clipped message will be a lot more helpful in such a scenario.

> > And to take a step back, I think that previous rounds of patches tryin=
g
> > to essentially address the same problem made the case that it is okay =
to
> > cut off insanely-long messages, so I am not sure we would want to open
> > that can of worms again...
>
> I draw a different conclusion here. Each author thought that "1024 must
> definitely be enough!" but then discovered that it's not enough again, f=
or
> example due to long "usage" output. At some point, f4c3edc0 even tried t=
o
> remove all limits after a chain of limits that were too small. So I woul=
d say
> that this is still a problem.

The most important aspect of `vreportf()` is, at least as far as I am
concerned, to "get the message out".

As such, no, I don't want it to fail, neither due to `alloca()` nor due
to `malloc()`. I'd rather have it produce a cut-off message that at
least shows the first 4095 bytes of the message.

> > Quite honestly, I would love to avoid that amount of complexity,
> > certainly in a part of the code that we would like to have rock
> > solid because it is usually exercised when things go very, very
> > wrong and we need to provide the user who is bitten by it enough
> > information to take to the Git contributors to figure out the root
> > cause(s).
>
> It's a choice between simpler code and trying to account for
> everything that could happen. I think we'd rather have more complex
> code that handles more cases, exactly to try and deliver output to
> user no matter what.

Complex code usually has more bugs than simple code. I don't want
`vreportf()` to have potential bugs that we don't know about.

> > Is the problem that causes those failures with VS the fact that
> > `fprintf(stderr, ...)` might be interleaved with the output of
> > another process that _also_ wants to write to `stderr`? I assume
> > that this _is_ the problem.
>
> This is where I started. But if you look at comment in vreportf_buf,
> there are more problems, such as interleaving blocks of larger
> messages, which could happen on any platform. I tried to make it work
> in most cases possible.

Again, I don't think that it is wise to try to make this work for
arbitrary sizes of error messages.

At some stage, the scrollback of the console won't be large enough to
fix that message!

So I think it is very sane to say that at some point, enough is enough.

Four thousand bytes seems a really long message, anyway.

> > Further, I guess that the problem is compounded by the fact that we
> > usually run the tests in a Git Bash on Windows, i.e. in a MinTTY
> > that emulates a console (there _is_ work under way to support the
> > newly introduces ptys, but that work is far from done), so the
> > standard error file handle might behave in unexpected ways in that
> > scenario.
>
> To my knowledge, this is not related. t5516 failures are because git
> explicitly wants stderr to be unbuffered. VC++ and MinGW runtimes take
> that literally. fprintf() outputs char-by-char, and all of that
> results in char-interleaving.

Yes, as my example above demonstrates. (Ugh!)

> > But I do wonder whether replacing that `fprintf()` by a `write()` woul=
d
> > work better. After all, we could write the `prefix` into the `msg`
> > already:
> >
> >  size_t off =3D strlcpy(msg, prefix, sizeof(msg));
> >  int ret =3D vsnprintf(msg + off, sizeof(msg) - off, err, params);
> >  [...]
> >  if (ret > 0)
> >   write(2, msg, off + ret);
> >
> > Would that also work around the problem?
>
> You forgot to add '\'n. But yes, that would solve many problems,


... and indeed, I verified that this patch fixes the problem:

=2D- snip --
diff --git a/usage.c b/usage.c
index 2fdb20086bd..7f5bdfb0f40 100644
=2D-- a/usage.c
+++ b/usage.c
@@ -10,13 +10,16 @@ void vreportf(const char *prefix, const char *err, va_=
list params)
 {
 	char msg[4096];
 	char *p;
-
-	vsnprintf(msg, sizeof(msg), err, params);
+	size_t off =3D strlcpy(msg, prefix, sizeof(msg));
+	int ret =3D vsnprintf(msg + off, sizeof(msg) - off, err, params);
 	for (p =3D msg; *p; p++) {
 		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
 			*p =3D '?';
 	}
-	fprintf(stderr, "%s%s\n", prefix, msg);
+	if (ret > 0) {
+		msg[off + ret] =3D '\n'; /* we no longer need a NUL */
+		write_in_full(2, msg, off + ret + 1);
+	}
 }

 static NORETURN void usage_builtin(const char *err, va_list params)
=2D- snap --

> except truncation to 4096. Then I would expect a patch to increase
> buffer size to 8192 in the next couple years. And if you also try to
> solve truncation, it will get you very close to my code.

My point is: I don't want to "fix" truncation. I actually think of it as
a feature. An error message that is longer than the average news article
I read is too long, period.

BTW I have a couple more tidbits to add to the commit message, if you
would be so kind as to pick them up: I know _which_ two processes battle
for `stderr`. I instrumented the code slightly, and this is what I got:

=2D- snip --
$ GIT_TRACE=3D1 GIT_TEST_PROTOCOL_VERSION=3D ../git.exe --exec-path=3D$PWD=
/..  -C trash\ directory.t5516-fetch-push/shallow2/  fetch ../testrepo/.gi=
t 64ea4c133d59fa98e86a771eda009872d6ab2886
14:55:55.360382 exec-cmd.c:238          trace: resolved executable dir: C:=
/git-sdk-64/usr/src/vs2017-test
14:55:55.362379 exec-cmd.c:54           RUNTIME_PREFIX requested, but pref=
ix computation failed.  Using static fallback '/mingw64'.
14:55:55.387189 git.c:444               trace: built-in (pid=3D21620): git=
 fetch ../testrepo/.git 64ea4c133d59fa98e86a771eda009872d6ab2886
14:55:55.392644 run-command.c:663       trace: run_command: unset GIT_PREF=
IX; 'git-upload-pack '\''../testrepo/.git'\'''
14:55:55.659992 exec-cmd.c:238          trace: resolved executable dir: C:=
/git-sdk-64/usr/src/vs2017-test
14:55:55.661762 exec-cmd.c:54           RUNTIME_PREFIX requested, but pref=
ix computation failed.  Using static fallback '/mingw64'.
14:55:55.662759 git.c:444               trace: built-in (pid=3D27452): git=
 upload-pack ../testrepo/.git
14:55:55.681188 run-command.c:663       trace: run_command: git rev-list -=
-stdin
fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab28=
86
fatal: remote error (pid=3D21620): upload-pack: not our ref 64ea4c133d59fa=
98e86a771eda009872d6ab2886
=2D- snap --

As you can see, the two error messages stem from the `git fetch` process
(with the prefix "remote error:") and the process it spawned, `git upload-=
pack`.

BTW if you pick up the indicated patch and the tidbits for the commit
message and then send out a new iteration via GitGitGadget, I would not
mind being co-author at all ;-)

Ciao,
Dscho
