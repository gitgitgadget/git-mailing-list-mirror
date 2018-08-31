Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AF21F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeHaVDQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 17:03:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34832 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHaVDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 17:03:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so5995228wmc.0
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1KBsCxMvHXVemfgRokgpC/vtcGf+tBhT7xdU5s3Q9wI=;
        b=cY++V+kuSt//tn1vN/IWCJAakBHH7eNujnJ5jLCc0rxjlUWjgzJ7NJ8fmKZDZeOADE
         aJBEFCOZrJKcBOkDYmx3ubDZGI/e+UcCGUPqeB3L0d9cUvE/EeueqPtlB2An7itrlEpn
         zjNku+ah4ocMj+B13PMU9zDAbbKj0NBtEsJiNhRz4DVG/U0grGDEVjtv9LJUvOVKbC7Q
         8HSnC5y5p8IsYgyOoRJHJrgNuSobomI9o7K0ED2X5G0LKTgxQHfZ0rrAZCVYdNPAj74W
         Nn2srJIUBzAIHD0qDi1GeKvt/aY/ODemlKsc0XVb5NzgRCspyPfpbGR9ornqsQYZTULo
         aOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1KBsCxMvHXVemfgRokgpC/vtcGf+tBhT7xdU5s3Q9wI=;
        b=X2cEXzHDVAQKjfSBBDLgP9XSplBvOyEVvtszbVzvMsinLdLL1TGpw9ptBtAlZ/MPOb
         UMi/lmVxZXSGBwzKMBzLBK3ZoXlBAC6CE+l/QdKq/CvVLVvgLoswhWi4GNfAc2dNo1kj
         QXE4wZTbE+MXMvPKE9rKPmfzoHeHulW7SZFCYUaKOdsM0r8YuOQVLVksnbB58xDNu/KM
         e7txmIOn61qXkbBfx09NG2kVL1cLhS2VgsQLWdPwbQADsh4xhcLXRWAiuQa0Ql6gJktS
         oNbQMRC1iDld+nkqf3QDbEaqWiJ+Pf5GRpO1zMexYXLILGRwaGD73uQwNOHjRdPL56OJ
         GdVQ==
X-Gm-Message-State: APzg51CZ1DkWKYjtTgcJFdVGykFb57jdQp4lTOfY45hQjWfAMOS42VCl
        gat+pmDiE6FuAoMBpbMRB5kLSmkf
X-Google-Smtp-Source: ANB0VdbilU5JTZx6V9uq2l13ZoCedrRDTV1BGDwi4HVMGKYgHyHR3YgnfFboGx7CBsJlMeipiI3uCg==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26-v6mr5408364wmh.61.1535734491470;
        Fri, 31 Aug 2018 09:54:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l10-v6sm12090454wre.0.2018.08.31.09.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 09:54:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Stephen P. Smith" <ischis2@cox.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] wt-status.c: Set the commitable flag in the collect phase.
References: <20180831053921.8083-1-ischis2@cox.net>
        <20180831053921.8083-4-ischis2@cox.net>
        <87a7p3c83g.fsf@evledraar.gmail.com>
Date:   Fri, 31 Aug 2018 09:54:50 -0700
In-Reply-To: <87a7p3c83g.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 31 Aug 2018 09:23:47 +0200")
Message-ID: <xmqq4lfa3291.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Aug 31 2018, Stephen P. Smith wrote:
>
>> In an update to fix a bug with "commit --dry-run" it was found that
>> the commitable flag was broken.  The update was, at the time,
>> accepted as it was better than the previous version.
>
> What update is this? I.e. git.git commit id? See the "or this invocation
> of `git show`" part of SubmittingPatches for how to quote it in the
> commit message.
>
>> Since the set of the flag had been done in wt_longstatus_print_updated,
>> set the flag in wt_status_collect_updated_cb.
>>
>> Set the commitable flag in wt_status_collect_changes_initial to keep
>> from introducing a rebase regression.
>>
>> Leave the setting of the commitable flag in show_merge_in_progress. If
>> a check for merged commits is moved to the collect phase then other
>> --dry-run tests fail.

"Some tests fail" is not a good explanation why you keep the setting
of commitable bit in the "show" codepath.  The test coverage may not
be thorough, and the tests that fail might be expecting wrong things.

The change in this patch makes the internal "diff-index" invocation
responsible for setting the commitable bit.  This is better for non
merge commits than the current code because the current code only
sets the commitable bit when longstatus is asked for (and the code
to show the longstatus detects changes to be committed), so the
short-form will not have chance to set the bit, but the internal
"diff-index" is what determines if the resulting commit would have
difference relative to the HEAD, so it is a better place to make
that decision.

Merge commits need to be allowed even when the resulting commit
records a tree that is identical to that of the current HEAD
(i.e. we merged a side branch, but we already had all the necessary
changes done on it).  So it is insufficient to let "diff-index"
invocation to set the committable bit.  Is that why "other --dry-run
tests fail"?  What I am getting at is to have a reasonable "because
..."  to explain why "other --dry-run tests fail" after it, to make
it clear to the readers that the failure is not because tests are
checking wrong things but because a specific condition that is
expeted from the code gets violated if we change the code in
show_merge_in_progress() function.

That brings us to another point.  Is there a case where we want to
see s->commitable bit set correctly but we do not make any call to
show_merge_in_progress() function?  It is conceivable to have a new
"git commit --dry-run --quiet [[--] <pathspec>]" mode that is
totally silent but reports if what we have is committable with the
exit status, and for that we would not want to call any show_*
functions.  That leads me to suspect that ideally we would want to
see wt_status_collect_changes_index() to be the one that is setting
the commitable bit.  Or even its caller wt_status_collect(), which
would give us a better chance of being correct even during the
initial commit.  For the "during merge" case, we would need to say
something like

	if (state->merge_in_progress && !has_unmerged(s))
		s->commitable = 1;

but the "state" thing is passed around only among the "print/show"
level of functions in the current code.  We might need to merge that
into the wt_status structure to pass it down to the "collect" phase
at the lower level before/while doing so.  I dunno.

Thanks for working on this.




