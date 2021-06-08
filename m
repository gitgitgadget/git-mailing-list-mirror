Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61261C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6FF6101A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhFHMlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhFHMlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 08:41:19 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A457C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 05:39:12 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h16so6687095ila.6
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ithar8kO/9JO7IMouF7RJHF8dDIJPlZJM3K5cNiAFdk=;
        b=TQxMpnzwU4jSRiPMhC04sUpRUJN+KuFtuhposxTWSsPkJxVzd0WrSrn5z3oHJbdrLE
         KCkQ5ADfeHvY61TOvlhGAxIoLMtjs83glX2ile3bpK2NteeqHsd2Uv/jMA81JKDrp6Zp
         pz9BpQLII0+Z85Nj4GJs0yOUdUNBRCFGq7fROB2WizjR4gdBzcMz5wLG1YhL66d1SX8k
         ZjVBIKWQdE33wYqS8AT6wgr6gODcLctb8GZ2CARKt52PysCd1nANFwHdj3aITXpg5IhR
         wozDy6oNn1GQHTlurHjtaOIUHCECeV60wkMAOPc6j6Jo4fpheRj2UxyALheHYjc/30I1
         3QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ithar8kO/9JO7IMouF7RJHF8dDIJPlZJM3K5cNiAFdk=;
        b=qqhJalUFvcPRwRc4fdDhcASVsFSCrImL+/SU89rbFc7pZFF9E3V4jT01CAGrHLEg9/
         X16ReOMmMpsmlclWS85kUSMD9oWiTDjHq+Y+K7p6F7lMGu1yPbSHq73pKo7idAaqKhYn
         C55aMSRuVcFDYF5ugJP2hSLV+LD1Kj3uI1SWeKaC8xTTgTpASDH4BdQev0XuiO19mD6P
         y+/oP+v2TRDv5g+7y02TBSnKfBUDurZUUi1wy7DAnmIy1zUEgjpx+ZfzYPIMWyYpkPY4
         C9N78sEV9pOSTmsTWhyswWaEyzFxgsfKT/0dyhIBq9pfUfwWKxXpe+HQMY2v8VtoBaKQ
         4yyA==
X-Gm-Message-State: AOAM533u9IVOKd9t8kkLAwpx4S76IdgdI7NyvAbOcHJ288CS/7kFC7h9
        +OlrYVblHLKkoU1n/58LWuEDd7xFltAcWXJ5zBc=
X-Google-Smtp-Source: ABdhPJxU6IvAujOegkI35On0CpIRfN7MlLeT1j6cMTvDmk6n+38x/dKjLpKA7NTSXOOVuC9t8HFPwBcCb1RmaibWiaM=
X-Received: by 2002:a92:b0b:: with SMTP id b11mr19413012ilf.301.1623155951473;
 Tue, 08 Jun 2021 05:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
 <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
 <xmqq7dj6w7a6.fsf@gitster.g> <CAOLTT8S+5m+-XF-AcQi9t8njTvyDYzHt=BU+4OPcvTT27RP6dw@mail.gmail.com>
 <CAOLTT8QE7pafPmhnz-6=5zuyjg9n1FNbu_k6bA80jE1e5vYCmQ@mail.gmail.com>
 <CAOLTT8TSue=Cx8xos20vnGSi3oOd8+=jTfTw2h82gXmmd4KyLg@mail.gmail.com> <xmqqk0n4q1t6.fsf@gitster.g>
In-Reply-To: <xmqqk0n4q1t6.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 8 Jun 2021 20:39:00 +0800
Message-ID: <CAOLTT8Tve8woTGsgWMpYb=adesMx8UzSVpCnK4xPV9-6agzQmA@mail.gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:59=E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > If we actually delete "--rest", we will have no way to test %(raw:textc=
onv)
> > and %(raw:filters)... So now I think we can keep --rest (or use
> > another name --path)
> > and let "git for-each-ref" family reject %(rest) by default.
>
> I didn't read beyond the %(rest) thing, but do we even need
> %(raw:textconv) to begin with?  It is totally useless in the context
> of for-each-ref because textconv by its nature is tied to attributes
> that by definition needs a blob that is sitting at a path, but the
> objects for-each-ref and friends visit are mostly commits and tags,
> and even for refs that point at a blob, there isn't any "path"
> information to pull attribute for.
>

After thinking about your words, now I think maybe we can leave
%(raw:textconv) and %(raw:filter) after cat-file --batch start using
ref-filter logic, so that we can provide them with suitable tests,
and we don't need `--rest` anymore.

> Is that what you want to add to give "cat-file --batch"?  Even in
> the context of "cat-file --batch", you can throw an object name for
> a blob to the command, but there is no path for the blob (a blob can
> appear at different places in different trees---think "rename), so I
> am not sure what benefit you are trying to derive from it.
>

So I will remove the last two commits.

> Thanks.
>
>

Thanks.
--
ZheNing Hu
