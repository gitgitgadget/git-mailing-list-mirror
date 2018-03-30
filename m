Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478CE1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeC3TGa (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:06:30 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:44760 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeC3TG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:06:29 -0400
Received: by mail-yw0-f174.google.com with SMTP id z21so3212032ywg.11
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 12:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QcJzbpXRnHVHzY4yURin5XbBRnGgd0YY7jI26DgnOOs=;
        b=CryZWxi8nS9js90C0OXpNwlvaj7YT6ehvqZ+8cXeDCmjNbDKEP5mJnUtM3jezAT9l0
         KsXdSh/J3kZK3CCxJTtGrXF8Nbu4eDzfRF9uYfEw+5OuLs254ebcoX08WxP9enON69po
         yZFpaEZiBxja5ijfJpTY4tpYHPJwzQtqzjXrT+iBKnBqZ1dca9NqPqcSq8/dsISf5FGi
         yANIAPpuGBFIAktFsL08XF/IZkvqSa4LH4nhA5DfkUJzShDeKsXRjj9UJjTmOgMPpfFT
         kP0QJjml+hI0KGZfQS3gaaFR5rojW7bQX8iaG8QbmV+CwBGusbblNJcmb1uRSlsTIpHy
         +GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QcJzbpXRnHVHzY4yURin5XbBRnGgd0YY7jI26DgnOOs=;
        b=JRrO9jOwhejIiV2+swrmIcK3HcEXhLYh85a2q+7qr8rklgIJkb44CRo2qybDatvXGi
         hG19fjLqDcjb7t7aGmfxdf0hFzGwkXsycP3b9h5dWQNyfeSu0jn+Mu05p4rBTtjhuLp6
         F9AwAdrsCC2ZMj5wK1BHZrcGadTsihb1Tauqca01my1MydFzQ/A7o2QNloIUTeZdz/+V
         51IS2gBqSiPdayWrp8udWcOMB+0YbAxkbvD81Qywr1BtYP15XJLiS6WG9RNrZcGEQzbo
         j/J3NXPoqiBYHHgltvPkYdHI0nUAUT0bhkwLmOFeWW22ih9zl7tj393wh8xyZMxYGK6n
         MecA==
X-Gm-Message-State: ALQs6tChzV2M7QPfU1juEHZ3BXDFL167l39bbmsp/JLUiZkSdNSByS3e
        ZMHx9DEN/n0lMw62VOHjGdehaAvvWbv7C2pTr4Vuzw==
X-Google-Smtp-Source: AIpwx48dW+pve956aFQEyHbD68FVDRyDPkv25lw/CNfqy+zsK+isQpkRFy2ANVVgmAMdHAjlii0lNfP+aQcsZ/Tv8DE=
X-Received: by 10.129.86.5 with SMTP id k5mr107212ywb.345.1522436788375; Fri,
 30 Mar 2018 12:06:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 30 Mar 2018 12:06:27
 -0700 (PDT)
In-Reply-To: <20180330190343.GB171603@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180330092907.611-1-avarab@gmail.com>
 <20180330190343.GB171603@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Mar 2018 12:06:27 -0700
Message-ID: <CAGZ79kaS834w1OjGpr9CzLNKcZ50p3jpaMaRxUKWHkvcF6-LoA@mail.gmail.com>
Subject: Re: [PATCH] {fetch,upload}-pack: clearly mark unreachable v2 code
To:     Brandon Williams <bmwill@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 12:03 PM, Brandon Williams <bmwill@google.com> wrot=
e:
> On 03/30, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change the switch statement driving upload_pack_v2() and
>> do_fetch_pack_v2() to clearly indicate that the FETCH_DONE case is
>> being handled implicitly by other code, instead of giving the reader
>> the impression that the "continue" statement is needed.
>>
>> This issue was flagged as DEADCODE by Coverity[1]. Simply removing the
>> "case FETCH_DONE" would make -Wswitch warn. Instead implement the same
>> solution discussed for my "[PATCH v2 18/29] grep: catch a missing enum
>> in switch statement" patch[2] (which never made it into git.git).
>>
>> 1. https://public-inbox.org/git/CAGZ79kbAOcwaRzjuMtZ_HVsYvUr_7UAPbOcnrmP=
gsdE19q=3DPrQ@mail.gmail.com/
>> 2. https://public-inbox.org/git/20170513231509.7834-19-avarab@gmail.com/
>
> I understand why you want this change, but I dislike it because it
> removes the ability to have the compiler tell you that your switch
> statements are exhaustive.  Of course it should be noticed rather
> quickly by the addition of those BUG statements :)

I think coverity doesn't flag empty sections, i.e.

    case FETCH_DONE:
    default:
        BUG(...)

would do for coverity. Not sure if we want to add a /*fall thru */
comment, that would aid other compilers to not warn about it.

This would cover both the compiler as well as coverity.

Stefan
