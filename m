Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD0420D0C
	for <e@80x24.org>; Fri, 16 Jun 2017 17:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbdFPRgW (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 13:36:22 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35130 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFPRgV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 13:36:21 -0400
Received: by mail-vk0-f68.google.com with SMTP id 19so3181172vkd.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BYyWYfibZzABmSR3S9A9L5Fu+S9gs/Vk+mChfyDGfr8=;
        b=WpfXoRb5k4o0WxHhsdgcIuXrITZ69yoh9wXPrQwwrCRA53xTdp3RfGD/59wXjG70hj
         TFIXDPpdk6unm5ucTE78G5un8g0AAGBrT5l6BL3p4sgAhwdKOYkm3JdBZ0hbjdzagBCN
         wmCJSTc+8buUtK6LHKoRtgQ4JlBdG8eQhSPgKEvTsl5SOYW9aLlcQEch6PLVS92Y3twe
         uvtxlawELf1pM2JwQNvxatkLZLFcLPTE1gR12YVVhTm2Ggtb+vZiitROQgh4tYW4GKoR
         NdyhFScoo7YnYg2AFg8+5UpLf9Rz2QAHhpqT2WOJD1zReV4PVWkwpKcMg45zwVr1FuB+
         LnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BYyWYfibZzABmSR3S9A9L5Fu+S9gs/Vk+mChfyDGfr8=;
        b=a2e0lLdztSpo52qWnLljhxgB58vNM/yDx19B7Y3q3/AC4fFdBNZE939Esxu/XhJwLe
         D4BfcKEHmoIgeaUL+fER/47wbQF8DZqMEQVPaxh6wWfQYZVqOM1fobpgrHi6Gi4SshvL
         Ur/giGAYpwSq5n83TOoiiiTBXQmse28v3iDM9b2Q82sloB3WPS5JZOkfzZiKnssyaMLf
         srafRO7g0Shc8q1KUEFHG9Ih2BElAgIvq5L32lizEwZwSNYygxhdHDhbCTVA7JCODk4m
         b7Oih0t2UYCgmPO4oVKB7/XsV6l+9rC4UXkchbBB4rk418zz2kBIEN7tGlB6M2SRzDHx
         LRNg==
X-Gm-Message-State: AKS2vOy0NBz7+E+PVwc35AyGOCJVwKOGGKQsUvRlUhR+Y1hoLLEKpAHE
        dYFjpuJmY3MtDiMkLVWYoBzbYYcYlA==
X-Received: by 10.31.254.199 with SMTP id l190mr6673016vki.114.1497634580201;
 Fri, 16 Jun 2017 10:36:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.86.86 with HTTP; Fri, 16 Jun 2017 10:36:19 -0700 (PDT)
In-Reply-To: <20170614004816.GR133952@aiede.mtv.corp.google.com>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com> <20170614004816.GR133952@aiede.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 16 Jun 2017 19:36:19 +0200
Message-ID: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
Subject: Re: [PATCHv4 1/2] clone: respect additional configured fetch refspecs
 during initial fetch
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 2:48 AM, Jonathan Nieder <jrnieder@gmail.com> wrote=
:

>> diff --git a/remote.h b/remote.h
>> index 924881169..9ad8c1085 100644
>> --- a/remote.h
>> +++ b/remote.h
>> @@ -164,6 +164,7 @@ struct ref *ref_remove_duplicates(struct ref *ref_ma=
p);
>>
>>  int valid_fetch_refspec(const char *refspec);
>>  struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspe=
c);
>> +void add_and_parse_fetch_refspec(struct remote *remote, const char *ref=
spec);

> I'm tempted to say that this one should be named add_fetch_refspec (or
> something like remote_add_refspec) --- this is the only way to add a
> fetch refspec in the public remote API, and the fact that it parses is
> an implementation detail.  The private add_fetch_refpsec that builds
> the fetch_refspec as preparation for parsing them in a batch is not
> part of the exported API.

I kind of agree, but ...

First, there is an add_push_refspec() function as well, which, just
like its fetch counterpart, doesn't parse the given refspec, only
appends it to remote->push_refspec.  Changing add_fetch_refspec() to
parse, too, would break this symmetry.

Furthermore, at the moment we have both remote->fetch_refspec (for
strings) and remote->fetch (for parsed refspecs), and parsing a
refspec die()s if it's bogus, therefore I think that parsing is not an
implementation detail that should be hidden.

> The caller adds one refspec right after calling remote_get.  I'm
> starting to wonder if this could be done more simply by having a
> variant of remote_get that allows naming an additional refspec, so
> that remote->fetch could be immutable after construction like it was
> before.  What do you think?

That's such a very specific and narrow use case that I don't think it
justifies a dedicated function.
I don't think remote->fetch should be immutable; I think
remote->{fetch,push}_refspec and the lazy parsing of refspecs should
go away.  Cleaning up this corner of the remote API is beyond the
scope of this patch series.

> [...]
>> +     /* Not free_refspecs(), as we copied its pointers above */
>> +     free(rs);
>
> Allocating an array to put the parsed refspec in and then freeing it
> seems wasteful.  Should parse_refspec_internal be changed to take an
> output parameter so it can put the refspec into remote->fetch
> directly?

No, I found that extracting the huge body of its loop into a helper
function that fills an output parameter is much more useful.


> [...]
>> +++ b/builtin/clone.c
> [...]
>> @@ -848,16 +853,13 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
>>       const struct ref *our_head_points_at;
>>       struct ref *mapped_refs;
>>       const struct ref *ref;
>> -     struct strbuf key =3D STRBUF_INIT, value =3D STRBUF_INIT;
>> +     struct strbuf key =3D STRBUF_INIT, default_refspec =3D STRBUF_INIT=
;
>
> nit: since it's not part of a key, value pair like value,
> default_refspec should probably go on its own line.

Fun fact: they were never part of a key-value pair.  While 'key' is
indeed the name of a configuration variable, 'value' is not the value
of that configuration variable, or any other configuration variable
for that matter.


Best,
G=C3=A1bor
