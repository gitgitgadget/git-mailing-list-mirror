Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4C46441
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717964695; cv=none; b=D9ncUPjTH+L+3ALaQPRcHcw1TlR56sh/jTaBCX880bDZSXXIRXxW6yoCfJJaYf7Yw6bJUwbdptzTJO2epMb8oAdsm8xi0SXQKuYiVYDbf4nPBbMGssVh+nOH7yymQPRWIcWvi1J5PSFngYwlP2mR0c/o83/WdL8w4iFfVBbCCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717964695; c=relaxed/simple;
	bh=DbVpCwqDN1e7yqCtChuQ38VG7g854zHwgTKtqAEzpGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn1ZZXJNbDbbpP/zWGs+i3CIVe4attMWRGFxn6CNEqvE7fU2lNTViRviY5OfkFydznnig2lPXYHXxVb7zbp+yyrcxrvDHBdNl2xFH2IzeRRBtIikpf54TOh6BO8UwZpeu+dQHx9oQrvobCd/PWQN1yLrRX+TUAb4PKl65fUJRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=x5B3UFgq; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="x5B3UFgq"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b081c675e7so35666d6.1
        for <git@vger.kernel.org>; Sun, 09 Jun 2024 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717964693; x=1718569493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Gfr7C8uT0Agb2xpeDrEhMwXQ3LKd8WDTVspiD5Nd2A=;
        b=x5B3UFgq684vl3UhxWAvoWLHmzAsx8nw8cREmHkDfIrB//AdxDKJqF9Swl3QirFT4h
         Q2MksKN4FfUsJczQME36r2MaNhWt7q1Aok+zY8BhVc3zQdytJDQwwN8hR9zPZ1RaFKp+
         IC1IuSW4nWk6iCAqb62oyXByn4Vvlf8O9Qee3dUffGoCSqgVWj8ngiA4+tbvcW+khZP1
         w/QxnJTlDJ54aTHNSehQXheqUrmuhv/hH7CvZSwVEyYbCt6G4JZyQ7phrxlc+ZmnmkIK
         FYjOwccK58VEvEg092v7NDy6zGSKaeo2+AzFRmQbwiiJCTXivtDbgqo+j5cNx7O/w9C8
         EpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717964693; x=1718569493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Gfr7C8uT0Agb2xpeDrEhMwXQ3LKd8WDTVspiD5Nd2A=;
        b=LMOSkSCLk0dciRjmji7iA7WywjE0HnCkn3JcZam9ERH0bBbLmUKFWXJTdm6D/9R5tE
         kdEguYDFsGX2naRaBHSufFcf89UGvx7wQv8fcLOYALIBc8caktYL/1I60pDpgW4pBqYF
         T5jOx0FwUr8OXiGsZwwBcFhU8E9xbPCemuSig5XIextAi37xSxZe7/pBdbPZItZa8nz7
         5FKHmGANQXAyT5pmgLQoiSOH2LqlENT0tWdcbNSw5yQk6DgDApvp/SfjgVFLMTSh9sY+
         pYwti+4eezgS+oP0NqLCsQ4e8Z2qEkoQcjc3/KUUxQ4lwGJhWD+IE743GhLhbphj/BvF
         socQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI9DG8d0TAUf0SWebl//bry9uNjEVBRtt6P4Lr3cOYtZCYIcilZqn9o1pflJWA8TzIM/olJzcnwqSXl0YRz8rOcSad
X-Gm-Message-State: AOJu0YwpXU7DaYAvaaEfVLnRBrVIvwwGx8KBCwqF8qmBR3D+euH7gGlS
	b8hlVOO4V1fVvb81EPyxqByvRH8hE25wy9+N+S3r6+OeMKQbLJjRjWQ9votnTMI=
X-Google-Smtp-Source: AGHT+IHynigvVk+OeaaUB2N/Q1nPDs3AIEk5aKougI9iikb3N9jTL3ecaENcPkRqV4/UW62Z+skL1A==
X-Received: by 2002:a05:6214:3b87:b0:6ad:5c79:b0e7 with SMTP id 6a1803df08f44-6b059cfa8camr76122916d6.40.1717964692754;
        Sun, 09 Jun 2024 13:24:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b063f995casm25502436d6.18.2024.06.09.13.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:24:52 -0700 (PDT)
