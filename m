Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6365C1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 18:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbdBFSbs (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 13:31:48 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33607 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdBFSbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 13:31:46 -0500
Received: by mail-lf0-f49.google.com with SMTP id x1so49723539lff.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 10:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2JD2lRGzF5xMUJUFxSdCJzsNBCLTcTLEmWN57yKc2Cc=;
        b=WR0lSJg3je6qaKsvkO+pU5zIZCGbFk9QL01HmvJC12eBmP52p2tFUwErGJGlOFB87/
         5DAkx39dVly4vsR0+oNXYj8J4DuLQvMhhzbJ6dDTTpxUkqMSpBRji4XjigXoV7UsgBN6
         YAkRISvWwu1KLuOjWGjiETEWRv0HwR4i2jVoXrFOIB+7SY1wKxBXL4OivUR62A6HQPwB
         Lc/93InKpD5eelndw1NMSLIYPshNtFihLhXaPQzpWJlalmA+FWVECfdcq+RyNC7fGDmW
         Hc4QEGLUPWB722RoQeoyZMJ1eLksQGl9BCOT4ti87jwz2uHjMO26I9s9BUlaQF9DGybs
         Z7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2JD2lRGzF5xMUJUFxSdCJzsNBCLTcTLEmWN57yKc2Cc=;
        b=H8RdjF6p8vzaPhry3CdRWI4xZcj5KY9qavdjxjFC7j4oW5z7Kx636qGR12SFbCyHvR
         RU3DoTaRlbfwvlV+M6C/eEi/J4LaoZtmIYXF0TxI7qM0VM62XAydYT6yEV/mRhmN/Q/V
         6gkvu+K2c7HBpQr1YEQMwImUqp0E0RjCQf8cSabfyTOXANaPquXS4bfFHi6qt8sDkXnZ
         vNrk8RE/MoLSOKNLdfuFPC7sBfyhsOua0O4V9qMewEuP6jej+362kitm3yNM4VAPeXgK
         lAAJ+E3p43pvGv7g1RFG5AYYZFEHy/fuJuLsKxhaNhDVALsp/L/KjZo0J+fRIbxSNWbC
         4n3g==
X-Gm-Message-State: AIkVDXIsobiPggNervJ7ntXjjYJsTD8I3aUwWTjK7RfUIIh/ZvrW6oB9ZWgQSZlLPVspj41DAc5buz1eSm7Wkw==
X-Received: by 10.25.79.79 with SMTP id a15mr4331007lfk.58.1486405905037; Mon,
 06 Feb 2017 10:31:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Mon, 6 Feb 2017 10:31:24 -0800 (PST)
In-Reply-To: <CA+P7+xpeyebN3pmSX09Avh1EvYVjALpBCQ9r2==q3SWTu3GMSw@mail.gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com> <CA+P7+xqhjVQMXtO4gtQ_2VAVd3qrpVLncH6YpFHreVV2mHORxg@mail.gmail.com>
 <CA+P7+xpeyebN3pmSX09Avh1EvYVjALpBCQ9r2==q3SWTu3GMSw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 6 Feb 2017 10:31:24 -0800
Message-ID: <CA+P7+xrAVM8C1dnEaY1VnTUwiCzoMzh+rbMqBknyBG27grs-uQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] completion: speed up refs completion
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 3, 2017 at 7:15 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> I haven't had a chance to further investigate, but I tried this series
> out (from your github) and it appears that this series (or the
> previous series for __gitdir work) breaks "git log" ref completion.
> I'll have further details when I am able to investigate a it more.
>
> Thanks,
> Jake

At first I had the same problem, but I verified by re-installing the
completion script and the problem appears to have gone away. I suspect
what happened is that the original time, I forgot to actually install
the new version of git, and only installed the completion script, so
when some of the commands were run with new options they (silently)
failed and the result was missing completion values.

Once I properly re-installed everything it appears to work as
expected. I haven't found any other issues yet.

Regards,
Jake
