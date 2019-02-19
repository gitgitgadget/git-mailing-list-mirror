Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F881F453
	for <e@80x24.org>; Tue, 19 Feb 2019 18:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfBSSio (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 13:38:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44650 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfBSSin (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 13:38:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so8511249wrt.11
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JVf66xxrQwzHnS6OqOYyeP1qJVZLdPraG8eimcTy/ko=;
        b=if/xeOlv2/rRoRU1gU0uUfH2ta9QoqZ6Q+XvjLKS2W8p3q+vUCDcavGDkc3JtS4LhW
         YJbRYS4NG74o64AC87rgoGuJ4OMFL1OkDn/eDYmZQ5guX0Ulk19HLYnAzyNCVn8KLvHe
         uK5mUiS9ZWcrJbBviWaZ4S8gHKeorhHMiNatvUcsAKVgM0aspqad3CAmsNC8wIzCDyM3
         i4mi3NHzsf/xKFpc0etjkhz5lPzkORKjTVRu5Km1Sa+6HVVIARKpU2TJufRQ7+SCI2TD
         3v5/VuaVuj36mFOmG99YW/50IK9Zu8Lc8p2GNmJoYyxiWaWWXF6GB97/qf1sfz3Xm3wu
         7hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JVf66xxrQwzHnS6OqOYyeP1qJVZLdPraG8eimcTy/ko=;
        b=CNh5P5kZ5XefS59+k8JKXBp8kZ3sGCdtidwtyTT/1kZWj99WHwdFNtu9vJqLHLGB5r
         7Q5dtHjDvrMO7P+Yg5Lr2s9KqWOrPSQWVKlqPfCK0huNsDSxqf5B7M1MnD054WgoKbKg
         QvWUFZvlpTAW1DTOJe+GVkULvg4r2mD78+g+iZI/X2IQWsE5Wr6nWEYBmWfDsmHsoY1X
         xndyDxIIZeOC1z0VMtzbVJsIrRWSIv2lMvYk0vsKj42hKnJd1EGgru8F+s6wT8k+pZH8
         dmklCcgY9mB2VLoR/83fTz3EjzW/TKVKvS8Cj7NgsKiWGSrFuQJcqzLSInz+//UWxTGc
         rIbw==
X-Gm-Message-State: AHQUAua6nSKjHOE3U/OqMOM+ZAhY0fT+iNmZAD3PpAruZgeyujkg517t
        FctVLlmKKasZqw/Hjop1BPk=
X-Google-Smtp-Source: AHgI3IZM3QTleh+n1X0g5WSPkbjtPyTV7UjinYi2pzxpbDi+BbXYmBTYl0TauzlbAvSBqAkS6fVbbw==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr21738803wru.119.1550601521133;
        Tue, 19 Feb 2019 10:38:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l125sm5999933wml.18.2019.02.19.10.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 10:38:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] t5562: chunked sleep to avoid lost SIGCHILD
References: <20190218205028.32486-1-max@max630.net>
Date:   Tue, 19 Feb 2019 10:38:39 -0800
In-Reply-To: <20190218205028.32486-1-max@max630.net> (Max Kirillov's message
        of "Mon, 18 Feb 2019 22:50:28 +0200")
Message-ID: <xmqq1s4339ow.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> If was found during stress-test run that a test may hang by 60 seconds.
> It supposedly happens because SIGCHILD was received before sleep has
> started.
>
> Fix by looping by smaller chunks, checking $exited after each of them.
> Then lost SIGCHILD would not cause longer delay than 1 second.
>
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> Submitting as proper patch. Note: I believe it does not relate to other issues
> discussed in this thread.
>  t/t5562/invoke-with-content-length.pl | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
> index 0943474af2..257e280e3b 100644
> --- a/t/t5562/invoke-with-content-length.pl
> +++ b/t/t5562/invoke-with-content-length.pl
> @@ -29,7 +29,12 @@
>  }
>  print $out $body_data or die "Cannot write data: $!";
>  
> -sleep 60; # is interrupted by SIGCHLD

Ah, of course.  If SIGCHLD interrupts, sets $existed in the handler,
then we won't go back to sleep.  But if the signal came before the
sleep starts, we spend full 60 seconds here before we check $exited.

Makes sense.

> +my $counter = 0;
> +while (not $exited and $counter < 60) {
> +        sleep 1;
> +        $counter = $counter + 1;
> +}
> +
>  if (!$exited) {
>          close($out);
>          die "Command did not exit after reading whole body";
