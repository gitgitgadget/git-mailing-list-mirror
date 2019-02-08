Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78691F453
	for <e@80x24.org>; Fri,  8 Feb 2019 04:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBHEAu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 23:00:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51803 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBHEAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 23:00:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so2006013wmj.1
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 20:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TxOCCSQYogI5oXfu0R0QIR7qssIOcI/CUgyEpUruMXA=;
        b=meFbNkARHp3gY7q3PmtaRYzPPlIeNBHOiFMaynoU0bc8aD0+irMLu46eYv/ot/UK9U
         FpnOevtVTdcC6WfFnOc/+wZ9HjRt8uexobCed5CinA65Ag4cPLqIWALoFiKBMGeibZmf
         YjYZXbiO2f+FsNmLiF2IXkwPd6tpyT9WrFN1KpFFHOmiwhsKkys+0D7bCzx5Hc/ocxJn
         u5hbYXtlmOOlwpc0s+MEgftmwooTwSFqxK3sopuTgh5o2CMIdurMnv8XqccknLuJ3XIG
         FrFgtHaADAVAkruDJ5VAH4376zMmdUi2FZr4SbPBw3s0/PGuzkUV1t6DRxb1cnxrGEBb
         QILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TxOCCSQYogI5oXfu0R0QIR7qssIOcI/CUgyEpUruMXA=;
        b=MV4jGdkqTxTpF9+hqoFJ8ozFzlW3xaoChKd7B8T8la0VS7kc+uTVWJO0btgglL2DjJ
         fP+5Y7q4vaXQxwGYwdwAKkxHFTYsHjO4tJmLPVisMVxg7SjsmKYw0h/cNMKV9F9gmT+G
         8o4mCjDKV94+wqlQmJ/s+6MsgMk/Sb4ztv2RJrUF4DS5UtRbyYh5WiIWVKWPfx9kMvLi
         +4XvrETjKzwYIrrlqfiHAPuOepRK9BiVZPVu2UrPM+59KEgsvYJGDjBYP+RIPnqk9Sgg
         y19JLHkqyS8j29K0nM6mfVYaeuAofNJQqzJ8jyH9yocqk25CNgjMGFO7YZwaUqfZf5rD
         f7Dg==
X-Gm-Message-State: AHQUAuZ2NL9P6Psi4VgsnKTLGE4pTDAHgscD5I1DJ7kJxMRjt58yTWy2
        D9u36qJRIfRSNBSEoMPYjgQ=
X-Google-Smtp-Source: AHgI3IYwWD/Gufja1U1uJqZyht1nyh1YeCoQ8FbZIhxRCm0GeuvKhuoDtzL3yJk8JDXDu4Act2xi1A==
X-Received: by 2002:a1c:a9d4:: with SMTP id s203mr9543679wme.132.1549598447329;
        Thu, 07 Feb 2019 20:00:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m4sm22484742wmi.3.2019.02.07.20.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 20:00:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 1/2] log,diff-tree: add --combined-all-paths option
References: <20190204200754.16413-1-newren@gmail.com>
        <20190208011247.21021-1-newren@gmail.com>
        <20190208011247.21021-2-newren@gmail.com>
Date:   Thu, 07 Feb 2019 20:00:46 -0800
In-Reply-To: <20190208011247.21021-2-newren@gmail.com> (Elijah Newren's
        message of "Thu, 7 Feb 2019 17:12:46 -0800")
Message-ID: <xmqq8syrlyj5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +For `-c` and `--cc`, only the destination or final path is shown even
> +if the file was renamed on any side of history.  With
> +`--combined-all-paths`, the name of the path in each parent is shown
> +followed by the name of the path in the merge commit.
> +
> +Examples for `-c` and `-cc` without `--combined-all-paths`:

s/-cc/--cc/

