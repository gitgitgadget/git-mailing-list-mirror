Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4231C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7DF61208
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbhKIACh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 19:02:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:48853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhKIACg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 19:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636415977;
        bh=UepVGywyN4eU8ZkvTwFrmTaEohZ0ArSGuPwTE6olEO8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FTzwdhVL7Od9XSkC/BqUTNhICM0G8PxT3MFEo5SGHmVDJoNsInflBofSyv+kJ1szT
         8jFBQZt/n0vG0QmvQdFfeXhGBzgEz1Rp5CgjF15hXSr4Lk+/uas7Mg2Q1HN5/akcwL
         CAKX58BAIUtXhc8dySqd2Xo0A9BU1GSgLEfBvPXo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.201.164] ([89.1.212.10]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1miqyD414n-003eDj; Tue, 09
 Nov 2021 00:59:37 +0100
Date:   Tue, 9 Nov 2021 00:59:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Adam Dinwoodie <adam@dinwoodie.org>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
In-Reply-To: <20211104194619.GA12886@dinwoodie.org>
Message-ID: <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com> <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com> <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com> <20211104194619.GA12886@dinwoodie.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zw4GnsUpFx/Qg7hNsLCZmFYW4ORXkvtqWY38grauDL0cISdXGFi
 UviecK92lhRX/8r72hhhmm9Zaq9+RiEYEJDrVx9MobUMjXJIuryNgkE8p3SLi8hQnkg+NXN
 Bxpi5B6RoYfwIZeUAkLsUgyvj7Q6b6bVRVQ4V4l92SEpisYjJ2LWNl/E5xANy1OtJy+bHg7
 Ny1aMDQKms2ZeeBRMVTmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hVvxFsIBXho=:MB5M0Ef40KgbxT2mvG8qao
 z7vSrmfrqvuxsTF2cZl3P20Q4M/Rndif6oCZKJ/KXtjNR89hEoOu+ztpgQMx2oZ/iJKnmZtDT
 j02gF57zQ3jkOr9VtosoEbeGHbu8O6ynIdWgB4lmaPcIos2fOUiBqvsNqVO/yAPppcex+rB8u
 YrLi+y6ZSAShbGJFvKSs3xXF61aRrGBGA/EetbtumRLDvLL5SnPkI/gWnI85FVw3iVZgKJs3K
 z6tC2AdQdy9xMoceRDT01yRUHmeE7m1b5YXy5DF7n7E6J7p8frwpHCL38u4o7asVEfLOfuY4P
 sQ2AkagwdX3TIt79qXsud9RwD1vit61gwtfp7pD869Mt3YeaWq+NQFeAvppC/PHx9AVNxtEcG
 rXsvS2mH9MHQdaNkeP1iNoZMEx3tM9LFuHb/EZYKsGkOZuiLZJOH1+EL8/dw2z6luKbL0SqeJ
 j0nxZuP9Jvof05KyhjQK8RqpuR66An/qmnA8WY/NbtMeoTxfPYO6PDUiddXhMcuqjKU1uApSd
 hP/y91gy+Bw5w1v//DiEt9qE4s2s2zSXGD8lN1VW1Labjx7ITWaouKiX7TAwRNv9AZ9olC05G
 C3673Rki8rJrni7S4xm/NjHdOIyU64EIrFMKnWDT2vZso0PNDPg8VkKvmfeCRL6kuOuQIHeeb
 yLzapZ9xnYuSTjr5J1lA+daExjyVPHzBGyVKGjOcRWbGdt+F7u46GD8/ijX0MTHQvGPRA6gcN
 Mn+yN2HuPBVMPQYhgwrF4sVjroTYapDSwgo/ZBKMnNKv08IybR0Xm5bATb50F4xX0YAsNuMRH
 qyrEB/xIoF3Egjqx5tuXvGq1sBqm2FCXZwkuDDsWqBcZI8DAzIPxxAP2BOGxzKOJdxwi88iOL
 DR8KJ5aiiE89uMN7whaKGZQvoDPGnINL3exZzW+ZaD0lj4kvUMvLofLqG5wS8P7J6HWQtVqEo
 Y7Dvl5iUb27fqbzCC/Vzg+U/PegSTbZgxRTfM303y73w9UdjssI+urPVVCCm3aWFZkQMsbrsp
 h/J+6g1xrm0oc07VQBWnCfpFqgpssuSHKQhnsUm754e/JHEYQ0vXZ/1dX8ocMrf1Q71jJPuq0
 6BLd3V00fD/rd8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On Thu, 4 Nov 2021, Adam Dinwoodie wrote:

> On Monday 20 September 2021 at 03:36 pm +0000, Jeff Hostetler via GitGit=
Gadget wrote:
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Convert test helper to use `start_bg_command()` when spawning a server
> > daemon in the background rather than blocks of platform-specific code.
> >
> > Also, while here, remove _() translation around error messages since
> > this is a test helper and not Git code.
>
> As part of testing the v2.34.0-rc0 release candidate on Cygwin, I've
> found this commit -- 05881a6fc9 (t/helper/simple-ipc: convert
> test-simple-ipc to use start_bg_command, 2021-09-20), according to my
> bisecting -- is causing t0052.1 to fail on 32-bit Cygwin.  Somehow this
> is only affecting the 32-bit Cygwin build; the 64-bit build is working
> as expected.
>
> Specifically, the failure I'm seeing is as below:
>
> ```
> $ GIT_TRACE=3D1 sh t0052-simple-ipc.sh -vix
> trace: built-in: git init '/cygdrive/d/git-32/t/trash directory.t0052-si=
mple-ipc'
> Initialized empty Git repository in /cygdrive/d/git-32/t/trash directory=
.t0052-simple-ipc/.git/
> expecting success of 0052.1 'start simple command server':
> 	test_atexit stop_simple_IPC_server &&
> 	test-tool simple-ipc start-daemon --threads=3D8 &&
> 	test-tool simple-ipc is-active
>
> ++ test_atexit stop_simple_IPC_server
> ++ test 0 =3D 0
> ++ test_atexit_cleanup=3D'{ stop_simple_IPC_server
> 		} && (exit "$eval_ret"); eval_ret=3D$?; :'
> ++ test-tool simple-ipc start-daemon --threads=3D8
> trace: run_command: test-tool simple-ipc run-daemon --name=3Dipc-test --=
threads=3D8
> error: daemon failed to start
> error: last command exited with $?=3D1
> not ok 1 - start simple command server
> #
> #		test_atexit stop_simple_IPC_server &&
> #		test-tool simple-ipc start-daemon --threads=3D8 &&
> #		test-tool simple-ipc is-active
> #
> ++ stop_simple_IPC_server
> ++ test-tool simple-ipc stop-daemon
> ++ exit 1
> ++ eval_ret=3D1
> ++ :
> ```
>
> I've had a look at the code changes, and cannot work out what might be
> being handled differently in 32-bit and 64-bit Cygwin environments.
> Given the Cygwin project is considering dropping support for 32-bit
> Cygwin anyway, it might not be worth doing anything about this.  But I
> thought it worth reporting in case there's something obvious to folk
> more familiar with this code.

I had a look at this and could reproduce... partially. I only managed to
make it fail every once in a while.

Digging deeper, it turns out that the `lstat()` call in
`ipc_get_active_state()` does not receive an `st_mode` indicating a
socket, but rather a file (in my tests, it was usually 0100644, but
sometimes even 0100755).

The reason is, of course, that Cygwin _emulates_ Unix sockets. What is in
the file system is just a special file, it is marked with the `system` bit
(which only exists on Windows), and its contents start with the tell-tale
`!<socket>`.

And as you might have guessed, there is a race going on between Cygwin
writing that file _and_ flipping that `system` bit, and Git trying to
access the Unix socket and encountering an unexpected file.

Now, why this only happens in your 32-bit setup, I have no idea.

In my tests, the following patch works around the issue. Could I ask you
to test it in your environment?

=2D- snip --
diff --git a/compat/simple-ipc/ipc-unix-socket.c
b/compat/simple-ipc/ipc-unix-socket.c
index 4e28857a0a..1c591b2adf 100644
=2D-- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -36,6 +36,23 @@ enum ipc_active_state ipc_get_active_state(const char
*path)
 	}

 	/* also complain if a plain file is in the way */
+#ifdef __CYGWIN__
+	{
+		static const int delay[] =3D { 1, 10, 20, 40, -1 };
+		int i;
+
+		for (i =3D 0; S_ISREG(st.st_mode) && delay[i] > 0; i++) {
+			/*
+			 * Cygwin might still be in the process of marking the
+			 * underlying file as a system file.
+			 */
+			sleep_millisec(delay[i]);
+			if (lstat(path, &st) =3D=3D -1)
+				return IPC_STATE__INVALID_PATH;
+		}
+	}
+#endif
+
 	if ((st.st_mode & S_IFMT) !=3D S_IFSOCK)
 		return IPC_STATE__INVALID_PATH;

=2D- snap --

FWIW it looks as if the loop might be a bit of an overkill, as I could not
get the code to need more than a single one-millisecond sleep, but it's
probably safer to just keep the delay loop in place as-is.

Ciao,
Dscho
