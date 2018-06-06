Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34BE51F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933585AbeFFRRc (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:17:32 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37949 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbeFFRRb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:17:31 -0400
Received: by mail-yw0-f195.google.com with SMTP id w13-v6so2118729ywa.5
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EL8p+A6wceSg+uq4RFWK3zowku5HZK2DEBQy62n5vWw=;
        b=AlapRpYjM1FoWmi5vz6llOuDDcIYK+6b2Pa/f4w25RjqZ+LssNgASUa0UqOr0aRlUi
         UBz3x02YOn8Jq6HBBD0J/RVNgm+pBa1feZtOTrKB1+j+tnfU/9ai0+8jzyNTmN8Un7JL
         wlr9phOHEndN7wpZXZywO4OXnDSeB1xmyAixIndTnljJQd9eMzyCh/nuoyogCkECsh1f
         ZW8xMTUQYUP3dlzDflXBUnEumvxoUFcXtt3bcyKyjV5wvY0K6ay7SCr7AHJ0H5uC96Jv
         keCGDBs66LIb8V2RakGzYRFT/y5R/OPTEAfGwea89m4/QplJ3pB+HhnA9eu5afeJ5r3G
         l1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EL8p+A6wceSg+uq4RFWK3zowku5HZK2DEBQy62n5vWw=;
        b=kvSrVC2HsSFg3lgGDzxE7YL1zYWZNjMzwGiU+iLkSkLMa3qIy/IrscJtM1xGgyBUJo
         bcJWOYXEDhpoY9JftXKV4T20UbHgj1Bt6ihAGBLQoD8tFjsjMfvYAY/1/qaoMO695fqm
         1jmSVOalV4/Wyz61DIIYqA5p3iR0mSM7ePtGTIbjUmkZi+u0vupGUgvbFUsaO4xvbPnO
         uRlYSBPeMDnoNKUnvTgbq7OJwHuL6Ic0qIojjfH82xG85pIEf9fXofPImQV33BUvwrbk
         6mPzBxVOkPSlyr9IDhozcKVj4B8hRGpmos2txmNClmSfNO0OED9o8WuoPk5O090JiCRF
         DXgg==
X-Gm-Message-State: APt69E2WN0sOARnMvkcF91CLJnnsn7i8EUWlsPgBmsuuA0MITshU+v3g
        TrOIc+G3xJFQtgK+AcxHsnoXTwU2+pX91FVxad8=
X-Google-Smtp-Source: ADUXVKKIAj02d1Aa1zlKdjce/jnlHA/1Rhi7+571e1ZA8AfDffNbcfWKEkuO6Xwfs5dAr0wvtcW7WFw3ccInw6vmZgM=
X-Received: by 2002:a81:738b:: with SMTP id o133-v6mr1854260ywc.120.1528305450631;
 Wed, 06 Jun 2018 10:17:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 10:17:30 -0700 (PDT)
In-Reply-To: <CAPig+cSzJ=2Zz7jRNB7sK7FyZ+YwdAFseCTSDbM_m4E8K9WxHA@mail.gmail.com>
References: <20180604201742.18992-1-asottile@umich.edu> <CAPig+cSzJ=2Zz7jRNB7sK7FyZ+YwdAFseCTSDbM_m4E8K9WxHA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jun 2018 13:17:30 -0400
X-Google-Sender-Auth: kzFZQPxqE06QFwzb06FOBghKBCI
Message-ID: <CAPig+cRyv=JuGo+OfULuvbLrqRxoYZyBZDrSJrt5F8YRwzNn6w@mail.gmail.com>
Subject: Re: [PATCH] config.c: fix regression for core.safecrlf false
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 1:15 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jun 4, 2018 at 4:17 PM, Anthony Sottile <asottile@umich.edu> wrote:
>> +       for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
>
> Simpler: printf "%s\n" I am all CRLF | append_cr >allcrlf &&

Or even simpler:

printf "%s\r\n" I am all CRLF >allcrlf &&
