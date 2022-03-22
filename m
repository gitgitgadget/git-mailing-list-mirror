Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F6C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 23:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiCVXG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 19:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiCVXGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 19:06:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6333E6EB10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 16:04:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i11so16049747plr.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5y6Uu1hpX5SoGuxVfiQ4LKF1fUdu/KF0OoG7ygc7hko=;
        b=fYZ+5tFyLF0r6hA9hveVWXsxwM0r/cV0WaYC2AK3ny6JxXwNvfUAJkLboVzFih+0Ze
         8l5lzr+Tg4XbXmh80ahYYCHAfBsdItaOPjppWS5ANTasDK93wi11mmuoeELm5NOIUSqn
         jhTdId9E1TF0s/JJsRfohY7bjIVmX4we6QrbCRPNetQXuWiqdZukbw4bGCjyBvYBT933
         cCwdNRUjkw9x/0OYV06BSevtoZtdmiQuHbIXYR1K+jBFcuLdrhIJBrBwtr0Y7QfQu1Oq
         Ha/j/swlp5pdzbwQ3ckPi002ipshLjvETg8Y2ofON5ogjQlVvew7iFiCLmwhrBbOKqoW
         gEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5y6Uu1hpX5SoGuxVfiQ4LKF1fUdu/KF0OoG7ygc7hko=;
        b=mprPWeKbRYgNq/MpUT68kgarARVCs7/FSTkKnmMRzxpu2e98i+JyatDE2Hd3/+uFDf
         d0cwUP+0uqWPIxAo9JztZXt3DfyqGqz5b1naMoRpLASLDkUm9mxwVSO3WAmYlMKHs275
         5MNBF+yM0X5TYwrMLV7rZDBzb9N6B+e3aeNatpUYL9FsWNBVIJ3k5kFFrJ3fFw2uwoAx
         TyACsDM/fDgL2hahOlXwO7dOtEHUvuaal/TH5+Z8IEbhZyQUirmj0Arrou02UGDm4Mjk
         4RyYhs+n4aQ2l3H6lEDyFmeNMfSTUTHszhLAr6bdJ97IAEFvCEAHLk1T6Yy4Ze6zTN/H
         meKQ==
X-Gm-Message-State: AOAM533STPRepScFo5KYWoz7Ilwja8D1tJrJkFCp6+70GCh9NSaA3Uh2
        25TE40sKNn7Ov8MR80kYu5g=
X-Google-Smtp-Source: ABdhPJzqWXhnUC1Br8FX8ORT1XV5tOjeTx3qRuxETZUeweO/YBIDMVdUyGaxNpifdf9kKZYrA6dTUg==
X-Received: by 2002:a17:90a:1f08:b0:1bc:1b9f:9368 with SMTP id u8-20020a17090a1f0800b001bc1b9f9368mr7958003pja.63.1647990295691;
        Tue, 22 Mar 2022 16:04:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:2e30:848f:8047:6e70])
        by smtp.gmail.com with ESMTPSA id s12-20020a056a00194c00b004f7c1da7dd5sm24703567pfk.1.2022.03.22.16.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 16:04:55 -0700 (PDT)
Date:   Tue, 22 Mar 2022 16:04:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <YjpWFZ95OL7joFa4@google.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
 <YiZI99yeijQe5Jaq@google.com>
 <YjkjaH61dMLHXr0d@nand.local>
 <YjpDbHmKY9XA2p0K@google.com>
 <YjpHbaBspUasDdEy@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjpHbaBspUasDdEy@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:
> On Tue, Mar 22, 2022 at 02:45:16PM -0700, Jonathan Nieder wrote:

>> Great.  Can the doc cover this?  I think it would be helpful to make
>> that easy to find for others with similar questions.
>
> I believe the doc covers this already, see the paragraph beginning with
> "Unreachable objects aren't removed immediately...".

Thanks.  I just reread that section and it didn't say anything obvious
about the race that continues to exist and whether cruft packs address
it.

[...]
>> Sorry, the above seems like it's answering a different question than I
>> asked.  The doc in Documentation/technical/ seems like a natural place
>> to describe what semantics the new .mtimes file has, and I didn't find
>> that there.  Is there a different piece of documentation I should have
>> been looking at?
>
> Are you looking for a technical description of the mtimes file? If so,
> there is a section in Documentation/technical/pack-format.txt (added in
> "pack-mtimes: support reading .mtimes files") that explains this.

