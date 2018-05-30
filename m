Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C6D1F42D
	for <e@80x24.org>; Wed, 30 May 2018 19:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbeE3TWv (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 15:22:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36202 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932108AbeE3TWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 15:22:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id v131-v6so30523640wma.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=G3dm87TvSooet/olMMrnz1u3sEKnd1RH1gI73LQcy4w=;
        b=PAW/s/gJZvFKeqAo/pFYbLwnqdu2iUS7chHArQCLt3vKxflHgUum+k2otCidSZsX4Y
         rA5ye20dnOtFiTG8j+HPCV4r7F9hNBDgVfAvPb8H5Z5vBSDekhnNbffccHCNoPGQ+gE8
         be5VT9x+7FHYyWSEXuTcx4C23NWGspgWaghWYoFNLn0R+S0UnT/ulgilH+RROo/2b2oL
         Nq8WW3rrgu0P5SmlvqgXnEN1MipKF9+OVSZNmZCfn603jjXMTCFjKdrrMtFL/GAyKfKU
         6oUpSYgr4pDc5iK79I1xlr4VXxlq4IeuNKn0HQAje2/GjbZHHxV2kiMuOeMES/wQ2CIL
         u+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=G3dm87TvSooet/olMMrnz1u3sEKnd1RH1gI73LQcy4w=;
        b=KmEP3oXABMBp5C8BiVJ1ZLUJeK232skQVtATh3ICvCVCyUsssYDAieXQpv1e3O8oUR
         YED+Gh298sxajKdgNH9Qrqd9OHHkMhkFDjJaMsM6TBNr1H9O+aw65CqWXVMz049+/fH5
         nsd0/JqzYg5MCi3zPCxbPrpPsjQpzv+ScldQr4d8smQ6Ns+qRvjWi8ok7/whxKoJ3856
         2+2yWOjEs9GLsIxfikD+GNb0hPPpQ/DiN8LLtSirapjwluccfM36UEKNxpi9FZ4A0r8v
         Pet9gs9bpvbdGnPULBa2p+OPmm1fuwsxtKy8PM/0AfJiQhA2FTz6ZbNOcjIRxLfvo6Vq
         sbiA==
X-Gm-Message-State: APt69E2bA8aoW/MITXS5fqvwGsjFYoBOmvCnUxVwE+JanckwRNxbUxZQ
        jsu6rinqsF6LTeEYrdThug4=
X-Google-Smtp-Source: ADUXVKIn1mcSMXabo0F5UzfJp6fqIR8N8DE1AlSTZCqOQ0TCUiWbkTWrvSSJ8HbeW89aHCeYesG+Rg==
X-Received: by 2002:a1c:c86:: with SMTP id 128-v6mr2194802wmm.18.1527708168522;
        Wed, 30 May 2018 12:22:48 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ahg103.neoplus.adsl.tpnet.pl. [83.25.188.103])
        by smtp.gmail.com with ESMTPSA id d12-v6sm27478274wre.39.2018.05.30.12.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 12:22:47 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 10/20] commit-graph: verify objects exist
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-11-dstolee@microsoft.com>
Date:   Wed, 30 May 2018 21:22:45 +0200
In-Reply-To: <20180524162504.158394-11-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:25:47 +0000")
Message-ID: <86a7shvth6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> In the 'verify' subcommand, load commits directly from the object
> database to ensure they exist. Parse by skipping the commit-graph.

All right, before we check that the commit data matches, we need to
check that all the commits in cache (in the serialized commit graph) are
present in real data (in the object database of the repository).

What's nice of this series is that the operation that actually removes
unreachable commits from the object database, that is `git gc`, would
also update commit-gaph file.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c          | 20 ++++++++++++++++++++
>  t/t5318-commit-graph.sh |  7 +++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index cbd1aae514..0420ebcd87 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -238,6 +238,10 @@ static struct commit_list **insert_parent_or_die(str=
uct commit_graph *g,
>  {
>  	struct commit *c;
>  	struct object_id oid;
> +
> +	if (pos >=3D g->num_commits)
> +		die("invalid parent position %"PRIu64, pos);
> +

This change is not described in the commit message.

>  	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
>  	c =3D lookup_commit(&oid);
>  	if (!c)
> @@ -905,5 +909,21 @@ int verify_commit_graph(struct commit_graph *g)
>  		cur_fanout_pos++;
>  	}
>=20=20
> +	if (verify_commit_graph_error)
> +		return verify_commit_graph_error;

All right, so we by default short-circuit so that errors found earlier
wouldn't cause crash when checking other things.

Is it needed, though, in this case?  Though I guess it is better to be
conservative; lso by terminating after a batch of one type of errors we
don't get many different error messages from the same error (i.e. error
propagation).

> +
> +	for (i =3D 0; i < g->num_commits; i++) {
> +		struct commit *odb_commit;
> +
> +		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> +
> +		odb_commit =3D (struct commit *)create_object(cur_oid.hash, alloc_comm=
it_node());

Do we really need to keep all those commits from the object database in
memory (in the object::obj_hash hash table)?  Perhaps using something
like Flywheel / Recycler pattern would be a better solution (if
possible)?

Though perhaps this doesn't matter much with respect to memory use.

> +		if (parse_commit_internal(odb_commit, 0, 0)) {

Just a reminder to myself: the signature is

  int parse_commit_internal(struct commit *item, int quiet_on_missing, int =
use_commit_graph)


Hmmm... I wonder if with two boolean paramaters wouldn't it be better to
use flags parameter, i.e.

  int parse_commit_internal(struct commit *item, int flags)

  ...

  parse_commit_internal(commit, QUIET_ON_MISSING | USE_COMMIT_GRAPH)

But I guess that it is not worth it (especially for internal-ish
function).

> +			graph_report("failed to parse %s from object database",
> +				     oid_to_hex(&cur_oid));

Wouldn't parse_commit_internal() show it's own error message, in
addition to the one above?

> +			continue;
> +		}
> +	}
> +
>  	return verify_commit_graph_error;
>  }
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index c050ef980b..996a016239 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -247,6 +247,7 @@ test_expect_success 'git commit-graph verify' '
>  	git commit-graph verify >output
>  '
>=20=20
> +NUM_COMMITS=3D9
>  HASH_LEN=3D20
>  GRAPH_BYTE_VERSION=3D4
>  GRAPH_BYTE_HASH=3D5
> @@ -265,6 +266,7 @@ GRAPH_BYTE_FANOUT1=3D`expr $GRAPH_FANOUT_OFFSET + 4 \=
* 4`
>  GRAPH_BYTE_FANOUT2=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* 255`
>  GRAPH_OID_LOOKUP_OFFSET=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* 256`
>  GRAPH_BYTE_OID_LOOKUP_ORDER=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN=
 \* 8`
> +GRAPH_BYTE_OID_LOOKUP_MISSING=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_L=
EN \* 4 + 10`

All right, so we modify 10-the byte of OID of 5-th commit out of 9,
am I correct here?

>=20=20
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -334,4 +336,9 @@ test_expect_success 'detect incorrect OID order' '
>  		"incorrect OID order"
>  '
>=20=20
> +test_expect_success 'detect OID not in object database' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_MISSING "\01" \
> +		"from object database"
> +'

I guess that if we ensure that OIDs are constant, you have chosen the
change to actually corrupt the OID in OID Lookup chunk to point to OID
that is not in the object database (while still not violating the
constraint that OID in OID Lookup chunk needs to be sorted).

> +
>  test_done

All right (well, except for `expr ... ` --> $(( ... )) change).

--=20
Jakub Nar=C4=99bski
