Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF164C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 18:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhLTS3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhLTS3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 13:29:12 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E798C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:29:12 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id t29-20020a62d15d000000b004baa073f34fso2030532pfl.12
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=duLNwKjnuIgeiYtk3D/W+ga2m9aNg4z222jJ1/SpyFI=;
        b=IWkN/DqWitK6YGcPVg3K066jU+Qg3pIiMzkKHw4BmRwTBPzJ+3qs6e0TYcOPYZvjn3
         CaFp8ZHzSBu7zHeEYsJYojjGq6yxoJ77iByltUboqBMdVvaEw9KjrchOqJ07+ZD0Yt91
         /GDRGbDnX0hNLgiChxXSopiN3vQCrkzpRlBWWwiZNNhftcaTg1X0G9PzkmN3+hjREQg1
         2E8AeOq8C7vOszqP5c/YzVwUqQu+9tsAj1Ivw7kld6XPKYsDjNKRfYdBy9l/Mov/lvCJ
         o232ADAmWEnFx1e4RaA3YfhsVw9ecNFCNnQTgYc481bYSBXu69fWOfvhjV7ZuYiWvaoD
         2U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=duLNwKjnuIgeiYtk3D/W+ga2m9aNg4z222jJ1/SpyFI=;
        b=FUV20jAogTZOXmcinPGl2MZ0wyWBPMajQKikZPc6B/XoL8lWLGBg59i7gr5x3ex41w
         9MaRSYi2K1g4dEjg3qYzY2JAv7cttjUHqsJBlg3D9wFs5ipZfi276JhbbPZLe+X+LhtN
         6WoYFqD+vNEIHPMkz3oH6t3JcDcW4uw/7kt6kliaX3ZJo//goqd+sDtFOM26yaoeSnc/
         mNdmjWK9qoD1Ag0N9a6Dbyx4Ft/atXACIpcvqGCN4rcNvoINaa+EkH7uF5rAZgUjtQ0z
         HRogbcHK8yuzQW7Arfv5lO9RWuw6bFXjDilf9kR3WccJ6hp+EmvaBucNtpFJ0HAbb5Hl
         cT7A==
X-Gm-Message-State: AOAM533kq9BOb/FV3qp7IEtDlBXEotTqc66lMrPtdYkXcv8RBVMmuBmX
        tye4yDR0BWrWY84q6yICG38vKBjvzQxJYg==
X-Google-Smtp-Source: ABdhPJzJtUtxW+IK8SNiT08BLaAJ8xHoEhrfFeyhBM0O/hTw1MPCuAfxTo9LalR/CsU57JGFy7XhWHdoliVPRg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:3d42:: with SMTP id
 o2mr76064pjf.1.1640024951161; Mon, 20 Dec 2021 10:29:11 -0800 (PST)
Date:   Mon, 20 Dec 2021 10:29:08 -0800
In-Reply-To: <Ybwb4UkQwAVRcJp5@google.com>
Message-Id: <kl6lzgovyvt7.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639524556.git.steadmon@google.com> <43d6f83fedc022c44d6a3be249e7fd8cd2a25007.1639524556.git.steadmon@google.com>
 <kl6lo85g8grj.fsf@chooglen-macbookpro.roam.corp.google.com> <Ybwb4UkQwAVRcJp5@google.com>
