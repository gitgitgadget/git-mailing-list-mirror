Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE104C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 01:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbiCWBDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 21:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiCWBDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 21:03:15 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AD65E769
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 18:01:46 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a5so197798qvx.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 18:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+haSQnX75YJylpjV7pR6LrTE+G7aE40e9swL2wtpXwg=;
        b=5zuB4kf0iUJZgzHuXRSI+a1sWp8Phalo2gdDi/ddvhTiZiC0xSJQWMFDaPNj1RNH34
         tij/9H7wwN1DPVXSUv2hyG3wn0pVxixGHYk2d+nDO3pyEt7SLKYX3lIG13QJi6u4/8VP
         gHZgw1vRDPWWExw6FaBUDqcLvys4V51i6mBY3+BbV3kTeecVnkQhaV6MuohD7j9hjw/x
         VLUDfI1XEhX7vxrpl0Zoryygj3U8h8+xFQtq0RaZQNdcz1xFs2hhhibG3EGq+sDxvTmv
         9ZoDcWIuAfov11U/pz5uwuo3I3vZYRzNHla+/9M3wj98iCR7siO6FDUIH42o9+ZX45pO
         gY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+haSQnX75YJylpjV7pR6LrTE+G7aE40e9swL2wtpXwg=;
        b=i3z0V7wbCYgIbARlDZxL7JH5/7Jcu6h620eiI0T9lw00KbLUbSF/xDbPVsVMuHW707
         XhdWcc3Zf+E8HJdshQLjWsIv5kG4qvKrGpAjst+6FnP1UIIPrXZ0suuRr+HVhJnU/qST
         vpRuhKuBjzjD9YBAyhOJxPcwKbzzpGKHY5Vc2Oejg+YJ60SG1BHSQo9zbcPk4nIacacP
         GNAwUVAQFsB3CTwofBeyAiSOKCHT9PY+eMeMDO+Hyzc14PB0yjidfu3cZdfdIUVuNWG5
         iTv0H3pmd5B6121ybZTquFO4xqeFpl2dSdDHaBYwLba/CErDUxjaNBarHX/sTJgPzX9q
         237w==
X-Gm-Message-State: AOAM531zCQmdgBo9DsTpwtmtrvSLSG1uVuo020ttNZrLDAy7hVaS4KKW
        TL/BoKDmq8zlI1kqQUpOJmJVtA==
X-Google-Smtp-Source: ABdhPJwSMhFpv/MspKELyF9oLimAcTp6+m9JsnYa3lU22oaM6T1v02GwtwoVgqjEsmWaQ2SMMXO4BA==
X-Received: by 2002:a05:6214:1c5:b0:42c:1227:c542 with SMTP id c5-20020a05621401c500b0042c1227c542mr22568881qvt.11.1647997305282;
        Tue, 22 Mar 2022 18:01:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j11-20020a37a00b000000b0067b436faccesm9891746qke.122.2022.03.22.18.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 18:01:44 -0700 (PDT)
Date:   Tue, 22 Mar 2022 21:01:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, tytso@mit.edu,
        derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <Yjpxd8qhwnAIJJma@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
 <YiZI99yeijQe5Jaq@google.com>
 <YjkjaH61dMLHXr0d@nand.local>
 <YjpDbHmKY9XA2p0K@google.com>
 <YjpHbaBspUasDdEy@nand.local>
 <YjpWFZ95OL7joFa4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjpWFZ95OL7joFa4@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 22, 2022 at 04:04:53PM -0700, Jonathan Nieder wrote:
> Hi,
>
> Taylor Blau wrote:
> > On Tue, Mar 22, 2022 at 02:45:16PM -0700, Jonathan Nieder wrote:
>
> >> Great.  Can the doc cover this?  I think it would be helpful to make
> >> that easy to find for others with similar questions.
> >
> > I believe the doc covers this already, see the paragraph beginning with
> > "Unreachable objects aren't removed immediately...".
>
> Thanks.  I just reread that section and it didn't say anything obvious
> about the race that continues to exist and whether cruft packs address
> it.

Yeah, there isn't an explicit "and cruft packs addresses the loose
object explosion but does not address the race" sentence. I'm not
opposed to adding something like that to clarify (though TBH, I would
rather do it as a clean-up on top rather than send out a bazillion
mostly-unchanged patches).

> [...]
> >> Sorry, the above seems like it's answering a different question than I
> >> asked.  The doc in Documentation/technical/ seems like a natural place
> >> to describe what semantics the new .mtimes file has, and I didn't find
> >> that there.  Is there a different piece of documentation I should have
> >> been looking at?
> >
> > Are you looking for a technical description of the mtimes file? If so,
> > there is a section in Documentation/technical/pack-format.txt (added in
> > "pack-mtimes: support reading .mtimes files") that explains this.
>
> I see --- is the idea that cruft-packs.txt means to refer to
> pack-format.txt for the details, and cruft-packs is an overview of some
> other, non-detail aspects?
>
> I just checked pack-format.txt and it didn't describe the semantics
> (what a Git implementation is expected to do when it sees an mtimes
> file).  For example, in Documentation/technical/cruft-packs.txt, the
> kind of thing I'd expect to see is

