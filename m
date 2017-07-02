Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2FAD20209
	for <e@80x24.org>; Sun,  2 Jul 2017 04:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750732AbdGBEZe (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jul 2017 00:25:34 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34605 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdGBEZe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2017 00:25:34 -0400
Received: by mail-io0-f181.google.com with SMTP id r36so41043659ioi.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xG5tT/8Kg0+mOnee1cTDBeVyVA58Ma+2M2J38cg+bMc=;
        b=af5FV4fxnSpazOgGKTaJQL/Ygch+KR4cFV/CUHoOincssXjCRjS7QK4Wtw68o1L9k+
         hAmQIls9MiH1FSnvSSMRI5kssQOht9BEjvgczubNmBUautS3QZMRbO5mFOXLjjw3jL8q
         /OCMwLr+KVhBRBs0YMoCWs0GJZ/TxhBcv9r4H9If++DdUtIE2X0UhCPEiUfdpBckRUZ3
         ACgIiAnIKuRnMrsiRyYf5tHqEmvrnWxa0fZZo+b/dCz0TJgKOUCLbo+ck4t/+Kt0pcoF
         cKlbvawv3dV2eh7iqYw/ctpJS+k9e0y2oTZaBTcD2I0lSaZMtaSnJgRUIcNckMACJUpF
         wfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xG5tT/8Kg0+mOnee1cTDBeVyVA58Ma+2M2J38cg+bMc=;
        b=jIjQpc2x4chgVQ8aQuyunQGUfofk9pzqCfRYN2tUQMzpLwMjuzslp0yOdSzU1lKtme
         uB23GEogjGIcRKbBg8+Q3+uwnBiym2F8Dl1JUQ3ADd2Y5++S74dkbzNC5Jn0XmdB7dnM
         qFQTQATfKoF2YRg52xFzvev6zzp/6w/J4TVPug7HF/4xx+KunhklaRGDLSGJKW3uJVQg
         ESfiKgPsadQ3peky3fPG3ziwXI0JXHUYU9Ei1VnIpmlXiDCnMuvHzya0pnJVetNWr4Q6
         rLTGar9+O7KjXnhzcYyAOog8sWN9ofsXZ1lB7ekI4vamWyinMyLqPye9l3WR5pDo9Prp
         TpSg==
X-Gm-Message-State: AKS2vOzSGphPdGyXoDWiSjeETkOJb6cjggypLAsui73ZvZDhVgfWHclX
        RhZ+VDqQtiumRwiuaDwc418PP2soVw==
X-Received: by 10.107.41.4 with SMTP id p4mr27744673iop.126.1498969533101;
 Sat, 01 Jul 2017 21:25:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Sat, 1 Jul 2017 21:25:32 -0700 (PDT)
In-Reply-To: <xmqqtw2vnbho.fsf@gitster.mtv.corp.google.com>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
 <4be750af-b093-6644-7f0e-82983327766a@gmail.com> <CAP8UFD2hghBePr-WVLiA6P0rS5=JPLmsxqJ_6rEWrqG3VEd7Dg@mail.gmail.com>
 <xmqqtw2vnbho.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 2 Jul 2017 06:25:32 +0200
Message-ID: <CAP8UFD3YPXRDc8ThSuTWjKDQ2i+zqNrhBi6JfEuTPXnNA6LUiw@mail.gmail.com>
Subject: Re: [RFC/PATCH v4 00/49] Add initial experimental external ODB support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 1, 2017 at 10:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>> I think it would be good to ensure the
>>> interface is robust and performant enough to actually replace the current
>>> object store interface (even if we don't actually do that just yet).
>>
>> I agree that it should be robust and performant, but I don't think it
>> needs to be as performant in all cases as the current object store
>> right now.
>
> That sounds like starting from a defeatest position.  Is there a
> reason why you think using an external interface could never perform
> well enough to be usable in everyday work?

Perhaps in the future we will be able to make it as performant as, or
perhaps even more performant, than the current object store, but in
the current implementation the following issues mean that it will be
less performant:

- The external object stores are searched for an object after the
object has not been found in the current object store. This means that
searching for an object will be slower if the object is in an external
object store. To overcome this the "have" information (when the
external helper implements it) could be merged with information about
what objects are in the current object store, for example in a big
table or bitmap, so that only one lookup in this table or bitmap would
be needed to know if an object is available and in which object store
it is. But I really don't want to get into this right now.

- When an external odb helper retrieves an object and passes it to
Git, Git (or the helper itself in "fault in" mode) then stores the
object in the current object store. This is because we assume that it
will be faster to retrieve it again if it is cached in the current
object store. There could be a capability that asks Git to not cache
the objects that are retrieved from the external odb, but again I
don't think it is necessary at all to implement this right now.

I still think though that in some cases, like when the external odb is
used to implement a bundle clone, using the external odb mechanism can
already be more performant.
