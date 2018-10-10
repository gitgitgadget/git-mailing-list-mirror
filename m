Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B571F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 00:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJJIIa (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 04:08:30 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45437 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJIIa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 04:08:30 -0400
Received: by mail-wr1-f43.google.com with SMTP id q5-v6so3708247wrw.12
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 17:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C4EbbU/b3fCDU7p74eDTq4XUtag31hnHGRaV8iuRP5w=;
        b=vB/nyl3GCvf2pRekHBOVR3CzBlDRIET0hNCdouEZ/nlwyj+vnIK5afpponhOGnCqMB
         YienPR2Z5RjUXmhD97IrKYNKIbGt28qoHAP6D3U2U/ARyrFodbb4M27E1+CrS6jjKc8X
         QgE3rFN5hvWZ0WCd9tsbq+qsyIjkTaFDboJBPWpILXSsA6KgCuYj3voyLGbiaRNAKMSn
         +koc/Xe/n83cb6ti2FMkY0l5Y4KsTXWaLO4TwZmmFaUTUc+azC/6AWsSRdKpNxuqTWa3
         Y2BWQDrkup1/Ri34Rl+/S90gd9YS5bpTuH10JI0+syZEDoAiSmsDLN+oQWzetxXgIzWs
         Z5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C4EbbU/b3fCDU7p74eDTq4XUtag31hnHGRaV8iuRP5w=;
        b=ONuCJWx7RriJe2MCkLU2Ftbu4sugCPg/P9D1Z3O2zSJC2Z03/8wXQQH3w6oxaPaRXg
         n33F3SaqvUAns6jvJASfTbN1M2ZGB3feR/eiGQVPLJlgCGc+Uc1bSELJJEngG1vigG92
         azXvUqtaBpV0vMcvdmM8QDrEuW6f9doHMsPwAYECzdKFgxtiwewKbqtLwYEI83fzDupz
         1p+arv2doSAurWpc3rT8uFswbPpJC4UGQcMWvc9RYm2je6qik/2Y3BP+fF8V/Q1E4AIW
         9R9H9NFKq6AKDVCfj1y1Hsl7ph3UUf4V7aKscDDcX8oJdcjle74/fChf8JwU7zhZljy2
         H9cA==
X-Gm-Message-State: ABuFfohMCHemRB+HbkwB5sxPlonOdhl5WV6OioPnx//1sowU3rC2a+bv
        2n6Xn84gmn5UMZqcRLf7NxQ=
X-Google-Smtp-Source: ACcGV618tWEe+WBf82apYT3Oi0aXmMiKN2sMFc31BQi2FE9ZBt+eXLFM+Oty0lcEDgogXci14S7mlQ==
X-Received: by 2002:adf:fe83:: with SMTP id l3-v6mr22419317wrr.322.1539132535721;
        Tue, 09 Oct 2018 17:48:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l67-v6sm38636034wma.20.2018.10.09.17.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 17:48:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PoC -- do not apply 2/3] test-tree-bitmap: add "dump" mode
References: <20181009231250.GA19342@sigill.intra.peff.net>
        <20181009231405.GB23730@sigill.intra.peff.net>
Date:   Wed, 10 Oct 2018 09:48:53 +0900
In-Reply-To: <20181009231405.GB23730@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 9 Oct 2018 19:14:05 -0400")
Message-ID: <xmqqy3b6occq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The one difference is the sort order: git's diff output is
> in tree-sort order, so a subtree "foo" sorts like "foo/",
> which is after "foo.bar". Whereas the bitmap path list has a
> true byte sort, which puts "foo.bar" after "foo".

If we truly cared, it is easy enough to fix by having a custom
comparison function in 1/3 used in collect_paths() phase.

> +	/* dump it while we have the sorted order in memory */
> +	for (i = 0; i < n; i++) {
> +		printf("%s", sorted[i]->path);
> +		putchar('\0');
> +	}

With printf("%s%c", sorted[i]->path, '\0'); you can lose the braces.

> +	putchar('\0');
> +
>  	free(sorted);
>  }
>  
> @@ -142,6 +150,8 @@ static void generate_bitmap(struct diff_queue_struct *q,
>  
>  	ewah = bitmap_to_ewah(bitmap);
>  	ewah_serialize_strbuf(ewah, &out);
> +
> +	fwrite(data->commit->object.oid.hash, 1, GIT_SHA1_RAWSZ, stdout);
>  	fwrite(out.buf, 1, out.len, stdout);

OK, so per commit, we have ewah bitmap that records the "changed
paths" after the commit object name.  Makes sense.

And the list of paths are based on the "one" side of the filepair.
When we do an equivalent of "git show X", we see "diff-tree X~1 X"
and by collecting the "one" side (i.e. subset of paths in the tree
of X~1 that were modified when going to X) we say "commit X changed
these paths".  Makes sense, too.

> -int cmd_main(int argc, const char **argv)
> +static void do_gen(void)
>  {
>  	struct hashmap paths;
> -

Let's not lose this blank line.

>  	setup_git_directory();
>  	collect_paths(&paths);
>  
>  	walk_paths(generate_bitmap, &paths);
> +}
> +
> +static void do_dump(void)
> +{
> +	struct strbuf in = STRBUF_INIT;
> +	const char *cur;
> +	size_t remain;
> +
> +	const char **paths = NULL;
> +	size_t alloc_paths = 0, nr_paths = 0;
> +
> +	/* slurp stdin; in the real world we'd mmap all this */
> +	strbuf_read(&in, 0, 0);
> +	cur = in.buf;
> +	remain = in.len;
> +
> +	/* read path for each bit; in the real world this would be separate */
> +	while (remain) {
> +		const char *end = memchr(cur, '\0', remain);
> +		if (!end) {
> +			error("truncated input while reading path");
> +			goto out;
> +		}
> +		if (end == cur) {
> +			/* empty field signals end of paths */
> +			cur++;
> +			remain--;
> +			break;
> +		}
> +
> +		ALLOC_GROW(paths, nr_paths + 1, alloc_paths);
> +		paths[nr_paths++] = cur;
> +
> +		remain -= end - cur + 1;
> +		cur = end + 1;
> +	}
> +

OK.

> +	while (remain) {
> +		struct object_id oid;
> +		struct ewah_bitmap *ewah;
> +		ssize_t len;
> +
> +		if (remain < GIT_SHA1_RAWSZ) {
> +			error("truncated input reading oid");
> +			goto out;
> +		}
> +		hashcpy(oid.hash, (const unsigned char *)cur);
> +		cur += GIT_SHA1_RAWSZ;
> +		remain -= GIT_SHA1_RAWSZ;
> +
> +		ewah = ewah_new();
> +		len = ewah_read_mmap(ewah, cur, remain);
> +		if (len < 0) {
> +			ewah_free(ewah);
> +			goto out;
> +		}
> +
> +		printf("%s\n", oid_to_hex(&oid));
> +		ewah_each_bit(ewah, show_path, paths);
> +
> +		ewah_free(ewah);
> +		cur += len;
> +		remain -= len;
> +	}

Makes perfect sense.

> +out:
> +	free(paths);
> +	strbuf_release(&in);
> +}
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	const char *usage_msg = "test-tree-bitmap <gen|dump>";
> +
> +	if (!argv[1])
> +		usage(usage_msg);
> +	else if (!strcmp(argv[1], "gen"))
> +		do_gen();
> +	else if (!strcmp(argv[1], "dump"))
> +		do_dump();
> +	else
> +		usage(usage_msg);
>  
>  	return 0;
>  }
