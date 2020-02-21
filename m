Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31490C35646
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 16:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044E424650
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 16:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smXKQwus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBUQ0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:26:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35814 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBUQ0W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 11:26:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so2723815wrt.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 08:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+MZ47YkY4Wm/Wo4dTIyHbk6WMb5/+0NKYf9OfRZy0t0=;
        b=smXKQwusMYFQ90bXQkmPmKAx//wwGoA3AckLX8LOJJujv4CBcSoQa24t3fpc6W2tMj
         2pSx0x2GhormjoVN7VG3tdorTPPCTxd/rreZ5+0EJylZ/gLjujLRXdxS3NWuGz/RYoWp
         foUWkWHgSJvGCWWk6fW3D1SeUhuI97w22z8lqvB1GtdLtI7kBDa4fpA0ku323GeGwU5j
         W4O0ZHkMODrltsWuCC0bls4CaxrA9zJX5uJQWL/vAQRUQnp4pMN6kzF273ODMR997fRu
         Y/PT7wQODQZSJg65uNaxxZxyeWQmYmEBwiPhLlfosGJBP4LIouG/sMNVdJI8X8l6Uib+
         UMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:cc
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+MZ47YkY4Wm/Wo4dTIyHbk6WMb5/+0NKYf9OfRZy0t0=;
        b=RZ42GRY0bkiVjL34jwOT8Ka4jVRZK75m+r6jTlGu0UF5OiQ++Pj3Rrn9T3nFaw+iey
         ip99bZeM/of1taLBZ6GM3S+Galy+mouCA7halIEZ58xZvgv7xSD6eDsc1MJwIV+9Zuuk
         iHhR7dvxlTZl6rEo+SfRtpzLtHJ3J26WjaKkGGGIV+1aYJwxwicsVI+q5ANxp7UiFCaZ
         uLDmEWJNLVNnslganbEMtgyi5rUSsvIbkKmL62MQcWLsoU2ZrU+zIiuDo7mMYrWf8X8x
         pefV+/dk2to0f04OL6jP5nn04ne/S2ez7q5KGarjw+PeExfKLZ6SkVKFupFFI9V95uo7
         C/Ng==
X-Gm-Message-State: APjAAAWq7HMwLFAEhYei6kYFuzwTsGzk7coZofTtSduEbnDnX8KqPMf7
        6utXtoUPeOVptWaVUURDInI=
X-Google-Smtp-Source: APXvYqzzO4kKc2q0chaTT3xf+ItBRi90ajLDom4NfkHPH+nk2eh8ZFUaOs7hpRyQG9fwMM7ooOq1Gg==
X-Received: by 2002:adf:f802:: with SMTP id s2mr52451323wrp.201.1582302380053;
        Fri, 21 Feb 2020 08:26:20 -0800 (PST)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id n13sm4536918wmd.21.2020.02.21.08.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 08:26:19 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Feb 2020, #04; Mon, 17)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <e9984c53-7266-c438-87f5-7f5474e3adce@gmail.com>
Date:   Fri, 21 Feb 2020 16:26:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/02/2020 22:08, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> Accumulated fixes on the 'master' front have been flushed to 'maint'
> and a new maintenance release 2.25.1 has been tagged.
> [...]
> [Stalled]
> 
> * pw/advise-rebase-skip (2019-12-06) 9 commits
>   - rebase -i: leave CHERRY_PICK_HEAD when there are conflicts
>   - rebase: fix advice when a fixup creates an empty commit
>   - commit: give correct advice for empty commit during a rebase
>   - commit: encapsulate determine_whence() for sequencer
>   - commit: use enum value for multiple cherry-picks
>   - sequencer: write CHERRY_PICK_HEAD for reword and edit
>   - cherry-pick: check commit error messages
>   - cherry-pick: add test for `--skip` advice in `git commit`
>   - t3404: use test_cmp_rev
> 
>   The mechanism to prevent "git commit" from making an empty commit
>   or amending during an interrupted cherry-pick was broken during the
>   rewrite of "git rebase" in C, which has been corrected.
> 
>   What's the status of this one?
>   The tip two are still RFC.

The tip "rebase -i: leave CHERRY_PICK_HEAD when there are conflicts" 
needs reworking and can be dropped (cf 
<7e1b92f5-48df-e202-ebcc-5b15987a7d63@gmail.com>). The other RFC patch 
"rebase: fix advice when a fixup creates an empty commit" [1] could do 
with someone commenting on it (I've Cc'd dscho and Elijah). I think the 
messages in it could be improved, but if the idea of different messages 
for fixups that make a commit empty is not popular then the rest of the 
series can be simplified by dropping some earlier patches including 
patch 6 which you had some doubts about. (I tired to address those 
<141f95b0-cae0-06f6-2c29-618dc22ae000@gmail.com> but I don't know if I 
convinced you)

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/20191206160614.631724-9-phillip.wood123@gmail.com/
