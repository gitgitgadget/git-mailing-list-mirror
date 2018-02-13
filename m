Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51F4C1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 20:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965696AbeBMUPh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 15:15:37 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:40071 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965610AbeBMUPg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 15:15:36 -0500
Received: by mail-it0-f66.google.com with SMTP id v186so7106761itc.5
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 12:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8N84gX6Ifmk4NNuSGAPjDHmoCp+rX8CNBE+/0UoyOMU=;
        b=btq+k1p8PdJh/xkhU8+cB4JXZ7AKJxryx9Jy8vAZFrf1F+4FmcJqBL00kP+pXgSlwU
         cQz7IZpKKcRKWipVaBsRZIZgihGJTIxjlCiB9rCkkIHPsVAXTp5hiEJWWI4VDhIjq8Lr
         a2VXJDpoEXKvCG44ACZ/zCogtRqANmRhAodLMfRbHaSkC6Yxd7rO+cHANu+N0SxJF98M
         azewy3mkx2ZLBw+e0tbMBl3wao/4nsrQAagZ9xaVwkkCfHNH3TkaAeGhNRJWR8+AqpsO
         XcbTJ5oRYjh365sBMoFVb70I+dMrH6ezQrBBxrVPMESVuQAJpHa+zyPW6YK5kS25SYUN
         OC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8N84gX6Ifmk4NNuSGAPjDHmoCp+rX8CNBE+/0UoyOMU=;
        b=tB+QpznfIQFQ9+J/6ygwXaYFi4arzSvnKhX+v3hCbvBU72dzoH8kxSUXlOo3u/w08s
         xu1HBDuiMyFDcI0Lg8Llq5Jqp5mSmPa1XFCOfqvFVHnTl5evB66Wp762hYw6LgGs27Q3
         leH69s3W96H85P3MVZvQJylJTBhLTh0lX0vXR2ABWrqTMNJywHvf5pYnc8w2tkXG5r1e
         NL2/Oe2gLOc8qSmz+sCnYItw9RA0cnRi9WHFLAO+zra2xKCUjIGBqRZwJ+dbpUK1+EcK
         bZDHdJUMBULXc+QWV7Gkq3sIXHoKBEOVa7YlB8XME1Uju5qaDbDg8XPXSVUYlBxI/XeN
         L7Rw==
X-Gm-Message-State: APf1xPBdSte81jmoWbARPAEHFF55RYaFMrKeLspKkZOTE86Vp+oslO7f
        yiiMbGRiL5QAVbGcvh6xfciRbA==
X-Google-Smtp-Source: AH8x226fk4cj5tKSCOGXoxz4R7Ywt6R3IaiGRCRf6TwUh6Q0+Hk5K6Rzp5aiVYXD0fzIHjdBYST66w==
X-Received: by 10.36.125.8 with SMTP id b8mr3081398itc.149.1518552936053;
        Tue, 13 Feb 2018 12:15:36 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m203sm304050ioa.30.2018.02.13.12.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 12:15:35 -0800 (PST)
Date:   Tue, 13 Feb 2018 12:15:34 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, l.s.r@web.de, stolee@gmail.com
Subject: Re: [PATCH v2 0/2] Refactor hash search with fanout table
Message-Id: <20180213121534.1c7b42109d40a9c41d0e8f0a@google.com>
In-Reply-To: <xmqqvaf0psrn.fsf@gitster-ct.c.googlers.com>
References: <cover.1517609773.git.jonathantanmy@google.com>
        <cover.1518546891.git.jonathantanmy@google.com>
        <xmqqvaf0psrn.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 13 Feb 2018 11:57:16 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
>=20
> > Updates from v1:
> >  - use uint32_t so that we can operate on packfiles of up to 4G objects
> >    (this also means that I had to change the signature of the function)
> >  - don't hide types
> >
> > Derrick: you'll need to slightly change your patch to use the new API.
> > As for find_abbrev_len_for_pack(), that's a good idea - I didn't do it
> > in this set but it definitely should be done.
> >
> > Jonathan Tan (2):
> >   packfile: remove GIT_DEBUG_LOOKUP log statements
> >   packfile: refactor hash search with fanout table
>=20
> Hmm, is this meant to replace the topic that was merged to 'next'
> last week?

Yes - Ren=E9 pointed out [1] that V1 of my patch series (which you merged
to 'next') does not handle packfiles of more than 2G pack entries, so I
sent out a new version. Yes, this replaces jt/binsearch-with-fanout.
Sorry for not being clearer.

[1] https://public-inbox.org/git/cfbde137-dbac-8796-f49f-2a543303d33a@web.d=
e/
