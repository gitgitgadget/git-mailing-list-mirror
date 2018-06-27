Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020B71F516
	for <e@80x24.org>; Wed, 27 Jun 2018 17:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeF0Rv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 13:51:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33092 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbeF0Rv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 13:51:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so18730080wma.0
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I28/0ySIdIg256qtGTR75alYM5EUQA0dR/wZGchTWtk=;
        b=mV1YEFVSOu7u9oLzLrM/Ea6AXlazPAKAQHzjK5ESj2yRCp3NzcSHFPXPctAurG2sTN
         WyjPhvwN7guJsh4ls+84PN/6w370zX0FG2AiRZnCy3/DlzkFqQjJ8vj4DP0EfrDMqWkZ
         wX8v9Wy09IoKkjFBn0p2xfdf7xnhzYTUreiaUjC10b5FzOhrcKSsKBFHLPRvjQGm4vf5
         SJ4iD0ZzABrjHLKPHK1NE8b4dQtp4uuFTI+26QMLtYT1o3tjlnNXluyE0Yk3t3spUZLy
         XBtayt0C/KO/ZmXa0osC9/FpCfoUrmaKR85ARbsdUzyxAkefsSOfNwuRhN/RDKh3Dnnf
         d+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I28/0ySIdIg256qtGTR75alYM5EUQA0dR/wZGchTWtk=;
        b=r8BQjl2T6lGMy7ZeuvUtatHNFl3SvbBhjfYci4SCR1PnYPNEiJtPWj/W6g085+E+UX
         mKHFfhBHS3L7IUMlEjjraPKMHkgKKMtMrXbMjLVdGmCiUa1YSs4rylvakzoepFqcdFzr
         sVoLO8WRsSLH3/Go7YqF1ybcGOtyxqBywpmgDaq0SVU/m7b9JPYzthAOj4XbC8/8sxqX
         ByuWi+ybwY6eWEWB91d9zJYPJPmDw86IZdmmU+/grEjwXxxEcJ4ml3sFjsyFagPJhb8k
         ZnkMUkkUArdgB8hHc3GtQih6jnPO12FlfDfUYn+YB17EW774jfKqMVOiKUkPsp2AGhO8
         LFiA==
X-Gm-Message-State: APt69E0cC6wbMYavnsJK0/iWefZ6/QnCIsmb/cHuByukE8OMgfApBJb3
        Gb7Upn+CYwUM+K4VkshCSCo=
X-Google-Smtp-Source: AAOMgpdMqbAgmlQUDqJJkoI8uSMt3w25zW9bV0xgiS8m1++YCnSceIqtaShok1fI4rPctGOJ+2nsqw==
X-Received: by 2002:a1c:c342:: with SMTP id t63-v6mr6074188wmf.123.1530121884893;
        Wed, 27 Jun 2018 10:51:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e188-v6sm17416281wmf.21.2018.06.27.10.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 10:51:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 17/22] commit-graph: verify contents match checksum
References: <20180608135548.216405-1-dstolee@microsoft.com>
        <20180627132447.142473-1-dstolee@microsoft.com>
        <20180627132447.142473-18-dstolee@microsoft.com>
Date:   Wed, 27 Jun 2018 10:51:23 -0700
In-Reply-To: <20180627132447.142473-18-dstolee@microsoft.com> (Derrick
        Stolee's message of "Wed, 27 Jun 2018 09:24:42 -0400")
Message-ID: <xmqq36x8glt0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +	devnull = open("/dev/null", O_WRONLY);
> +	f = hashfd(devnull, NULL);
> +	hashwrite(f, g->data, g->data_len - g->hash_len);

I wondered if we can hide the knowledge of "/dev/null" by reusing
hashfd_check() from csum-file.c (which is used by the verification
of pack idx file), which also gives us the hash comparison of an
existing file on disk for free.  But unfortunately this codepath
only verifies the checksum and not contents, so we cannot avoid
setting up the /dev/null sink manually like this patch does, I
guess.

> +	finalize_hashfile(f, checksum.hash, CSUM_CLOSE);
> +	if (hashcmp(checksum.hash, g->data + g->data_len - g->hash_len)) {
> +		graph_report(_("the commit-graph file has incorrect checksum and is likely corrupt"));
> +		verify_commit_graph_error = VERIFY_COMMIT_GRAPH_ERROR_HASH;
> +	}
> +
>  	for (i = 0; i < g->num_commits; i++) {
>  		struct commit *graph_commit;
>  
> @@ -909,7 +921,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
>  		cur_fanout_pos++;
>  	}
>  
> -	if (verify_commit_graph_error)
> +	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
>  		return verify_commit_graph_error;
>  
>  	for (i = 0; i < g->num_commits; i++) {
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index a0cf1f66de..fed05e2f12 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -279,6 +279,7 @@ GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
>  GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
>  			     $GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
>  GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
> +GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
>  
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -393,4 +394,9 @@ test_expect_success 'detect incorrect parent for octopus merge' '
>  		"invalid parent"
>  '
>  
> +test_expect_success 'detect invalid checksum hash' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> +		"incorrect checksum"
> +'
> +
>  test_done
