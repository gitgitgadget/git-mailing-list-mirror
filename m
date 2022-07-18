Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D0FC43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 09:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiGRJHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 05:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiGRJHG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 05:07:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C22011810
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 02:07:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a15so11208355pjs.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hyRJVTeEi7R88LqQn3Pn2gngj+1muSE2vG5dzob8pA=;
        b=iiADzssQbt5nv8qzwgljOm4/LeV6pwXEOXo10Nu36yZD6KwcpmD+e/BMhXEaK7pE+h
         LnCN6GgSzSGrEIXoYnYLSrx9/ZJQEnb+hT3J06o2/dtG1pHEN8Uv2EI3Yc1z+KAirsoQ
         vt7FgIqLM49uQhzJhF1N6HoKNlUIwWSxvJwHOjYz3MQQ8N69YT9vlwKWHfWCAcvl4WYk
         A2bWB3x+rFthdOatFu3ARAEURoUcUpRhlrRsA6X9RfzXKZFbl240jLpfsnjYc03UPghw
         0Wak5h7/nUqxaL29OAovIxIdmfvwVuNTyfsd0WF/otgVA6gyJKtgt+Jb/hE6aK6vP9QA
         +gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hyRJVTeEi7R88LqQn3Pn2gngj+1muSE2vG5dzob8pA=;
        b=7NsxoVKtXJs4xkzZ5Z9MMehAZiozNPSwY0rhMM7Vpa0l0XrDfPWflxQyBaBLPA0Ozq
         Tfx2Z0AJSzgk5JYiDMQCYml5zSCLeSlcl/1iHssLtCmomEBG0Gn2nsmx6zqr9bNwFAn6
         LKm0oUhjnAAgv1DvwKZ1LyUAFdxcNUB8zN4+9NTzocq5LmGYMzVP98W2FNepsw/fHLkp
         CZhdLQHay85MDhtelu6B5E/+CYMfggqFLpRwbSvDGztciTHQtsvm+QbpZJ8cBXXSQcJy
         tCXw4O7FBIxkCoTYyNfQhgPaqH7aPpU4PTUoDZoACm/hcMeOOavxHkwL2mP+rGQnmCeY
         1kEA==
X-Gm-Message-State: AJIora9sTdKAV2EkLuwP6iuXVEKAbB6M0xUpuEgi4E/qjiYfDPYznipC
        rShc/5SKMWWn73bLOQlvs0Yo+Ndqljv53bAXEr4=
X-Google-Smtp-Source: AGRyM1sesrnk0cJ9tHQePnC8DNC6A4Xtu3Ak767r8GA8zclnyMYqicTzVBrIQHvg2DZlagt4Jd+xfBmqvLmmCIAH2qI=
X-Received: by 2002:a17:902:b215:b0:168:da4b:c925 with SMTP id
 t21-20020a170902b21500b00168da4bc925mr26054842plr.155.1658135224652; Mon, 18
 Jul 2022 02:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com> <e64362621d235f2c79f52e984de7a2a2794e2842.1656924376.git.gitgitgadget@gmail.com>
 <YtDVDu7VKgAcvRse@nand.local> <CAPOJW5y+ywbiT2XBYYNN+y73+V98Ro33D1bgZQveQLTPfrgE_g@mail.gmail.com>
 <YtHoJ90N6rmDmn6M@nand.local>
In-Reply-To: <YtHoJ90N6rmDmn6M@nand.local>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 18 Jul 2022 11:06:53 +0200
Message-ID: <CAN0heSoA=wv4syJ3VOe92QPpjPHyqUPJ8+Pv+mbB0-TiiieVmw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] pack-bitmap: prepare to read lookup table extension
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep and Taylor,

I very much enjoy following from a distance Abhradeep's work on this
series and all the reviewing and mentoring. I don't grasp anywhere near
all the details, but I've looked into this a bit:

