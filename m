Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8A71F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 11:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeKQVgQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 16:36:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54131 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeKQVgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 16:36:16 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so80590ita.3
        for <git@vger.kernel.org>; Sat, 17 Nov 2018 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HmhpxcqwUfOmR08c4sz45fhNdJ27swS/SpM2wrcjjmY=;
        b=KoEvCalBafbN85MkZBFhS2SHINVTVSLxmCFbjT1rjRVY5YloviV+HfFpPh4PHhxKXy
         YhH3pi8mKX8B5MnV35dYwgslKEZCRt1IyXUMezgM7viffIDCbgBoeBJPBnWqBzPguTJn
         6de9yR088ThBQuomJ8QaNKIH04agSwkTdh7iFA0C7N9n8BY8mYolAxtfi4owXbiWl6Tj
         pvV/FwoJmr4Osd/LQ7qKDZ/mskKq8dgqmVTDn6ozWhCQZ8K1SnFhdbGejF1akfaDmgps
         aCc5IYcOhCuHH6hiroRkx28kW5T18t5MRBrMFq6goOq/r3p0xCY20R0KlObVBiaCkxAo
         jLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HmhpxcqwUfOmR08c4sz45fhNdJ27swS/SpM2wrcjjmY=;
        b=n7b/o/7k2RwkIWpsWJB7WRJrl0opxfLLFnZ1kJj2S37zq9kkFGf/T/Zp342tMti5KG
         fADZZbBVO6MpSli4ePXWTi5d5LUwcTINwFwNZ/sqt7927Jl9YTsrcGzjyVM5EvbpLplz
         Y2lVn4fgIwc6FfIS7sHuvswYtqi/VYfc5ZWJ+CMJrArojruH1OG3ZP9oMKPhqNEGQ4Am
         iyLmOR6o8a9n/kLGCB832RX7kq8PhT32ULtUvWt1cR0Tf29fsSL8NuIM0tq1ZBYTu1FA
         h5h7QMUemRpalAmk7smzsZP3b95GFsx/RJxlB4PKkynAN+jxKGHbk/+2JsKfEkPN4HZX
         x1NQ==
X-Gm-Message-State: AGRZ1gLNcc61hNC+yD3u9tUhjZNL3zbTggGhwlsSzjmdfXK70evaR4yw
        Wjl3XEoMOZFdVMnKybX7DC/zVCD8Ac8/Lz+jPQ9R/j/P
X-Google-Smtp-Source: AJdET5fTJqrVh7KQW9ftf0k+Byul8SFSk3bKdXQ0euQFirOhh5oJX/zCfhrjFe0SXcqiPua1lgl3BV64FqnKYA+XhuA=
X-Received: by 2002:a02:8c1d:: with SMTP id l29mr850065jak.93.1542453593307;
 Sat, 17 Nov 2018 03:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20181116173105.21784-1-chriscool@tuxfamily.org> <xmqqpnv4gigi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnv4gigi.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 17 Nov 2018 12:19:41 +0100
Message-ID: <CAP8UFD0f_oD2cm61exc9mCczD59ze0Qj1cHGn-MvtSMWNXA+gg@mail.gmail.com>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 17, 2018 at 10:29 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > However, as noted in those commits we'd still create the file as 0600,
> > and would just re-chmod it depending on the setting of
> > core.sharedRepository. So without core.splitIndex a system with
> > e.g. the umask set to group writeability would work for the members of
> > the group, but not with core.splitIndex set, as members of the group
> > would not be able to access the shared index file.
>
> I am not sure what the above wants to say.

I tried to improve from =C3=86var's previous commit message but I agree
that the above is not very clear.

> If we are not making
> necessary call to adjust-shared-perm,

The issue is that adjust_shared_perm() returns immediately when
core.sharedRepository is unset (or false). So when it is unset (or
false), and when the umask is 0022 or 0002 for example, then the index
and the shared index will not have the same permissions because one is
created using open() with mode 0666 and the other with mode 0600.

> then it is irrelevant that the
> lack of the call does not immediately cause an apparent problem for
> users who happens to have non-restrictive group perm bit in their
> umask.  Another group member whose umask is tighter will eventually
> use the repository and end up creating a file unreadable to group
> members.

The issue is that a group member with non-restrictive group perm bit
in their umask, like 0022 or 0002, will currently create an unreadable
shared index when using the repo.

I agree that it is much safer to just set core.sharedRepository to
"true" or "all", but maybe in some setups/systems it might be ok to
rely on everyone having non-restrictive group perm bit in their umask.

> Are you saying that we _lack_ necessary call when core.sharedRepository
> is set?

No, I am saying that, when it is unset, adjust_shared_perm() does nothing.

> If so, a commit that fixes such a bug would be the best
> place to have a paragraph like the above.  If not, the above description
> simply misleads the readers.

I agree that it is a bit misleading. Maybe something like:

"However, as noted in those commits we'd still create the file as
0600, and would just re-chmod it only if core.sharedRepository is set
to "true" or "all". If core.sharedRepository is unset or set to
"false", then the file mode will not be changed, so without
core.splitIndex a system with e.g. the umask set to group writeability
would work for a group member, but not with core.splitIndex set, as
group members would not be able to access the shared index file.

> > Let's instead make the two consistent by using mks_tempfile_sm() and
> > passing 0666 in its `mode` argument.
>
> On the other hand, this is a relevant description; this patch kills
> an inconsistency that is very short lived (I am assuming that there
> is no bug in the current code before this patch and we make
> necessary calls to adjust-shared-perm when core.sharedrepository is
> set).

It is unfortunately not short lived when core.sharedrepository is
unset for example as adjust_shared_perm() starts with:

int adjust_shared_perm(const char *path)
{
        int old_mode, new_mode;

        if (!get_shared_repository())
                return 0;

but get_shared_repository() will return PERM_UMASK which is 0 when
git_config_get_value("core.sharedrepository", ...) returns a non zero
value which happens when "core.sharedrepository" is unset.

Maybe there is a bug somewhere in adjust_shared_perm() or the
functions it calls, but I don't know this part of the code base much.

> > Note that we cannot use the create_tempfile() function itself that is
> > used to write the main ".git/index" file because we want the XXXXXX
> > part of the "sharedindex_XXXXXX" argument to be replaced by a pseudo
> > random value and create_tempfile() doesn't do that.
>
> Sure.  Pseudo-random-ness is less important than the resulting
> filename being unique.  "Because we are asking for a unique file to
> be created, we cannot use create_tempfile() interface that is
> designed to be used to create a file with known name."
>
> But is that really worth saying, I wonder.

I am ok with either your version or removing the above from the commit mess=
age.

> > Ideally we'd split up the adjust_shared_perm() function to one that
> > can give us the mode we want so we could just call open() instead of
> > open() followed by chmod(), but that's an unrelated cleanup.
>
> I would drop this paragraph, as I think this is totally incorrect.
> Imagine your umask is tighter than the target permission.  You ask
> such a helper function and get "you want 0660".  Doing open(0660)
> would not help you an iota---you'd need chmod() or fchmod() to
> adjust the result anyway, which already is done by
> adjust-shared-perm.

It seems to me that it is not done when "core.sharedrepository" is unset.

> > We already have that minor issue with the "index" file
> > #leftoverbits.
>
> The above "Ideally", which I suspect is totally bogus, would show up
> whey people look for that keyword in the list archive.  This is one
> of the reasons why I try to write it after at least one person
> sanity checks that an idea floated is worth remembering.

It was in =C3=86var's commit message and I thought it might be better to
keep it so that people looking for that keyword could find the above
as well as the previous RFC patch.