Right; I have always considered the files in Documentation/technical to
primarily be about the file format itself.

> - what does an mtime value in the mtimes file represent?  When is it
>   meant to be updated?
> - what guarantees are present about when an object is safe to be
>   pruned?

The cruft-packs.txt document covers these, though I think somewhat
implicitly. Again, I'm not opposed to more clarification, but I again
would like to do so on top.

I think many of these are discussed within the threads above, but to
answer your questions in order:

  - The mtime of an object in a cruft pack represents the last time that
    object was known to be reachable, and it's updated when generating a
    cruft pack or pruning.

  - The same guarantees are made in the cruft pack case as in the
    non-cruft case (i.e., "none", and so a grace period is recommended).

> [...]
> >> Can you tell me a little more about why we would want _not_ to have a
> >> repository format extension?  To me, it seems like a fairly simple
> >> addition that would drastically reduce the cognitive overload for
> >> people considering making use of this feature.
> >
> >There is no reason to prevent a pre-cruft packs version of Git from
> > reading/writing a repository that uses cruft packs, since the two
> > versions will still function as normal. Since there's no need to prevent
> > the old version from interacting with a repository that has cruft packs,
> > we wouldn't want to enforce an unnecessary boundary with an extension.
>
> Does "function as normal" include in repository maintenance operations
> like "git maintenance", "git gc", and "git prune"?  If so, this seems
> like something very useful to describe in the cruft-packs.txt
> document, since what happens when we bounce back and forth between old
> and new versions of Git operating on the same NFS mounted repository
> would not be obvious without such a discussion.

Yes, all of those commands will simply ignore the .mtimes file and treat
the unreachable objects as normal (where "normal" means in the exact
same way as they currently do without cruft packs). I think adding a
section that summarizes our discussion would be useful.

> I'm still interested in the _downsides_ of using a repository format
> extension.  "There is no reason" is not a downside, unless you mean
> that it requires adding a line of code. :)  The main downside I can
> imagine is that it prevents accessing the repository _that has enabled
> this feature_ with an older version of Git, but I (perhaps due to a
> failure of imagination) haven't put two and two together yet about
> when I would want to do so.

Sorry for not being clear; I meant: "There is no reason [to prohibit
two versions of Git from interacting with each other when they are
compatible to do so]".

> [...]
> > Expiring objects in piecemeal is somewhat interesting, but I think I was
> > reaching a little too far when I said it was the "key benefit". It does
> > have some nice properties, like being able to store cruft objects as
> > deltas against other cruft objects which might get pruned at a different
> > time (though, of course, you'll need to re-delta them in the case you do
> > prune an object which is the base of another cruft object).
> >
> > But the issue with having multiple cruft packs is that the semantics get
> > significantly more complicated. E.g., if you have an object represented
> > in multiple cruft packs, which mtime do you use? If you want to prune
> > it, you suddenly may have many packs you need to update and keep track
> > of.
>
> Thanks for this explanation.  In hash-function-transition.txt, I see
>
> 	"git gc" currently expels any unreachable objects it encounters in
> 	pack files to loose objects in an attempt to prevent a race when
> 	pruning them (in case another process is simultaneously writing a new
> 	object that refers to the about-to-be-deleted object). This leads to
> 	an explosion in the number of loose objects present and disk space
> 	usage due to the objects in delta form being replaced with independent
> 	loose objects.  Worse, the race is still present for loose objects.
>
> 	Instead, "git gc" will need to move unreachable objects to a new
> 	packfile marked as UNREACHABLE_GARBAGE (using the PSRC field; see
> 	below). To avoid the race when writing new objects referring to an
> 	about-to-be-deleted object, code paths that write new objects will
> 	need to copy any objects from UNREACHABLE_GARBAGE packs that they
> 	refer to new, non-UNREACHABLE_GARBAGE packs (or loose objects).
> 	UNREACHABLE_GARBAGE are then safe to delete if their creation time (as
> 	indicated by the file's mtime) is long enough ago.
>
> 	To avoid a proliferation of UNREACHABLE_GARBAGE packs, they can be
> 	combined under certain circumstances. [etc]
>
> So the proposal there is that the file mtime for an UNREACHABLE_GARBAGE
> pack refers to when that pack was written and governs when that pack
> can be deleted.  If an object is present in multiple packs, then newer
> packs with the object have a newer mtime and thus cause the object to
> be kept around for longer.

That matches my understanding.

Thanks,
Taylor
