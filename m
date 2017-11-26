Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32B42036D
	for <e@80x24.org>; Sun, 26 Nov 2017 11:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbdKZLfh (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 06:35:37 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:46788 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752023AbdKZLfg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 06:35:36 -0500
Received: by mail-wm0-f47.google.com with SMTP id u83so29254439wmb.5
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 03:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5GQLGXQK3DIq43c62dj/KjsxlhXpcYxpFEHVkdzCrZs=;
        b=FGAy7PE33MBbLsJxmt2IsoV2pA7YfqCsK3mszm2P293fjdefBG6KNGDsFUzetlcZ9X
         hYdgcSfWj2W14XDKW6BTJp7xeKp6O5Nhz8qp7MZbO8SgFRHFFxF2alzUEqInmn0Qa9TN
         w0fRkmPjlKOIXb/19kWG7+5tvfOW4UcOqVTUH8IjPW8EvYk+R1zFA/LGLeGCTLWH1H5M
         ql/MEj3WKDTkDDof0mtKYeyddE2o+S4+GQmAspSj6+fTxD5wZh8+xZVDdGxNYil9dzYq
         gExJ67fl2aixrVn80Zzv/11ThLqUdmEQk5flqtGa5s9vMR+kEdtm4XPNjClMBCJIytI5
         fbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5GQLGXQK3DIq43c62dj/KjsxlhXpcYxpFEHVkdzCrZs=;
        b=AyjEBF1loXAnotdXZaREbBvV4z6MHCoRuoLYi53PrBaD170lWWJIxVpQIRD6fxLnZu
         Vl5AYAIMHa2758pIdw1ous4jQ0SeN58UBG0bcaNDp6PE396q6Xb6tJUZDS+KX8RAL6VJ
         Gy13Z8chPjj5dJr9/t1D2FCBaqYGL11Ep8TWDOl7Nh3rZp58CroOXN8RbGFbFwq6hiSH
         HUhoLQJurmoA9k1ajpB2Q5INQdjvstc0ii5+W/gP9jgfaafjfyTZGGrAZQu9/T9y/90L
         s9k8TrGRfpBojmk4OLucCqCgbNzax7tUP1bdCz2QldyHM2hYfwT0bEqI935QEepukmba
         S9Sw==
X-Gm-Message-State: AJaThX6bD6K+rv711GN1C3HbnaOoQBBjAv0/iOQ5UCWgP1RKB+RRhw1+
        mzQi8ghiNRlVcmm3QxeIJaQ=
X-Google-Smtp-Source: AGs4zMa3M4ncrUHYMlEuJ+qSqImvqyUAlKKEgELax4D7oEOa+Q8KnKiBghNrf29HBb2lLZC3jmnipg==
X-Received: by 10.28.235.22 with SMTP id j22mr14915934wmh.68.1511696135240;
        Sun, 26 Nov 2017 03:35:35 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id c22sm13467115wme.2.2017.11.26.03.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Nov 2017 03:35:33 -0800 (PST)
Date:   Sun, 26 Nov 2017 11:37:06 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] worktree: make add <path> dwim
Message-ID: <20171126113706.GA6055@hank>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
 <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171122223020.2780-5-t.gummerer@gmail.com>
 <xmqq1skonoaw.fsf@gitster.mtv.corp.google.com>
 <20171125175010.GB14993@hank>
 <xmqqshd1iueo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshd1iueo.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Of course that assumes that it's used directly, not in scripts, and
> > that users will actually read the output of the command when they
> > invoke it.  Maybe these are not safe assumptions to make though, and
> > we'd rather not have this on by default then.
> 
> None of these is a safe assumption to make.  With a transition plan,
> we could change the default eventually, but if this feature is already
> used by real users, the proposed change without any transition plan
> will hurt them and make them hate us, I am afraid.

Fair enough, I definitely wouldn't want users to hate us.  I guess
I'll add this to the list of things that I'd like to change when git
3.0 comes along.

How about once we make the decision when git 3.0 happens, adding a
warning:

    warning: The current behaviour of creating a branch from HEAD when
    no <branch> is given will change in git 3.0, to try and match the
    new branch name to a remote-tracking branch.  To get rid of this
    warning in the meantime, set git.guessRemote to true or false,
    depending on whether you'd like to enable the new behaviour now,
    or would like to keep the existing behaviour. (see also
    --guess-remote in man git-worktree)

or something along the lines, and once we decide to release git 3.0 we
flip the default?  The warning would be displayed whenever the new
behaviour would be invoked, but no config option or flag is set.

Either way I'm going to add a flag and a config option to hide this
behaviour behind for now.

Thanks!
