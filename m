Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909D91F404
	for <e@80x24.org>; Tue, 28 Aug 2018 20:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH2Aio (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 20:38:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43016 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2Aio (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 20:38:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so2758879wre.10
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 13:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Pia2fGo+LAd/l4nSz5hf5XHg5r6CF3XwNgi+exE20Q8=;
        b=JNH3x36DnSqsqmG0ZKojv3TtydCvE09hQU6Are1s52O9ptyKamLUynbpbvaokk87pn
         hNtG98qsblyUfcegj0eT4OSIzjAiojOKISuLfpY1VwsGQHuu/vsMCIkHsUP6DFd/yV/0
         JELHAt9yfCQcjaMI4/mxDBQlnbNw4tWk3FRxUTc9zYjpYeVufuaBA3q7ruAK0b79IQnl
         diPWm4pj4Qfg7BHVwWp05V0eADIBM63j3i8cEuM8H8ZZ2N7Kyfj9TYmgr0RuX8PkN3b1
         J3sB03DhcmTHil8nrvbmtVUoLafDt9NvPk6ASVgVDvXKpROBSEZz48TjHtJDyGr2GT6g
         8u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Pia2fGo+LAd/l4nSz5hf5XHg5r6CF3XwNgi+exE20Q8=;
        b=P+GOrbtpKvlrOvOjuv9qOTFs6HgpXbXaxhHr8rMu4ZAnegyxJxzCntyimvQn2WEMak
         Ev+iricLHrZUy+zVzFS6gBdBXUpM5i80yngMq/Zl2Gul7HpEit5cvrJ7YwVU87Buzwpc
         LSwyMFaswxDWXYoV4ZJ75h5UuFnDp8bSEqVt2nVk/dKnVbkP5zEcBIi95+CaSpV5HOcl
         mdB0N9t5DC1WCUl69N29Fq7Qykmde8CPxfOltRuXd0Hq8CNHJk0hxV43/33Wpzzr+5om
         j4VHpfNgKBDRQxF/tq4Q/gh4WEpiTLMd3/5rr5T/BHfTS0zjWw7fxJKbcS4PuiiKtSt5
         dkgg==
X-Gm-Message-State: APzg51DkFeaWk3X3hCArD6fFqK/BOBaJju3DyfZ6SQG4qWCsPqBS+iTj
        FeVb64Jtq341QMfI5eH/c18=
X-Google-Smtp-Source: ANB0VdZJjnTb7toQnZ9XVcpzDB/nHefHcF8q3dhdA/MH+WR0z3IHvBnXQUrWnTuEt1/Q7HfHYhYAyQ==
X-Received: by 2002:adf:e486:: with SMTP id i6-v6mr2251380wrm.145.1535489120911;
        Tue, 28 Aug 2018 13:45:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w17-v6sm2232612wmc.43.2018.08.28.13.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 13:45:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, christian.couder@gmail.com,
        haraldnordgren@gmail.com, Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [PATCH v6] Implement --first-parent for git rev-list --bisect
References: <20180828123234.44582-1-tiagonbotelho@hotmail.com>
        <nycvar.QRO.7.76.6.1808281512240.73@tvgsbejvaqbjf.bet>
        <xmqqy3cqfi8c.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 28 Aug 2018 13:45:19 -0700
In-Reply-To: <xmqqy3cqfi8c.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 28 Aug 2018 11:39:47 -0700")
Message-ID: <xmqqbm9mfcf4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> I would have preferred to reuse the already existing commits generated in
>> the `setup` phase rather than generating yet another batch, and to not
>> introduce an inconsistent way to present a commit graph (compare your
>> diagram with the one in
>> https://github.com/git/git/blob/v2.18.0/t/t6002-rev-list-bisect.sh#L64-L90
>> i.e. *in the same file*)
>
> As I already said in the previous round, I do agree with these.
> That is, ...
>
>>>  
>>> +# We generate the following commit graph:
>>> +#
>>> +#   B ------ C
> ... the above graph construction should not be necessary.  An
> earlier part of t6002 would have already created a history of
> suitable shape to use for writing the following tests.

Something like the following, perhaps?  I have a feeling that use of
test-output-expect-success is trying to be too cute without making
the result easier to read, and also makes it harder to debug the
test script when it does not work as expected (e.g. you need to see
where the output from the actual command is stored by going to the
definition of the shell function), and would have preferred to see
these three tests written without it (and instead using explicit
'expect' vs 'actual' comparison), but at least the patch below shows
what I meant when I suggested updating the tests to reuse the
existing history (I do not speak for Johannes, but I am guessing we
are on the same page on this one).

Thanks.

 t/t6002-rev-list-bisect.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index a661408038..d27d0087d6 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -263,4 +263,50 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
 	test_cmp expect.sorted actual.sorted
 '
 
+# See the drawing near the top --- e4 is in the middle of the first parent chain
+printf "%s\n" e4 |
+test_output_expect_success '--bisect --first-parent' '
+	git rev-list --bisect --first-parent E ^F
+'
+
+printf "%s\n" E e1 e2 e3 e4 e5 e6 e7 e8 |
+test_output_expect_success "--first-parent" '
+	git rev-list --first-parent E ^F
+'
+
+test_output_expect_success '--bisect-vars --first-parent' '
+	git rev-list --bisect-vars --first-parent E ^F
+' <<-EOF
+	bisect_rev='e5'
+	bisect_nr=4
+	bisect_good=4
+	bisect_bad=3
+	bisect_all=9
+	bisect_steps=2
+EOF
+
+test_expect_success '--bisect-all --first-parent' '
+	cat >expect <<-EOF &&
+	$(git rev-parse tags/e5) (dist=4)
+	$(git rev-parse tags/e4) (dist=4)
+	$(git rev-parse tags/e6) (dist=3)
+	$(git rev-parse tags/e3) (dist=3)
+	$(git rev-parse tags/e7) (dist=2)
+	$(git rev-parse tags/e2) (dist=2)
+	$(git rev-parse tags/e8) (dist=1)
+	$(git rev-parse tags/e1) (dist=1)
+	$(git rev-parse tags/E) (dist=0)
+	EOF
+
+	# Make sure we have the same entries, nothing more, nothing less
+	git rev-list --bisect-all --first-parent E ^F >actual &&
+	sort actual >actual.sorted &&
+	sort expect >expect.sorted &&
+	test_cmp expect.sorted actual.sorted &&
+	# Make sure the entries are sorted in the dist order
+	sed -e "s/.*(dist=\([1-9]*[0-9]\)).*/\1/" actual >actual.dists &&
+	sort -r -n actual.dists >actual.dists.sorted &&
+	test_cmp actual.dists.sorted actual.dists
+'
+
 test_done
