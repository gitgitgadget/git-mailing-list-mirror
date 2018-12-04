Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F29211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 11:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeLDLEV (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 06:04:21 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:34354 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeLDLES (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:18 -0500
Received: by mail-io1-f45.google.com with SMTP id r9so5797252ioa.1
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 03:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b+BNz8h496x5fVK/eKUbu5H03DeCRf5bgsJGe4V+UqU=;
        b=k4C2bxyxPP9HhZLjnYNg02isEy437PwCWY4x9PsnyqXbX/wJwOxPfawpE6nfu1q7Mm
         uZlbhccdCZvCyLS4X1ceD/FryDxvq+bAVWPmqoD7mj29c0YDmv+h/pwTP3erPCa4935h
         L0GfBSDOyJ436oWUZYiRb5iXUN5RUJ3Aa3xv9UyQAY45yWQnB2v3RaziN82MrKjYM7qZ
         hx0b9HW7xxZsKtF4/DTqPGO8bBDUDDbVNk+qoyuJUUFJNP2XxwvYDK2B1EP0eRJUE0yh
         VPasLVEyEifXd/sjOMjbZuud+cp54CuycljkCjPgND/5uyg/uFJTOj0fHYOXk8kxlnPB
         BDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b+BNz8h496x5fVK/eKUbu5H03DeCRf5bgsJGe4V+UqU=;
        b=B7mFYlj2Q5iRCPx5+IBBWV+7+LCu+qHmYVLx5fs3/cGGaQk8kxcrK4Q7s1qiYls/oL
         79gVuZi6OCYzxDC6ZW6lMqFpo9VJewheaxMLERRkdh9oHJ1WxQ+U7kLS2dA3G0nwMg2T
         mpeUsN0SO++wWDUSL77bJR/1TfS+cSABYBYnAcVgP59SODAYuKKdGXnu+1xO91UckoU3
         oa6+4P+NWjRD0wUbCsby9wx4OFiZdGPdC7dJezHGcGjSOORdA8zyC5mqWQhlJEpDw3VE
         wg246n/cjlaAEQhTz3I/tl/GAp6jVKLWYj53kcVARGIHLtxKKviP3MfTOtil0KL+6VAg
         eVVw==
X-Gm-Message-State: AA+aEWYWhj0CXbXEOnFFGFjZ8eKUhinwelIIDIz3MlNM6H37OBmX43JY
        N09vadg1c0RlBqi9x+kdZvPvXtdoE6D0Pu7VpBM=
X-Google-Smtp-Source: AFSGD/XObn9srP8A6Inl4U4v9ur1uLqk6yPrwZDfsPFLI6d8N2HS6iVJw5sgmlsQog6RbJyOTZOUgL/oXPtqhca23Ck=
X-Received: by 2002:a5d:8b8d:: with SMTP id p13mr15980270iol.223.1543921457335;
 Tue, 04 Dec 2018 03:04:17 -0800 (PST)
MIME-Version: 1.0
References: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
In-Reply-To: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 4 Dec 2018 12:04:05 +0100
Message-ID: <CAP8UFD2xv6SK+qPXKr5hQ0ZctOR5K-BNg1wdBy5=fp2DVBZMHw@mail.gmail.com>
Subject: Re: [BUG REPORT] Git does not correctly replay bisect log
To:     lskrejci@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 10:53 AM Luk=C3=A1=C5=A1 Krej=C4=8D=C3=AD <lskrejci@=
gmail.com> wrote:
>
> Executing git bisect replay reaches a different commit than
> the one that is obtained by running the commands from the bisect log manu=
ally.


> $ git bisect replay /var/tmp/git-bisect.log
> We are not bisecting.
> Bisecting: a merge base must be tested
> [d72e90f33aa4709ebecc5005562f52335e106a60] Linux 4.18-rc6

Merge bases are tested only when the good commit is not an ancestor of
the bad commit. If this didn't happen when the log was recorded, it
shouldn't happen when it is replayed.

Here it seems that this is happening at the beginning of the replay.
Perhaps git bisect replay is taking into account the current
branch/commit though it shouldn't.

I wonder if this would happen if the current branch/commit has the
good commit as an ancestor.

Could you try to check that? And first could you give us the output of:

git merge-base 5b394b2ddf0347bef56e50c69a58773c94343ff3
94710cac0ef4ee177a63b5227664b38c95bbf703
