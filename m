Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2440AC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 21:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbiHHV65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 17:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiHHV6y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 17:58:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B783A1AF0A
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 14:58:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z22so12983515edd.6
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KfLqZofxxlA9N9sTII6IzN3pG9UDN7cSSc8+a3RSf6k=;
        b=STfd3+qSTJOj9M0qrWYWReQpyODpAgKLQl/NiUzZ5djXygwmlfpLOLpZdhW2lIj3MX
         ZX1NAF/95Rergc4EqQh0Kfv1lE1nUPEVrlvCdapUpdd0Kpvml2JGeb1AaIdVB460ojVi
         JeVhwdkEZQ+r4xYSxPkNO8M70qWgEDf0eqECwZJGcfHoZoLGn2/cjOu8fH7gcRiNZOUC
         k8H5zajJ4Yzlh3Z72B8OvYQxFgvd2xtJMjhBMXJ/eBzK7+mSdBh2dRzgacrafF7tTuuM
         y1gkC/7Yhg1vilKDxwYLWK4SPnpg1ybLWIqNIR+5QPydeljBLMccAOYlZovuRwtPJOSo
         9hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KfLqZofxxlA9N9sTII6IzN3pG9UDN7cSSc8+a3RSf6k=;
        b=4r52VLfQsFC99JJMHMZ1adBAh3V8lvrwqdInYkTPe+T3Au8+rZ2gLQn4pN7O78fbtD
         UI5AtRLL1gllR8rFd1jBX1fUjjsD8elo5TfvF2EjXiSPM+BlRKFxhHDqpPaCq1+Z4QgF
         XxzrfrffhqAer/mfMq8a4yD/tKFb6eoswiXOd1xmkIcw6b0/g/OpwQpT+J9HLWVb5qbg
         l0xanSC5kwE1bNLCHx3FN82eQL92VV5Lk4qCYPGpdP3ccL77FcDbmVbhTEEyRwhyfWTq
         hjOQPdCl5KuGv1T74EW4rZhwKeFRryonjpNggg3fecLrj4n1/FUaBj5vEsP3tdKETQsB
         n2Vg==
X-Gm-Message-State: ACgBeo2O7KPqPGAlEI/niifY8rEwNJ94HJz6HsFjqhPDpkBRFdAL0jyx
        sgxsmBBa+QyFIIrIKVdcKBi3xtFTpq07lk15qFeevsBPuwYq1w==
X-Google-Smtp-Source: AA6agR4hW+aUUc6+mHZwu/PnKIWGfJ/5c+eW/lkjoIqfxOP2DTORrRr/zj8zPAYVe5YlsTUjXx2RZ76rwh73DAGWAsU=
X-Received: by 2002:a05:6402:1681:b0:43d:2e92:63d with SMTP id
 a1-20020a056402168100b0043d2e92063dmr19687847edv.253.1659995932307; Mon, 08
 Aug 2022 14:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAMxJVdH+o+H56tJ4UmD8YcsNsLuutiUXpOP=euQbomBe1kLkMw@mail.gmail.com>
 <16832f8a-c582-23bb-dda9-b7b2597a42eb@jeffhostetler.com>
In-Reply-To: <16832f8a-c582-23bb-dda9-b7b2597a42eb@jeffhostetler.com>
From:   Eric D <eric.decosta@gmail.com>
Date:   Mon, 8 Aug 2022 17:58:40 -0400
Message-ID: <CAMxJVdH+_xJc0VmRkaepww+gQH_==7wf3F8tX4hi99gWVTXCnQ@mail.gmail.com>
Subject: Re: Option to allow fsmonitor to run against repos on network file systems
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 1, 2022 at 9:32 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
>
> On 6/30/22 1:11 PM, Eric D wrote:
> > I can appreciate the concerns expressed here:
> > https://github.com/git/git/commit/d989b266c1a7ef47f27cec75e90f3dfefbfa0200
> >
> > However, in my environment, our file servers are very capable and have
> > the requisite support. It would be great if there was an option to
> > override this check and allow fsmonitor to operate against network
> > filesystems.
>
> Yeah, I was just being cautious.  I probably should have also added
> concerns on the remote system being an actual Windows server or a
> non-Windows host running SAMBA.  There were just too many combinations
> for me to be comfortable enabling it by default (on the initial
> release, at least).
>
> Also, the ReadDirectoryChangesW() API limits the buffer size to 64k
> for remote handles (because of protocol limitations), so there _may_
> be more of an opportunity for dropped events on very busy remote file
> systems.  (I never saw any dropped events in my testing (without
> intentionally breaking things), but it is a possible concern, so again,
> caution and safety...)  And I do handle dropped events and force a
> resync and send the client a "trivial" response (so it must do a regular
> scan), so output is still correct, but slower.
>
>
> Having said all of that, I did do lots of testing and never had an
> issue with remote drives actually working correctly, so I think it'd
> be fine allow a config setting to optionally allow it.  I just didn't
> want to clutter up things in advance if no one actually wanted to
> use it on remote file systems.
>
>
> I think it would be fine to have a "fsmonitor.allowRemote" or
> "fsmonitor.allowWindowsRemote" config setting and default them to false
> for now.  Or until we learn which combinations of remote mounts are
> safe and/or problematic.
>
> Jeff

OK, based on this and other conversations, I have implemented the following:

1. Introduced a new config setting, "fsmonitor.allowRemote"
"fsmonitor.allowRemote" has a default value of false. Setting it to
true overrides
fsmonitor's default behavior of rejecting network-mounted repos.

2. Restricted allowing remote repos to Windows clients using SMB
If the client is not using SMB and using a network path, then
fsmonitor will reject
the repo path regardless of the value of "fsmonitor.allowRemote"

-Eric
