From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCHv2 0/10] pkt-line and remote-curl cleanups server
Date: Tue, 19 Feb 2013 23:14:45 -0800
Message-ID: <CAJo=hJsRJ4iEL0MmH9sdz2UXFm76vVE3OxcVBR6hE1PavzGfPQ@mail.gmail.com>
References: <20130216064455.GA27063@sigill.intra.peff.net> <20130216064929.GC22626@sigill.intra.peff.net>
 <20130217110533.GF6759@elie.Belkin> <20130217192830.GB25096@sigill.intra.peff.net>
 <20130218014113.GC3221@elie.Belkin> <20130218091203.GB17003@sigill.intra.peff.net>
 <7vhalaas2b.fsf@alter.siamese.dyndns.org> <20130218093335.GK5096@sigill.intra.peff.net>
 <7v8v6mar4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 08:15:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U83tu-0004Yl-Kk
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 08:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933679Ab3BTHPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 02:15:07 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35215 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933676Ab3BTHPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 02:15:06 -0500
Received: by mail-ie0-f171.google.com with SMTP id 10so9612651ied.30
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 23:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TmIP3RCaOYGMGWwVAt9HSwBJNYGCe6T5rLz09MvzWtk=;
        b=Zl8znwTpfD6HeP9Fl6nvYUzhDHtJupTei5XLsEJmwqcx11zQd/95Ta0nJF+HpdRuRi
         FgF+4ZPnrLmxbhFXekZ6nWdkAbKBqu5adn2e63XyKDmokDmVdNHy369ArzD9FjZOLrkB
         asQe9oVbj5xQ2a6Zq/KRbxO3kcx1P6k04bmM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=TmIP3RCaOYGMGWwVAt9HSwBJNYGCe6T5rLz09MvzWtk=;
        b=QzyoxkySLR1xJahlHuu6W6OXRQb6xTEfpPW/u+f4hCRrvqGmXoEdWP03L38FU+4XxA
         yD0JhSNdjhO3PfpuKdPoGWYDoaFl66k9BEQojq9u5gO0lk3RLcLiGv0RasgDl5i0sB7s
         jITjsGwQrRn4lgqtKYdZb04aJmHhFD9gCp1bhyP5YaQLdEuovo2w5PtOI8GAgiTz1AEC
         Is+WBXMSyTEYRr7VXk/4J3pi29Oi1VeB7xNIcxhjzQGP6RwEZDWvpX9t/GhKC9z4QTik
         +M7tA7MRhABrqWUw4dweXCADIX8xrEl2PexnHow6UiVLstZjJ51p7pbr2epa6gUdW46h
         6otA==
X-Received: by 10.50.173.105 with SMTP id bj9mr8881391igc.44.1361344505302;
 Tue, 19 Feb 2013 23:15:05 -0800 (PST)
Received: by 10.64.89.99 with HTTP; Tue, 19 Feb 2013 23:14:45 -0800 (PST)
In-Reply-To: <7v8v6mar4e.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQklGB8rXPaJqr6JBIN4DJrF+ZBCy6HzpPszYNx1rH8wBUNwJpmIBLtpC5h4B9g/ILTGMrAz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216687>

On Mon, Feb 18, 2013 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Feb 18, 2013 at 01:29:16AM -0800, Junio C Hamano wrote:
>>
>>> > I just checked, and GitHub also does not send flush packets after ERR.
>>> > Which makes sense; ERR is supposed to end the conversation.
>>>
>>> Hmph.  A flush packet was supposed to be a mark to say "all the
>>> packets before this one can be buffered and kept without getting
>>> passed to write(2), but this and all such buffered data _must_ go on
>>> the wire _now_".  So in the sense, ERR not followed by a flush may
>>> not even have a chance to be seen on the other end, no?  That is
>>> what the comment before the implementation of packet_flush() is all
>>> about.
>>
>> Despite the name, I always thought of packet_flush as more of a signal
>> for the _receiver_, who then knows that they have gotten all of a
>> particular list. In other words, we seem to use it as a sequence point
>> as much as anything (mostly because we immediately write() out any other
>> packets anyway, so there is no flushing to be done; but perhaps there
>> were originally thoughts that we could do more buffering on the writing
>> side).
>
> Exactly.

This is also my understanding of the flush-pkt ("0000"). Its an
end-of-list/end-of-section marker to let the peer know the protocol is
moving to the next state. Except where the protocol can move to the
next state without a flush-pkt of course (see below).

> The logic behind the comment "we do not buffer, but we should" is
> that flush tells the receiver that the sending end is "done" feeding
> it a class of data, and the data before flush do not have to reach
> the receiver immediately, hence we can afford to buffer on the
> sending end if we can measure that doing so would give us better
> performance. We haven't measure and turned buffering on yet.

So funny story. JGit actually buffers the pkt-line writes in memory
and does flushes to the network socket when any of the following
happen:

- fixed size in-memory buffer is full (8k or 32k by default)
- flush-pkt is needed in the protocol
- JGit forces a flush without a flush-pkt

There are places in the protocol where data needs to be shared with
the peer *despite* not having a flush-pkt present in the data stream
to do that. ERR is one of these places. "done\n" at the end of the
negotiation in a client is another. Sending ACK/NAK in a multi_ack
from upload-pack is another. I may be missing more.

JGit had to define three methods to make the pkt-line protocol work correctly:

- writeString: format a string as a single pkt-line, insert into buffer.
- end: write "000" into the buffer, flush the buffer.
- flush: flush the buffer if it has any content.

I always found that comment in front of that function funny. Its
totally not true. Fixing it is harder than just stuffing a buffer in
there and hoping for the best. The callers need work. At which point
that function isn't really what its author was trying to do.

> But when dying, we may of course have data before flushing. We may
> disconnect (by dying) without showing flush (or preceding ERR) to
> the other side, and for that reason, not relying on the flush packet
> on the receiving end is a good change. Once we turn buffering on, we
> probably need to be careful when sending an ERR indicator by making
> it always drain any buffered data and show the ERR indicator without
> buffering, or something.

Yes.
