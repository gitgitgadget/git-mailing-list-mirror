Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5AF1207FF
	for <e@80x24.org>; Thu,  4 May 2017 04:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbdEDE3t (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 00:29:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35142 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbdEDE3s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 00:29:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id o68so480264pfj.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 21:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+LOzONKuK+b2OjAxVfPD9CKeRLv4uzJQjLZOAUVXljo=;
        b=lrmfIe90eqFgomDf/DE1Z3EnehZFmuGjzBJ7iAUMj0ds98OzhrbIM0ZTvyRAS+jn/9
         SdZWhRA3S4l5qkl3dFlFuYdVA8FtzVDTqu4MGKtkxDaf7wUOhbDH1xWwIRepqyeTU3k1
         iK6VUIWvASMYATlixVLfqN2abQ3q0p14HiD7ddVG6XMIOFoJDjyqmZGUbxTqdfGYNQC7
         EhrfayE5jWsraKzP6jK/QAY0cli2+6aYUIHdok8OtG/x+KX3Aw8nZ2B0CyvAjzeXEMpA
         Np/21IinJQk2M1PDVKZ3jEhxoCJjTcAymZOU5rU/9ZeffZqgzn+k5yaImMBPg37MiwVI
         yj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+LOzONKuK+b2OjAxVfPD9CKeRLv4uzJQjLZOAUVXljo=;
        b=HxeISTAvWMNhROOjpCRr0ujMh3infl5JFsRSzSJoezHhX9nXqLAOYilXu0NbyVB3ei
         CUxem9dlKaZdbfGmH9ieEBtN2a1XHPNKG82MWr+Ad2NKLU2jzpfWNk3d7qmOC1HmHaMP
         kOO46jB9RyvfYVc1W6UiJEpF6UZxKb2WGqSHHAp378TbUYW2bmwF3rzT8YHtHzfvxOwT
         tjbT6XEzgRSPNqZXC0gMBJjVjMfs/KrCuEHVAbRiVqZe43iYIDfDotfPIJKvHkMpxoo5
         5zeCx9/dzuwIf6JRlpGpdP7I5TXy1oBGwdEBulw2lUkd+HrvCo887nePGUMQFGQH1qbw
         2wMA==
X-Gm-Message-State: AN3rC/7bMFtJ6qkT9RRQHMeaWlu7lCntguJdDSkGB59edcrNYoA+CVFj
        Ys9eCXkWDlw08Q==
X-Received: by 10.99.167.3 with SMTP id d3mr42490168pgf.70.1493872187550;
        Wed, 03 May 2017 21:29:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id r13sm1120275pgn.16.2017.05.03.21.29.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 21:29:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Mark Thomas <markbt@efaref.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Kevin David <kevin.david@microsoft.com>
Subject: Re: Proposal for missing blob support in Git repos
References: <20170426221346.25337-1-jonathantanmy@google.com>
        <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com>
        <193d1d84-2386-c4c8-81ef-0042f0d8bb02@google.com>
        <xmqq1ss8gnqn.fsf@gitster.mtv.corp.google.com>
        <c0c8a0c3-582c-cf3b-3833-c918a0630f9f@google.com>
        <xmqq37cof320.fsf@gitster.mtv.corp.google.com>
        <CAGf8dgK05+f4uX-8+iMFvQd0n2JP6YxJ18ag8uDaEH6qc6SgVQ@mail.gmail.com>
        <CACBZZX6jQtO_3zYjnvq0dhtWvUxb7vYLtQUWpFHLw1v-SteHcQ@mail.gmail.com>
        <daed427f-b39e-c3d9-76ee-9c37203e1988@google.com>
Date:   Wed, 03 May 2017 21:29:46 -0700
In-Reply-To: <daed427f-b39e-c3d9-76ee-9c37203e1988@google.com> (Jonathan Tan's
        message of "Tue, 2 May 2017 14:45:06 -0700")
Message-ID: <xmqq1ss5b5xh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I see the semantics as "don't write what you already have", where
> "have" means what you have in local storage, but if you extend "have"
> to what upstream has, then yes, you're right that this changes
> (ignoring shallow clones).
>
> This does remove a resistance that we have against hash collision (in
> that normally we would have the correct object for a given hash and
> can resist other servers trying to introduce a wrong object, but now
> that is no longer the case), but I think it's better than consulting
> the hook whenever you want to write anything (which is also a change
> in semantics in that you're consulting an external source whenever
> you're writing an object, besides the performance implications).

As long as the above pros-and-cons analysis is understood and we are
striking a balance between performance and strictness with such an
understanding of the implications, I am perfectly fine with the
proposal.  That is why my comment has never been "I think that is
wrong" but consistently was "I wonder if that is a good thing."

Thanks.
