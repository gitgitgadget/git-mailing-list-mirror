Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1EAC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 21:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiEWV7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 17:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiEWV7R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 17:59:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C443670929
        for <git@vger.kernel.org>; Mon, 23 May 2022 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653343141;
        bh=nVhQ2++0GnfLTis7vXdm/TN5zBhJSLj2/MIK6HIhwuM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R8G4xWZbUngcWLBjNnBbHW0Me3+6F7HjHgzIZwvFhb1bKPODM98n47RBlkgjtbyLX
         DzMStWmV7vsZb6tmCLtWYDtj22C3X7D8j220zdbw1g0Te1mnqDmA5zCh1hVhubXAiw
         nuuGK1h3xDqKhOtlO7G28aw8FJwNCsVKpkFStl9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1oGAHn3Nw3-00Mpqc; Mon, 23
 May 2022 23:59:00 +0200
Date:   Mon, 23 May 2022 23:58:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
In-Reply-To: <xmqqczgqjr8y.fsf_-_@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
References: <cover.1651859773.git.git@grubix.eu>        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IrWXsFidA6rRccBspdDqkoRVMwtzUouKXu7usX9BNY3Zva1+98K
 4ESCcNMQgIGRAM11fYmskRbZWiwqiDag6AV5mvwM7AZlvW9awIjOuiiaq1hHdIn7XpbQqvR
 5oYXneBauRQjpChV81i0mLCnOoMvJPuQWeET/zZ1iep6VRXamN15EfzJdCQLkeDbXSCtFar
 UywfHTsnfvpTgYc/NwsdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lXp7HNme004=:bHNODdxozEHD+e/WJl9pD1
 bjb715g88IJTaPNJAY9Xx6eeSu/gW9/2L5u/gcV+NuFGG7+mdIt0va1R33b8ABI1pIhuFaPJx
 Har/Wq3leb1nuYOFihb6VXlws3XDIPC9mlCju2pHWYT+7ZgvlWsLk6mJEeAaXFnA6hQS5h1O8
 7OAHDzgEcSQSaUutB7pYbPZHguY8uPGHcPD6r4wMf8rRQZoXr2cs0lPNpp/jO0K6AibUQDqao
 WNbCrMgWSBdjLUdRGojiDg31pM5caIKzWDW7TDrGXkaKeK1X3f1Nl5zrNbrhN7f18e2M1IS/V
 wByK9QqpBKXzWmHfZx2hzhg+ajSbjcPtIZ6jAfsY9O8RPDPy0jR99DiulPCwiQQ+rD9EFTrPK
 Hnf8fcwH9Eg1jO+YDJ8NaiVPj+nZloHwTZglUmmPZG4rxKNZ4HIF3sGIdTyN4ann4AOa4Xosh
 hsQFVUdJ93vZg53N0OLXPmKk/5yABWw2LJ+5VhrzVmnbtW+nWh7vCO+x56kEGkZ4aIdyGXKm0
 OeD2luEyHLNdR4+qfryp4eeduP3Ng12tGf51dIYQJzmlK8De7C+Cmddy1TjpV/ZxoYPhhSd72
 Vi37mPw4ta0EQzNXDZlH7xjSoodF4jioyXR0DzGyh+3Fw2Qtuomt1xgvE/CFtxr4UQOt5r5JY
 tkbJ4OWiV8I0uo7OfJGhxX/IxJDJjIH1rYCPusvAaUte5E0KbqYyF74BvVFCbFq7/Llpxtpfj
 hsFuROwl4Etjv7pGIuAURG7fKMyA+4b2D/Ts+51Y6SfdxG4ugAkOTuSd2QerO7N7gCuEkBmRp
 esET/ec8Acr11kqOrf800AReHmZBXKHYQNAU03uC942uzT4ZSPno5BblqKTsdCYUcH4wdoO/M
 L0H0iA+BZPi797PtrQPuVwUGeNjECqOotrrXAWmwN57Gvqcf9fJdoxAx2kH58yvcRhsBp9voG
 H4dUZpamKwUqc2lcBDUqaTRr2lBW5YFPA+apWRgRoisDUQCrPfyuUMvFje0B8W2zNMOL4BGbA
 SrNCZUhHGI3CHdc0yaYF1eN7QJU5ypL2MHeOzFYJpIwmUtqviC84fV++N6iKqckW/fgowKX8j
 eLARxBmaXqer7nLSu01B8trkakyjm6rs5rC7xd+H9NElHvaEMBX+3va1A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 May 2022, Junio C Hamano wrote:

