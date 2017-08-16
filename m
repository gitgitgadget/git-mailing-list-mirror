Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D057208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 01:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbdHPBF1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 21:05:27 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36809 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbdHPBF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 21:05:26 -0400
Received: by mail-yw0-f173.google.com with SMTP id u207so14337504ywc.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 18:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lwr6DTuPNizn1TA0lZvrk52ueEjyt7XFaB/7N8EHI2I=;
        b=YXE/TarCqjaeVxnhSOyfdJASozQ4Ll/w9clWbuUpu7DILDSC7Tz1RTB/uo30IOjKJB
         +Wh1tCmxP7ckB1M/J1LW5RrKEUvqGUfA6EGGxoJttCMNnXG4KaY+ZV8OkH30rSu2nY10
         QwV/ykl1v6wv/VflBmWu5ebruwuUG/SnoJlPgtw6aeQznkAQ8uehLtVjhXtimCLlpqQZ
         wwUngvZuqtGiC8RV/f+V/PWb4CNZYvURGCM7yJ3kwvWkXrYXd7g4Fkog8qoa7wgWKW5f
         klJidBgUXdD1JeW2SfBx+ud3Y/WyWM6urJXCCQanYInHiwTF6Yc63TNz6nG1dbyWqN5D
         u26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lwr6DTuPNizn1TA0lZvrk52ueEjyt7XFaB/7N8EHI2I=;
        b=NnfISnnryHs+UcETVWzZS8xi1GMyS8vsrm5RiuRffUTf25aj7t7sRWMyQXrT1aGkBC
         +z71MgQ5GkX7J9B4bBAVhhy4+jcdjI8aniUnzU5IHI9UFt7ftpB5xg23SQcyyui6x/lv
         veX8eM+D9MURIwguMVe5r7LLPgdDzMyNfOaprT1+qGukVA8/JFVrAYeT/jD8mhhVGbBP
         qGsoBBucQ6d8UhG0QZH1Nu8A8zI4b640gJg5WTYJS3PU37BZc6aSRxhJ33O0snEjgywz
         xeY73vt9fMh4UQljlrJD/Lh4DRYwOg7zSTYfewkOC90w1sFPeKxl6lUZqONo0dRk09N8
         EDOg==
X-Gm-Message-State: AHYfb5g2+dyH3G4/hf3CGVRCKP9j29H06PKYDGYv8wVwLDLgNbG6xZiF
        tIyxtHymSJZOazAtHjgb8Kz25Ju7WzLrT0E=
X-Received: by 10.13.212.3 with SMTP id w3mr51289ywd.4.1502845525585; Tue, 15
 Aug 2017 18:05:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 18:05:25 -0700 (PDT)
In-Reply-To: <xmqqd17wpe14.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
 <20170815224332.22730-1-sbeller@google.com> <xmqqh8x8pg8p.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kag+U94tzJ14mB4VZjSZ2MtUJ4vu4MXKLKkpkLw=2K_NA@mail.gmail.com> <xmqqd17wpe14.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 18:05:25 -0700
Message-ID: <CAGZ79kZAkdiKHUweQK6U4dqAakfzReDMfiHKDmzsKGuAH3BgyA@mail.gmail.com>
Subject: Re: [PATCH] push: do not add submodule odb as an alternate when
 recursing on demand
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> Is "is it populated" a good thing to check here, though?  IIRC,
>>> add-submodule-odb allows you to add the object database of an
>>> inactivated submodule, so this seems to change the behaviour.  I do
>>> not know if the behaviour change is a good thing (i.e. bugfix) or
>>> not (i.e. regression) offhand, though.
>>
>> Good point, we should be able to push non-populated, even inactive(?)
>> submodules. For that we strictly need add_submodule_odb here
>> (or the repo object of the submodule, eventually).
>>
>> So let's retract this patch for now.
>
> Not so fast.

Ok, I took another look at the code.

While we may desire that un-populated submodules can be pushed
(due to checking out another revision where the submodule
doesn't exist, before pushing), this is not supported currently, because
the call to run the push in the submodule assumes there is a
"<path>/.git" on which the child process can operate.
So for now we HAVE to have the submodule populated.

  In the future we may have the a lighter version just checking the
  object store of the submodule. Maybe this use case in the submodule
  can be covered by the .remote/.imported mechanism as well, such
  that we'd know if we have any local objects.

> I am not convinced "push --recursive" should touch a submodule that
> was once cloned from the upstream and then deactivated, so using
> add-submodule-odb to decide if the push should go through may be a
> bug that we may want to fix, in which case the diff of the patch in
> question may be good as-is.  We need to sell it as a bugfix to the
> users, who may complain about behaviour change (if there is one).

correct. Coupled with the observation above, we want really need
both "is active and populated" (your paragraph suggest not-active
submodules don't need pushing, the populated bit comes from the
observation above)

> On the other hand, even if it were desirable for such a deactivated
> submodule to be pushed, as your log message explained, there is no
> reason to contaminate the in-core object hash by calling the
> add-submodule-odb helper, when the only thing we care about is "do
> we have the refs and object store for this submodule? we do not care
> if it is activated or not".  Perhaps there is a more appropriate
> helper in submodule.c that answers that question that we should be
> using instead of add-submodule-odb, and if there is not yet such a
> helper, perhaps this indicates that we need to add such a helper,
> which essentially is the early half of what add-submodule-odb does,
> i.e. ask git_path_submodule() for the object store and check if that
> directory exists.

I think due to the constraint of also needing a worktree the is_populated
helper is the correct choice here.


>
> Thanks.
