Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FC861F597
	for <e@80x24.org>; Thu, 26 Jul 2018 19:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbeGZUyu (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 16:54:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33187 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbeGZUyu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 16:54:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id r24-v6so351623wmh.0
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xZ5gkeFideCbZ0WzyK8QgNHC3Ge6vicqTKQ4Sk/tgZ8=;
        b=Gzm3a9L0MPUMufPwQYOi4f2R1mgNRDMLVGBh3bU7vceNrWUrRtQHa6ngJXeg2ry+RF
         iES8wcrDt2lnvAhxEYBmNdOtmSpQuAA73X0NegnX4q7Ei4KYWZhX/vym3PXhBhBWp7ge
         P2JnM+jNmhxZlYaXDdm5atBNNpKDz9o8wdFAsKOjozl1UXK/sKeSEq096GLe+4+MwBjn
         J9UqxHl5SJxQU8V31ncvm4RCsxgN7JPFys1F0PFweChQpIW1Aq3IJs9VHa8Do90RS6lJ
         yDerzc+dxPElaoEpigZGEcl2HLhNX+YrTpBbmGCIRs+pXd8nClbRw2JxfhLhntSdMwvI
         bg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xZ5gkeFideCbZ0WzyK8QgNHC3Ge6vicqTKQ4Sk/tgZ8=;
        b=I19h7VFReYhyOlTgQzw0DIaSwSzqWDq+N4BdQ+qB0utpB5IAyzH4hfVaNsN0esT2Uz
         3BMhfcQTDHc/KFAEBYJOWmCKSCoISQDPGr8EEsJBgraSJU9M+WiwmUXLcckD6gVSFqNY
         EiAGimS88MvZYLneg7srXP27c0M+yrKKIvC4aroVGr1zOygR4VpeEQlYBMM4faJpv/c5
         kE1SQHzyKEdkh3aqhTIFZ8guFdwj7G3r9tZ8wlDLd0BZJ88RUxXJVkKozNt4LPxfMUbp
         SaNEWrwiK49Z9qGjF7F1YwjFJITCqxUBLqDqDUlQM/HaT4+C0NOQZkSJjDtMfkL9wxFE
         eQvw==
X-Gm-Message-State: AOUpUlGSsMzTm6vJ/B5iD9Nb/eZHabvmzxpe8ql1cFW0zDcYZNbKbwqW
        fMv7FClknj/SnFTkTjuqud8=
X-Google-Smtp-Source: AAOMgpdcPmY/NL5KjmXbxQpSTY25sZqVRNVE3eJMzma+THm+xEl2i/GVpz/qyfrMnYkmxosR0/daSg==
X-Received: by 2002:a1c:93d3:: with SMTP id v202-v6mr2464165wmd.57.1532633790827;
        Thu, 26 Jul 2018 12:36:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j6-v6sm1304622wrs.91.2018.07.26.12.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 12:36:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 1/4] add -p: select individual hunk lines
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180726155854.20832-1-phillip.wood@talktalk.net>
        <20180726155854.20832-2-phillip.wood@talktalk.net>
Date:   Thu, 26 Jul 2018 12:36:29 -0700
In-Reply-To: <20180726155854.20832-2-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Thu, 26 Jul 2018 16:58:51 +0100")
Message-ID: <xmqqin51pz5u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> +sub label_hunk_lines {
> +	my $hunk = shift;
> +	my $text = $hunk->{TEXT};
> +	my (@line_flags, @lines);
> +	my ($block, $label, $last_mode) = (0, 0, '');
> +	for my $line (1..$#{$text}) {

$text is a ref to an array so @$text is the whole thing, $#{$text}
is the index of the last item in that array, and $text->[0] is the
first element of that array.  This for loop runs with $line == 1
thru $line == $#{$text}, so we are somehow excluding the very first
element?

> +		$line_flags[$line] = 0;
> +		my $mode = substr($text->[$line], 0, 1);
> +		if ($mode eq '\\') {
> +			$line_flags[$line - 1] |= NO_NEWLINE;
> +		}
> +		if ($mode eq '-' or $mode eq '+') {
> +			$lines[++$label] = $line;
> +		}
> +	}
> +	if ($label > 1) {