> In http.c, the run_active_slot() function allows the given "slot" to
> make progress by calling step_active_slots() in a loop repeatedly,
> and the loop is not left until the request held in the slot
> completes.
>
> Ages ago, we used to use the slot->in_use member to get out of the
> loop, which misbehaved when the request in "slot" completes (at
> which time, the result of the request is copied away from the slot,
> and the in_use member is cleared, making the slot ready to be
> reused), and the "slot" gets reused to service a different request
> (at which time, the "slot" becomes in_use again, even though it is
> for a different request).  The loop terminating condition mistakenly
> thought that the original request has yet to be completed.
>
> Today's code, after baa7b67d (HTTP slot reuse fixes, 2006-03-10)
> fixed this issue, uses a separate "slot->finished" member that is
> set in run_active_slot() to point to an on-stack variable, and the
> code that completes the request in finish_active_slot() clears the
> on-stack variable via the pointer to signal that the particular
> request held by the slot has completed.  It also clears the in_use
> member (as before that fix), so that the slot itself can safely be
> reused for an unrelated request.
>
> One thing that is not quite clean in this arrangement is that,
> unless the slot gets reused, at which point the finished member is
> reset to NULL, the member keeps the value of &finished, which
> becomes a dangling pointer into the stack when run_active_slot()
> returns.  Clear the finished member before the control leaves the
> function, but make sure to limit it to the case where the pointer
> still points at the on-stack variable of ours (the pointer may be
> set to point at the on-stack variable of somebody else after the
> slot gets reused, in which case we do not want to touch it).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * So, this has been sitting in my pile of random patches for a few
>    weeks.

I stumbled over the need for this while investigating the build failures
caused by upgrading Git for Windows' SDK's GCC to v12.x.

> diff --git a/http.c b/http.c
> index 229da4d148..85437b1980 100644
> --- a/http.c
> +++ b/http.c
> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *s=
lot)
>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}
> +
> +	if (slot->finished =3D=3D &finished)
> +		slot->finished =3D NULL;

First of all, I suspect that
https://github.com/git/git/blob/v2.36.1/http.c#L1207 makes sure that GCC's
complaint is not actually accurate: we always re-set `finished` to `NULL`
when getting an unused slot, so even if there is a left-over dangling
pointer, it is not actually used, ever.

But we need something to pacify GCC. Let's look at your patch.

The first thing to note is that this is not _quite_ thread-safe: between
checking the condition `slot->finished =3D=3D &finished` and assigning
`slot->finished`, another thread could potentially have noticed that the
slot is not in use and overwritten the `finished` attribute, which would
then be set to `NULL` in this thread, in which case _that other_ thread's
`while (!finished)` loop would become an infinite loop.

Having said that, the time window is really narrow.

Besides, I suspect that we _already_ have an equivalent "offender" in
https://github.com/git/git/blob/v2.36.1/http.c#L1336: we look at `in_use`
there, assuming that it is either `1` if "our" request is still active, an=
d
otherwise it is `0`. However, it might have turned to `0` _and_ to `1`
again in the meantime (but the `in_use` would now refer to _another_
request).

I am not quite sure how correct my reading of the situation is, so please
double-check my analysis.

If that analysis is correct, I would expect the correct solution to turn
`finished` into an attribute of the slot, and change its role to be a flag
that this slot is spoken for and cannot be re-used quite yet even if it is
not currently in use.

Something like this:

