Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE69320D12
	for <e@80x24.org>; Thu,  1 Jun 2017 02:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbdFACUY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 22:20:24 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34146 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdFACUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 22:20:24 -0400
Received: by mail-pf0-f178.google.com with SMTP id 9so23678515pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+jGEX28W40WVk8cTfbBIoHP/Rf4hO1BIP5ZRDm2Nbps=;
        b=cp7+vinDGHEuY5tQz+98jVFcBCQz6eCKjryd4LmKfsGVEjG2btXJT7XxJ4HsRwk1Sn
         bywk4jb3ib8+fSlRC7MJrbSGtywwJ9aaEIL/DdIDegLPSks6Cq/yyT0/JWH8Qqm8KlEW
         MULYzCXHDl/yzxhEpQ2MPax48Brn4/dKgNqzV7TXfNPar2jj26mCH751sJIpU55CXmbP
         I4CKdQeDykrsm9UUOd9uxhTNposOzb7R/6MUETvm6q6OhEGQfcBBF8FJ08LnPAv7JaIu
         RU/p0uH8xnGktdSJNiXRKyavItP4qvllooj+JE3iQj/zwVZD+wrvko00F9Dww1WsryEI
         OCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+jGEX28W40WVk8cTfbBIoHP/Rf4hO1BIP5ZRDm2Nbps=;
        b=XfoQ6esQyft12Tny79Z2Gb6ekHEWTqglkHLKW7zYfJpfzfqnb++ehytoeQ7QXVLeIR
         Z/VsRp39/6pyMqUE4XekVm0JZxg/zttnSoRdF/bapqvpw+7EG7v4px4+VCL1pp7Cqyb+
         sfU6IkDSO/2rF+c5wcnkYMNpyPvRdthRbptDFbJ6k5JEzdeBZv5k26sbmUHU1z1qTeXI
         7Fyd0tww3WQOQA0ldteS4VmGIx7Gy1HYo+93zlw+cOTIsr+Mpgd8i33RrC/WDUoM1tHS
         aeZPfblcVhqdPUq5XIhDQ44DfYbGWf386+C3TEkOuGZyWQxl75LFLY3+CoP4em7YOOnM
         HR4g==
X-Gm-Message-State: AODbwcCcLONm1ZJn2QaljLEi+wz+CrjY7dV3A/h/zSZfpSxBbYMVEfGA
        5FOt0xYaXSgfOg==
X-Received: by 10.84.230.129 with SMTP id e1mr17319542plk.88.1496283623302;
        Wed, 31 May 2017 19:20:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id h28sm34191705pfd.55.2017.05.31.19.20.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 19:20:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: bug: `git log --grep ... --invert-grep --author=...` negates / ignores --author
References: <CA+dzEBn4EKzDqS0pCHHsPtGGJc1orf5weKKh0GN-GkE+fVYGcg@mail.gmail.com>
        <CACBZZX7OhdRM+Mhx4FVX-Upvq169ZLvArL5ZxcTgz8u=WRh3aw@mail.gmail.com>
Date:   Thu, 01 Jun 2017 11:20:21 +0900
In-Reply-To: <CACBZZX7OhdRM+Mhx4FVX-Upvq169ZLvArL5ZxcTgz8u=WRh3aw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 May
 2017 20:08:54
        +0200")
Message-ID: <xmqqtw4078ka.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> $ git log --grep=bar --invert-grep --author=Ævar --pretty=format:%an
> -100 origin/pu |sort|uniq -c|sort -nr
>      78 Junio C Hamano
>      14 Jeff King
>       2 Andreas Heiduk
>       1 Sahil Dua
>       1 Rikard Falkeborn
>       1 Johannes Sixt
>       1 Johannes Schindelin
>       1 Ben Peart
>       1 Ævar Arnfjörð Bjarmason
>
> That last command should only find my commits, but instead --author is
> discarded.

Hmph, the way I read revision.c::commit_match() is that we check
with "--grep=bar --author=Ævar" and then emit the commit if that
check fails when --invert-grep is in effect (instead of emitting the
commit when the check succeeds, which is the normal case).

So there is one commit that didn't pass "has 'bar' and written by
Ævar" check that was written by you in the recent past (iow,
recently you were writing bar all over the place).  Changes by other
people by definition does not pass "has 'bar' and written by Ævar"
check, on the other hand.


