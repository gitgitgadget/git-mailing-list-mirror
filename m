Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="O2cOXDA2"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515BD126
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 12:28:24 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67aa00ea853so7990206d6.2
        for <git@vger.kernel.org>; Thu, 07 Dec 2023 12:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701980903; x=1702585703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCtiDkVOSYYa2bQpzzzixBuN5BkA3xJ3cmTCmAybmuk=;
        b=O2cOXDA2vDtsLwhoc42Zr2kjNCkiyu/9bk8MHFpZ0t6gmHq7jDOhR2WjEcjn6pcX+w
         xTByf27mvn79/MElDeYDrDHbh9UrXqfZXEKff/3JpD6hAc/8EZIVPAQ7HkHoypkBvMX2
         jbcGCYnnS+QvQm24S7qbXlDdHZlOLquecKwajdkVfeFiAqDCm8ypLk8AWUuQoNJoCjCk
         9BMPG2h6oHiFGQDq5B28i6Zq5dLmXYnnfWaAO6h1xO1h1x7P46SstkeVg3e+GttOlWMb
         7Ei28Uod/w4jiGzx1mTS8y1QM7Hf3GZyDg+g+zxHD88Foezr4FgzjofvnPKWNYS0VeWD
         rilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701980903; x=1702585703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCtiDkVOSYYa2bQpzzzixBuN5BkA3xJ3cmTCmAybmuk=;
        b=uXC4Va/NRbAj5/f6nllndSP/QL+E/1rMQGX3ZZo5TZdVsT7PLUfZTuNOa43dO2xZJ3
         UXrva8+zTPik4LeOFbsbgSmibYm3xWeA+PUB5SpUuPFfzgvR/e6RQZkXOTYDzNVgh2kD
         N7iKBHlglLfYh5X7B69JXYkO+YwONdDq+Ey5rbxm1llK5ZJ4cMIC2kf9JQapllM5bc+M
         MHyzESumCGU82YDAyRyyA695DsSet49sN/D/9wX1InYjig8m8Z5GHt5uAiosu6YqFL1B
         qWKivXHWbwcV0hHNBQIMQrZj2rcbMCeoL9zKi9L4JegDnzQ1Xq6Kvu9B/P4DD8qcNp/D
         IXOA==
X-Gm-Message-State: AOJu0YykZ6m1cRSj1iaJx7/nw+S8vnZzzUsTp6a96mMPwcHgK0amIZEK
	/NIZPRzp24rrzwrSckeUriGcNA==
X-Google-Smtp-Source: AGHT+IHYjjpNWLltOnEqwx8prTpZUdRtCqjbsd38iI0f8JJeP39/OgkFEDgXi3UDDfE9WLvKAux++g==
X-Received: by 2002:a05:6214:5ca:b0:679:e3aa:362c with SMTP id t10-20020a05621405ca00b00679e3aa362cmr3253057qvz.29.1701980903401;
        Thu, 07 Dec 2023 12:28:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a0e9600b0077589913a8bsm152748qkm.132.2023.12.07.12.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:28:23 -0800 (PST)
Date: Thu, 7 Dec 2023 15:28:18 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/24] repack: implement `--extend-disjoint` mode
Message-ID: <ZXIq4mjDUoqlGvgW@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <b75869befba26899d88d6c6d413cc756aeadbd80.1701198172.git.me@ttaylorr.com>
 <ZXHE5Lce_6CAWKFT@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXHE5Lce_6CAWKFT@tanuki>

On Thu, Dec 07, 2023 at 02:13:08PM +0100, Patrick Steinhardt wrote:
> > The gotchas mostly have to do with making sure that we do not generate a
> > disjoint pack in the following scenarios:
>
> Okay, let me verify whether I understand the reasons:
>
> >   - promisor packs
>
> Which is because promisor packs actually don't contain any objects?

Right.

> >   - cruft packs (which may necessarily need to include an object from a
> >     disjoint pack in order to freshen it in certain circumstances)
>
> This one took me a while to figure out. If we'd mark crufts as disjoint,
> then it would mean that new packfiles cannot be marked as disjoint if
> objects which were previously unreachable do become reachable again.
> So we'd be pessimizing packfiles for live objects in favor of others
> which aren't.

Yeah, that's right, too. There are a couple of cases where more than one
cruft pack may contain the same object, one of them being the
flip-flopping between reachable and unreachable as you suggest above.
Another is that you have a non-prunable unreachable object which is
already in a cruft pack. If the object's mtime gets updated (and still
cannot be pruned), we'll end up freshening the object loose, and then
packing it again (with the more recent mtime) into a new cruft pack.

That aside, I actually think that there are ways to mark cruft packs
disjoint. But they're complicated, and moreover, I don't think you'd
ever *want* to mark a cruft pack as disjoint. Cruft packs usually
contain garbage, which is unlikely to be useful to any fetches/clones.

If we did mark them as disjoint, it would mean that we could reuse
verbatim sections of the cruft pack in our output, but we would likely
end up with very few such sections.

> >   - all-into-one repacks without '-d'
>
> Because here the old packfiles that this would make redundant aren't
> deleted and thus the objects are duplicate now.

Yep.

> > Otherwise, we mark which packs were created as disjoint by using a new
> > bit in the `generated_pack_data` struct, and then marking those pack(s)
> > as disjoint accordingly when generating the MIDX. Non-deleted packs
> > which are marked as disjoint are retained as such by passing the
> > equivalent of `--retain-disjoint` when calling the MIDX API to update
> > the MIDX.
>
> Okay. I had a bit of trouble to sift through the various different
> flags like "--retain-disjoint", "--extend-disjoint", "--ignore-disjoint"
> and so on. But well, they do different things and it's been a few days
> since I've reviewed the preceding patches, so this is probably fine.

Yeah, I am definitely open to better naming conventions here? I figured
that:

  - --retain-disjoint was a good name for the MIDX option, since it is
    retaining existing disjoint packs in the new MIDX
  - --extend-disjoint was a good name for the repack option, since it is
    extending the set of disjoint packs
  - --ignore-disjoint was a good name for the pack-objects option, since
    it is ignoring objects in disjoint packs

Writing this out, I think that you could make an argument that
`--exclude-disjoint` is a better name for the last option. So I'm
definitely open to suggestions here, but I don't want to get too bogged
down on command-line option naming (so long as we're all reasonably
happy with the result).

> One thing I wondered: do we need to consider the `-l` flag? When using
> an alternate object directory it is totally feasible that the alternate
> may be creating new disjoint packages without us knowing, and thus we
> may not be able to guarantee the disjoint property anymore.

I don't think so. We'd only care about one direction of this (that
alternates do not create disjoint packs which overlap with ours, instead
of the other way around), but since we don't put non-local packs in the
MIDX, I think we're OK.

I suppose that you might run into trouble if you use the chained MIDX
thing (via its `->next` pointer). I haven't used that feature myself, so
I'd have to play around with it.

Thanks,
Taylor