=2D- snip --
diff --git a/http-walker.c b/http-walker.c
index 910fae539b89..5cc369dea853 100644
=2D-- a/http-walker.c
+++ b/http-walker.c
@@ -225,13 +225,9 @@ static void process_alternates_response(void *callbac=
k_data)
 					 alt_req->url->buf);
 			active_requests++;
 			slot->in_use =3D 1;
-			if (slot->finished !=3D NULL)
-				(*slot->finished) =3D 0;
 			if (!start_active_slot(slot)) {
 				cdata->got_alternates =3D -1;
 				slot->in_use =3D 0;
-				if (slot->finished !=3D NULL)
-					(*slot->finished) =3D 1;
 			}
 			return;
 		}
diff --git a/http.c b/http.c
index b08795715f8a..2d125132fb90 100644
=2D-- a/http.c
+++ b/http.c
@@ -205,8 +205,7 @@ static void finish_active_slot(struct active_request_s=
lot *slot)
 	closedown_active_slot(slot);
 	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);

-	if (slot->finished !=3D NULL)
-		(*slot->finished) =3D 1;
+	slot->in_use =3D 0;

 	/* Store slot results so they can be read after the slot is reused */
 	if (slot->results !=3D NULL) {
@@ -1212,13 +1211,14 @@ struct active_request_slot *get_active_slot(void)
 			process_curl_messages();
 	}

-	while (slot !=3D NULL && slot->in_use)
+	while (slot !=3D NULL && (slot->in_use || slot->reserved_for_use))
 		slot =3D slot->next;

 	if (slot =3D=3D NULL) {
 		newslot =3D xmalloc(sizeof(*newslot));
 		newslot->curl =3D NULL;
 		newslot->in_use =3D 0;
+		newslot->reserved_for_use =3D 0;
 		newslot->next =3D NULL;

 		slot =3D active_queue_head;
@@ -1240,7 +1240,6 @@ struct active_request_slot *get_active_slot(void)
 	active_requests++;
 	slot->in_use =3D 1;
 	slot->results =3D NULL;
-	slot->finished =3D NULL;
 	slot->callback_data =3D NULL;
 	slot->callback_func =3D NULL;
 	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
@@ -1332,7 +1331,7 @@ void fill_active_slots(void)
 	}

 	while (slot !=3D NULL) {
-		if (!slot->in_use && slot->curl !=3D NULL
+		if (!slot->in_use && !slot->reserved_for_use && slot->curl
 			&& curl_session_count > min_curl_sessions) {
 			curl_easy_cleanup(slot->curl);
 			slot->curl =3D NULL;
@@ -1363,10 +1362,9 @@ void run_active_slot(struct active_request_slot *sl=
ot)
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
-	int finished =3D 0;

-	slot->finished =3D &finished;
-	while (!finished) {
+	slot->reserved_for_use =3D 1;
+	while (slot->in_use) {
 		step_active_slots();

 		if (slot->in_use) {
@@ -1403,6 +1401,7 @@ void run_active_slot(struct active_request_slot *slo=
t)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+	slot->reserved_for_use =3D 0;
 }

 static void release_active_slot(struct active_request_slot *slot)
diff --git a/http.h b/http.h
index df1590e53a45..3b2f6da570cd 100644
=2D-- a/http.h
+++ b/http.h
@@ -22,9 +22,9 @@ struct slot_results {
 struct active_request_slot {
 	CURL *curl;
 	int in_use;
+	int reserved_for_use;
 	CURLcode curl_result;
 	long http_code;
-	int *finished;
 	struct slot_results *results;
 	void *callback_data;
 	void (*callback_func)(void *data);
=2D- snap --

I integrated this into a local branch that fixes the build with GCC v12.x
(required so that our CI/PR builds work again after Git for Windows' SDK
upgraded its GCC) and plan on contributing these patches in a bit.

Ciao,
Dscho

>  }
>
>  static void release_active_slot(struct active_request_slot *slot)
> --
> 2.36.1-200-gf89ea983ca
>
>
>
