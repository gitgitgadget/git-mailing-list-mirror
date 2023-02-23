Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EFCC636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 17:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBWR2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 12:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBWR2H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 12:28:07 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5782193FE
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 09:28:06 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e9so8834804plh.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 09:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXns+tTjs5axBwyfct3iedfG9hK0xHD0pJ6wVuY9P4A=;
        b=ltug5VHx9BhllZINPjcrpZFZ1DnVFbM+wkJZFIoe0WkSDM2TC2WaTvTmHTyAsoyRAC
         TE+67D65urG8wnPsC7c0W+6fCcyS/rPR8NdBUXw2KaChl2uMtqIBwVER6nz0eTaou2Y9
         MVlbvp9L2eOmTnJdHw20yzZr8759HMw8R5w0st9/5K7Sisrgg770Hpu8jmuS50akh/X4
         OK13RVhnF7ONQ6xB2qWEiGpcLyh9XJ7m8weJZQN5oeoEr3wDTTKjdwq9saEZezMKhiNZ
         fXkmjXNCgpvYE3VIhXRw5viHh3LqkbmfRj3mgrsBNKhz5jOFaUmws2IQSFCKHAFNaBE8
         WcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HXns+tTjs5axBwyfct3iedfG9hK0xHD0pJ6wVuY9P4A=;
        b=3Xonigc42hAcUXvAXki1ZmUEKdpSxYG4YWUxlBTp21d9tFAzsS8/YKctBVl1776yKv
         Lpwf/AMfbVJMwkclHoMJYD+4F8guuDLNtfHIIWzBKGjQhhRIAhoa/lk/JoB9lSMe2E7W
         LE6VTeDYdTfNNdCWAbdk8YCPVccNjJNy5NORRBG5jR9e/wFnIB7wKReBz1f5Ol8op2++
         LSrgRkgGvUTBdfTJxmtqrEI73pdlQoGVHWsofxtndLwhZHHv7RATdvQej3UdP1+3nSJi
         nIRW82D4k6q4VURSreXJHpgt09eG7pWbfrH7Skwxkrjl3I6Km2JrpkwmMrOrVnJcGKgw
         jAKw==
X-Gm-Message-State: AO0yUKV+f/2eBnfrtiasna8GjuE02agOAvJqOmQqg6GPbDVChZjyBfuN
        e1HHRCEk+oFkWi/xYmjolFUpZUxy6JU=
X-Google-Smtp-Source: AK7set9413kiL+V5tVYq+Qha1Smm+IH4tXIbj95hY9OPZezMcApCCP011xd489lw722s1MVh0FeL1Q==
X-Received: by 2002:a17:902:9a4b:b0:19c:bd10:3444 with SMTP id x11-20020a1709029a4b00b0019cbd103444mr2357581plv.63.1677173286067;
        Thu, 23 Feb 2023 09:28:06 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902e8c300b0019a96d3b456sm7872646plg.44.2023.02.23.09.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 09:28:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com
Subject: Re: [PATCH v4 1/3] rebase: add documentation and test for
 --no-rebase-merges
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
Date:   Thu, 23 Feb 2023 09:28:05 -0800
In-Reply-To: <20230223053410.644503-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 22 Feb 2023 22:34:08 -0700")
Message-ID: <xmqqh6vc9tqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---

No cover letter to summarize the changes?

Comparing this round with the previous, the only two changes are
that [1/3] lost one test "do not rebase merges unless asked to", and
[2/3] now uses test_must_fail to mark a git command that is expected
to stop.

Looks good, but a rerolled patch series should not force reviewers
to fetch and compare, but give a summary of changes when it is sent
out, to save everybody's time.  Preparing a summary before sending
it out also helps the patch author, too, that all the intended
changes are included in the new round.

Thanks.
