Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B9DC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiEYKQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiEYKQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:16:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44C2A45C
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653473768;
        bh=zF7bDrBlZd0CdlvTTGMcYx+Z1wMPjswFJWGDbtcisSQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WQ0KhmwLSbdNB4QSpDEH0vsO+mYa4D+/a1NMWt45k4csBH5HC5pfPOK8tAuttIL1X
         9/xVUWH0zqb9r0nJjw79XOQ4mjPOf3Tqb/LDZ5JJZpE8O2MwdkA1caXc9KwKXPQfTs
         EN+8T8M7dlYlOXNxEBj7yrpKW2PaP2u6oqfS7vQM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1oLiAX1fen-00YTPK; Wed, 25
 May 2022 12:16:08 +0200
Date:   Wed, 25 May 2022 12:16:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] http.c: avoid danging pointer to local variable
 `finished`
In-Reply-To: <xmqqczg2eeth.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205251208560.352@tvgsbejvaqbjf.bet>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com> <4a4e0aa0a49a54eea88f9c2d8e1db6a697012718.1653351786.git.gitgitgadget@gmail.com> <220524.86fskzxsvq.gmgdl@evledraar.gmail.com> <xmqq35gyhf11.fsf@gitster.g> <nycvar.QRO.7.76.6.2205242309160.352@tvgsbejvaqbjf.bet>
 <xmqqczg2eeth.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:efOCfHlK+6y3anOJzXzGewjqEG/u6OtvYnwQkVPI0GIkBaJ3FQR
 cxXkeLNrNdnHPaBWJYxD0Ir6ecUdHshpon/c7eApEYZg/s6NsxyloByVu1R2nPykd//LqJ+
 Kar7rk0GPweufoI/cHREcQ2SE1MCVzj14QaTuJyriw4O+dyjCek0z83DcBtUZokmQR6xGBo
 6+pVaIFO6GXXVI+rQDaUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E4IaqW51fSo=:rsxkOyJgQcFlvmIrCr4jqy
 C/ZJ3r6IKlTQ+3yq8/qg7sm606YjOxJVaQoT9kjClUEtu/s53xO7uMGbEzCH/Achcmq1/B65G
 AcSbeBWuuDtx/WZ2LBa8+gQnUnK8cuf8rxo0TUd7XXHNn1+JgQ+Qd91lwl1Yg81+0C6c97fLQ
 vh1DyeXInI4GPIIVvG1CKrBip80n5HtxlVVVqMNUHbERWoP75IS5yeNrvWRWF1cYXmeoJ5BzY
 OhpBrw7oSsknztbeqblW7SlOk6N5fduUczPzrn3KmRnQiU3ej5mKn1c6MCCs8Nbb2hYuh53Gg
 REsMux03rWacLVy8WInjwPXelXXdepK2F1PGV0BRW7FCqisS/ia67ApJUUy4G1raKLRaGDEjM
 oGiwQpjNcsKK99zPadaObWnmobhRwbmIeI/BDi21+qZqJTpc0He3hcrKYNNVDXSExNbXHZMbB
 +ZcZDfVQoF0S+lReD1XnvwghxvBnci1IegvyOx75R8v5w3b1s7uKIFD9u/mI8XDyMnD19/r21
 cIf56cLdBxl3Bx06yzCtLBwGZv3P7gM5bhzCXQfcmpzJgJyomnbD5bHRHL6b2jVaZULrCQzZ0
 BXOsNJNqW6EC5wjln1xKUShcYzGi9jDLJ+otJqzVGVSZFueAzMwPgYUrbK0cvD3rTURm9JetI
 VUohpCjFurzM9n6Jgx4/HMDDUW/GQSVKDf5aE99nrMrhlpCbpwlHkqOmpeUotDvCs844zXGZ+
 eJmr3t15+ncrd1n4+GF7xny0SjcjB4dqaYku/i8N1hxSVhS0BukpkqQQoTf0ZLziD6EeoCQS0
 92yTtYGSycGUUsVt470ZJz8b7c02eN9cjPg9WgDav0X5MfJiZ4dDM8IR3X/ulhbMGSZOLc5+s
 A1qf/9ij+SbShZjKIkUF+ugDZV69dfz04XGddlbnRlTOo3pzZaSWxiKN0vaKJMqQJ3a3JkVFa
 DqjVsdWckRayv4FVjse/iwZjgMr5YIiyDRiv4Mj5ehaX3aJrQ/FAjJgHsjYZgJWuOE1HhFk9T
 FKTGHbjoazhb3AascqRZJrZ821hHfDatkeaVTsflrqKSDvel+0yP/BWAkNF9naq6ZAKQjDaDp
 wn2/gS22pBKl1A50O9o+81cKMj5P6z67ZJSZfyuJLwfE0FGNcXm1NskPw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 May 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 24 May 2022, Junio C Hamano wrote:
