Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B94C32774
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 18:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiHVSOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbiHVSOf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 14:14:35 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E8443E5C
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:14:33 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id m5so5906152qvo.4
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=bToazt1pzdp4dUBGacrL2eKzohmw9TeTYGjje51TxZc=;
        b=FzdbJOxflUkdhdmzfx+tG2t585krWRmKx6zTqDQ/NaknRz6iy5hUpJtjPDw4Rdoaan
         XfPWvS5pH8bZt1WoQ63TkBq1rS/Q8iPAB6F+9M3SGRfxSu+WTLfolw4pYd7YTk11IpC3
         2jqqw3ChfAX1r6ED4RPIjyVi+Cg27+cY9wQWmP2AuErApC6S4sMaZV3lEDXJE08rb6OY
         Iz5JGNUwfBAR12mMN4I0cJAGIU0x8JpIkEEzIhJuC5U9FbYu+eewNEG4JCPVEgeR+O01
         XMhjlnNeWAYxFmBlCGTGPm7Fxao7GQs3kPdvnWUFiJVlEN7sKoMdl29TKOI2uEcoXjuR
         ZL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bToazt1pzdp4dUBGacrL2eKzohmw9TeTYGjje51TxZc=;
        b=IVys0rpU/LbV/HX18T7UJlF/Jv6N53OPzEb1G7/WdTKCBL6vPXhw66yYde0jxrkj9G
         yVMjz0Hh5weL351OYVA07WRuMvUTUbOs3cQ3J0ZHuY0iZl9/rN+pfWaIJuogkbmRndOP
         uhsHWyBu3mMd0noiN0bRw4R5iHzWaISKsq56hGUS7FrzCoT0rz41q34HoRlZ5XwCoKDE
         IgV6i8WjA1eBG0x79pGsWBC8OWYnXdt1XjfjAFiZtxISCVkRkO68KMp3TRW3bsHFGECl
         K2scHp1cZu2DIzF6B7dXpPfHILvMkPG+rHRY+oLkdro64+ImDfpUg5xS7tOvs8HlqV7v
         XFpQ==
X-Gm-Message-State: ACgBeo3Z31SHmoBCjelAIDCdi/KZzXPOafiAgv6SP6vw5es4RqaSUJX5
        6usyHUtF5GyY5XZFe468GlNN3A==
X-Google-Smtp-Source: AA6agR7j67U6ON1DH//MnHnLMUfa8lLslxznLGlKMHPVdK4VCQJh8Ld9/Z9vYPGWIzUXtgJ6mlE7vw==
X-Received: by 2002:a0c:a953:0:b0:495:5c8f:ae2f with SMTP id z19-20020a0ca953000000b004955c8fae2fmr16542912qva.20.1661192073018;
        Mon, 22 Aug 2022 11:14:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t201-20020a37aad2000000b006b9264191b5sm12012155qke.32.2022.08.22.11.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:14:32 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:14:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, jonathantanmy@google.com,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH 6/6] midx.c: include preferred pack correctly with
 existing MIDX
Message-ID: <YwPHh/EDIS0S4uoj@nand.local>
References: <cover.1660944574.git.me@ttaylorr.com>
 <4ddddc959b042faf7ae98a8e8eaa05e77f9ea23e.1660944574.git.me@ttaylorr.com>
 <3cecd058-aec2-d5f9-ef79-58cc10ce14fb@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cecd058-aec2-d5f9-ef79-58cc10ce14fb@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 01:03:11PM -0400, Derrick Stolee wrote:
> On 8/19/2022 5:30 PM, Taylor Blau wrote:
>
> > Resolve this by adding all objects from the preferred pack separately
> > when it appears in the existing MIDX (if one was present). This will
> > duplicate objects from that pack that *did* appear in the MIDX, but this
> > is fine, since get_sorted_entries() already handles duplicates. (A
> > future optimization in this area could avoid adding copies of objects
> > that we know already existing in the MIDX.)
>
> ...
>
> > This resolves the bug described in the first patch of this series.
>
> Thinking ahead to when this is a commit, perhaps this could instead
> refer to the 'preferred pack change with existing MIDX bitmap' test
> case?

Good idea, thanks.

> > @@ -610,10 +609,7 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
> >  		nth_midxed_pack_midx_entry(m,
> >  					   &fanout->entries[fanout->nr],
> >  					   cur_object);
> > -		if (nth_midxed_pack_int_id(m, cur_object) == preferred_pack)
> > -			fanout->entries[fanout->nr].preferred = 1;
> > -		else
> > -			fanout->entries[fanout->nr].preferred = 0;
> > +		fanout->entries[fanout->nr].preferred = 0;
> >  		fanout->nr++;
>
> Here, we have lost the ability to set the 'preferred' bit from the
> previous MIDX. Good.

Yep, we don't want to propagate any of these bits forward when reusing
an existing MIDX. Thinking on it more, I think this is the only
legitimate use of MIDX reuse in the "I'm about to write bitmaps"
context.

I mentioned before the idea that we could use `--stdin-packs` now when
writing a MIDX bitmap where before it wasn't implemented (likely due to
problems caused by this bug). But the whole premise doesn't make a ton
of sense:

  - Every pack that's in the include_packs list would need to be handled
    separately.

  - And every pack that *isn't* in that list would be skipped.

Which means that it wouldn't help at all to reuse an existing MIDX. The
reason that we'd need to handle all included packs separately is subtle
and a little different from what's going on here, though. The problem
there is that if you have two packs, say P1 and P2, and P1 is in the
include list but P2 is not, then any objects duplicated between the two
and selected from P2 will disappear when writing the new MIDX.

Since the set of packs that are going into the new MIDX are precisely
equal to the set of packs that we'd need to handle separately, it
probably makes sense to continue to avoid using the existing MIDX when
writing a bitmap with the `--stdin-packs` option.

> > @@ -694,6 +689,11 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
> >  						    preferred, cur_fanout);
> >  		}
> >
> > +		if (-1 < preferred_pack && preferred_pack < start_pack)
> > +			midx_fanout_add_pack_fanout(&fanout, info,
> > +						    preferred_pack, 1,
> > +						    cur_fanout);
> > +
>
> And here, when there is a preferred pack _in the previous MIDX_,
> we add its objects a second time, but now with the preferred bit
> on. If the preferred pack is _not_ in the previous MIDX, then the
> 'preferred_pack < start_pack' condition will fail and the bits
> would have been set within the for loop.

Exactly!

> > @@ -346,7 +346,7 @@ test_expect_success 'preferred pack change with existing MIDX bitmap' '
> >  		test_path_is_file $midx &&
> >  		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> >
> > -		test_must_fail git clone --no-local . clone2
> > +		git clone --no-local . clone2
>
> I mentioned in patch 1 that this test could use some comments about
> what is unexpected and what _is_ expected. I think this comment needs
> an update in this patch:
>
> 	# Generate a new MIDX which changes the preferred pack to a pack
> 	# contained in the existing MIDX, such that not all objects from
> 	# p2 that appear in the MIDX had their copy selected from p2.

Good eyes, thanks for spotting. I updated the comment below, too (which
doesn't exist in this version of the patch, but you suggested adding to
the first patch in this series).

Thanks,
Taylor
