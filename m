Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599531C2E
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833578; cv=none; b=YIlg706z/MTCMnTRlCIagkVjYqUCgbrbuUKa/SHQ0Yp9GljDeebPT7efwkLkCK0dETdhrKZfGmE4usamz8mTSzgzbZC43gixL1CKrjCkoWYkUMouB/iWw9b+syCcVBJFBD2LMFxttcQuRPDeSmLX9AUfExTNKtQcLnhOBcViADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833578; c=relaxed/simple;
	bh=yKBzRhni5As/zAhQT5FHkgJLnr2GUO4UZO3NrYr5Ox8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLnXdC3iLS51jT1VSL1MdmV9UnRH0xmm8SUyRFm3ZEwguCWyydu8DNMm7Ud9lLsEfyoaLcIYOoxi8ahzEpSTw0y+/B+Qe1CS8HfXCXH3SJbN7tJDY4J1PcODzOM8uN86QHyn7XFkpsra0IcMTnO3y3mxG49mf0Nw66L+cGmGmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=2GtApSqY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="2GtApSqY"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-68518bc1407so59801997b3.2
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 18:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1727833575; x=1728438375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6v2V4ChSDvt6+Egdh0HEcVlnrEt0zCooaY5VXQV6fE=;
        b=2GtApSqYaIOMuSKxzopCS8ftAulzl8+uwUyOEv7XUAviPUO1zPUTrUaVQpO7gS5E7m
         WUclrBBq0E9BjwCLmYeVjCDnzk79BiMa2/JoquX7/fsW9Q1XBW0t/+yHE3JWz9esOzrd
         sDHH4el+4wNBDLUqxb5e9vvTdoyUcIaqxbFZJKGL11UejJHxIqrhKc5L5LiAvnNAThys
         noEi0vvTHo6ueIYlf0iUdFnBkoyQyG9zccHrVQ+U9zBlx9/74Vw+/CqOqeG004ZhMM77
         qE5JfvyfoUGU1hEOEOI2wVgc8LRfLkyHEIx76U/+zMA6J0Vt+7ztFZoMgWYKmy6r+im6
         kOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727833575; x=1728438375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6v2V4ChSDvt6+Egdh0HEcVlnrEt0zCooaY5VXQV6fE=;
        b=Ab7/nmqZO8J7Xp0h5nS/C5zuRrb3aDgQ/8NtKoUyw5uKTWEzyTv2+Ndg5uE3wIPJo8
         nw+HxXScDRCEGrL0yeLA5UYWrx7JUnroW+zkmyKeKdXgNYehbg5bDU98/281kCW+SS3L
         VQ43swG7Uby2c8QOOkupFp2xDaJqfB1cAQjR5LDz8onu1OMDcOzrFuydexOnLLaGOYjs
         xBrmvlzxmwxjDeZneJuta48RGbcmco/O9I5g1oG4fS40VUkc2/uD51ptt7pkLiHGv3yi
         t3osHZdIfSntSq93mue6BF+wGimRURmTu4eU4tq6SB0yMgoEZrl+JVqGRwdan+EZmwK/
         KZrQ==
X-Gm-Message-State: AOJu0Ywe/QIwagr+/7+IX/+9DsGdaOFpdQ3gMdegGlc7bcH9gnHSWq4M
	fHmfA37k2kSNyzgEeqVFoZWDgMLtTXpf2S6VppCbgswdOfNRZFl+U4aN75+dSbFy5Lq52RB+gd5
	jvJXU7BN47t+dfT2KM1nAZxirTKr1DCh7Uz3UIHNYTCTGet0ILKrfzl1vMRsII2jgBjhUziDr+M
	D2hykDW2vkZ8H9OCfDVw87fP7H5CPB8zJPH2adst1748zs1LOWK313QnAY+zLnBBBjZBWnzZeTk
	HveICSVFZINSai5GQrM9ajHOdrgfDo3xAcZGYe2fql5mBsp/+t7kPvPMrtZnmX66cHfQ/7f9WVt
	PsE/dWvj94E=
X-Google-Smtp-Source: AGHT+IErPUoGoAzcRavU5OtF2wds6kpXOiUGEwHe/LGB41ipW8mtV44MTzMaBgYWKPrqBmIDMKPWsf3Ti3knSrQHwhc=
X-Received: by 2002:a05:690c:1a:b0:6dd:fd31:c60f with SMTP id
 00721157ae682-6e2a307e673mr16390327b3.41.1727833574757; Tue, 01 Oct 2024
 18:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930194600.GA1805534@coredump.intra.peff.net>
In-Reply-To: <20240930194600.GA1805534@coredump.intra.peff.net>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 2 Oct 2024 10:46:03 +0900
Message-ID: <CAOTNsDykrEBGBnQJqmCghWBTgzirxHZQM25ohsCBysp8ZO1qLg@mail.gmail.com>
Subject: Re: fsmonitor deadlock / macOS CI hangs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:46=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> I did some more digging on the hangs we sometimes see when running the
> test suite on macOS. I'm cc-ing Patrick as somebody who dug into this
> before, and Johannes as the only still-active person mentioned in the
> relevant code.
>
> For those just joining, you can reproduce the issue by running t9211
> with --stress on macOS. Some earlier notes are here:
>
>   https://lore.kernel.org/git/20240517081132.GA1517321@coredump.intra.pef=
f.net/
>
> but the gist of it is that we end up with Git processes waiting to read
> from fsmonitor, but fsmonitor hanging.

Perhaps I found the cause. fsmonitor_run_daemon_1() starts the fsevent
listener thread before with_lock__wait_for_cookie() is called.

      /*
       * Start the fsmonitor listener thread to collect filesystem
       * events.
       */
      if (pthread_create(&state->listener_thread, NULL,
                         fsm_listen__thread_proc, state)) {
              ipc_server_stop_async(state->ipc_server_data);
              err =3D error(_("could not start fsmonitor listener thread"))=
;
              goto cleanup;
      }
      listener_started =3D 1;

fsm_listen__thread_proc() starts the following:

      fsm_listen__loop(state);

which is defined as below for darwin:

  void fsm_listen__loop(struct fsmonitor_daemon_state *state)
  {
          struct fsm_listen_data *data;

          data =3D state->listen_data;

          pthread_mutex_init(&data->dq_lock, NULL);
          pthread_cond_init(&data->dq_finished, NULL);
          data->dq =3D dispatch_queue_create("FSMonitor", NULL);

          FSEventStreamSetDispatchQueue(data->stream, data->dq);
          data->stream_scheduled =3D 1;

          if (!FSEventStreamStart(data->stream)) {
                  error(_("Failed to start the FSEventStream"));
                  goto force_error_stop_without_loop;
          }
          data->stream_started =3D 1;

          ...

Normally FSEventStreamStart() is called before
with_lock__wait_for_cookie() creates a cookie file, but this is not
guaranteed. We can reproduce the issue easily if we modify
fsm_listen__loop() as below:

  --- a/compat/fsmonitor/fsm-listen-darwin.c
  +++ b/compat/fsmonitor/fsm-listen-darwin.c
  @@ -510,6 +510,7 @@ void fsm_listen__loop(struct
fsmonitor_daemon_state *state)
          FSEventStreamSetDispatchQueue(data->stream, data->dq);
          data->stream_scheduled =3D 1;

  +       sleep(1);
          if (!FSEventStreamStart(data->stream)) {
                  error(_("Failed to start the FSEventStream"));
                  goto force_error_stop_without_loop;


Koji Nakamaru
