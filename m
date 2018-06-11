Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029B81F403
	for <e@80x24.org>; Mon, 11 Jun 2018 22:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbeFKWqs (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 18:46:48 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44251 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbeFKWqs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 18:46:48 -0400
Received: by mail-wr0-f196.google.com with SMTP id x4-v6so13889741wro.11
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CkDZGYaKOOsSisT85Or9uXmqiW5MOoqgkyxRrj7Ubq4=;
        b=LQd1jVmuLK+eAuZcPgle5x9SfV2pJRDafbCut5tcZAJIsHPhhNTcPj7mZE7NoU50QU
         W1iQQyu4Lx4BHLYqB/TWEohL7Djj/i4esJ9PcB55LiSumCSp4z2JwZ/TSaAvQCHz9ERj
         g8VsI3YTKDDmVRMeUm3tt3+tym3qLSfDiI8Ii5wT+t1pQTxMumHJHJppWRpgHh3m05K2
         7OntJTlHBdTGlYPEwATLpjWL12fdN+lR53w2E83JvkCH3IxDdZ+/KiNCk3cBaSL3J1Oy
         paqaVEUrRuURrxTyFSI8W8qUClSpidimLd/Sv5fuwLPEdyd5kT2FA2XakGwfYe6+yhc/
         0fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CkDZGYaKOOsSisT85Or9uXmqiW5MOoqgkyxRrj7Ubq4=;
        b=O2UrSHXnbYleSK4wKl4ydd3Yiy+5GaDVpF++71Wg3myrCEE+GpAnTSZHjyWeV8uhrx
         yuXVgs3eZCntt01jJxxwLKbLcSS3rA6WgZ0aRkthogKRJqyDbVqQGa6gwRUqfIunB3u4
         thoYlZ4tReLJRejlPNyFfC4GWPbHCspu/3mLU7/Z1SHZB6xy/8QtTlMYJIDQUukFqPDn
         1vRjt/PkjsSKju9XCan9IMen3szcD/U6G6dSUff30wYbg5rfLrvGTNMS3l3XwYHrUnSd
         7HeDUTzaqMf1UpmuklkVFkBNJPGwLfrwIiV6TJeJm8ZkXzdoWKY/kPCxCfnQNyoWLLAD
         H30g==
X-Gm-Message-State: APt69E0YlUgX5DK/D1O5vZDnINbCrPIU5g3r8JEcQmlln18LbgWSaVlQ
        cw1umkgyRgxP9+BMsm/wGz4=
X-Google-Smtp-Source: ADUXVKKrQLEk1EH2c/CdZjDXZW4dkqiN8RL/8fF7rdqCWQLYANXEwS0cRUt6e7s8qLOhCbQhpDr5Hg==
X-Received: by 2002:a5d:4b4b:: with SMTP id w11-v6mr704523wrs.87.1528757206794;
        Mon, 11 Jun 2018 15:46:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l15-v6sm25074009wrs.95.2018.06.11.15.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 15:46:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Clemens Buchacher <drizzd@gmx.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH v2] checkout files in-place
References: <20180610194444.GA1913@Sonnenschein.localdomain>
        <20180611203958.GA1306@Sonnenschein.localdomain>
        <87a7s1vw9a.fsf@evledraar.gmail.com>
Date:   Mon, 11 Jun 2018 15:46:45 -0700
In-Reply-To: <87a7s1vw9a.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 11 Jun 2018 23:38:57 +0200")
Message-ID: <xmqqa7s1aqlm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> ...And this seems to conflict with what Junio's summarized in
> xmqqvaapb3r1.fsf@gitster-ct.c.googlers.com. I.e. (if I'm reading it
> correctly) it's not correct to say that we unlink the existing file,
> then replace it, don't we create a new one, and then rename it in-place?

No, my recollection was incorrect.  entry.c::checkout_entry() does
an unlink() then write_entry() to the final place without any
rename-to-finish phase.
