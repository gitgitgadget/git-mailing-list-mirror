Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9081F453
	for <e@80x24.org>; Mon,  5 Nov 2018 11:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeKEUvK (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 15:51:10 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39082 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeKEUvK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 15:51:10 -0500
Received: by mail-ed1-f53.google.com with SMTP id w25so1268380edx.6
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 03:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zI4wFfnjLp8WVzdDZpKPkfdRKyHZIFS8ZU2gQc0Hz4A=;
        b=TnJIQZeQYiQZ/+0cxgKdT7gdcgHk0Qr7Ad2ckzYMOuL8C3QRoWMW4pDH2Xzqx6QL9O
         JyfBtlUR/gG3Zz631o00WrrTiJFdbPuXKL9i23A7wMbYqHilz0mXS10WdOUK0BaV3fCB
         tuUUPIT4kdIe/RSUeEsVzvXzeZ8PR/9YfQCsOZsRpuUuLCapXHNNuJCpU1LM6dBCe8jW
         gMfaZZkvbrXg1c36B5WCXASlwNrpLuGwlYY/PojFYu6rCh5BjYAFiIxyK25aK1JZt7YH
         K92TknVwsugkvPlmWZDABZRQjA5NyxDx+5T4/ehGR1yEfgDnARbgi5zEahLe3n4/97uu
         HwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zI4wFfnjLp8WVzdDZpKPkfdRKyHZIFS8ZU2gQc0Hz4A=;
        b=HJSeTxeNrTApMcQzBxIBo77yKukUsWWbZT+oPABROBp8C2pZL7IyosjzHZkLC64SKj
         8gDgPqO26ejCe8kOfMAj7H7HNBqx/eGOI8aB0riwpsEiLXZ+IcSFBPLo+MtczzMHjtuE
         RRMhTY6nU7bTf5tCHQoB+nEbY6sGmJRVBBfuL5yv0PKohDM6a0cJnPjLT28O56qt4+Rv
         bxa8koR9YkKwVDGpsIez8H/NAKAFt8AmqeH5aX/H1DfSUnpMb6D9oJD6Iwur2jpAgIHd
         5dUvG3xSdQIY0Ps4MHelxl9z83gK3VGGzyZXeb1b9t2j3IWGEIzO5uoe1S/eHgTPA3eU
         JY7w==
X-Gm-Message-State: AGRZ1gJN47O8McLF6PeZ7JQ3cOMVRv9KymvRPKPUl3fwORt/vSK8enpK
        uJhCaZofjOpOyLQbv8WqQ1G6ZEcC
X-Google-Smtp-Source: AJdET5dcUEs31sl+kpblD9uJ4/Vc+vuC8Fk4sSdRIQ1jd+LU5UIRPfQWw4G7Amd3FUNsQopx8IU8gg==
X-Received: by 2002:a50:d78b:: with SMTP id w11-v6mr18354978edi.19.1541417511807;
        Mon, 05 Nov 2018 03:31:51 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id z49-v6sm827011edz.40.2018.11.05.03.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 03:31:50 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/8] push: add DWYM support for "git push refs/remotes/...:<dst>"
References: <20181026192734.9609-1-avarab@gmail.com>
        <20181026230741.23321-8-avarab@gmail.com>
        <xmqqlg6h4964.fsf@gitster-ct.c.googlers.com>
        <87in1lkw54.fsf@evledraar.gmail.com>
        <xmqqy3adtopw.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqy3adtopw.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 05 Nov 2018 12:31:50 +0100
Message-ID: <87k1lr7obd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I'll re-roll this. Hopefully sooner than later. I'll leave out the later
part of this series as it's more controversial and we can discuss that
later on its own. Meanwhile just some replies to this (while I
remember):

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> On the other hand, I do not think I mind all that much if a src that
>>> is a tag object to automatically go to refs/tags/ (having a tag
>>> object in refs/remotes/** is rare enough to matter in the first
>>> place).
>>
>> Yeah maybe this is going too far. I don't think so, but happy to me
>> challenged on that point :)
>>
>> I don't think so because the only reason I've ever needed this is
>> because I deleted some branch accidentally and am using a push from
>> "remotes/*" to bring it back. I.e. I'll always want branch-for-branch,
>> not to push that as a tag.
>
> Oh, I didn't consider pushing it out as a tag, but now you bring it
> up, I think that it also would make sense in a workflow to tell your
> colleages to look at (sort of like how people use pastebin---"look
> here, this commit has the kind of change I have in mind in this
> discussion") some random commit and the commit happens to be sitting
> at a tip of a remote-trackig branch.  Instead of pushing it out as a
> branch or a remote-tracking branch, which has strong connotations of
> inviting others to build on top, pushing it out as a tag would make
> more sense in that context.
>
> And as I mentioned already, I think it would equally likely, if not
> more likely, for people like me to push remotes/** out as a
> remote-tracking branch (rather than a local branch) of the
> repository I'm pushing into.
>
> So I tend to agree that this is going too far.  If the original
> motivating example was not an ingredient of everyday workflow, but
> was an one-off "recovery", I'd rather see people forced to be more
> careful by requiring "push origin/frotz:refs/heads/frotz" rather
> than incorrectly DWIDNM "push origin/frotz:frotz" and ending up with
> creating refs/tags/frotz or refs/remotes/origin/frotz, which also
> are plausible choices depending on what the user is trying to
> recover from, which the sending end would not know (the side on
> which the accidental loss of a ref happened earlier is on the remote
> repository that would be receiving this push, and it _might_ know).

Yeah this example was bad, but now since I've written it I've become
more convinced that it's the right way to go, just that I didn't explain
it well.

E.g. just now I did:

    git push avar avar/some-branch:some-branch-wip
    git push avar HEAD -f # I was on 'some-branch'

Because I'd regretted taking the "some-branch" name with some WIP code,
but didn't want to lose the work, so I wanted to swap.

It's also arbitrary and contrary to the distributed nature of git that
we're treating branches from other repos differently than the ones from
ours.

After all sometimes "other" is just the repo on my laptop or server. I
shouldn't need to jump through hoops to re-push stuff from my "other"
repo anymore than from the local repo.

Yes refs/remotes/* isn't guaranteed to be "other repo's branches" in the
same way our local refs/heads/* is, and this series bends over backwards
to check if someone's (ab)used it for that, but I think for the purposes
of the default UI we should treat it as "branches from other remotes" if
we find commit objects there.

So I think the *only* thing we should be checking for the purposes of
this DWYM feature is what local type of object (branch or tag) we find
on the LHS of the refspec. And if we're sure of its type push to
refs/{heads,tags}/* as appropriate.

I don't think it makes any sense as you suggest to move away from "guess
based on existing type" to breaking the dwimmery because we found the
branch in some other place. The user's pushing "newref" from an existing
branch, let's just assume the new thing is a branch, whether the source
is local or not.

> As to the entirety of the series,
>
>  - I do not think this step 7, and its documentation in step 8, are
>    particularly a good idea, in their current shape.  Pushing tag
>    objects to refs/tags/ is probably a good idea, but pushing a
>    commit as local branch heads are necessarily not.
>
>  - Step 6 is probably a good documentation on the cases in which we
>    make and do not make guess on the unqualified push destination.
>
>  - Step 5 and earlier looked like good changes.
>
> If we were to salvage some parts of step 7 (and step 8), we'd
> probably need fb7c2268 ("SQUASH???", 2018-10-29) to number all the
> placeholders in the printf format string.

Thanks. As noted will try to re-roll this soon.
