Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF342013A
	for <e@80x24.org>; Tue, 14 Feb 2017 09:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbdBNJYO (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 04:24:14 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34504 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbdBNJYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 04:24:10 -0500
Received: by mail-oi0-f67.google.com with SMTP id w144so2295057oiw.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 01:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eSJ9T+EFNeYPRFk2IHAkFr1Krclp4EEfPs58cOe68Nc=;
        b=Eo08jiIqB2dYYA7wJwWH8IT4s+drbxmY/2I5BjsilN8tecNd8Lbsk54gUXTfbkkLHt
         Ox8NmYCPHB6dofMTIwKKBgl0tdZp9TRDF+oUpbCJ/aGnFAEoTULgcN0T5mrfKeRVBNKi
         MvzQdcAjuhv8c/d258yrpqhtvLjCusUQKHP9fWHDqGWhse5mGVJzw0RS0UIyFQHDpQVc
         T7U20+MhWl9zU0+jLp72ra2IOLFNMh9YAFTJAN6yqeQPOy6rYwcD4AtRMMcfPugL8ohW
         SQM+GX+0ushWAWRCAHeyDar2GoAn3rjDd+0Oy225TGKuuHRfyxSGEqumyuH1qFmbKQO+
         cZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eSJ9T+EFNeYPRFk2IHAkFr1Krclp4EEfPs58cOe68Nc=;
        b=di/TpKau3ib3EwqVBSZFdmlurLkt1WBiguvm7Q5WH7okRy1rqxFuM9NPG2S5+85ufP
         MJvwvCNVNZ2oD8QjZthsYJogDf0u1tk5OAWEyj2Y7BTqJk1PF8rCjuP4XAQYANQ+dMWn
         jtnBD17vJiP/slOVHSpjFrCLz6FSHZx+sOQp7rSCMgt4gxJW5C3as2Fa2NmX2aFsObUw
         MZz+/F7flO2E36A/e1kP0OEhWiCgmjTf/sI9brmw92Ms6hyoGU6FoZAeuwjHhjkt0FOb
         J+tjtTG2zm6UrkgYX/wOY1sPdJ/E4GhhZGcDvR9UPxfn6ooP/h2bOU9bNL/W8UMS41M9
         69Nw==
X-Gm-Message-State: AMke39nOCD84itbG/fpv7lsbSDkpSDXDCUg4Cic+92B1judxkoyLvVyyJVM055SNk+8HjIYFwSgvjNjdtm8NzQ==
X-Received: by 10.202.78.214 with SMTP id c205mr15467829oib.65.1487064249299;
 Tue, 14 Feb 2017 01:24:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 14 Feb 2017 01:23:38 -0800 (PST)
In-Reply-To: <6510f4b2-51bb-eabd-9cd7-30bc4164b25d@ramsayjones.plus.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-2-pclouds@gmail.com>
 <6510f4b2-51bb-eabd-9cd7-30bc4164b25d@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 Feb 2017 16:23:38 +0700
Message-ID: <CACsJy8BnSdaUHx1tCu6YkMedwp3RL4riKLYfT5N4cHHjG9fNLw@mail.gmail.com>
Subject: Re: [PATCH 01/11] refs-internal.c: make files_log_ref_write() static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 3:14 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 13/02/17 15:20, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Created in 5f3c3a4e6f (files_log_ref_write: new function - 2015-11-10)
>> but probably never used outside refs-internal.c
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  refs/files-backend.c | 3 +++
>>  refs/refs-internal.h | 4 ----
>>  2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index cdb6b8ff5..75565c3aa 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -165,6 +165,9 @@ static struct ref_entry *create_dir_entry(struct fil=
es_ref_store *ref_store,
>>                                         const char *dirname, size_t len,
>>                                         int incomplete);
>>  static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *ent=
ry);
>> +static int files_log_ref_write(const char *refname, const unsigned char=
 *old_sha1,
>> +                            const unsigned char *new_sha1, const char *=
msg,
>> +                            int flags, struct strbuf *err);
>
> Why? I don't like adding forward declarations unless it
> is absolutely necessary (ie mutually recursive functions),
> and even in the current 'pu' branch (@c04899d50), the
> definition of this function appears before all uses in
> this file. (ie, just add static to the definition).
>
> What am I missing?

It may have been needed at one point. With all the code changes and
movements, I guess I forgot to remove it.
--=20
Duy