> >
> >> The "clear slot->finished", by the way, is what I think is the right
> >> thing to do, especially that the objective is to squelch the false
> >> positive warning from a new compiler.  If there is a way to annotate
> >> the line for the compiler to tell it not to warn about it, that would
> >> have been even better.
> >
> > We could do something like this:
>
> Yuck.
>
> > -- snip --
> > diff --git a/http.c b/http.c
> > index b08795715f8a..2ac8d51d3668 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -1365,7 +1365,14 @@ void run_active_slot(struct active_request_slot=
 *slot)
> >  	struct timeval select_timeout;
> >  	int finished =3D 0;
> >
> > +#if __GNUC__ >=3D 12
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdangling-pointer"
> > +#endif
> >  	slot->finished =3D &finished;
> > +#if __GNUC__ >=3D 12
> > +#pragma GCC diagnostic pop
> > +#endif
> >  	while (!finished) {
> >  		step_active_slots();
> > -- snap --
> >
> > That's quite ugly, though. And what's worse, it is pretty unreadable, =
too.
>
> Yes, very ugly.  Would an unconditional
>
> 	slot->finished =3D NULL;
>
> at the end squelch the warning?

No, unfortunately not:
https://github.com/dscho/git/actions/runs/2383492484

As you mentioned elsewhere, the error is clearly about the assignment in
the first place, and it does not matter that the function will rectify the
situation. It's the correct thing to do for the compiler, too: since
`slot->finished` already has the pointer, and since the
`active_request_slot` struct is declared globally, code outside the
current file might squirrel that pointer away for later use.

> Or there is a way to say "we make all warnings into errors with
> -Werror, but we do not want to turn this dangling-pointer warning to
> an error, because it has false positives"?
>
> Or we could add "-Wno-dangling-pointer" globally, perhaps.

I'd like to avoid that because it would quite likely hide legitimate
issues elsewhere.

It currently seems to be the easiest solution to simply turn the local
variable into a heap variable:

=2D- snip --
diff --git a/http.c b/http.c
index f92859f43fa..0712debd558 100644
=2D-- a/http.c
+++ b/http.c
@@ -1327,10 +1327,10 @@ void run_active_slot(struct active_request_slot *s=
lot)
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
-	int finished =3D 0;
+	int *finished =3D xcalloc(1, sizeof(int));

-	slot->finished =3D &finished;
-	while (!finished) {
+	slot->finished =3D finished;
+	while (!*finished) {
 		step_active_slots();

 		if (slot->in_use) {
@@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *slo=
t)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+	if (slot->finished =3D=3D finished)
+		slot->finished =3D NULL;
+	free(finished);
 }

 static void release_active_slot(struct active_request_slot *slot)
=2D- snap --

This pacifies GCC (https://github.com/dscho/git/runs/6589617700) and is
the most minimally-intrusive work-around of which I am currently aware.

Ciao,
Dscho
