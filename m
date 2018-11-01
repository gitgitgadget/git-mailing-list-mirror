Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 687CA1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 04:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeKANTy (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 09:19:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40774 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeKANTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 09:19:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id i17-v6so18672221wre.7
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 21:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xL6/wIZ6uQ95xIhin29YksZSZraihxDRLhtG2sadGbk=;
        b=pUlDNmbqS+M/RaRZcOo4JNVdPS1afMCwKwhg8zFvjUTN0wReRsJFWVAYXW5yZn0+Vt
         arTLLZ8TunahQH9Cw6A+pjmHfxHKivL7l9kC0m+X2w1coinWe+MjXkBaHiuagTwe0dk7
         n39G6Khk5h+Up1E8Y7Sy/w6X8i1rt8grjndKLL6t1T62MNZCwqn5y7EdTGLrGK+3neyf
         brVnQcQRcvfQ9yKuMh9I6OzOOU3DnGLlo56C8KsmR5Q8R8gyLn39X6GVWrDBVLKjuH1Y
         a/epBfT890qxBcry6HatJqKtI9c5c0Nss9u3yRbExk5OdjR0KaiXh38SYx2G8YvPQZm0
         HyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xL6/wIZ6uQ95xIhin29YksZSZraihxDRLhtG2sadGbk=;
        b=HyNhFAgY4fJLiifI2G91Dgs9JpK5ZbLd2KFqejC8nqkaegJwPK2HPh16htIDM3Lf6Z
         Dh5n5Q1ZRiMxHRL2yb0MHwoGDsVN0XrRl7qndKEdyZmuEMfrpkxI2uIiutzZVESthqgS
         EMLYEKqLizf47l66zKIT6wOSiLQYXVMic3enA/ey8noxMTpr+p+mFQPIIbA79bd87hOd
         IP72D9GvxjVFFgGUzgoPNIvYkk69CLyEMOoHzzaRYlSUwRPyTUiHxgkYyCl6flGAiZ7m
         T1Q3B6gchG5tNBUBSldLSJBd0Ebvwod88Ub9IsRH0Izxoa5mcdDxaMmBq7UhkwAyO6NG
         X4Bw==
X-Gm-Message-State: AGRZ1gJCl/jnfFVvECGH17d0ZNeFbzkhrTOml9ZN6aRkrH0FcLD5/fE0
        z9YnSjN8NdmFd3Ni2EmzGauNyGpp6CI=
X-Google-Smtp-Source: AJdET5eS07tYmRJdfmTEbUzMDDp2Rl+rl4T+088mBLkSmlBpaoWeNgnndwGFAZ7VgFkmWZKRL3CKvA==
X-Received: by 2002:adf:8281:: with SMTP id 1-v6mr5263793wrc.252.1541045918698;
        Wed, 31 Oct 2018 21:18:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l140-v6sm40244203wmb.24.2018.10.31.21.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 21:18:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/8] push: add DWYM support for "git push refs/remotes/...:<dst>"
References: <20181026192734.9609-1-avarab@gmail.com>
        <20181026230741.23321-8-avarab@gmail.com>
        <xmqqlg6h4964.fsf@gitster-ct.c.googlers.com>
        <87in1lkw54.fsf@evledraar.gmail.com>
Date:   Thu, 01 Nov 2018 13:18:35 +0900
In-Reply-To: <87in1lkw54.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 29 Oct 2018 09:13:59 +0100")
Message-ID: <xmqqy3adtopw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> On the other hand, I do not think I mind all that much if a src that
>> is a tag object to automatically go to refs/tags/ (having a tag
>> object in refs/remotes/** is rare enough to matter in the first
>> place).
>
> Yeah maybe this is going too far. I don't think so, but happy to me
> challenged on that point :)
>
> I don't think so because the only reason I've ever needed this is
> because I deleted some branch accidentally and am using a push from
> "remotes/*" to bring it back. I.e. I'll always want branch-for-branch,
> not to push that as a tag.

Oh, I didn't consider pushing it out as a tag, but now you bring it
up, I think that it also would make sense in a workflow to tell your
colleages to look at (sort of like how people use pastebin---"look
here, this commit has the kind of change I have in mind in this
discussion") some random commit and the commit happens to be sitting
at a tip of a remote-trackig branch.  Instead of pushing it out as a
branch or a remote-tracking branch, which has strong connotations of
inviting others to build on top, pushing it out as a tag would make
more sense in that context.

And as I mentioned already, I think it would equally likely, if not
more likely, for people like me to push remotes/** out as a
remote-tracking branch (rather than a local branch) of the
repository I'm pushing into.

So I tend to agree that this is going too far.  If the original
motivating example was not an ingredient of everyday workflow, but
was an one-off "recovery", I'd rather see people forced to be more
careful by requiring "push origin/frotz:refs/heads/frotz" rather
than incorrectly DWIDNM "push origin/frotz:frotz" and ending up with
creating refs/tags/frotz or refs/remotes/origin/frotz, which also
are plausible choices depending on what the user is trying to
recover from, which the sending end would not know (the side on
which the accidental loss of a ref happened earlier is on the remote
repository that would be receiving this push, and it _might_ know).

As to the entirety of the series,

 - I do not think this step 7, and its documentation in step 8, are
   particularly a good idea, in their current shape.  Pushing tag
   objects to refs/tags/ is probably a good idea, but pushing a
   commit as local branch heads are necessarily not.

 - Step 6 is probably a good documentation on the cases in which we
   make and do not make guess on the unqualified push destination.

 - Step 5 and earlier looked like good changes.

If we were to salvage some parts of step 7 (and step 8), we'd
probably need fb7c2268 ("SQUASH???", 2018-10-29) to number all the
placeholders in the printf format string.