Subject: Re: [PATCH v6 1/3] branch: accept multiple upstream branches for tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> > @@ -87,29 +112,42 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>> >  	strbuf_release(&key);
>> >  
>> >  	if (flag & BRANCH_CONFIG_VERBOSE) {
>> > -		if (shortname) {
>> > +		const char *name;
>> > +		struct strbuf ref_string = STRBUF_INIT;
>> > +
>> > +		for_each_string_list_item(item, remotes) {
>> > +			name = item->string;
>> > +			skip_prefix(name, "refs/heads/", &name);
>> > +			strbuf_addf(&ref_string, "  %s\n", name);
>> > +		}
>> > +
>> > +		if (remotes->nr == 1) {
>> > +			struct strbuf refname = STRBUF_INIT;
>> > +
>> >  			if (origin)
>> > -				printf_ln(rebasing ?
>> > -					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
>> > -					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
>> > -					  local, shortname, origin);
>> > -			else
>> > -				printf_ln(rebasing ?
>> > -					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
>> > -					  _("Branch '%s' set up to track local branch '%s'."),
>> > -					  local, shortname);
>> > +				strbuf_addf(&refname, "%s/", origin);
>> > +			strbuf_addstr(&refname, remotes->items[0].string);
>> > +
>> > +			/*
>> > +			 * Rebasing is only allowed in the case of a single
>> > +			 * upstream branch.
>> > +			 */
>> > +			printf_ln(rebasing ?
>> > +				_("branch '%s' set up to track '%s' by rebasing.") :
>> > +				_("branch '%s' set up to track '%s'."),
>> > +				local, refname.buf);
>> > +
>> > +			strbuf_release(&refname);
>> > +		} else if (origin) {
>> > +			printf_ln(_("branch '%s' set up to track from '%s':"),
>> > +				local, origin);
>> > +			printf("%s", ref_string.buf);
>> 
>> It's not clear to me why the hint contains the word 'from' when it is a
>> remote ref...
>
> Because in the multiple-branch case, we don't prepend the origin to each
> ref, so we need to let users know which remote the refs are coming from.

I see. So if I'm reading this correctly, the error message in the remote
case would read something like:

  branch 'main' set up to track from 'origin':
    main
    topic1
    topic2

Is there any reason why we couldn't append the origin to the ref to make
it consistent? I think this could be as simple as:


	for_each_string_list_item(item, remotes) {
		name = item->string;
		skip_prefix(name, "refs/heads/", &name);
			if (origin)
+         strbuf_addf(&ref_string, "%s/", origin);
		strbuf_addf(&ref_string, "  %s\n", name);
	}

and the resulting list could look like:

  branch 'main' set up to track from 'origin':
    origin/main
    origin/topic1
    origin/topic2

This looks repetitive, but I suggest this because, as I understand it,
we are omitting the "{local,remote} ref" phrase based on conventions
around ref names, like "origin/main" is probably a remote ref and not an
oddly named local ref. However, when we print the list like so,

  branch 'main' set up to track from 'origin':
    main
    topic1
    topic2

we now expect the user to understand that 'main', 'topic1' and 'topic2'
to implicitly have 'origin/' prepended to them. This behavior seems
inconsistent to me; I'd anticipate most users responding "Wait, I was
supposed to be tracking 'origin' branches right? Why am I looking at
local branches?". Some users would be able to recover because they can
figure out what we mean, but others might just give up.

Prepending 'origin/' would get rid of this problem altogether, and it
would let us drop the 'from'.

>> >  		} else {
>> > -			if (origin)
>> > -				printf_ln(rebasing ?
>> > -					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
>> > -					  _("Branch '%s' set up to track remote ref '%s'."),
>> > -					  local, remote);
>> > -			else
>> > -				printf_ln(rebasing ?
>> > -					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
>> > -					  _("Branch '%s' set up to track local ref '%s'."),
>> > -					  local, remote);
>> > +			printf_ln(_("branch '%s' set up to track:"), local);
>> > +			printf("%s", ref_string.buf);
>> 
>> but does not have the word 'from' when it is a local ref. As far as I
>> can tell, this is the only difference between remote and local refs, and
>> adding the word 'from' does not seem like a good enough reason to add an
>> 'if' condition. Maybe I missed something here?
>> 
>> This motivates my answer to the question you asked in [1]:
>> 
>>   I removed as many distinctions as possible, as most can still be
>>   inferred from context. [...] Likewise, we don't need to specify whether
>>   refs are remote or local: "some-remote/some-branch" vs.
>>   "a-local-branch" should be understandable without us spelling it out.
>> 
>> I agree that there is adequate context, so I would be ok with the
>> simplification if there was corresponding code simplification e.g.
>> dropping "if (origin)". But in its current form, I don't think there is
>> good enough reason to simplify the message.
>
> I think the proper point of comparison is not the original code, but the
> code from V5 where we try to preserve the same level of detail in output
> as the original code. If we are committed to both having multiple
> remotes and keeping similar styles of output as the original
> implementation, then something like the massive conditional in V5 is
> unavoidable.

I see. So for instance, post-simplification you have:

  printf_ln(rebasing ?
    _("branch '%s' set up to track '%s' by rebasing.") :
    _("branch '%s' set up to track '%s'."),
    local, refname.buf);

if you preserve the same amount of detail as before, you'd have to
distinguish between local/remote, which doubles the number of cases to
4, which is why the conditional v5 is so complicated.

That said, I think that it's already much simpler than v5 because you've
split the singular and plural cases. I wonder if you have considered
building the final string purely from format strings, like:

  char *message_format = _("branch %s set up to track %s%s%s%s");
  char *ref_type_clause = origin ? " remote ref " : " local ref ";
  char *rebasing_clause = rebasing ? " by rebasing." : ".";
  char *branch_names = "<branch names>";
  printf_ln(message_format, local, ref_type_clause, branch_names, rebasing_clause);

This sounds potentially unfriendly to i18n, but it would make the
conditional simpler. What do you think?
