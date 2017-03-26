Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5462220966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbdCZCSM (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:18:12 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33973 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZCSK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:18:10 -0400
Received: by mail-oi0-f46.google.com with SMTP id w81so10158700oig.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=990bPA1P7v6NTS7wRenIU7NEDRWKNbKSjUf0cCIteTc=;
        b=YNEYI/8YT8s/jxWVkPn0w90cqxQd+kBqZ3vvwFBgeE9inrLLIMGm8+3PxDtTRQ7jBg
         DGc2gqF4n2j+SXdZ4eynORvFe6WKoceQwa0AQytrJyS/QKapE848hN1wqaRWmJh/D+Zv
         X+zNPGlHDo0JUBRE6I/WEEVyPwdHZSk0Fvf1Vyu9/2geyh5kKqheFlJJtoTVmFEFUD/r
         ZagKs764FThvYOdAlFJT0iehaY6j6QWLBXHo5U8R4BDbDSoRpFijW16gFsImrOz0gDy2
         IDcvvRvrcZ37nZ1vCQ1XVY2Elx35eDsqtK0AmbppdcpobQWjXb4iSeym8OcPuElgOgEO
         mlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=990bPA1P7v6NTS7wRenIU7NEDRWKNbKSjUf0cCIteTc=;
        b=qn+Lyu7V3FxgEmjee11lK3uBmyQTSx+uoBbU7RytsGgIq2lFzHj8rywHXhwc+hP7HW
         9hUHkOsgY2gAqTK/doSpiHxc+mIPU6pJiOSbvLOd9eMZ7lTBkC9/yJ6ceJ4z6PdoIZu4
         TJp2DObhHfq7zI95w1d/QjynGUUWv5BKfIwR1FlkvjHpvfPE7BwwkhCNPV8/n1jUNA24
         Q+c3cDpAR7EbsiELf357G6z/cgOdztURhm8psUJUUVsweH8nei9+mhhQt+Ny0jtOyB+I
         9edcffJfd0sMrPjPbe3NUHmR2uQlKLZfimx9xe/6mNb3RSJvPRK9+vKucZr7ghtW7oLN
         Lj1g==
X-Gm-Message-State: AFeK/H33OM4T8e0Kh5mPNilG05vy0PKJyZdm/QLCOFf5Fj76nfBYEjyHMYTaTRc2SL7KqtMj/k1csVWgQ5K4ng==
X-Received: by 10.202.212.20 with SMTP id l20mr8756410oig.146.1490494646822;
 Sat, 25 Mar 2017 19:17:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 25 Mar 2017 19:16:56 -0700 (PDT)
In-Reply-To: <004082a0-871f-cd41-edc5-522b5c2b3b58@alum.mit.edu>
References: <20170222140450.30886-1-pclouds@gmail.com> <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-19-pclouds@gmail.com> <004082a0-871f-cd41-edc5-522b5c2b3b58@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 26 Mar 2017 09:16:56 +0700
Message-ID: <CACsJy8CpUzRjZG7V8a6XvzcjxhwTnAfpwYed3OSLrygUPOK66g@mail.gmail.com>
Subject: Re: [PATCH v6 18/27] files-backend: replace submodule_allowed check
 in files_downcast()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 4:18 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> +/* ref_store_init flags */
>> +#define REF_STORE_READ               (1 << 0)
>
> I asked [1] in reply to v5 whether `REF_STORE_READ` is really necessary
> but I don't think you replied. Surely a reference store that we can't
> read would be useless? Can't we just assume that any `ref_store` is
> readable and drop this constant?

I deleted it then I realized many lines like these

    files_downcast(ref_store, REF_STORE_READ, "read_raw_ref");

would become

    files_downcast(ref_store, 0, "read_raw_ref");

I think for newcomers, the former gives a better hint what the second
argument is than a plain zero in the latter, so I'm inclined to keep
it.
-- 
Duy