On Sat, 16 Jul 2022 at 00:37, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Jul 15, 2022 at 10:08:17PM +0530, Abhradeep Chakraborty wrote:
> > On Fri, Jul 15, 2022 at 8:16 AM Taylor Blau <me@ttaylorr.com> wrote:
> > >
> > > On Mon, Jul 04, 2022 at 08:46:14AM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> > > > +/*
> > > > + * Searches for a matching triplet. `va` is a pointer
> > > > + * to the wanted commit position value. `vb` points to
> > > > + * a triplet in lookup table. The first 4 bytes of each
> > > > + * triplet (pointed by `vb`) are compared with `*va`.
> > > > + */
> > > > +static int triplet_cmp(const void *va, const void *vb)
> > > > +{
> > > > +
> > > > +     uint32_t a = *(uint32_t *)va;
> > >
> > > The comment you added is definitely helpful, but I still think that this
> > > line is a little magical. `*va` isn't really a pointer to a `uint32_t`,
> > > but a pointer to the start of a triplet, which just *happens* to have a
> > > 4-byte integer at the beginning of it.

Yeah, this all looks quite magical with the casting, and with the
asymmetric handling of `va` and `vb`.

> > Are you sure about this? As far as I know, the first parameter of such
> > comparing functions is always a pointer to the given key that we need
> > to search for and the second parameter points to each element of an
> > array.

Yes, that matches my understanding and the man-page for bsearch(3):

  "The compar routine is expected to have two arguments which point to
  the key object and to an array member, in that order, [...]"

I think it would help to make this something like

  static int triplet_cmp(const void *key, const void *array_item)

to really highlight this asymmetric nature of this function, or to make
clear how the values flow through our call-chain through something like

  static int triplet_cmp(const void *commit_pos, const void *table_entry)

Because we really do rely on this promise of bsearch(3) -- if we would
instantiate a 'dummy' triplet carrying the key, we wouldn't need to (but
we would instead need to have our `cmp` function constantly re-read the
same value, including doing the byteswap).

Would it make sense to let the `const void *key` directly carry the
32-bit value and hope that `sizeof(key) >= sizeof(uint32_t)`? That's
probably too magical, "just" to save on dereferencing.

One thing that could perhaps make things clearer is if
`bsearch_triplet()` did take the position directly, rather than as a
pointer:

-static int bsearch_triplet(uint32_t *commit_pos,
+static int bsearch_triplet(uint32_t commit_pos,
                           struct bitmap_index *bitmap_git,
                           struct bitmap_lookup_table_triplet *triplet)
 {
-       unsigned char *p = bsearch(commit_pos,
bitmap_git->table_lookup, bitmap_git->entry_count,
+       unsigned char *p = bsearch(&commit_pos,
bitmap_git->table_lookup, bitmap_git->entry_count,
                                   BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH,
triplet_cmp);


Also, maybe s/bsearch_triplet/&_by_pos/ could clarify the intent of this
function?

> > I think "`va is a pointer to the wanted commit position value" is not
> > that descriptive. Maybe "`va` is a pointer to the given key" is
> > better. What do you think?
>
> Yes, the first argument to the comparison function used in bsearch() is

s/first/second/

> a pointer to some element in the array. I just meant that that array is
> the bitmap_git->table_lookup region, so each element isn't actually a
> uint32_t array, but the whole thing is an array of (uint32_t, uint64_t,
> uint32_t) triplets.
>
> What you wrote here is fine, and I don't even think that the comment
> needs updating. If you did want to clarify, I think you could say
> something along the lines of what you wrote above ("`va` is a pointer to
> an array element") and add something along the lines of "where the array
> is the lookup table region of the .bitmap".

I mentioned a few ideas for clarifying things above. I do think it would
be a good idea to differentiate the names of `va` and `vb` to make the
fundamental asymmetry between them clearer. The rest of my comments are
really just musings.

I originally started looking at this because I wanted to see why the
casting to a `uint32_t *` and dereferencing it was safe. The reason is,
we're always handling the same pointer to a `uint32_t` on the stack, so
alignment is guaranteed.


Martin
