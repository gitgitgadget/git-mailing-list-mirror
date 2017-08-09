Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB2420899
	for <e@80x24.org>; Wed,  9 Aug 2017 00:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbdHIACN (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 20:02:13 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:36143 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdHIACL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 20:02:11 -0400
Received: by mail-ua0-f177.google.com with SMTP id k43so22278625uaf.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RaXaRBywd4oDQe/MEnI6uNl+2A3/C4pn+xzb24aM29Q=;
        b=TN7yY5wi/mnwzSbThqvX9RlX5rd+ILu1hBrt2AIx7WgP2RCAjrA7wpin7I7wFJPZ/x
         gzfNywI8sQwHLfShEIm65vtGW8n4bCu9NJ/zYoLb7L9jNeCEEIlJ2/x5EpbPdFZ9+iCl
         96PNH0OYNoeisl2vsVgNgf65KGXM3dkqtCbiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RaXaRBywd4oDQe/MEnI6uNl+2A3/C4pn+xzb24aM29Q=;
        b=FPBMvnA0nLgenDHi8f7XPe2hEtFzPRUMkg6YTGmAjMarFXvL9LVIwTvH5jcs//C3MF
         bdquxPiUWllAG3cGX2fnxezIs5TWzRfTSpddNSqc9LH3uNu1JjsCy1XTINhCX1n4PzEu
         wRPW/pNG4Lq72DdW9NfDtNcELsV/a0/VDcES3b1SHY3bKfd4jVbGGaBAPdDbJZhJjAw2
         vyFURz4det7j+RXjU2/82gEUixxaoYOxO4E7HdpCj/x1XZV52mUFNOSBLbfZG59PNVW6
         yhe0loIYKoqObk1uMsfKyzFUSGwBqbJieRYAF+DnBlQmJtlr3zdP7a74vCzRlqVcWQeH
         4NKA==
X-Gm-Message-State: AHYfb5jydAqhdeMxoYNQG/Ah7WE96QehcxYIKtoVplltUx1eYtoS2041
        gdHJiJZI4NcGBa0I9OtnomWwVMc7wedr
X-Received: by 10.176.75.167 with SMTP id v39mr4482128uaf.11.1502236930280;
 Tue, 08 Aug 2017 17:02:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 8 Aug 2017 17:01:49 -0700 (PDT)
In-Reply-To: <xmqqy3qt8wi0.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
 <xmqqtw1hc28z.fsf@gitster.mtv.corp.google.com> <CAJo=hJsyoFeCQbeJ=2XCRcE1U0zYaRr8VvzXHwkPwisdfUm71Q@mail.gmail.com>
 <xmqqy3qt8wi0.fsf@gitster.mtv.corp.google.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 8 Aug 2017 17:01:49 -0700
Message-ID: <CAJo=hJt5b=e1-k7FnMixe7vqH8V0ynCHQU80aWKAMJzghU+s3A@mail.gmail.com>
Subject: Re: reftable [v6]: new ref storage format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 4:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> Given that the index can now also be multi-level, I don't expect to
>> see a 2G index. A 2G index forces the reader to load the entire 2G to
>> take advantage of the restart table. It may be more efficient for such
>> a reader to have had the writer make a mutli-level index, instead of a
>> single monster index block. And so perhaps the writer shouldn't make a
>> 2G index block that she is forced to buffer. :)
>
> Ah, OK, then it is sensible to have all table blocks to have the
> same format, and restart at the beginning to help readers would be a
> fine choice.  For the same "let's make them as consistent" sake, I
> am tempted to suggest that we lift "the index block can be 2G" and
> have it also be within uint_24(), perhaps?  Otherwise the readers
> would have to read (or mmap) the whole 2G.

Gah. I just finished moving the restart table back to the end of the block. :)

However, I think I can agree with the index fitting into the uint24
size of 15M, and asking writers making an index that exceeds that to
use multi-level indexing.
