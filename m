Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE498202AF
	for <e@80x24.org>; Thu, 16 Nov 2017 10:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934130AbdKPK4J (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 05:56:09 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:51011 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933968AbdKPKz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 05:55:56 -0500
Received: by mail-pf0-f194.google.com with SMTP id u70so14543642pfa.7
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 02:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u4gK0bNacnUpc/8NjHvb6npoyU0OEXz111YR3yN5Aqc=;
        b=F64KmI4wS6jnrrDbiZucVvsdOeCN+H+UC0AFXaTG1Czl2tA7lu2oD2vRQUsKoq2UUM
         5bUUHCo6apMNy5ZPZHoHZRz7pzuCw1q3rur2dIokv68/MbLp4ipa0vGQvLgGl4d1DLli
         CemaBf4OeqEdeHl9V7W5DBDi8E8YGJOc9ZiCzryjV+fYV344Uet7n+JalTvsE3UzwfOn
         uhs6WQn4m2b7CXAtQHnTKBxJ2WhT1GX5Moerj8O5uqzX1xt37VWckoHAe8oYfJ26W+c7
         D7TeVuRyp+X8LnS84huF2qyrouwECt9PljTn51jVLvDm8FsFkyCpaXUEkbtUZvN1iRYI
         bgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u4gK0bNacnUpc/8NjHvb6npoyU0OEXz111YR3yN5Aqc=;
        b=RN3ZKgR4i3xmlM2e/+yJdk4mTFiFpCOz9PbuoeJ3M84THDcudZrJA9R0znXamjjTD+
         767NvVqiM1/CWxB/9JAEgSItrPbA5ZjgZNW1766ge/KyRdzkJQ49YOyFKaOQ+jpvBPpO
         fDwhAmkoNkBRQHl1AfdGlcI7gd51mX8trrXR10GAWle178zZU3jsxpAMtEjUg6rzpRPK
         pvi8o6PXqdTa3sMr38s16cbfg+/Y3J2g8XNpg/vgtU9rCCONtBjt6oNp64agZ8EtTX1G
         5C+94GYotadbD/bXQUTDBOgcRg4ji5LhinaJyrB2CKBSbH1VrpSdL2vPLXsE6XraOFQd
         u7UQ==
X-Gm-Message-State: AJaThX4rbQaG+/IgEUHOig1feQeaWBvlHVZ7aQyl2kEJu/fCdeNRNOTl
        3DEP3UofpXTdxdtmoqee7e0bMSBadAKC63JNQrOmSQ==
X-Google-Smtp-Source: AGs4zMYOf6r8JKHcL3trTw7+L64G7rsJQljrI11TN3R7TP2MSynxv3TiBAs8WoAx/+ptx9sNm5z875iCG9eBDBQsfQw=
X-Received: by 10.84.164.231 with SMTP id l36mr1271236plg.179.1510829755801;
 Thu, 16 Nov 2017 02:55:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.167.42 with HTTP; Thu, 16 Nov 2017 02:55:55 -0800 (PST)
In-Reply-To: <804e30dd-3c06-02c1-e5c0-f07265635943@talktalk.net>
References: <20171115104125.1686-1-phillip.wood@talktalk.net>
 <CAN0heSrbszhhFauYHNs70-WWk+bju0sSVzjavRcwg09CzCXSjA@mail.gmail.com> <804e30dd-3c06-02c1-e5c0-f07265635943@talktalk.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 16 Nov 2017 11:55:55 +0100
Message-ID: <CAN0heSrcAQhyzzB5c=W-diQecHgVQUC69xQwqnc36hSPVBpNig@mail.gmail.com>
Subject: Re: [PATCH] sequencer: reschedule pick if index can't be locked
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 November 2017 at 11:43, Phillip Wood <phillip.wood@talktalk.net> wrot=
e:
> On 15/11/17 18:44, Martin =C3=85gren wrote:
>>
>> On 15 November 2017 at 11:41, Phillip Wood <phillip.wood@talktalk.net>
>> wrote:
>>
>>  From the commit message, I would have expected the flags to be zero. Th=
is
>> patch
>> does not only turn off the die-ing, it also tells the lockfile-API to
>> print an
>> error message before returning. I don't have an opinion on whether that
>> extra
>> verboseness is good or bad, but if it's wanted, I think the commit messa=
ge
>> should mention this change.
>
>
> Hi Martin, thanks for your comments. LOCK_DIE_ON_ERROR also prints the sa=
me
> warning so that behavior is unchanged by this patch, though mentioning it=
 in
> the commit message would be no bad thing.

Argh, you're right of course. Sorry for this.

Martin
