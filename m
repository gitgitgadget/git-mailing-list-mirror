Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB5AC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 13:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5007420739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 13:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPbJYxIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCTNlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:41:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46500 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCTNlm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 09:41:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id ca19so7090911edb.13
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAnxBQ3eSoXLOBxs15cfJh9c5rzyZ9q6YFpa+4TjSNY=;
        b=DPbJYxIyBoLcvqoNdFOA3tgNHJsKOObssoVacSjAVPMKLnrVO9L8lYtPtcBY+6/d+i
         58EN5MD+JhdDG89+Pvf/bG9XyeSxcc5oxgykFiDxrtzU7iAX4cs/gFLN+P0e+5pFezV6
         9VbOdVdOI7iUqu6SLPl83KdNKt9yIvi8WmMcI6xBZklFbsWeDNBdPAYIZbGAJzlPXp+y
         wLTCRZNcAzUEA1rQn+QSwUnyDMdXG3uE6t+toT80R7uA7AjK+4WnzDZfnCqWV13EnwOC
         HvWo9UyrDGb3KGlFM/AWTejpAjPmAgjFj8XWKcCLWTH/TgNa3WHJvvZT1t4V3u/dESJ2
         r7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAnxBQ3eSoXLOBxs15cfJh9c5rzyZ9q6YFpa+4TjSNY=;
        b=InGMGAmiVQiRRJTSTxqVRcbsxywVd26Tl+aq6tKGmj18g9dh9hVnvHL2U9xwceYzKc
         2Z82uChBPGe5gwLfgxDAnzdW68oF4rTxWqVjNabaxBo7+XWLOnXKRohmm3yOAL3fXWN3
         0hUVgqk5jTa99NDOR5k9fenneT52k6H4JUKoNvJiovuTq55NTocOhbGL9m7sbZ+qRfPG
         EC9gVsT+78Vs0cm8FZjl9cYoJ4sxbjuEb/UoboQLZNL0v3w67u3s1u76l2H6B7CJ2cqH
         FsSB2a5rhOdHhtqWuyfE3V9ngC0oClQCjGtKWoFQlWwmELsZaitgl2koUwx5gHZwjxml
         u7gg==
X-Gm-Message-State: ANhLgQ0/XN+Cw39UE3tTeddMh8isxMOLOGrHHl2P4RP6zekb9TuxkDjR
        y6jrb/jpmVei3Gg2qZb55CRXfB6OZxX8RJLiPPs=
X-Google-Smtp-Source: ADFU+vtGg0Xn9TdnTo3yR9fB6bWWhUNV+saSgeEpBGRMKv1wCEoP0/Z9OKA/LtZVcu+Ksz0OfLtp3YnQgI/V4iqJ+rw=
X-Received: by 2002:a17:906:b80f:: with SMTP id dv15mr8440220ejb.28.1584711700075;
 Fri, 20 Mar 2020 06:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNOEmugZDWpvAHsOzmm_Fqo_Vj5GcC--GfTg3JHPm701HjBXA@mail.gmail.com>
In-Reply-To: <CAGNOEmugZDWpvAHsOzmm_Fqo_Vj5GcC--GfTg3JHPm701HjBXA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 20 Mar 2020 14:41:29 +0100
Message-ID: <CAP8UFD2bgzvc2K2Sj4HSeXo16kB8D8se=+=Y7gp6FN+4Y3C1BQ@mail.gmail.com>
Subject: Re: [GSoC] Query regarding Microproject
To:     Shanthanu Rai <shanthanu.s.rai9@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Mar 20, 2020 at 7:39 AM Shanthanu Rai
<shanthanu.s.rai9@gmail.com> wrote:
>
> Hi, I am a 3rd Computer Science Undergrad at National Institute of
> Technology Surathkal, India. I wish to apply to git for GSoC.
>
> I am currently working on the microproject titled "Avoid pipes in git
> related commands in test scripts". I found 't/t9116-git-svn-log.sh' to
> have some commands wherein output of git is redirected to grep (using
> pipe). So shall I go ahead and make the required changes, i.e., redirect
> the output of git to a file and grep this file, in the relevant commands?

Yeah, sure.

In 't/t9116-git-svn-log.sh' it seems to me that some refactoring might
be needed too.

Best,
Christian.
