Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B18B2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 23:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdFBX0B (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 19:26:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33266 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBX0A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 19:26:00 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so3154284pgc.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ii2u7aeTcS04EPG9dxyzYAodGVxr5OZKITuz2YebNk=;
        b=UM9jAS4AuNyv405o19qqn4OG4BrE5/WaQUdTv4mq8TvOq+oPWrG9oXP6tjnH/oQo+D
         w4IOzzM6RXmw7g6ND6s4wM/c//vtDxp455fzDI7bIc00e226I/H/dh72xiQHoJmopE6I
         zsNJV7J0dUu87a3bRhsOOd5zzaJQzSjL2NCaKtsK7/h8vxmxFxahO92lDmFLX5iKsnfZ
         axxyhubl1OJQV6IlGrv4Z6XdPEWRrUU5zgGPcQHV2CkoTKpJBY/eqfV7Mwrz2ms80NQ9
         rNXDrJV1gfjOgccQxXUZpJWlY2hak4rBSMQTxMKgsaPP+qAOfxfcZK6I6J+jkGyku4mi
         p0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ii2u7aeTcS04EPG9dxyzYAodGVxr5OZKITuz2YebNk=;
        b=Y+OQ8/Z6evTflTK/M2D4AyziYrverjSJ8i6+HHklpZaYGa4Sv4d02/BSCf02uDYzbY
         gNZZuRVrdkjGARUw1cA3J1L2otEYdJQGBX09iim0vPnVNqm7nHIWCY+WomRJYlhm+k2U
         ftvlkiEX+9jPw7iG7Jw6EKrVYX/1HtU5j85KJLlDnvBzYSJMiTcJWfkg+eAzKI5SHQar
         pvA49m/z0gVQkOZ/ZVEs3VMdHg20OHBf7nyUV0B2Z+IsRLSyz1qwuiiKRlxxTIK21DYr
         ARm5N5trka10X71CNB22kdX8iiCkz9hyvP6b+xWZkqI+S9WMzgqgYwIRL4I57dwt6XYe
         NmLw==
X-Gm-Message-State: AODbwcAsD3wLUAXf6Ld38r0T7TOxZsFT2FXOYvg2LJofw2XJBabr5q81
        kBg1U2ya/WJ2yw==
X-Received: by 10.84.135.101 with SMTP id 92mr2377462pli.114.1496445960035;
        Fri, 02 Jun 2017 16:26:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:c157:69:82e:3213])
        by smtp.gmail.com with ESMTPSA id q28sm37416846pgc.0.2017.06.02.16.25.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 16:25:58 -0700 (PDT)
Date:   Fri, 2 Jun 2017 16:25:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [WIP v2 2/2] pack-objects: support --blob-max-bytes
Message-ID: <20170602232508.GA21733@aiede.mtv.corp.google.com>
References: <cover.1496361873.git.jonathantanmy@google.com>
 <cover.1496432147.git.jonathantanmy@google.com>
 <6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com>
 <20170602222640.u6vni5tdpjp3sayt@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170602222640.u6vni5tdpjp3sayt@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Jun 02, 2017 at 12:38:45PM -0700, Jonathan Tan wrote:

>> +--blob-max-bytes=<n>::
>> +	This option can only be used with --stdout. If specified, a blob
>> +	larger than this will not be packed unless a to-be-packed tree
>> +	has that blob with a filename beginning with ".git".  The size
>> +	can be suffixed with "k", "m", or "g", and may be "0".
>> ++
>> +If specified, after printing the packfile, pack-objects will print the
>> +count of excluded blobs (8 bytes) . Subsequently, for each excluded blob
>> +in hash order, pack-objects will print its hash (20 bytes) and its size
>> +(8 bytes). All numbers are in network byte order.
>> ++
>> +If pack-objects cannot efficiently determine, for an arbitrary blob,
>> +that no to-be-packed tree has that blob with a filename beginning with
>> +".git" (for example, if bitmaps are used to calculate the objects to be
>> +packed), it will pack all blobs regardless of size.
>
> Hmm. So this feature can't be used with bitmaps at all?  That seems like
> a big downside, as we still have to walk the whole graph to come up with
> the list of blobs (even if we're sending them). That's 30-40 seconds of
> CPU per clone on torvalds/linux. I imagine it's much worse on
> repositories big enough to need a full GVFS-style "don't send any blobs"
> approach.
>
> We have a name-hash cache extension in the bitmap file, but it doesn't
> carry enough information to deduce the .git-ness of a file. I don't
> think it would be too hard to add a "flags" extension, and give a single
> bit to "this is a .git file".

A nicer approach IMHO is to include an extra bitmap, like the existing
object-type bitmaps (see the dump_bitmap calls in
bitmap_writer_finish).  This would would represent the set of all
.git* blobs in the pack.

[...]
>                      If you're not just avoiding large blobs but trying
> to get a narrow clone, you don't want the .git files from the
> uninteresting parts of the tree.

This is something I've wondered about, too.  Part of the story is that
we haven't started omitting trees, so there is already O(number of
trees) objects being sent and some additional small blobs for .git*
specials doesn't make it much worse.  Sending all .git* blobs keeps
things simple since the server doesn't have to infer which .git* blobs
are relevant to this client.

Longer term, we will likely want to allow clients to request omission
of some trees, too.  Omitting the corresponding .git* files becomes
more straightforward at that point.

Does that make sense?

Jonathan
