Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0097E2027C
	for <e@80x24.org>; Tue,  6 Jun 2017 00:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdFFAKd (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 20:10:33 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34781 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdFFAKc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 20:10:32 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so89973352pfj.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 17:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GIWMRtQPkcHzHaTXaUzavP3x9ewA1D+XUTCCPQjaXzo=;
        b=QK0OaDJ439IFg9MiYjHwKYE9M/wgPc5nKZ23cUbcAqBhVqxcPbcB2E/fzQDa+/groE
         be0rnzsfiG+ePLMWZtEn8q+P+xyyWEmFjYK7zapXs+kBzoQrGi3txoDNP4gg1q+Dt0TB
         5Vm5XcuTOFHy0Ju8ZBZqkI5DrG0UvqHA1AdP+SGGp9ZrVTy3u4UciJ0bj1QVMN6CxPm2
         SgiMIBZI6+8GwOzYCrDQX0b12LKc1HT/wPzSfWbnq7MxNRi5nVXEksRTp4u90v3BU9SX
         rcpM+NsKzlOwZdrQ8roLBDWOfQIyaGt6mm+RdMBStHW7p9Um+Fpjp+dWtME9b7hAW9/2
         O8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GIWMRtQPkcHzHaTXaUzavP3x9ewA1D+XUTCCPQjaXzo=;
        b=YGl8F3QjDxGaLhNi/RFFwDgFMX2P52B08lYFJhOPN2gHNb8eA5wAfaauHTzxlHK/yP
         oe5wZWDueaHSyYUCpVRZWW5XXYTS4O7yi9pGrO5BkKa62bzzuWRzUAGk5OVxs4N4LQE8
         XOSTaUFe2g0M17biJXnrlp82HH8Xjr3gRMSNE7J5yIVDDP0ugzyxWMnlM/UdkOpwcSkH
         d9HtbVnk3bsypSGUjgQR1cPqc2FI7hxGCrEmNgL2m317WI889Cs0gDiBwYgGxHP9OL3N
         YY3af40KvEXveRd0d5DnfW1v3KTstaiUnOzwSO0annYcfO12bfEvl0TIh/+yI3Cr5AEF
         oYlg==
X-Gm-Message-State: AODbwcC2baOEA7sQZSqdf7xk8oMs4LvFEepM08mCGsswyHWT9d8OV+OF
        LwyjAn4T8vcDxg==
X-Received: by 10.84.218.76 with SMTP id f12mr17893981plm.269.1496707832024;
        Mon, 05 Jun 2017 17:10:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:5d03:f5d1:882a:10e])
        by smtp.gmail.com with ESMTPSA id h15sm59728630pfk.120.2017.06.05.17.10.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 17:10:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC v4 3/3] branch: add copy branch feature implementation
References: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
        <0102015c79fcbe99-7e18cee7-d82d-4ab2-9d6a-ad7376a5ac27-000000@eu-west-1.amazonses.com>
        <CALiud+=qoSSSg_p2MXZEaVTGMhFW_FtirDJ2-FnmNh+U0yf0Gw@mail.gmail.com>
Date:   Tue, 06 Jun 2017 09:10:30 +0900
In-Reply-To: <CALiud+=qoSSSg_p2MXZEaVTGMhFW_FtirDJ2-FnmNh+U0yf0Gw@mail.gmail.com>
        (Sahil Dua's message of "Mon, 5 Jun 2017 22:52:16 +0200")
Message-ID: <xmqqlgp69ds9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

> I want suggestions about one logical point raised by Evar.
>
> Let's consider a case that I'm on branch maint and then I do 'git
> checkout master' followed by 'git branch -m feature', it will rename
> master branch to feature. Now if I do 'git checkout -' to go to the
> last branch, it will take me to maint since master branch doesn't
> exist in this case.
>
> Now, for this copy operation - if I'm on branch maint and then I do
> 'git checkout master' followed by 'git branch -c feature', it will
> copy master branch to feature. Now if I do 'git checkout -' to go to
> the last branch, it will again go to maint (according to the current
> implementation). What do you think it should do? Is this the desired
> behavior? Or should it go to master branch since that was the branch
> checked out before copying.
>
> Also, in case this needs to be changed, can someone please point me to
> how it's being handled so that I can change the behavior.

When somebody says "I want to rename my current branch to X", it is
clear that the person wants to end up being on a branch called X.

To me, "I want to copy my current branch to Y" sounds more like "I
want to create another Y that looks just like the current branch,
but I want stay on my current branch".

If you think copy makes @{-1} problematic, perhaps your copy is
doing more than it should (e.g. switching the current branch at the
same time, or something).


