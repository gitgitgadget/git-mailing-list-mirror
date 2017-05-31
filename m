Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BDFE20D0A
	for <e@80x24.org>; Wed, 31 May 2017 09:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdEaJe0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 05:34:26 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33121 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbdEaJeY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 05:34:24 -0400
Received: by mail-vk0-f68.google.com with SMTP id c185so572424vkd.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=abRoRU0pohu2gR9awAhVGKzxrFrgEPAStqzvmP3T9BA=;
        b=jC/cnbtySjCpx/1JfRYmlzDm7JgNGaVX7Bvd3nWTb1FQdG7WIDm/g7spFHCKwG/XOg
         8EbP0LgkLLHDtUYSuHtksj9Xm1+mPnlEYZt8ALuzTyx6jViwS1/Gg8zTad5azvAmV/lA
         89I6ih1IXP/E6hCgjPky6xCW5fHexn1Pc79SLRHcqMKctktylzdOb38DPhNx1qeH9Ex/
         jVYbHTaKnlaA/oneX7SZWDk/SEtbku+Iw5aSPDTOkUpavWkYJ1pbmxppa+nM0/ov12qc
         IaRG6pPdYV83iR/hu+CzKKRMKraaOuMModPDwNasgIbeXQUsoTPSkgHtqOyPWicD26XR
         ogAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=abRoRU0pohu2gR9awAhVGKzxrFrgEPAStqzvmP3T9BA=;
        b=hOYUtUXS5KXARgPO1ZBIKpl5uHlVIcQY7P+Qq5r9UjbGe3prKTukyqNro+dndinU3c
         VP8RjvFnqYqOuORSM+Mn3bMBR3gzzUPHpAdjGEDxITBedFWOuCo89KbFs3M4JVU9Hxq3
         2wHNupAVuzux/iISKy2pzaTE7Nx23DgpDtUYCd/bO2bgkJe+fOZEI25jCqnf0R3fMeLc
         u+SuCngWylvjCyh2kGiyXghLvFQR9cJnI1dJQyiqQWMGhRsSRR17PAGQfTOfWgQ8DwzQ
         Pq9JXtmrO+aKzfxUuS4V+ho4mDtOA/t9AEqOPfsUTx4WPPUiXOn+KRIaqggAJpX6CEXV
         swig==
X-Gm-Message-State: AODbwcCGawciO+JllspwL2WbtzyHA1/rVWrXERUubP8J4TeipvI9aiwb
        je5b3ZnL386dS3TVWaNYxwmaaSt30g==
X-Received: by 10.31.176.1 with SMTP id z1mr5638322vke.151.1496223263682; Wed,
 31 May 2017 02:34:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.82.57 with HTTP; Wed, 31 May 2017 02:34:23 -0700 (PDT)
In-Reply-To: <20170531042304.unkxkuw6s3tcpzkm@sigill.intra.peff.net>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com> <20170531042304.unkxkuw6s3tcpzkm@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 31 May 2017 11:34:23 +0200
Message-ID: <CAM0VKjkfuyBzZmpJL47xmK24EOh6X5OjrxtxVdsgGupAseT_wQ@mail.gmail.com>
Subject: Re: [PATCHv4 1/2] clone: respect additional configured fetch refspecs
 during initial fetch
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 6:23 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 30, 2017 at 09:12:43AM +0200, SZEDER G=C3=A1bor wrote:
>
>> diff --git a/remote.c b/remote.c
>> index ad6c5424e..b8fd09dc9 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -626,6 +626,19 @@ struct refspec *parse_fetch_refspec(int nr_refspec,=
 const char **refspec)
>>       return parse_refspec_internal(nr_refspec, refspec, 1, 0);
>>  }
>>
>> +void add_and_parse_fetch_refspec(struct remote *remote, const char *ref=
spec)
>> +{
>> +     struct refspec *rs;
>> +
>> +     add_fetch_refspec(remote, refspec);
>> +     rs =3D parse_fetch_refspec(1, &refspec);
>> +     REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr);
>> +     remote->fetch[remote->fetch_refspec_nr - 1] =3D *rs;
>> +
>> +     /* Not free_refspecs(), as we copied its pointers above */
>> +     free(rs);
>> +}
>
> What happens here if remote->fetch isn't already initialized? I think
> we'd end up with a bunch of garbage values. That's what I was trying to
> protect against in my original suggestion.
>
> I'm not sure if that's possible or not. We seem to initialize it in both
> remote_get() and for_each_remote(), and I don't think there are any
> other ways to get a remote.

The only place creating remotes is remote.c:make_remote(), which
calloc()s the required memory, making all of struct remote's fields
zero-initialized.  In case of clone the common case is that the user
doesn't specify any additional fetch refspecs, so remote->fetch will
still be NULL after full initialization and when
add_and_parse_fetch_refspec() is called with the default fetch
refspec, meaning we can't 'if (remote->fetch) { parse ... }'.  OTOH,
all functions involved can cope with the fetch-refspec-related fields
being 0/NULL, and at the time remote->fetch_refspec_nr-1 is used for
array indexing it's not 0 anymore.

> (In fact, I kind of wondered why we do this
> parsing lazily at all, but I think it's so that misconfigured remotes
> don't cause us to die() if we aren't accessing them at all).
>
> If we assume that the contract that remote.c provides is that the
> fetch fields are always filled in before a "struct remote" is returned
> to a caller, and that only such callers would use this function, it's
> OK. It just seems more dangerous than it needs to be.
>
> -Peff
