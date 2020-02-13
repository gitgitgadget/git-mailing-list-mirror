Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600D6C3B18B
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 13:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3175220873
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 13:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNiscu/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgBMNWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:22:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39267 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgBMNWF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 08:22:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id 84so3076653pfy.6
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 05:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhmXx9N9kYViUBuJSVU/A0/OEfRERxJQIiaW/V5tKyw=;
        b=qNiscu/cpAsbP5uzNc2JggiQZpfmTFFl26h4tNeKbwlCkxA+kIU3VfNuzdmFX2fGPt
         mvP1G0ZbJQXcCJuyWxeWHiG/GuRmg2lYcPzJJeUAzcvAKb//+gLYB9ukH1O/MIvclQun
         F0a3NuBsvbTfj2B3BJvlfrEyn8qoCMEovnFi4vEevruTAkP5X9Is76T+dq0/jCYtQ//+
         srO8Nq655Xx0fLn0BITE+tu4JTNmI0CpKMEZWy9Q9fC+uMq9xMPfcFcToK5yqNJnegtH
         bMeAhvsBNBfr5zwk3+Fra1PDhtmB2A0jKSvc283kJgRaj7SoIWYVPy+CX6Mkaoyqmmm3
         +9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhmXx9N9kYViUBuJSVU/A0/OEfRERxJQIiaW/V5tKyw=;
        b=XOBfJbK5kgFWc2YIVutiLYNDRaZJiet+i1NI+SaA2X+pv+WH5x5a4vkwe2pvxSD6KC
         7V9Wrzk/YS8VUK4DAhOKe2jU9yBGkG/dJ/HWgAuq61V3ZJY3H27frd3o2DZGwSpBqB5Q
         uIqjVtIdrRAC58WqJ8IJ+stg1enFdDFO2ShmHfpVbga6WESO6LGa+fsBpLRqNM5KRQw9
         4YnicgvBB+M+eJYHjh/XaIjU4za18inBIs8aJyQGfqJxeyuI+qcWt7wPceqNwy+4ecGT
         q71KMST7VzmeQKcdAcqJWPPOBtoU5ThWVdJgrjZTpQa3LEvlPkIDfq1S1+fyN7vX2VIA
         9J3Q==
X-Gm-Message-State: APjAAAVDiSopoU3y3K8mTBanskUwSrymEyl58WVJ95pWX1puBX18j989
        nxu5uuiNrTugES21f/MjXanSe5KChNA2dfjNLWV23kKEAR4NiQ==
X-Google-Smtp-Source: APXvYqy6Zvp1pVb1BF1VcaQyNitP+XdV+dmz+4npq296lYu/6UKeUJklUOYLlmebnjg8aZYKFemsgbU8PInjpYlj77g=
X-Received: by 2002:aa7:9908:: with SMTP id z8mr16200496pff.68.1581600125027;
 Thu, 13 Feb 2020 05:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20200212235033.782656-1-eantoranz@gmail.com> <CAOc6etbkMJf9qSNMU4fD4KeHE6NuMRUuQf_cBos_oxuYwaaeAA@mail.gmail.com>
 <xmqqblq3t6w1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqblq3t6w1.fsf@gitster-ct.c.googlers.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Thu, 13 Feb 2020 07:21:54 -0600
Message-ID: <CAOc6etYA79mTHB595cCVphmYmFECYvgPgV09SNo-pdEPEVD37w@mail.gmail.com>
Subject: Re: [PATCH] [RFC PATCH] stash save/push: add --index-only option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 11:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I am not sure if you explained how useful the "feature" being
> proposed is, which is a very important skill to exercise to entice
> readers to start reading and helping your code.
>
> Why is it useful to be able to do this?  It is unclear at least to
> me.

Fair enough. It's ok to explain here, right? There's no simple way to stash only
what you have on index while retaining your working tree state.

I would do this to achieve it:
save what I have on the index somehow
$ git commit -m "will drop this revision later"

that revision I just created has what I want to stash, actually

$ git stash save -m "want to keep this on working tree when I finish"

my work tree is now clean (perhaps with untracked files)

$ git reset soft HEAD~1 # get what I had on index before

now I can stash... this is what I originally intended

$ git stash save -m "what I really meant to stash"

and now I need to get the working tree the way I had it when I started:

git stash pop stash@{1}


All of that with git stash push --index-only... well, git stash push --cached

>
> By the way, per "git help cli", the name for this new option that is
> more in line with the rest of the system would be "--cached"; it
> would tell Git to work only on the data in the index (as opposed to
> the working tree files).
> .
>
