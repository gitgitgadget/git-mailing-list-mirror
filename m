Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0EC1F4B5
	for <e@80x24.org>; Mon, 11 Nov 2019 23:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKKXrO (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 18:47:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41123 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKXrN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 18:47:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id d29so8512918plj.8
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 15:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=auVcj+LlhcK92FmDaUZhh7QOoLnE9lLmt3mMImnQJb4=;
        b=Gjw/A5uaP0E4YoPOfZ/01tjlsehkZGtRPqTiO48mITgNIuCqUhbxBg3cxxzcsDzgP6
         kUgD8ZqHMOL2Lh4TTUfSoLvzE2NAS5mj0Ml7hBUDSSu24T29DPdDam30dn+6m4oTKgr9
         KfuUdopAnPbqma7wAWdGc8aT/Y5nwc0Lmp1fPLvtcs7wJPLW5B2G/tJMUpCZOqkI5r/V
         9c3p2NOdVM0OOUljcdcE3S/J98AVU4EIIaPYOFYxE06cPALUW89COxCSsJ2k7MO6Heax
         KOoyW/tb3KLFKzfdBarCBeO6uKpuo+YT3JtKhYrrHFnO7jkyeqKnI1VI7GzwjXjmL4Lj
         61TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=auVcj+LlhcK92FmDaUZhh7QOoLnE9lLmt3mMImnQJb4=;
        b=ZPytoIfGgbORZv0gJtpzcb+XDadTB7RIppyCAWmeSqhD2NrJow9AvsAK53L4ANtsQY
         /zkPbhBNEcQsAIYUQAJKNAU6XGM5cZ5JyYjcrqN6cj0EQVGnUq7GQh6gO5HK3kEqBh5i
         yoCgirOTG/5yjtW7dd08zFsXf+vWYG2jo3mHMfmkOcxeU3E1gwnRfw/ThETUZtpVttYY
         5Y2eskcmzy1CyTDO3leP3tK2yaTmJT3mVqM2geftQNiwmIMCniVBhnMNANT7vV73ObMW
         lH6HT6tURfe2l83FqJ1xBxG1w9TOOvpDM5eqUyXaxoB8e9meki2CPDnCQQmSSOLNksGw
         XkNQ==
X-Gm-Message-State: APjAAAWsii+I+jzOFtuxtTH8k2iN8XvDPUpy1vbTZOcIWvEVyHWJZKPy
        ISuXryLxR153KQhNrtyA8qM=
X-Google-Smtp-Source: APXvYqzHG7YPHhkxIo3GoIH6iAPAQvlHCb04A9nuJSPCIUug100X4ORqJIR6pDjokevTJIWf24RqzQ==
X-Received: by 2002:a17:902:6a8a:: with SMTP id n10mr28833044plk.146.1573516032927;
        Mon, 11 Nov 2019 15:47:12 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 12sm546575pjm.11.2019.11.11.15.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 15:47:11 -0800 (PST)
Date:   Mon, 11 Nov 2019 15:47:10 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, g@generichostname
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 09/10] pretty: implement 'summary' format
Message-ID: <20191111234710.GA23111@generichostname>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
 <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
 <08afdbcd-5972-05f9-ec8c-b12bd29d9030@web.de>
 <xmqqftiwl02i.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqftiwl02i.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Sun, Nov 10, 2019 at 03:25:41PM +0900, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> > Hmm, that's quite a lot of code to add to the formatting code with its
> > repeated special-case checks.  Why not implement it as a built-in user
> > format, like making it an alias for something like this?
> >
> >    git log --format='%C(auto)%h ("%s", %as)'
> >
> > We don't have %as, yet, but making --date=short available as a
> > placeholder would be a good idea anyway (patch below).
> 
> Yes!  Implementing the 'summary' internally as merely an alias to a
> canned user format does sound like the right approach.

We don't have any canned user formats currently, do we? I'm trying to
figure out where to insert the code to do this.

Is the idea to just insert a row in the builtin_formats[] table in
setup_commit_formats() with the `user_format` field populated?

> 
> Further, instead of inventing %as, I think you could just use %ad
> there, and when 'summary' uses that canned user format, flip the
> default date format to short.
> 
> That way, "git show -s --pretty=summary --date=iso" would be
> available to those who like the format.

If we do implement it as a canned format, then we lose support for
displaying `--no-abbrev`, `--walk-reflogs`, `--decorate`. Would we be
okay with this?

Thanks,

Denton

> 
> Thanks.
