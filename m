Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6F95202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 04:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbdIZEZN (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 00:25:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35667 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754062AbdIZEZN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 00:25:13 -0400
Received: by mail-pg0-f65.google.com with SMTP id j16so6073084pga.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 21:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g5NALSkIDUFBtC+KyT4fFLjWvcsVYVoF/fU2K8t9uoA=;
        b=P8fVWmfwYLbDH3g1vKqf70uJio1zxxhXn+347Ri2mev5Ft1OH/A+SHD2RRy70zUmjg
         Q6EPhjYVZSn1OG0Uj8tJilqC0ttpkn9Bb0n0jdgZt6vFSCE/q9dCUFYMH9H/fR42bGN/
         B/A1lwxAYV/6crbuBSNCBokWkkE7m/uljCnX5hBlvTK51oOPadBVc3HIFc5uLjf51Zed
         FTdQjWqwk3fCwKlqeACho9THtfQ/ABfEHTBNkbOPGQ1QgrrW7FVt4cJ3DeYgtolaCqd3
         K1ncxY2Isbe2kQpRayZMIEloL4cfgJ1BUOsksh4+aL6CX82GylvTPRmXEjqQHME7bFEr
         EyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g5NALSkIDUFBtC+KyT4fFLjWvcsVYVoF/fU2K8t9uoA=;
        b=EKT919yDn9j6i+108VzXDVHL/njfhw9g5eLORKXnkIh3/OEkVxmR4XH7TPJD3qCPQb
         jW0ux+HO4Til8ZLj4/Crthjkq3u3JLiOlkCtofFOxo/F8sTn4cEahNJ/Y7VrTzmMyFmn
         ezKPvkL5GX6SspjOCrrlB+DvJBGzTb52dQ09m34Xs+Uq2qPNAb8uFbhT71/vdB+3jknM
         h5g4Zk5EH0Les4e315uMXqTnluiIqbf0hJeQcgEiagTeKkaG3MoyaISNm0xGlLtGO+dx
         5RiCAybLjMZrUisxFL+c1SSvys5P2SYrbBtLsU9uEB9IiPdFgxnC+0m3vmhzL8wWveSu
         IEsQ==
X-Gm-Message-State: AHPjjUiDFoAqxuZ31177JV/T70Zd4uawgN8e2SvC6XfDDpY2yrX190Qv
        Ro4NWrghaZi7OMQ2ph/9P40=
X-Google-Smtp-Source: AOwi7QDuHJyGfx227Tn+PCMU+fXK2C5mrGpFtlQHGjpnmb95lH75SkFG//eujN6GOq9anPpSNsGclA==
X-Received: by 10.84.131.66 with SMTP id 60mr9655431pld.341.1506399912134;
        Mon, 25 Sep 2017 21:25:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id d12sm14076193pgn.53.2017.09.25.21.25.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 21:25:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Rannaud" <e@nanocritical.com>
Cc:     git@vger.kernel.org, jeremy.serror@gmail.com,
        "Shawn O . Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
References: <598f0addb8b1a5dd535b5bea5f2685ab4c3eb2b0.1506396652.git.e@nanocritical.com>
Date:   Tue, 26 Sep 2017 13:25:10 +0900
In-Reply-To: <598f0addb8b1a5dd535b5bea5f2685ab4c3eb2b0.1506396652.git.e@nanocritical.com>
        (Eric Rannaud's message of "Mon, 25 Sep 2017 20:30:52 -0700")
Message-ID: <xmqqr2uuaxy1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Rannaud" <e@nanocritical.com> writes:

> The checkpoint command cycles packfiles if object_count != 0, a sensible
> test or there would be no pack files to write. Since 820b931012, the
> command also dumps branches, tags and marks, but still conditionally.
> However, it is possible for a command stream to modify refs or create
> marks without creating any new objects.

That reasoning sounds sensible.  Especially given the discussion of
"checkpoint" and "progress" we can see in "git fast-import --help"
documentation. E.g.

    Placing a progress command immediately after a checkpoint will
    inform the reader when the checkpoint has been completed and it
    can safely access the refs that fast-import updated.

would not be true without this change, I suspect.

Can we also add a new test or two that protect this from future
breakages?

Thanks.
