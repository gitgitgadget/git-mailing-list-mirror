Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2B51F404
	for <e@80x24.org>; Tue, 20 Mar 2018 17:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeCTRel (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 13:34:41 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51952 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeCTRej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 13:34:39 -0400
Received: by mail-wm0-f52.google.com with SMTP id h21so5014952wmd.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FkkAQkqrnqcgbQUkABiiNNJy/AaLX9hR42j8j8Ughr0=;
        b=pdFjURECPxiOpmufh0TQYI29AxRDLr9u4Y7knScZRvU99VLS6w4gtzoDX2SBwjQ9p9
         8iyHg7kFOet2F0LroR/YQC+I9gB4+Fj0AHsveeGobwSdZypLQ5OxZRIcuZRtQnpfxD9C
         XTiS190qhd/QktYZC4ehHTFvhbs04QVHXaejcfKG8tjOxLQQPtQpazx7jOZibjMcUrRw
         kQfELpqM95GqLdbgeSdZdBiViz4cIDn3aMEzIkpAHcEKUozsY6Pa392oWMEdajLDbSfx
         aF/jmXTNzK0O/c0r0dDWTCJbkZaHc1zKSRfibewfjQr9K9AEUbdDJkvlKNMYxHZpmm6+
         16og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FkkAQkqrnqcgbQUkABiiNNJy/AaLX9hR42j8j8Ughr0=;
        b=V1+KJXp2PiOnehDhUDE3jFA/ct1RXjVR6hX2avkEf7TTUl+ao/8aOh7xgUUx6gDAnU
         TsBaUQKxsPvXM79/BKtqlkz19Nbg6JbwxQvPeE2y4P1iMNxHEf7k4jvgLTGk+Pt2N/DO
         IWZzsrIGCfdtYetDGRYo9uuFRjNy0LApJxQNjFDZ927bxBDQex4eyeprSeppa/w5wxae
         xG1BHC8W/BN/N0FlkFkkx1YAexIX4gDcsm/LY9QAl86Z4VaiTsgO4omQYMVY1RBh25Ug
         B2KUh1i48xRHZOy5eMPea2xzEkwhEnm44aP8vnMujm3Jk0r2CbV3//yCYhcx5ORV2kBx
         OtxA==
X-Gm-Message-State: AElRT7FQxt0+sq2AovkaO7oBVOhrWrCZkqMmr1xBrOH9Yh5eSojy4DGf
        Ajs/5j73pActUafgfaqrTqE=
X-Google-Smtp-Source: AG47ELuB27S9W3fpSugHctlhMWSCrrl6EPGEWHV5Cx8GfxD+zHzd9jMrFX7LDfJfQnjmAPdUjv2t4g==
X-Received: by 10.28.64.131 with SMTP id n125mr418726wma.140.1521567278123;
        Tue, 20 Mar 2018 10:34:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r71sm3314696wmd.48.2018.03.20.10.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Mar 2018 10:34:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] rebase -i --keep-empty: don't prune empty commits
References: <20180320100315.15261-1-phillip.wood@talktalk.net>
        <20180320100315.15261-3-phillip.wood@talktalk.net>
        <nycvar.QRO.7.76.6.1803201630380.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 20 Mar 2018 10:34:36 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803201630380.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 20 Mar 2018 16:33:46 +0100
        (STD)")
Message-ID: <xmqqfu4uslar.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +		if (!keep_empty && is_empty)
>>  			strbuf_addf(&buf, "%c ", comment_line_char);

We are not trying to preserve an empty one, and have found an empty
one, so we comment it out, and then...

>> +		if (is_empty || !(commit->object.flags & PATCHSAME)) {
>
> May I suggest inverting the logic here, to make the code more obvious and
> also to avoid indenting the block even further?
>
> 		if (!is_empty && (commit->object.flags & PATCHSAME))
> 			continue;

... if a non-empty one that already appears in the upstream, we do
not do anything to it.  There is no room for keep-empty or lack of
it to affect what happens to these commits.

Otherwise the insn is emitted for the commit.

>> +			strbuf_addf(&buf, "%s %s ", insn,
>> +				    oid_to_hex(&commit->object.oid));
>> +			pretty_print_commit(&pp, commit, &buf);
>> +			strbuf_addch(&buf, '\n');
>> +			fputs(buf.buf, out);
>> +		}

I tend to agree that the suggested structure is easier to follow
than Phillip's version.

But I wonder if this is even easier to follow.  It makes it even
more clear that patchsame commits that are not empty are discarded
unconditionally.

	while ((commit = get_revision(&revs))) {
		int is_empty  = is_original_commit_empty(commit);
		if (!is_empty && (commit->object.flags & PATCHSAME))
			continue;
		strbuf_reset(&buf);
		if (!keep_empty && is_empty)
			strbuf_addf(&buf, "%c ", comment_line_char);
		strbuf_addf(&buf, "%s %s ", insn,
			    oid_to_hex(&commit->object.oid));
		pretty_print_commit(&pp, commit, &buf);
		strbuf_addch(&buf, '\n');
		fputs(buf.buf, out);
	}

Or did I screw up the rewrite?
