Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385FC1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbeHETpk (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:45:40 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40412 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeHETpj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:45:39 -0400
Received: by mail-io0-f195.google.com with SMTP id l14-v6so9095317iob.7
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c0k0lR6w/8KwIZonbGv0RhbWho3gxKlXE/GwF6rIQ+U=;
        b=RY1QJh8a92nHk5NcmwgND6qvTWWW69gjhHCKPp/raHQjsGI0zIkY975U6Zrz3GyoIY
         Nw2ZRVU2XyKUG7eXiwclBF/KyQUzopDvJjMD6N3BTNgUTYkylA0tZoH7N4O4Kf+UcCqw
         vlAiJ4LL6Csu+o7x59eolIUudefGa9JJ6GgDeyZvxr/vpLuX4DbJ1/kKalAw6PpincSC
         eYm7hMLjDrZu1FcGX81wQtD6eiS0LYXPjAMKcOeQwVdA3CK04P4zfQ1CJqJb+AqF/L+5
         noCCVUo5Cikitxav7R03MO6Q+GWODmAD+7BQagWyP70iZCHIeid9/wqtithxW5fTsFXL
         XdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c0k0lR6w/8KwIZonbGv0RhbWho3gxKlXE/GwF6rIQ+U=;
        b=n/+N375U5/Tp9H3woKojH7bHCIHeNu5aMAC3g5AWZLz5KS/PEhnVNCg76/U8vDD3Ss
         OyWyJKLbUP0OHeDypVfg3RaTgq+TngHgDG1BwVopS5+jly3CCrWunmKHUUZer4Hll74B
         Oot68rKIWRLVBsrOo1lRapj0OyPRAApQjruINJIG8vr9kJUelr87eCeIMLoxofnoNDsV
         nrdLn4FfmbuXu7qlfEWjJRsVvogMNer2nlP2VC3BmcTVzewOC5KBe4iCg9f5cHm1Id2D
         6cMq70wJxrnKpif+i428f6Z3hAiM7F03STR5A839SbVE38OgflRYZThL5mOHG5HpSkD2
         UV1w==
X-Gm-Message-State: AOUpUlEUFmlsvT2ppMFcUjKwHrR693rmiOLY67w6xyMY1jzKk7R8Kip1
        1lnYl/G85WSEjG6n74HuNvmBAkphYPw/6YqFHHQ=
X-Google-Smtp-Source: AA+uWPyFT0ajSmEwm+IjRyD95wJRa2sBodpLPFmjY9IfV5l353ZSTZaYy8xh8IZCpkaRrEjnytIkPpO4hNQR5NnQNp4=
X-Received: by 2002:a6b:5a08:: with SMTP id o8-v6mr12741161iob.5.1533490819614;
 Sun, 05 Aug 2018 10:40:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 10:40:19 -0700 (PDT)
In-Reply-To: <xmqqfu08zhh7.fsf@gitster-ct.c.googlers.com>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-4-chriscool@tuxfamily.org> <xmqqk1pkzhuo.fsf@gitster-ct.c.googlers.com>
 <xmqqfu08zhh7.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 5 Aug 2018 19:40:19 +0200
Message-ID: <CAP8UFD2Ri6N33UhZSHOvxtxiCBC13-1rpa_ZByY9dsyPjmaC8A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Another thing I noticed from 2/5 is that you can have up to 7 such
> capture groups.  I do not have any opinion if 7 is too few or too
> many, but we would want the number to be documented, and end-user
> input diagnosed when it requires more captures than we support (if
> we are not already checking, that is).

This is the new documentation:

-> Refs are grouped into islands based on their "names", and two regexes
-> that produce the same name are considered to be in the same
-> island. The names are computed from the regexes by concatenating any
-> capture groups from the regex, with a '-' dash in between. (And if
-> there are no capture groups, then the name is the empty string, as in
-> the above example.) This allows you to create arbitrary numbers of
-> islands. Only up to 7 such capture groups are supported though.

I added the last sentence above, but I wonder if it is 7 or 8. The
code is the following:

-> static int find_island_for_ref(const char *refname, const struct
object_id *oid,
->                    int flags, void *data)
-> {
->     int i, m;
->     regmatch_t matches[8];
->     struct strbuf island_name = STRBUF_INIT;
->
->     /* walk backwards to get last-one-wins ordering */
->     for (i = island_regexes_nr - 1; i >= 0; i--) {
->         if (!regexec(&island_regexes[i], refname,
->                  ARRAY_SIZE(matches), matches, 0))
->             break;
->     }

I also wonder if the above is enough to diagnose end-user input when
it requires more captures than we support. A quick look at the man
page of the regex functions wasn't enough to enlighten me. Any input
on these issues is very welcome!
