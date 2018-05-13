Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6F51F406
	for <e@80x24.org>; Sun, 13 May 2018 18:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeEMSkd (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 14:40:33 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:46836 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeEMSkc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 14:40:32 -0400
Received: by mail-pf0-f178.google.com with SMTP id p12-v6so4950388pff.13
        for <git@vger.kernel.org>; Sun, 13 May 2018 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WUimx2m12+M/zi6ykHUT0cP+YGT3fuhSCQxBxlfMY/Y=;
        b=Mi1maRyksTHxfvV14e9GS4vLFpqT5iRv/ph+I8uhVWkHhODE7ZEGNtEPDYlEoBCMal
         OVMLeeDCDc0DDyX5lDLD+YXXXnMeAIbdFF9z3rnsoGSt8ddvYzQwPIYQloiHinmeGMrU
         1YflsNgyIrwAHfBccL8xmMiJrC/K7rlj+xBM7U/4MLupky+yAC+aKt5LhXxKM7al45LJ
         ajLKJfkS9fEX0UxrVt6sejCyOHdoZfXhdR1Dt2yEJLUYMHWS9jhsEbJv1be09yVyfdvo
         is4wMRHEmuqwCMoHZJg5Z61uJWGpfzg68T2jehIBi+8pwNEXtOExRCdZgkgMPO9lrkem
         hxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WUimx2m12+M/zi6ykHUT0cP+YGT3fuhSCQxBxlfMY/Y=;
        b=TvNgBRj96x1QrckUnRNlIzVSIqWlIRXJbxDbRHHrrVV08XQ/jdJykDTK8h7pb+cd0l
         W4tKigYqbEAs/FQIq1u4ygMr3bp2tyMg6lmNsKfOozdaXULdQiDFefCscHrd4nIwYbM+
         vU2cU2IW9nTpNQ4NlXWhDWAalCrnYU0XcRv12KQWmtvmQjLqy1I1rg6G7Vg2JocnVJW+
         iU9q20V3qwK/SUi69SBUKpE7f+B1ZqXO3mid4oK+X0tiFhmgQcmw8f8wkgFL8zH8wBrt
         WPkRDlul2+VxSZ+2D36sbCNV7lZxB2FwaHdcolieY/Dusy6qdoNg/EOWUeJMT9wkvhBc
         X/Ow==
X-Gm-Message-State: ALKqPwcyi2K5R1w/fiwOzGDCbVrgTP7iKG//tK3LLJ0BhCxZPmNz9Oow
        HRCIkBZLtAl7ttH56P7rhQTzh2j7nPUXTOX8r+ENvyzx
X-Google-Smtp-Source: AB8JxZpRc56n1JXWIaL1BRqYOyJch7YDHLzuOK0CoVbC3lzz/Az4h42fcKIqVOsBiMg6YWIMNVJ4c/986bEy8Vmia0c=
X-Received: by 2002:a62:5050:: with SMTP id e77-v6mr7482125pfb.16.1526236831800;
 Sun, 13 May 2018 11:40:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sun, 13 May 2018 11:40:30 -0700 (PDT)
In-Reply-To: <20180513082303.19582-1-martin.agren@gmail.com>
References: <20180513082303.19582-1-martin.agren@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 13 May 2018 20:40:30 +0200
Message-ID: <CAN0heSrFYyGiVwJYceC--wB88=taSis=KrdGpSfiGk1orC754A@mail.gmail.com>
Subject: Re: [PATCH] config: free resources of `struct config_store_data`
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 May 2018 at 10:23, Martin =C3=85gren <martin.agren@gmail.com> wrote:

> +void config_store_data_clear(struct config_store_data *store)

I will do s/void/static void/ here...
