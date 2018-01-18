Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903111FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeARWkU (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:40:20 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:40120 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbeARWkS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:40:18 -0500
Received: by mail-ua0-f171.google.com with SMTP id t6so15164121ual.7
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 14:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qErveytbNHc+WWQ2593fH+rJZCZl4zXcF13bagQ588k=;
        b=ZMicWm5jXc1JGWhBwAIfoh3yVuYVO+ZBUf3DwTXvKNjbZ55OoyphtY5lQ3cRcUNQ6N
         aJ2UYZmK2cmC3s9bng6WqyuHiFVLDSovK4PFkAwtmO+kWqujOtRPhMi0aYXs3ObDCmeg
         zc59uxnPoPEMPftvfhItY8+vvhuyvt9bsuv7KocZ3UpgaRLKBYarfib2a8wpkCEY4ntl
         yUPzPwaUvhG58Fa724WJKY3i0OzR3KWcFOxGWoKk2wjOD7p0Rw2eIgS+3XgfyelGb+81
         W387gSdpMQ2IaMB6hfUXZHgo5h9ChilNxItVrqGoW2Ci8Rd+iO1N9xltizwUOGxOW7XP
         RIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qErveytbNHc+WWQ2593fH+rJZCZl4zXcF13bagQ588k=;
        b=hucxvIFxND+mgqph8klu+bS9GWsrCqWxpbKsAM4PkqYwJ+7KJOMj+QFZTuuwrZDtL5
         2IqOZWY/pg3QOoaT+rXDDnFlk2cLSzfaBDpnjcRPi/cPVrksAKKuwX70uP2wbv7BUHiX
         Q6Vv4tZDQz+sF7IYY0o3XeuHxP7RktqKIUtgSWZpEfUOroJUxIAWKVMtnJZKC1Babdil
         bMSdDnm+oYnr8zt/kyRb0RiWPi+94geMLaFhVygiUPbu6dK271gY3nDnUZbOMKowO5rw
         yJ5ExLus2AB+WUzh08Er3zpDijZR5wOEIm55LN/SmQx/zeZN/S1hdHphZ68ZXiqCK2oc
         aUBQ==
X-Gm-Message-State: AKwxyte60WyWrI8fk7VSN8GW9qBVqaP7oW5SdaTr9GHC7dqfWWr6i9v0
        lTE0sc3p+jLR+b11ujkoQ/vUVRt+yqD4RHI1gFE=
X-Google-Smtp-Source: ACJfBov9W+h7RDMGe0bynoCk7An1rKV7qWfvQ9tTbLFU+t3JaO8+xhxEZox1Ku+tFLYoFLHKvAeiVQmP9kTNkMnFjTA=
X-Received: by 10.176.72.178 with SMTP id x47mr6338173uac.24.1516315217502;
 Thu, 18 Jan 2018 14:40:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.10.140 with HTTP; Thu, 18 Jan 2018 14:40:17 -0800 (PST)
In-Reply-To: <7390fd9c-5969-61f1-86b8-6971eaf1432b@web.de>
References: <20180116171130.16568-1-szeder.dev@gmail.com> <7390fd9c-5969-61f1-86b8-6971eaf1432b@web.de>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 18 Jan 2018 23:40:17 +0100
Message-ID: <CAM0VKj=eL5ZnnwKrxqtDYE+ijqJvcU-4bJNhjurvdn+Bpv7gUQ@mail.gmail.com>
Subject: Re: [PATCH] describe: use strbuf_add_unique_abbrev() for adding short hashes
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 10:40 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 16.01.2018 um 18:11 schrieb SZEDER G=C3=A1bor:
>> Unfortunately, most of the changes coming from 'strbuf.cocci' don't
>> make any sense, they appear to be the mis-application of the "use
>> strbuf_addstr() instead of strbuf_addf() to add a single string" rule:
>>
>>    -             strbuf_addf(&sb_repo, "%d", counter);
>>    +             strbuf_addstr(&sb_repo, counter);
>>
>> It seems that those rules need some refinement, but I have no idea
>> about Coccinelle and this is not the time for me to dig deeper.
>>
>> What makes all this weird is that running 'make coccicheck' on my own
>> machine doesn't produce any of these additional proposed changes, just
>> like at Ren=C3=A9's.  Can it be related to differing Coccinelle versions=
?
>> Travis CI installs 1.0.0~rc19.deb-3; I have 1.0.4.deb-2.
>
> The version difference may explain it, but I couldn't find a matching
> bugfix in http://coccinelle.lip6.fr/distrib/changes.html when I just
> skimmed it.  I wonder if the following patch could make a difference:

Yes, it does, now all those nonsense suggestions are gone on Travis CI.

  https://travis-ci.org/szeder/git/jobs/330572425#L713

Those "memmove() -> MOVE_ARRAY" suggestions are still there, of course.

> ---
>  contrib/coccinelle/strbuf.cocci | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.=
cocci
> index 1d580e49b0..6fe8727421 100644
> --- a/contrib/coccinelle/strbuf.cocci
> +++ b/contrib/coccinelle/strbuf.cocci
> @@ -29,8 +29,9 @@ cocci.include_match("%" not in fmt)
>
>  @@
>  expression E1, E2;
> +format F =3D~ "s";
>  @@
> -- strbuf_addf(E1, "%s", E2);
> +- strbuf_addf(E1, "%@F@", E2);
>  + strbuf_addstr(E1, E2);
>
>  @@
> --
> 2.16.0
