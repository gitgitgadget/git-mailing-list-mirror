Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8728C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 04:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhLGE0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 23:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhLGE0c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 23:26:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B8AC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 20:23:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l25so51503247eda.11
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 20:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=c2hWQb40HViyJgMTvNX3CWNC0abs2iiINVXtKWBMGzE=;
        b=AYmErYOZfAbDagHg4R7rLbYd/Ks9ws9HwFVD25MzDl+i4C3zGZRLBhQA36AoyOl1bv
         SpmnB7kdLCLqVeeMcc+XHrPW0zWtqW2pagkaMNtVVnRGshzL1r3u4mdaon9iVJmLfTp9
         hHF7euNUrHGK4SnXH9QUfD1p2cbvo7RtQ2fo746itXMe/RyhF0Pp/rvmCWRM1+1XiR8z
         FHXLA5EOGE9hohoolt5lZjTK7jlcW53VnB/jPjl9Va2FbLoovCv0xXwdocj2Eeatmzc9
         VvuWDFJrl/YfaCOdPer78CAB56hSjEi01/OwBKVPrbe1+IOIHA3P8+lF9LybtSMYwtRV
         kLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=c2hWQb40HViyJgMTvNX3CWNC0abs2iiINVXtKWBMGzE=;
        b=M6A8sGjmtkA7oAsQXStbO38sUc3DgKK9wo4zDIhGOAjritBZILdJafATlvyExekc97
         pCTQEo8j1Kg/EhjMEBpkjeom2OuGbAOT0rwsr28YykltNUt7sYhpgi+Fuzu570dyQ4Jt
         ZCN/k80iVn0kmsUwFw9M3bVW7vaCvyyYsKRbEUrg07Ahz7Kd/AuaQNQFlag4yrNoKj6O
         67ubGRUJ4O8h8w47SxjFw/EHuXpe/5SDjzK7toNUGZEyWOqtQiLgCT+QMuaUh8uLbpbb
         +9CrGs0iILpW5Wu0JKcgRrLv+2crhi78w+MpRLGjTiZsfkr+6eR4w8GxuQ4cgBjOco21
         eT0Q==
X-Gm-Message-State: AOAM530bcSUATOXrW7fGyU/pQKLaiFIitRqQC7k9ALTxw9FnGKRzL2kF
        +s9chYKzI9aEMnNB9LSOnZANC8N0TZgT/w==
X-Google-Smtp-Source: ABdhPJxn0PhvttbDy+6Sex1kYp2gVnkTuptZ1WQ3Axf/SaPwehruiyRoQz6aBPVN1PE//lBWYv4X5Q==
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr48566906ejc.357.1638850981184;
        Mon, 06 Dec 2021 20:23:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ht7sm7884675ejc.27.2021.12.06.20.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 20:23:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muS0K-0010bC-14;
        Tue, 07 Dec 2021 05:23:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Large delays in mailing list delivery?
Date:   Tue, 07 Dec 2021 05:20:18 +0100
References: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
 <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
Message-ID: <211207.86v901oxgc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, 3 Dec 2021 11:52:58 -0800 Elijah Newren wrote:
>
>> Are there some rather large delays in mailing list delivery these
>> days?  Anyone know who to contact to investigate?  [*]
>
> I've got E-Mail delays so large that I manually crafted In-Reply-To
> etc. to reply to this :)
>
> I'm 99% sure it's some weird thing at GMail, and nothing to do with
> kernel.org.
>
> When I've experienced delays (sometimes of half a day or more) both
> https://public-inbox.org/git/ and https://lore.kernel.org/git/ have been
> updated.
>
> Konstantin Ryabitsev notes (and would be in a position to know) that
> GMail throttles delivery (with an smtp 451 error?).
>
> But the other day when Junio sent out a What's Cooking and I saw it on
> lore, but it wasn't in my mailbox for some hours. That time I looked a
> bi tinto it.
>
> I went into the gmail UI and searched for rfc822msgid:$id, nothing. It
> was neither there on IMAP or in the UI.
>
> However when the E-Mail finally arrived I looked at the raw headers, and
> all the "Received" headers (including GMail's own internal routing) were
> within a couple of minutes of Junio having sent the mail (and in the
> meantime it went through vger etc.).
>
> So, I'm hazy on E-Mail infrastructure details these days (but worked no
> it in a past life), but that really seems to me like GMail in fact got
> the E-Mail, but it was just sitting in some local queue of theirs before
> it got served to me.
>
> Right now I can't see the mail I'm replying to in my inbox[1], but I can
> report the full headers once it arrives if that helps.
>
> 1. A search for:
>    rfc822msgid:CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.g=
mail.com

For what it's worth after it finally arrived the relevant part of the
headers is, which shows the issue Konstantin Ryabitsev
described. I.e. it was sitting for ~3 days between vger and GMail:
=20=20=20=20
    [...]
    Received: from vger.kernel.org (vger.kernel.org. [23.128.96.18])
            by mx.google.com with ESMTP id g10si21274138pfj.188.2021.12.06.=
17.50.50;
            Mon, 06 Dec 2021 17:51:02 -0800 (PST)
    Received-SPF: pass (google.com: domain of git-owner@vger.kernel.org des=
ignates 23.128.96.18 as permitted sender) client-ip=3D23.128.96.18;
    Authentication-Results: mx.google.com;
           dkim=3Dpass header.i=3D@gmail.com header.s=3D20210112 header.b=
=3DV2iU5Wyg;
           spf=3Dpass (google.com: domain of git-owner@vger.kernel.org desi=
gnates 23.128.96.18 as permitted sender) smtp.mailfrom=3Dgit-owner@vger.ker=
nel.org;
           dmarc=3Dpass (p=3DNONE sp=3DQUARANTINE dis=3DNONE) header.from=
=3Dgmail.com
    Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
            id S1343798AbhLCT4g (ORCPT <rfc822;bojan.kljakic.tech@gmail.com>
            + 99 others); Fri, 3 Dec 2021 14:56:36 -0500
    [...]

I.e. not at all what I alluded to above, and at this point I'm not sure
I ever really saw a mail like that (maybe I just misread the headers at
the time + confirmation bias, and I didn't go re-digging again now...).
