Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BEEC3E8C5
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 20:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B2421D91
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 20:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Tx0FAKTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbgK0UpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 15:45:01 -0500
Received: from mout.web.de ([212.227.15.4]:40437 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732584AbgK0UoB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 15:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1606509822;
        bh=PNictYJg1JCd9X5Xv2k6/LhsUbARdQXsSzbobfPIbXY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Tx0FAKTZcCZvGeu5WM1E8cKI9RPuQi/em5x0lJURBAgbZeomvvloyQScsv4NewLHX
         DNiHL8p5yl4jSoYrPs7w5CbYe0CkKiCVaFMi6JJwlnFpxOLztIjLECtktU0C1VgjWW
         DBzABZWBQUQroXZi3uul1u9/W3MGG2MJrYXDfLFk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3T28-1js1Pi20zA-00qxnX; Fri, 27
 Nov 2020 21:43:42 +0100
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>,
        git@vger.kernel.org
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
 <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
 <20201121002921.GC353076@coredump.intra.peff.net>
 <xmqqd006s7ee.fsf@gitster.c.googlers.com>
 <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
 <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
 <X778eIAr3uzdh0H0@coredump.intra.peff.net>
 <xmqqo8jllyhc.fsf@gitster.c.googlers.com>
 <bd2c4577-4c8c-851c-6045-ba4b306ca612@web.de>
 <X8B9589XMlCQEltA@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d0fcfa7f-9835-a9e6-c4a4-af4de177ff8c@web.de>
Date:   Fri, 27 Nov 2020 21:43:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8B9589XMlCQEltA@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1nWT6VmgIobhokr3OfbX6QDtgAfdHf9aR39FwLuAgF1JXNrs0Of
 u0d9t+zhTxHpdsWGVy3qOgsJIWpxBY3sbpysAjkfiN1BrQunFvsmATSbo+3H6Ipmts6UKW8
 yw445F2dLYOAeTsfDRfik6ay+W1XGOMp3N3KW1GKtlE2eK8OnP3roz0Ox5Nk1S4zPYXBnTO
 Uij9g84iBP7VGlxjBlAQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1GuC2BJeapg=:s08mYlzY09+7RaZC4hYO3H
 Eqx+ExV8Dd/Cg4t8mik8aexKRvSztQb+1MF7krqzWcCnys+BCArpgsS4npBKhgQ5M23XGxpPw
 qLzuxDXYghATzaKmGmdVOwxmhb+oNeZBWGwLycdDC1ciAbvRRpWt7k8OFZ66rewDbrJBI9U4l
 01tLmQm2vyq3v8H+kCuwbGyGKdCkck5y+Z2aaq7eKF/BKrQqrVOhT5tRMMxLmiQaje8QoLQmi
 C058gDeNngEdULRDuov68eb+DJKjiheV0oo9udd5WBMHbATWgkOt7viLCP7JO6KUsQDT34pjC
 OYeJD8HQE1PzwRbk5lo8EJ945v1Kq0LtI/1b3v0te6iV+G9MsvzoiK8jAdo7wIk1Gi5YX++Wp
 ykOKDcocBJPRiM36efJyF+674YYtrdu82iAt9ASz6w5K+lBKRA9LfuO5ndooXni9oN4q6R4I7
 He3psLPubt31FH3TYYte6CVrQ1usrkdQiH9voUAJYIx9Cu6LBB4ilorJtxrYFdmC2Xn/O6TMm
 vt1iD1w0CoDYEoHMpCpdZsCGeZQkkXvItopY0CWBqOGervXgMXpwBghyXR4X7eb4h9fzac8O+
 Zvf30eHlmq9tUMdcTA/cZmHIPp01mwTqIkPYnfSi6kBvR7Fp3vDhhyV40c55uopQygIQ12X5n
 gYc1q8jLRnBPcCl7JXWa4gk20wa7lReCHal9aclkUKx3PDlJ/saQHcoFBHqZeHowkIpBMlJB6
 TOVO62yCea0KZQkbmrD/4RiDDRSG6yy8/Hoaf9BQGsDVTXjx0jRurMsPykpBHj9pN+ZN393y3
 CHJitutIVzKbNwmm0tt+U/VK/ccFtPXn5UosTIMYzXc4Rdp/R4oegHSwjJyrMI6e7rO0UQnsf
 Ij4/8spcLaslsTMP0GCw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.11.20 um 05:17 schrieb Jeff King:
> On Thu, Nov 26, 2020 at 09:04:35PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Before I could submit that one (or something similar) formally, I'd nee=
d
>> to understand what's happening here a lot better and witness the effect
>> of the patch.
>>
>> I understand that the main benefit of stopping the child upon
>> termination of the parent is to avoid using CPU cycles on a heavy task
>> whose results will just go to waste.  But wouldn't the orphaned child
>> then become a zombie?  Init would reap it eventually, but are there
>> perhaps init-less deployments (containerized daemon?) where such
>> zombies could pile up?
>
> I think an init-less deployment like that is already broken. If we
> encounter any error at all in upload-pack we may quit without reaping
> all of our children. And this could never be protected against entirely;
> we could be killed by SIGSEGV, SIGKILL, etc.

That might be true, but it might still be usable if the rate of zombie
production is low enough.  And reducing it slightly might still help by
increasing the time between container restarts.  Segfaults should be
very rare, and people using kill -9 can clean up after themselves..

> My understanding is container deployments often have a tiny pid-1 init
> that takes care of zombie processes like this (but it's not something
> I've dealt with much myself).

True, e.g. https://github.com/krallin/tini, which is built into newer
Docker releases already.  So this problem is real and has an (optional)
solution.

OK, so overall the situation sounds a bit messy to me and perhaps
there's room for improvement, but I agree now that we can leave the
specialists (init, tini) to deal with our zombies.

>> For a test, winning the race condition should be easy if we cheat by
>> letting the child loop forever.  But I struggle even with the most
>> basic task: Making upload-pack invoked by clone call pack-objects.
>> (Feeling a bit silly.)
>
> Here's an easy reproduction. On a clone of something large-ish (by
> number of objects) like linux.git:
>
>   - make sure you don't have bitmaps on (since they make the enumerating
>     phase go quickly). For linux.git it takes ~30s or so to walk the
>     whole graph on my machine.
>
>   - run "git clone --no-local -q . dst"; the "-q" is important because
>     if pack-objects is writing progress to upload-pack (to get
>     multiplexed over the sideband to the client), then it will notice
>     pretty quickly the failure to write to stderr
>
>   - kill just upload-pack with "pkill git-upload-pack" or whatever you
>     like
>
>   - run "ps au | grep pack-objects" (or just "top") to see pack-objects
>     chugging on 100% CPU (and consuming 1GB+ of RAM)
>
> With the patch adding clean_on_exit, that last step turns up nothing.

