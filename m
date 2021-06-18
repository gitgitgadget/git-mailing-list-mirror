Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F496C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 08:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B0F610EA
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 08:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFRIJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 04:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhFRIJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 04:09:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D371CC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 01:06:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hv20so8483161ejc.12
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 01:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qn+r6Y/2Rr4xa+9UhmM5F+RvFL+my5Llsn+DA/IEGbc=;
        b=QzaOESka0IWz+MiOumZs0P5K8kOMtbxrXzC/4PaLqFBFyOlGY4vxO+8ExiZiON2iuL
         iQBEmDhdBZECcSHOeBMmqykDOZUB4UzBMbQHAT0HUznsNWMxtbdiIuxh9lgNfcNhe6Cp
         tLkfmiYrFF5NFxH54khht5047sbRdi+Ud0Q2wcw7f1d1iuK2snvSUxK5L7s/CYj7ppl+
         k1Sc8FXTJpgt+A2+nCyEtvPcDuxPKokLeJrEfJ6Vjkg9wW0VdqxEHBsW2tWMUciauVX8
         a99nWvUJeoUPYLycdo9iVXYxZtNfNnnHYsaWOppU/45ZVM2CyDhtDywE6h3HdLxFP031
         iGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qn+r6Y/2Rr4xa+9UhmM5F+RvFL+my5Llsn+DA/IEGbc=;
        b=faDWOt4wIqauZUZuHulu3GeJULzxudh++RojvO8YH+mO2MWMerS9WJtTeqYiwj9BMr
         3nQc0e8PPw/a23o4/CZAM1g/OKItv/Ilt+pG6HiVoTeHnjvUhppmRXqL3tbHf4IpQNc9
         95TobfthrTHBBQJDKAPiRZiYItq/5/oCgG6v3ZCG5WZ5eRF8FSj6F06Xd0YatDiRXtpE
         OLbC6QneFpGRZ6NMIKHA7lzZTpD6aRCgqBnH3TcxZiDs0TRr8wA8by3d/CyhNFv5c9FY
         +TgF43r43HxxVPTB5m7ZFXFeSmV3MGatD4UyrfDvza2TYZ7dce18m8luR4Msj81LvZpP
         maBw==
X-Gm-Message-State: AOAM532x5LQ4f/GFSQAzThZE89iQHH7gjvwi729blRiFN2Jm8X74UZIO
        urhvZm+Fw1uXMaUGpi/WBRg=
X-Google-Smtp-Source: ABdhPJz4/uQOxJK4wFoJUGd59KdlY6b86qBQ4Mj+y4sVvFEgKyD9wx7F/ZJ2PIxiziQX3ydHZhLwaQ==
X-Received: by 2002:a17:906:b20d:: with SMTP id p13mr6805026ejz.519.1624003609345;
        Fri, 18 Jun 2021 01:06:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m7sm5774291edc.46.2021.06.18.01.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 01:06:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Makefile: stop hardcoding {command,config}-list.h
Date:   Fri, 18 Jun 2021 10:05:33 +0200
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
 <patch-2.3-6e164edb0b-20210617T095827Z-avarab@gmail.com>
 <60cbad11b13f5_9bf20896@natae.notmuch>
 <87zgvo435v.fsf@evledraar.gmail.com>
 <60cbc56c92b4_1299208f6@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <60cbc56c92b4_1299208f6@natae.notmuch>
Message-ID: <87tulv4mw7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 17 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Jun 17 2021, Felipe Contreras wrote:
>>=20
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >> Change various places that hardcode the names of these two files to
>> >> refer to either $(GENERATED_H), or to a new generated-hdrs
>> >> target.
>> >
>> > Avoiding hard-coded things is generally a good idea, and I can smell
>> > there's an advantage nearby, but it's not stated.
>> >
>> > Can you spell out what you are trying to achieve?
>>=20
>> It's hinted at in the CL,
>
> Yes, but the commit message should stand on its own.
>
>> but this is series 1/3 of a re-roll of the
>> base topic for config-based hooks, real use of this is made in step 2/3,
>> 3/3 has a better overview:
>> http://lore.kernel.org/git/cover-00.27-0000000000-20210617T101216Z-avara=
b@gmail.com
>
> Yeah, I read the cover letter afterwards, but I'm just putting my
> reviewer cap; the rationale belongs in the commit message: we will want
> more generated files in GENERATED_H.
>


Thanks, I'll reword it. I initially figured in this case it was better
not to distract from a stand-alone change with what inspired it, but
will do.

> Also, I presume you meant this one:
> https://lore.kernel.org/git/cover-0.3-0000000000-20210617T100239Z-avarab@=
gmail.com/

That's 2/3, but yes. That comes after this one. I meant to link to 3/3
to give the general overview of how this relates to that re-rolled topic
at large.
