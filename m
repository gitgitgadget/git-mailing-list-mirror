From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 04/19] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 11 Mar 2016 08:11:57 +0700
Message-ID: <CACsJy8CT7x3p2TLvMbJ2OkNbd=PZ7bxZQJv1wSU1j_8s826J2A@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-5-git-send-email-dturner@twopensource.com>
 <xmqqtwkffdus.fsf@gitster.mtv.corp.google.com> <xmqqpov3fdb6.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CqOOB6C6bWkVSEvtPuHxZR_avSb7z7hgo-vtv3gu44Cg@mail.gmail.com> <1457641341.13557.32.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 02:12:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeBd7-0008Mz-9x
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 02:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933041AbcCKBMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 20:12:30 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36503 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932892AbcCKBM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 20:12:28 -0500
Received: by mail-lb0-f169.google.com with SMTP id x1so135949588lbj.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 17:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3fiPD9zAzeqfUw8PcGwc/Ul2rWxofcXGXf82YxULS0U=;
        b=EIBqxlljlkr5Y1qoNPms82PiUedfUeavRLPSrZvWV2rveFGlIn6HYftCLLssnjS88u
         ywDZXlez/TqsNE+40pA29CMQ/cvpeEI9MSpqFm9tOY4pTI73DijfjE3qlUdAG9nOFmKM
         gXuWYPvgHR91Hx5EfH5I2iKxep2prkChUod64W/sBvE3xUaGfVKXSK2iJbp4deKTqw4U
         xaY6SXlvbAmjk37bsmgL+9HX9eDvcT8iKCGfJKbUr527Obwu7bfjvvmmV0kUgoK65OCR
         I0/FGZKmVSigiaWVX+y5So/9qyo4ppkcPKC02k3o1PBrnrYN0JIn8Xt5opdfaqigKtXY
         gpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3fiPD9zAzeqfUw8PcGwc/Ul2rWxofcXGXf82YxULS0U=;
        b=L91dRd5QyDxf1EdJWlitF1o2epwKLkEDpNi56x0LLdub478Mp+mLgxLG6WMDa1GhDs
         cQ67kTfMmy3Tfe38Nip0Obu45QoJanKJXPcsFhMaK0eo0IaZ7HuKILEoz2vEuMB/ck8b
         KYAZYswalpznSIDOQPI4ssES+DQ5B4tvmXcjT/S7+3GamPAhRx2KuABdDsQKgn7LGKW6
         /f320pQ3Te/9il4mFLldLmV1eB+TbiAfsPlFETg7X3mQuv4FmkPpgmpDyTAxA+BSyPQK
         2Uc0ObxYO/IiXcb5/sKKnRaFtV+XL6VWmWVYf4NymBnbDTpftqzLK08TkNoEeHLWiriO
         +cDQ==
X-Gm-Message-State: AD7BkJIojJdNAsMSENUIlBPlSaFRHtmsc8Erjl4QpQsokJE8+Bv4eSHNaGUTn4ayGf40xvrQltbmw/fcB603ag==
X-Received: by 10.112.150.133 with SMTP id ui5mr2199297lbb.12.1457658747075;
 Thu, 10 Mar 2016 17:12:27 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Thu, 10 Mar 2016 17:11:57 -0800 (PST)
In-Reply-To: <1457641341.13557.32.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288669>

On Fri, Mar 11, 2016 at 3:22 AM, David Turner <dturner@twopensource.com> wrote:
> Reads (ignoring SHA verification) will be slightly slower (due to the
> btree overhead).  If, in general, we only had to read part of the
> index, that would be faster. But a fair amount of git code is written
> to assume that it is reasonable to iterate over the whole index.  So I
> don't see a win from just switching to LMDB without other changes.

I didn't think of the btree overhead. Will need to run some test.. I
think lmdb just gives us pointers to mmap'd file, so an entire index
reading can be fast. We just record where the on-disk data is. We need
to make index-on-lmdb use native byte endian though to avoid
conversion and actually reading all index entries because of that.

> (I guess we could parallelize index deserialization more easily with
> lmdb, but I don't know
>
> The original intent of the index was to be a "staging area" to build up
> a tree before committing it.  This implies an alternate view of the
> index as a diff against some (possibly-empty) tree.  An index diff or
> status operation, then, just requires iterating over the changes.
>
> I haven't really dug into merges to understand whether it would be
> reasonable for them to use a representation like this, and what that
> would do to speed there.

I think we keep the same internal representation of the index, a list
of paths with extra info like stat and some flags. Minimal impacts to
the code base that way. There are some cases (I think) where we just
need to read a portion of the index (filtered by pathspec). If we
don't update the index afterwards, lmdb partial reads definitely help.
I need to check if those cases are common (and worth optimizing for)
though.

> In general, git takes the commit side of the commit-diff duality. This
> is generally a good thing, because commits are simpler to reason about.
> But I wonder if we could do better for this specific case.
>
> But I don't think switching to LMDB would replace index-helper.

The point of index-helper is reduce reading cost (let's leave watchman
out for now). But it looks like we're not certain if using lmdb can
reduce reading cost at lower complexity. I'll give it some thought
over the weekend. Maybe in the end we better just go with
index-helper...
-- 
Duy
