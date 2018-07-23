Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB3F1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbeGWT0O (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:26:14 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:44759 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbeGWT0O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:26:14 -0400
Received: by mail-io0-f175.google.com with SMTP id q19-v6so1331571ioh.11
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aq/kjFxYTyvecbPu1RP6pjsxwuF570Gh94smZp9FkOM=;
        b=D709h+WE/X7jDpi7HymeNuUQDzd+IuRgc0YQo4pzzXVjvtPSrn1iAcINp49KpPvFKk
         7oyZ2G1YDhu6bPfXoYZ09fQIRlrgOUiTrPt5l82CHp8YNfwKVJ72iWOMTARKxKJRnh8+
         1vA/0r8qO5UFGDeEJyuAMrTNBmGU24Iz/DU3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aq/kjFxYTyvecbPu1RP6pjsxwuF570Gh94smZp9FkOM=;
        b=reTuPKhemdnhItYYeQowcwdmCi2Npd6p+Tp/MP1d74RzxNnsDrIZmlQbiP48PjLBaV
         0VJmcq7mEbanB/m8gsX6DruJIAsvUGyq7MoYbo51TJ624d6XcBm9h2+mNBtX+Y6xFkII
         fRM3QXYIdCvbyBAV9074VbH0kSZcpw3r3BOcAQZXJnhsZfjNuwlvZ/QzB6ELseeWnoyg
         ei4t4x/KyeiKY/hBRtSTyrl0RYwJWwebW39e2MBauGRTbjzs7Vgh5Si9+xh2ZAvrymSh
         +7VZFHqbp4pRs2ODFIhffAnolHEqwzYSefk2sEjR6kTDA4Cwxlkp8jP8pvNQhxxK8/La
         HFng==
X-Gm-Message-State: AOUpUlGbym9haG0ZkAu8kH+q8MfDBAtBN5y/Q0NU1P7kOW7Lc0zzIWmt
        P1kkzTY1jUh+blRn7IXGtKBXZXNhWrgtY7VRAlE=
X-Google-Smtp-Source: AAOMgpdhHT3avkJaH2wVBiTCfo4YBjM4x3KPUC5jJJZ9yNNsYLKpO4L4ZXXTMzbOsYQEPYhim6MwiHK1NL3ffP9BcJU=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr11391380iom.238.1532370225987;
 Mon, 23 Jul 2018 11:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net> <CANgJU+X39NoEoMyLu+FX38=x19LrRqatz_dUpUAc+WFV+Uw+=A@mail.gmail.com>
 <98111891-a605-1cfd-e92b-a3b5b4186ac2@gmail.com>
In-Reply-To: <98111891-a605-1cfd-e92b-a3b5b4186ac2@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Jul 2018 11:23:34 -0700
Message-ID: <CA+55aFx876XPwdSqRsKDk+Vo4pD-0wVRx=E+SAN6JiZKWUMrHg@mail.gmail.com>
Subject: Re: Hash algorithm analysis
To:     Sitaram Chamarty <sitaramc@gmail.com>
Cc:     demerphq <demerphq@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Adam Langley <agl@google.com>, keccak@noekeon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 5:48 AM Sitaram Chamarty <sitaramc@gmail.com> wrote:
>
> I would suggest (a) hash size of 256 bits and (b) choice of any hash
> function that can produce such a hash.  If people feel strongly that 256
> bits may also turn out to be too small (really?) then a choice of 256 or
> 512, but not arbitrary sizes.

Honestly, what's the expected point of 512-bit hashes?

The _only_ point of a 512-bit hash is that it's going to grow objects
in incompressible ways, and use more memory. Just don't do it.

If somebody can break a 256-bit hash, you have two choices:

 (a) the hash function itself was broken, and 512 bits isn't the
solution to it anyway, even if it can certainly hide the problem

 (b) you had some "new math" kind of unexpected breakthrough, which
means that 512 bits might not be much  better either.

Honestly, the number of particles in the observable universe is on the
order of 2**256. It's a really really big number.

Don't make the code base more complex than it needs to be. Make a
informed technical decision, and say "256 bits is a *lot*".

The difference between engineering and theory is that engineering
makes trade-offs. Good software is well *engineered*, not theorized.

Also, I would suggest that git default to "abbrev-commit=40", so that
nobody actually *sees* the new bits by default. So the perl scripts
etc that use "[0-9a-f]{40}" as a hash pattern would just silently
continue to work.

Because backwards compatibility is important (*)

                     Linus

(*) And 2**160 is still a big big number, and hasn't really been a
practical problem, and SHA1DC is likely a good hash for the next
decade or longer.
