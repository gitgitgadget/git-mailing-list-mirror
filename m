From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH/RFC] index-pack: produce pack index version 3
Date: Thu, 16 Aug 2012 08:54:00 -0700
Message-ID: <CAJo=hJtgq7j67RU28ziQN4xUX7S5-YcaiApmcpMSYdamV-0SgQ@mail.gmail.com>
References: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
 <7vtxw8exii.fsf@alter.siamese.dyndns.org> <7vlihjgaaj.fsf@alter.siamese.dyndns.org>
 <CACsJy8CNp2w6PsMSrQ4aFBwHKbOGid4pVHUhE4xgmTatrnEepQ@mail.gmail.com>
 <7v8vdjfddk.fsf@alter.siamese.dyndns.org> <CAJo=hJtwS=fdjTCVsEQHdVn9p+_2k-wJ_W_zLtZkWGO+M4suNQ@mail.gmail.com>
 <7vmx1v2y01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 17:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T22Oz-0006KH-B0
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 17:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab2HPPyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 11:54:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41145 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2HPPyV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 11:54:21 -0400
Received: by yenl14 with SMTP id l14so3052854yen.19
        for <git@vger.kernel.org>; Thu, 16 Aug 2012 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MrxweFuH6UaW5lTgSIICH25NNZI/Y4TUGCUD1q647Po=;
        b=KFt3PwqRdao9QGnMhsp5vtVCMlWynlViFZ1U7ZSekspjuwGGCKVN9KHloLvBgwGQqi
         RETBNMB61JHUcqPZQQznC8d3YxlEzd8GcnTr7ntkJw0rpzTTbaMr89KLF1odWBocFcq/
         HZgswxJ++XlwxkEyYJAAgZts1MKk7zZVVGPpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=MrxweFuH6UaW5lTgSIICH25NNZI/Y4TUGCUD1q647Po=;
        b=P1h4babBm36hsppDp7p3kMiXWNqYfsQH27FohdLrK+oMOpfeG7mK3fFP7yrkxSBejW
         3tctvXOD7RPDegOj7H66h656/if/yQBAniGvY5e/kPzpGa0pMKjFZ0+DT/YF+0iBbqSQ
         Cq8/YCFRXtmQfUNg8f0pKOa27MGDyKxJVIPhcBX07uduP+is2Lqqf4sBKcg65Mqd2Q5k
         3/SzkYF1opXweBxNRCBfIrsCo8pez+cY3Xz1jjC+gUljc83IdXv2RgshYky0teWFSulb
         eqhv3yUjNX0a5iaUHgp6i5QiC4CMgmPH8tpxKUI9c1JrTeBuGjTeSQhRWuK0nH17Fn1d
         L6mg==
Received: by 10.50.236.4 with SMTP id uq4mr2251403igc.18.1345132460628; Thu,
 16 Aug 2012 08:54:20 -0700 (PDT)
Received: by 10.64.141.50 with HTTP; Thu, 16 Aug 2012 08:54:00 -0700 (PDT)
In-Reply-To: <7vmx1v2y01.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlJo+XBCVJUv2E1Zn/9EvN5tMS075LxqhRRd/ssPW/G8VFdRuc9VbSe8u6yJPDg7/s87fwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2012 at 10:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> ... But I think its worth giving
>> him a few weeks to finish getting the code ready, vs. rushing
>> something in that someone else thinks might help. We have waited more
>> than 6 years or whatever to improve packing. Colby's experiments are
>> showing massive improvements (40s enumeration cut to 100ms) with low
>> disk usage increase (<10%) and no pack file format changes.
>
> No matter what you do, you would be saving the bitmap somewhere
> outside the *.pack file, yes?  Will it be in some extended section
> of the new *.idx file?

Yes, because it is derived from the pack stream its stored external
from it. We have chosen to append it as a new section below the CRC-32
table in the *.idx file. It could also go into a new file stream
(*.bdx?) but I don't think this is worthwhile. Its a bikeshed that can
be painted once the algorithm has proven its value. If it can't do
that, its irrelevant where its stored.

> With the bitmap, your object enumeration phase may go very fast, and
> you would be able to figure out, in response to a fetch request "I
> have these tips of refs; please update me with these refs of yours",
> the set of objects you would need to pack (i.e. the ones that are
> reachable from your refs that were asked for, but that are not
> reachable from the refs the requestor has).

Yes. Not only that, but we are finding that the number of objects to
send is fewer, resulting in a much smaller data stream. The bitmap
gives us near perfect knowledge of everything the client has, not just
the objects on the edge of the graph cut expressed by the ACKed have
lines. Objects that existed earlier than the cut don't have to be
reset.