I was missing --no-local, d'oh!

To win the race consistently I used this:

=2D- >8 --

diff --git a/run-command.c b/run-command.c
index ea4d0fb4b1..a6bf0a86dd 100644
=2D-- a/run-command.c
+++ b/run-command.c
@@ -672,6 +672,19 @@ int start_command(struct child_process *cmd)
 	int failed_errno;
 	char *str;

+	const char *loop_argv[] =3D { "while :; do sleep 1; done", NULL };
+	const char *fail_cmd =3D getenv("GIT_DEBUG_ABANDON_CHILD");
+	const char *argv0 =3D cmd->argv ? cmd->argv[0] : cmd->args.v[0];
+	int fail =3D fail_cmd && starts_with(argv0, fail_cmd);
+
+	if (fail) {
+		fprintf(stderr, "starting endless loop instead of %s\n",
+			cmd->argv ? cmd->argv[0] : cmd->args.v[0]);
+		cmd->argv =3D loop_argv;
+		cmd->use_shell =3D 1;
+		cmd->git_cmd =3D 0;
+	}
+
 	if (!cmd->argv)
 		cmd->argv =3D cmd->args.v;
 	if (!cmd->env)
@@ -982,6 +995,9 @@ int start_command(struct child_process *cmd)
 	else if (cmd->err)
 		close(cmd->err);

+	if (fail)
+		die("abandoning child %"PRIuMAX"\n", (uintmax_t)cmd->pid);
+
 	return 0;
 }


=2D-- 8< ---

We could build tests that always win (or lose, based on your
perspective) the race condition based on that.  Turning on clean_on_exit
is such a no-brainer that I don't see the need for one, though.

> Now the situation above is probably pretty rare. Nobody is usually going
> to kill upload-pack specifically. The more common case is when
> upload-pack realizes that the client (or the network) has gone away,
> because it tries to write and finds the connection gone. But what is it
> writing? Most of the time it's stuff from pack-objects! So in the normal
> case, pack-objects is continually writing either data or progress
> reports, so it would notice for its next write.
>
> But again, a client asking for no progress is a problem. upload-pack
> will be sending keepalives every 5s or so, so it will notice client
> death then. But pack-objects will keep running, not generating any
> output until it starts spewing the pack.
>
> So you could probably make the scenario above a bit more realistic by
> killing the parent git-clone process. But don't use ^C; that will send
> SIGINT to all of the processes. Simulate a network failure by killing
> the "git clone" process specifically. This shows the same problem, and
> the same improvement after the patch (though remember it may take up to
> 5 seconds for upload-pack to send a keepalive and notice the problem).

With the debug patch above and GIT_DEBUG_ABANDON_CHILD=3Dgit-upload-pack I
need the following patch get rid of the spawned process:

=2D-- >8 ---

diff --git a/connect.c b/connect.c
index 8b8f56cf6d..e1b1b73ef5 100644
=2D-- a/connect.c
+++ b/connect.c
@@ -1369,6 +1369,7 @@ struct child_process *git_connect(int fd[2], const c=
har *url,

 		conn->use_shell =3D 1;
 		conn->in =3D conn->out =3D -1;
+		conn->clean_on_exit =3D 1;
 		if (protocol =3D=3D PROTO_SSH) {
 			char *ssh_host =3D hostandport;
 			const char *port =3D NULL;

=2D-- 8< ---

So is there a downside to clean_on_exit?  It doesn't make sense when we
start browsers or pagers, but for hooks and helpers (which are probably
the majority of started processes) cascading program termination makes
sense, no?

Ren=C3=A9

