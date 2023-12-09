Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="w5RcveKW"
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7071710
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 18:30:16 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67ac8e5566cso17040006d6.3
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 18:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702089016; x=1702693816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxcBKIxqSqY/YcWH5U7VVYOE/9Oc38JBR9xsZkYmbRE=;
        b=w5RcveKWgHroDgwmZnKSfz5LLgS1wY1uCbeFlhXKZLxnRVWxrsytyytco3Sr1+QGaS
         +IcnBD5V1ynAA84vWlrTWafSK8HWiabeNrh17PQ1cwxNyY/4o+d1LnLKvZWGhGk8HRVJ
         1CqpOjhxdOCfieqqRkagk2ek5ZNsqhbQUEmAxu36yGquo/2VjSfSndAjtKq05IccJfiq
         n1iujnrh1WhAaS8PNN3/2aaHbuxRMDaVKC8HKCsnHEt7EJjn5dfDCMzXLJ0J3ae/R3sn
         e4JalXVOmCneZRiIt/e+kcsqmZ2/Bm5vsNRsiMtQGspUwXAweaX4XBXYpzQFHK6PcgT6
         hdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702089016; x=1702693816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxcBKIxqSqY/YcWH5U7VVYOE/9Oc38JBR9xsZkYmbRE=;
        b=e+DrkKmfEha2f0yq6hh+orPIE3aGU5vjYU5/d+VYfoqfp3NPpHbjeDjt6atjI+9YO2
         fndFROAnuORGxOm2rKjM+Bc630U9qov4hmhTjQzXyYe1IIxfR8d9iqKltdc1tiFsBIZS
         g6aPvw4kIZ/6pbqqbg8GsL+ze18Gmw4xmbd+rh1M1PaNhuyvgaSTTwncml+HpFCoiKDX
         Uv8GOxUsSfEKPHBy3S18l6N/+Y+3QmNlJlz8tKlbVQ6iu8QJUqEWHdvABY6PifFMd96V
         45SvuXo+GWg9fjnYT3z68+srdbM8OF7UHwbSOplAbCUfOr//g7AFyFDJMcrcLMERZGVI
         TSNA==
X-Gm-Message-State: AOJu0Yxbzf1vdSkxkoSf2+lkyHHsjuHI1EA3baSirhQ/XBvuQYq+78W5
	3Hqe+fO8VPWSltxhZLfvpkTx4lHDweohVkdGQZA=
X-Google-Smtp-Source: AGHT+IE4JlgyMKBvrIYmT/i/OSUsM3AJiv6B4Spkapv2IvU/lyyo4Q/cBQMJ0vf7nEvkxqP7B/u3NA==
X-Received: by 2002:a05:6214:2cd0:b0:67a:cc22:baab with SMTP id lf16-20020a0562142cd000b0067acc22baabmr1061513qvb.4.1702089015793;
        Fri, 08 Dec 2023 18:30:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pr5-20020a056214140500b0067a8fe21448sm1269667qvb.2.2023.12.08.18.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 18:30:15 -0800 (PST)
Date: Fri, 8 Dec 2023 21:30:07 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/24] midx: implement `DISP` chunk
Message-ID: <ZXPRL5yCTQKr0k7e@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com>
 <xmqqjzpv4ecg.fsf@gitster.g>
 <ZW95WSErCXvkfrAG@nand.local>
 <xmqqlea4nofm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlea4nofm.fsf@gitster.g>

On Fri, Dec 08, 2023 at 05:40:29PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Hopefully you're satisfied with the way things are split up and
> > organized currently, but if you have suggestions on other ways I could
> > slice or dice this, please let me know.
>
> I did wonder how expensive to recompute and validate the "distinct"
> information (in other words, is it too expensive for the consumers
> of an existing midx file to see which packs are distinct on demand
> before they stream contents out of the underlying packs?), as the
> way the packs are marked as distinct looked rather error prone (you
> can very easily list packfiles with overlaps with "+" prefix and the
> DISK chunk writer does not even notice that you lied to it).  As long
> as "git fsck" catches when two packs that are marked as distinct share
> an object, that is OK, but the arrangement did look rather brittle
> to me.

It's likely too expensive to do on the reading side for every
pack-objects operation or MIDX load. But we do check this property when
we write the MIDX, see these lines from midx.c::get_sorted_entries():

    for (cur_object = 0; cur_object < fanout.nr; cur_object++) {
      struct pack_midx_entry *ours = &fanout.entries[cur_object];
      if (cur_object) {
        struct pack_midx_entry *prev = &fanout.entries[cur_object - 1];
        if (oideq(&prev->oid, &ours->oid)) {
          if (prev->disjoint && ours->disjoint)
            die(_("duplicate object '%s' among disjoint packs '%s', '%s'"),
                oid_to_hex(&prev->oid),
                info[prev->pack_int_id].pack_name,
                info[ours->pack_int_id].pack_name);
          continue;
        }
      }

This series doesn't yet have a corresponding step in the fsck builtin,
but I will investigate adding one.

I'm happy to include it in a subsequent round here, but I worry that
this series is already on the verge of being too complex as-is, so it
may be nice as a follow-up, too.

Thanks,
Taylor