So the object enumeration phase goes very fast. The compressing
objects phase is also time reduced, as fewer objects are needed to be
considered, as fewer objects are being sent. With more complete
knowledge of the have side, more deltas can be reused as-is, rather
than re-encoded on the fly. This reduces the compressing objects phase
time even further. And with fewer objects to send, we have easily seen
trivial cases of a Linux kernel fetch that is 1 week behind Linus' tip
save like 200K on an 800K transfer. Its hard to hate having all of the
phases go faster, and transmit less data to the client.

> Among these objects, there will be ones that are expressed as a
> delta against what you are going to send, or as a delta against what
> you know the recipient must already have (if you are using thin pack
> transfer) in the packfiles you have, and you can send these deltas
> as-is without recomputation.

Yes. I point that out above before even reading this far in your message. :-(

> But there will be ones that are either expressed as a base in your
> packfile, or as a delta against something you are not going to send
> and you know that the recipient does not have.  In order to turn
> these objects into deltas, it may be necessary to have a way to
> record which "delta chain" each object belongs to

Excellent observation. Instead of performing a hacky delta base search
by looking at identical path names in the have set, finding another
candidate in the same cluster of deltas that the object is currently
encoded against would yield a pretty efficient delta on the wire. It
doesn't have to be another object in the same chain, it could also be
a sibling object that shares a similar transitive delta base.

>, and if you are
> introducing the mechanism to have extended sections in the new *.idx
> file, that may be a good place to do so.

Thus far we haven't done an extended sections modification to the
*.idx format. Its just a 'E003' version that requires the bitmaps to
be present below the CRC-32 table. But I can see how framing this as a
group of optional extensions would be worthwhile.

>  When you need to express
> an object that your bitmap told you to send (as opposed to rev-list
> walking told you with the paths to the objects), you can find other
> objects that belong to the same "delta chain" and that you know are
> available to the recipient when it starts to fixing the thin pack
> using that extra piece of information, in order to find the optimal
> delta base to encode such an object against.

Yes.

> Just for fun, I applied the attached patch and repacked the history
> leading to v1.7.12-rc3 with the default depth/window:
>
>   git rev-list --objects --all |
>   git pack-objects \
>       --no-reuse-delta --no-reuse-object --delta-base-offset \
>       [--no-namehash] pack
>
> with and without the experimental --no-namehash option.  The result
> is staggering.  With name-hash to group objects from the same path
> close together in the delta window, the resulting pack is 33M.
> Without the name-hash hint, the same pack is 163M!  Needless to say,
> keeping the objects that should be hashed together inside a delta
> window is really important.

Cute experiment. Yes that name hash works as a decent predictor of
which objects should go near each other in the delta window. So does
the descending size sort.

> An obvious way to record the "delta chain" is to simply keep the
> name_hash of each object in the pack, which would need 2 bytes per
> object in the pack, that would bloat pack_idx_entry size from 32
> bytes to 34 bytes per entry.  That way, after your bitmap discovers
> an object that cannot reuse existing deltas, you can throw it, other
> such objects with the same name-hash, and then objects that you know
> will be available to the recipient (you mark the last category of
> objects as "preferred base"), into the delta_list so that they are
> close together in the delta window.

Yes, this is one thought I had. Inside of JGit I think the name hash
is 32 bits, not 16 bits. Storing the name hash into the *.idx file
means we need to codify what the name hash algorithm is for a given
*.idx file version, and compatible implementations of Git must use the
same hash function. Thus far the name hash has been an in-memory
transient concept that doesn't need to be persisted across runs of the
packer. Storing it means we have to do that.

Another alternative is to try and group objects by delta clusters. Tag
each object with some marker for the non-delta base object the delta
chain it builds on top of. Delta groups are supposed to tend to be
bushy and not long, so many many objects should share the same common
base object. Most of them have the same name hash, but even when they
don't their contents were near enough together that the prior packer
run chose to combine these together. This avoids the need to encode
the name-hash function into the *.idx file format, and instead lets us
work with something that any implementation can easily observe from
the file's contents.

Tagging each object with its base could cost 4 bytes per entry, so
32->36 bytes... a 12% increase in file size. It may be possible to
organize these as bitmaps and get really good compression from deltas
that are located near each other in the pack stream, but doing the
lookup to identify which base would be more expensive. We would
probably have to walk the object's delta chain backwards to identify
the base, then inflate the bitmap to identify the candidate siblings.
