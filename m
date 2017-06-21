Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7368E20401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbdFUVXW (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:23:22 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34756 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbdFUVXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:23:20 -0400
Received: by mail-pg0-f48.google.com with SMTP id e187so29816786pgc.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y1aPSayewT5ESTX1uDBslxXHuq7HeXbkzoHwM+I6Y/U=;
        b=s2mFPi9eOxQNxbvUh/i/36Vt9E0HN2Mq8ySN0PFWDombZhrDk+cfRNlGXADtcQuSQE
         OBq8stU/gXn6k7s5hgvh+VndiMXHcdbmbInEGijYhbriqkHpOujlQPrjnH8281aruB4E
         xX5ZK7zfKCdd4nkNrJCfXhfoX61OqnAJl6hD60mdDRG0BzV2oYPQFlTiPLur4NUcLv5b
         Kk1pTTx7wA3Psa7VoQPVjw05b0jNpU7BuxMexUsrCp28EKsBsn2ZnP32sEjb3y2z6Xay
         0bm2MxneI1Fhx+jIIwNfWQLU7ylbTifwC33qOfTPA6tlufZG+B5i322IWdD1Y9vBKHGh
         6Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y1aPSayewT5ESTX1uDBslxXHuq7HeXbkzoHwM+I6Y/U=;
        b=SomtI+1uXv04ZeBSXJc+Up45Dj/Qpy5u+Jh/bBk6/Y5x8Crwqvc8VrhoXraEWqdXqO
         aOMcSpy5hXT/ApLAQKPI6okjduguflf7jNL3WHbSWyInvLLlaABzJ+sqzuOzlhawf2yt
         lRCBk/3Gs8QZVVDLKm3QS695+0r22w9ZUXq8gcpTrq/+c5iDI3iXnOgsc8w0N3nZJI18
         j/nTEmfc3A/XklqGPTd2iCMpsFTZVCWaSg5pPqw8o0vHBMT3qRI8gbyjO/jlyOukL6jh
         xSzgeHb36J/G1i9vaT2TCebR0l7PRq7l3JRpm5MfG/U/zRvMwK+iVSdnqC4eO2gjPSp2
         6tHg==
X-Gm-Message-State: AKS2vOzK4V+c+al3Eew/fOAEUgsVeu7HlHdLBszXI+BUBEIhwLBH+ooQ
        cPNz4kqxAI4GbQgkKvbqUmkj0qCmx0AP
X-Received: by 10.84.131.101 with SMTP id 92mr40785915pld.279.1498080194737;
 Wed, 21 Jun 2017 14:23:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 14:23:14 -0700 (PDT)
In-Reply-To: <xmqq7f05niwt.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-5-sbeller@google.com>
 <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com> <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
 <xmqq7f05niwt.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 14:23:14 -0700
Message-ID: <CAGZ79kZnDdtB6O5jnt7ouG-qoOS90kZALqZB_-gOT0OQcJzvRg@mail.gmail.com>
Subject: Re: [PATCH 04/26] diff.c: introduce emit_diff_symbol
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>>
>>>> +enum diff_symbol {
>>>> +     DIFF_SYMBOL_SEPARATOR,
>>>
>>> Drop the last comma from enum?
>>
>> I looked through out code base and for enums this is
>> actually strictly enforced, so I guess I have to play
>> by the rules here as I do not want to be the first
>> to deviate from an upheld standard.
>
> You sound like you are trying to find an excuse "not to play by the
> rules".  Don't.
>

When the rules are not yielding best results, adapting the rules
should be considered. And having no comma at the last element
produces review noise when working in a line oriented format, such
as diffs. (Add another element at the end, and then you have to
have the diff that just changes the comma)

  C99 allows a trailing comma to follow the last enumeration
  constant initializer within an enumeration type declaration,
  similar to structure member initialization lists.
  C99: =C2=A76.7.2.2

  For struct member lists we already do that, e.g.
  builtin/help.c: struct common_guides[]
  builtin/repack.c: struct exts[]
  ...

Yet, I will construct this series in a resend to not
have this issue.

Thanks,
Stefan