I see --- is the idea that cruft-packs.txt means to refer to
pack-format.txt for the details, and cruft-packs is an overview of some
other, non-detail aspects?

I just checked pack-format.txt and it didn't describe the semantics
(what a Git implementation is expected to do when it sees an mtimes
file).  For example, in Documentation/technical/cruft-packs.txt, the
kind of thing I'd expect to see is

- what does an mtime value in the mtimes file represent?  When is it
  meant to be updated?
- what guarantees are present about when an object is safe to be
  pruned?

[...]
>> Can you tell me a little more about why we would want _not_ to have a
>> repository format extension?  To me, it seems like a fairly simple
>> addition that would drastically reduce the cognitive overload for
>> people considering making use of this feature.
>
>There is no reason to prevent a pre-cruft packs version of Git from
> reading/writing a repository that uses cruft packs, since the two
> versions will still function as normal. Since there's no need to prevent
> the old version from interacting with a repository that has cruft packs,
> we wouldn't want to enforce an unnecessary boundary with an extension.

Does "function as normal" include in repository maintenance operations
like "git maintenance", "git gc", and "git prune"?  If so, this seems
like something very useful to describe in the cruft-packs.txt
document, since what happens when we bounce back and forth between old
and new versions of Git operating on the same NFS mounted repository
would not be obvious without such a discussion.

I'm still interested in the _downsides_ of using a repository format
extension.  "There is no reason" is not a downside, unless you mean
that it requires adding a line of code. :)  The main downside I can
imagine is that it prevents accessing the repository _that has enabled
this feature_ with an older version of Git, but I (perhaps due to a
failure of imagination) haven't put two and two together yet about
when I would want to do so.

[...]
> Expiring objects in piecemeal is somewhat interesting, but I think I was
> reaching a little too far when I said it was the "key benefit". It does
> have some nice properties, like being able to store cruft objects as
> deltas against other cruft objects which might get pruned at a different
> time (though, of course, you'll need to re-delta them in the case you do
> prune an object which is the base of another cruft object).
>
> But the issue with having multiple cruft packs is that the semantics get
> significantly more complicated. E.g., if you have an object represented
> in multiple cruft packs, which mtime do you use? If you want to prune
> it, you suddenly may have many packs you need to update and keep track
> of.

Thanks for this explanation.  In hash-function-transition.txt, I see

	"git gc" currently expels any unreachable objects it encounters in
	pack files to loose objects in an attempt to prevent a race when
	pruning them (in case another process is simultaneously writing a new
	object that refers to the about-to-be-deleted object). This leads to
	an explosion in the number of loose objects present and disk space
	usage due to the objects in delta form being replaced with independent
	loose objects.  Worse, the race is still present for loose objects.

	Instead, "git gc" will need to move unreachable objects to a new
	packfile marked as UNREACHABLE_GARBAGE (using the PSRC field; see
	below). To avoid the race when writing new objects referring to an
	about-to-be-deleted object, code paths that write new objects will
	need to copy any objects from UNREACHABLE_GARBAGE packs that they
	refer to new, non-UNREACHABLE_GARBAGE packs (or loose objects).
	UNREACHABLE_GARBAGE are then safe to delete if their creation time (as
	indicated by the file's mtime) is long enough ago.

	To avoid a proliferation of UNREACHABLE_GARBAGE packs, they can be
	combined under certain circumstances. [etc]

So the proposal there is that the file mtime for an UNREACHABLE_GARBAGE
pack refers to when that pack was written and governs when that pack
can be deleted.  If an object is present in multiple packs, then newer
packs with the object have a newer mtime and thus cause the object to
be kept around for longer.

[...]
>> Sorry, I don't understand this answer either.  Do you mean to say that
>> JGit's DfsRepository does not in fact have a cruft packs like feature
>> that is live in the wild?  Or that that feature is equivalent to not
>> having such a feature?  Or something else?
>>
>> To be clear, I'm not trying to say that that's superior to what you've
>> proposed here --- only that documenting the comparison would be
>> useful.
>
> I'm not familiar enough with JGit (or its DfsRepository class) to know
> how to answer this. I was comparing cruft packs to the
> UNREACHABLE_GARBAGE concept mentioned in the hash-function-transition
> doc, and noting the differences there.

Thanks.  I think there's some implied feedback about the documentation
of UNREACHABLE_GARBAGE there, because if I understand then you're
saying that it does not describe maintaining cruft packs.  Perhaps a
pointer to the particular sentence that led you to that conclusion
would help.

Sincerely,
Jonathan