Date: Sun, 9 Jun 2024 16:24:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Kyle Lippincott <spectral@google.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: MSan failures in pack-bitmap
Message-ID: <ZmYPjuGnh+UvT5dt@nand.local>
References: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>
 <20240608081855.GA2390433@coredump.intra.peff.net>
 <ZmXKzJ9CpbYTmTwC@nand.local>
 <xmqqmsnuaqus.fsf@gitster.g>
 <ZmYJ+d3+j1E08Ms/@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmYJ+d3+j1E08Ms/@nand.local>

On Sun, Jun 09, 2024 at 04:00:57PM -0400, Taylor Blau wrote:
> A more likely outcome would be if a Git client who was using MIDX
> bitmaps, but only doing single-pack reuse tried to generate a pack to
> push to some remote (or vice-versa, replacing client and server/remote)
> which ended up being corrupt in some fashion. I haven't had enough of a
> chance to determine if this possible, though I suspect it is.

OK. I looked a little more, and I think that though this is possible in
theory, it is exceedingly rare to hit in practice.

The thing that we care about reading pack_int_id is for rejecting
cross-pack deltas in try_partial_reuse(). A cross-pack delta occurs, for
some delta/base pair when either half of the pair was selected from
different packs in the MIDX. When this is the case, we can't verbatim
reuse the delta object, since the base object may be selected from a
pack that was reused later in the MIDX, thus we'd have to convert to a
REF_DELTA on the fly.

(This is a bit of an aside, but it is technically possible to allow
cross-pack deltas if you are careful, I just didn't implement it thus
far, though I would like to do so in the future).

So when we try and do a partial reuse (i.e. on a single object instead
of saying, "these N words in the bitmap of objects that we want to pack
are all ones, so we can blindly reuse a chunk of objects from the
beginning of this pack) we check if the object we're reusing is either
an OFS_DELTA or a REF_DELTA. If it is, *and* we're reusing it from a
MIDX, we need to check that its base object was selected in the same
pack.

That's what we're doing when we call:

    midx_pair_to_pack_pos(bitmap_git->midx, pack->pack_int_id,
                          base_offset, &base_bitmap_pos);

If we can't find the base object in the same pack, we toss out the
cross-pack delta and kick it back to the regular pack generation logic.

So in order to hit this in a way that would produce a broken pack, you'd
have to have the uninitialized memory at pack->pack_int_id be set to the
same value as some MIDX'd pack's pack_int_id, *and* have that pack
happen to contain the same object as the base of some delta that you
would otherwise want to throw out.

If that were all to happen, then you would likely end up with a broken
pack. But I think in the vast majority of cases try_partial_reuse()
would read garbage out of pack->pack_int_id, and kick it back to the
regular pack generation logic, and produce a correct pack (albeit doing
so using a slightly slower path).

But this is all much too close for comfort for me. I think that this
points to a gap in our test coverage, and that we should ensure that
this case is covered.

(Note, I'm not sure exactly how to do this, since such a test would
depend on an uninitialized read. I'll think about this a bit more and
see if it is possible to write such a test.)

But in summary, though I think it is possible for either a client to
send a broken push to a server (if the client were using MIDX bitmaps
and only doing single-pack reuse) or for a server to send a broken pack
to a client (if the server was also using MIDX bitmaps in the same
fashion), I think that it is exceedingly rare to hit in practice. Which
is not the same as saying that it is impossible, of course, but I am
confident with the fix I posted in:

    https://lore.kernel.org/git/4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com/T/#u

to fix the issue. Note also that I don't think a repository would be
able to actually corrupt itself using this bug, since we don't bother
taking this code path at all during repacks.

So in short, I think the fix I posted above should be tracked down to
'maint' at least for the 2.45.x series. It will avoid the MSan failures
and more importantly the issue I described above. I would also like to
find a way to further test this case so that we aren't bit by such a bug
in the future.

Thanks,
Taylor
