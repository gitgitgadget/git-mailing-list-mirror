Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65EA320248
	for <e@80x24.org>; Mon,  1 Apr 2019 16:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfDAQmP (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:42:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39995 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbfDAQmO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:42:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id h22so8846845edw.7
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0d5rHCR08h3INuVWEup1J2sCPqUBFPKSDff4Tx7amWE=;
        b=sc5A9ArXpMB7pakEKzZBw030jltQD1+M+WR37U7JJs/pNgY9OibKnAE7fU6wjePYot
         yJI1zXVBgbv/jDShB9XDriQjeWvK1MVKInjlwYBe6AVR2n86w6yj8G/rljoFYO4AYEYF
         GHQ4p9Fo1RqadB3/ZQ6wVd56Sb+WSsmUjbOUGZr2DqHsEmV1aZM1wt1f98hi9a29DE2x
         /Nsu4k92Z/YzgkYaQVTxr6rm0bU3yJX8iSRgNcWOqiu6qWJSzY/XAaZiX+mbi4d1q6pX
         0mJwkjs0koPmNGiYGbEmjy7PEsUQxSdWY3/z5EdvqKgpV3vgoDjWMliQ3/MN1ZTmdeMu
         21ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0d5rHCR08h3INuVWEup1J2sCPqUBFPKSDff4Tx7amWE=;
        b=ckaRk5Ra47oCmm20+DLkJxbBdr5CKf1y4Vp643fL7s9G/KEfDog2B1oMYbalzTCwXm
         6U40X8xcwuvPM+wY0XYnBCa7mqjcQqbkS3dEkm3Az9f8pIeyRl4HCljSRtKumxd6Aqi0
         Ng/gQTV+ChgrU1GSdyRT0bO7QrcToxJjb5q03YPHvkjVTZI1x+IXneWhQFLdN3CGS2rI
         uPUMj4IHd3lCB76ivo5oiQntyd/Gc+lvB285a69rZy68b8QRWK68QrIIKgnO2sF7hYrR
         I/uTjjah+cuxWAFn25HfW1qiBJtKZ6Re8WKndt1Nlx2wJzbVO3hBcHrPlNuy62vNan+O
         cfVw==
X-Gm-Message-State: APjAAAW3p/LgjGnEL40OA04GyB0OWZLLwc9R6tVb0gtvVm1Ic4vhf7dV
        q03zJqwn07cH9D8gBWRCovQ+vM9qEhlDO+lc0Qo=
X-Google-Smtp-Source: APXvYqyQwFjj+7Dv6CsoeN5OtZREoqwZy4FzX50QXJpb3KMfWqaW/DmSCARyclKqmMwq3F0o9MTjcs8VT3r1f1W8KeM=
X-Received: by 2002:aa7:d3d8:: with SMTP id o24mr45014598edr.53.1554136932027;
 Mon, 01 Apr 2019 09:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
 <20190312132959.11764-5-chriscool@tuxfamily.org> <xmqqlg1je6uk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg1je6uk.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 1 Apr 2019 18:41:59 +0200
Message-ID: <CAP8UFD1n9=DH-AA+7u10Xk=7Rs3Kq+Bn4AdyxoG+cu2_pOQKvA@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] promisor-remote: add promisor_remote_reinit()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 5:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > From: Christian Couder <christian.couder@gmail.com>
> >
> > We will need to reinitialize the promisor remote configuration
> > as we will make some changes to it in a later commit.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
>
> At this point, turning "initialized" into a file-scope static, and
> building reinit as
>
>         void promisor_remote_reinit(void)
>         {
>                 initialized = 0;
>                 ... clear existing "promisor" entries ...
>                 promisor_remote_init();
>         }
>
> may make more sense.

Ok, I implemented that.

> > -static void promisor_remote_init(void)
> > +static void promisor_remote_do_init(int force)
> >  {
> >       static int initialized;
> >
> > -     if (initialized)
> > +     if (!force && initialized)
> >               return;
> >       initialized = 1;
> >
> >       git_config(promisor_remote_config, NULL);
>
> The promisors and promisors_tail would need to be reinitiazlied and
> existing elements on the list purged.  Otherwise, after removing an
> entry from the configuration file, the entry will still stay around.

Yeah, that's in the new version too.

> >  }
