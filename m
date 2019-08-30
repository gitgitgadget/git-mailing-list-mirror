Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0540E1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 20:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfH3UQq (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 16:16:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55047 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfH3UQp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 16:16:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE3C377788;
        Fri, 30 Aug 2019 16:16:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=CQAl4wTyLOe13SHYWSL5jJfGbpg=; b=epE3E5/gWEG0AUpmIDUL
        inksJvNbvdXeJP1ohZeZkOk8oHHyHlFtt34ARD8/0uF2KqOHyY1LR07oD9VlHpW4
        YlIrhGpA80wEpLMOBiEWLgEG2xYIcuQASQ5czYl8ZAsdRsHXOL/Wh5bfnhuqMBNa
        EK+50CxMmB5H3uslr6Jngng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=s04qVK/gSgox/5UewSY8XDiTadAOg769IIaAmCFimTrSnc
        m3L8+IUNrLSCUp+ILmQfCObTIE1UW4slUWl8I2j9WuoPa2EvRyyW/Jao93mg/syq
        Yrv2Muc7d4iMEZYnHCZNsUR+wopAP2ly3cCCzv7dCEcpV52K0BqyGE4MKe0FM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5B9B77786;
        Fri, 30 Aug 2019 16:16:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05F9177785;
        Fri, 30 Aug 2019 16:16:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Wijen <ben@wijen.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Szeder =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 2/2] builtin/rebase.c: Remove pointless message
References: <20190829164757.7301-1-ben@wijen.net>
        <20190830151607.4208-1-ben@wijen.net>
        <20190830151607.4208-3-ben@wijen.net>
Date:   Fri, 30 Aug 2019 13:16:38 -0700
Message-ID: <xmqqimqewgrd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14117E4C-CB63-11E9-BC56-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Wijen <ben@wijen.net> writes:

> @@ -1968,13 +1968,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  				state_dir_path("autostash", &options);
>  			struct child_process stash = CHILD_PROCESS_INIT;
>  			struct object_id oid;
> -			struct object_id head_oid;
> -			if (get_oid("HEAD", &head_oid)) {
> -				ret = error(_("could not determine HEAD revision"));

I think we saw die() in the previous one.  This patch would not
apply on top of the result of applying 1/2.

I'll tentatively queue this instead on top of the corrected 1/2.

Thanks.

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0a2f9273ee..118205e481 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1968,12 +1968,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				state_dir_path("autostash", &options);
 			struct child_process stash = CHILD_PROCESS_INIT;
 			struct object_id oid;
-			struct object_id head_oid;
-			struct commit *head;
-
-			if (get_oid("HEAD", &head_oid))
-				die(_("could not determine HEAD revision"));
-			head = lookup_commit_reference(the_repository, &head_oid);
 
 			argv_array_pushl(&stash.args,
 					 "stash", "create", "autostash", NULL);
@@ -1994,17 +1988,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				    options.state_dir);
 			write_file(autostash, "%s", oid_to_hex(&oid));
 			printf(_("Created autostash: %s\n"), buf.buf);
-			if (reset_head(&head->object.oid, "reset --hard",
+			if (reset_head(NULL, "reset --hard",
 				       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
 				die(_("could not reset --hard"));
-			printf(_("HEAD is now at %s"),
-			       find_unique_abbrev(&head->object.oid,
-						  DEFAULT_ABBREV));
-			strbuf_reset(&buf);
-			pp_commit_easy(CMIT_FMT_ONELINE, head, &buf);
-			if (buf.len > 0)
-				printf(" %s", buf.buf);
-			putchar('\n');
 
 			if (discard_index(the_repository->index) < 0 ||
 				repo_read_index(the_repository) < 0)
