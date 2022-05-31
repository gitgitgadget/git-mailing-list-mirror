Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F42C433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 14:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbiEaOAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 10:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245022AbiEaOAx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 10:00:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBD759333
        for <git@vger.kernel.org>; Tue, 31 May 2022 07:00:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso1299641wmh.3
        for <git@vger.kernel.org>; Tue, 31 May 2022 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AKX86Wk9yLc29X4dxJiLmMhbOOMw7De09B1CeJyXB2w=;
        b=SfJQbTvoIt5+MgY/ZdtXykbSn9I7bGLnOzOeztvS4VuK/oVkwieRWI3FDfbwi2AB/I
         I4bMomc5p5ZJMawojO26yUHKzIHvXiiHMVYyMB8DKWxwQ4uq/NB+VcEBI2Iye2mqWGpV
         Bi33CyVPd1tbZiJ4cSPKdtIZ99Ey/QK88iFf4+gGk5eHZIDGBJyeTaM3S5LmasJiQjsm
         eJYGYwGLZoRc6MWCkf6wirS2eZLXlGxrxUP7rIcEqvdyhORSfbcuz2BPafVOhgE9O9HE
         GqnfKOcWI4MudhWKs0rRzR0QfieDPPSXJ9kW24a4rwAxDMZGgazx9124BBQz13eBQ3WA
         IA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AKX86Wk9yLc29X4dxJiLmMhbOOMw7De09B1CeJyXB2w=;
        b=QwwPvPEDn+seo8TTs0e4qW+Sws7cfG04z3WIOrXQ/9JBO2h5SYyBTDHsl9x3a4WApj
         9ThYceXB1Vo6PO0GDqhv1P9ibzCchB9zz3ntdCNYVIsW5nb04IRCOHU+hxcnYKe5TTwX
         NSAEvpZFfIK88bRrC+f3vyeE/nZxogt8/nw+uZD9BAUPKLH1+l1j0fRjTEmzMb6IpFZd
         IgRSxuHQI4chenQ/8o65YQIiWep3Eo5LT5QGdT25fRorn/qOiVJ3pAZI+5F7x3R8YCI/
         JuuXeX98lnVmwqQ9y0zqBuos0JP8bt2EVfccD+8Xnq9zIBYcTAgpM1fGYK17kP0HQO9L
         4clA==
X-Gm-Message-State: AOAM5335znBisIDyNw9TY074gQQ8HPie+IWFtieNKHp4jdbdIhXVuiwN
        UJ+v7P+QvKlSWLEOAF5WO3o=
X-Google-Smtp-Source: ABdhPJxscJkgN6V9E0BZN4ynei0HxWrwzLTbzfOO2lZBxoQpaTgEcPYVlTmkcDvaFUS8YLQTlhjwfA==
X-Received: by 2002:a05:600c:3b15:b0:397:6403:7091 with SMTP id m21-20020a05600c3b1500b0039764037091mr23966016wms.193.1654005650334;
        Tue, 31 May 2022 07:00:50 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc354000000b003974a3af623sm2207087wmj.17.2022.05.31.07.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 07:00:49 -0700 (PDT)
Message-ID: <479d97af-eef1-ce86-19f7-afcc0e6ecf30@gmail.com>
Date:   Tue, 31 May 2022 15:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] revert: optionally refer to commit in the "reference"
 format
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqsfp2b30k.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet>
 <xmqq35gzn9vk.fsf@gitster.g> <xmqq8rqn7buk.fsf_-_@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8rqn7buk.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 27/05/2022 07:01, Junio C Hamano wrote:
> A typical "git revert" commit uses the full title of the original
> commit in its title, and starts its body of the message with:
> 
>      This reverts commit 8fa7f667cf61386257c00d6e954855cc3215ae91.
> 
> This does not encourage the best practice of describing not just
> "what" (i.e. "Revert X" on the title says what we did) but "why"
> (i.e. and it does not say why X was undesirable).
> 
> We can instead phrase this first line of the body to be more like
> 
>      This reverts commit 8fa7f667 (do this and that, 2022-04-25)
> 
> so that the title does not have to be
> 
>      Revert "do this and that"
> 
> We can instead use the title to describe "why" we are reverting the
> original commit.
> 
> Introduce the "--reference" option to "git revert", and also the
> revert.reference configuration variable, which defaults to false, to
> tweak the title and the first line of the draft commit message for
> when creating a "revert" commit.
> 
> When this option is in use, the first line of the pre-filled editor
> buffer becomes a comment line that tells the user to say _why_.  If
> the user exits the editor without touching this line by mistake,
> what we prepare to become the first line of the body, i.e. "This
> reverts commit 8fa7f667 (do this and that, 2022-04-25)", ends up to
> be the title of the resulting commit.  This behaviour is designed to
> help such a user to identify such a revert in "git log --oneline"
> easily so that it can be further reworded with "git rebase -i" later.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>   * The only difference since the second one is that the first line of
>     the log message template is commented out and has asterisks to
>     draw more attention.  The last paragraph (new) in the proposed
>     log message explains the rationale behind this design.
> 
>     Third-time a charm, hopefully.

I think the changes to the template message are good. We're still adding 
"--reference" as a valid option to cherry-pick though which I don't 
think is a good idea (though in the future we may want to allow 
"cherry-pick -x --reference")

Best Wishes

Phillip

> Range-diff against v2:
> 1:  4152fc2092 ! 1:  f4325a503a revert: optionally refer to commit in the "reference" format
>      @@ Commit message
>           tweak the title and the first line of the draft commit message for
>           when creating a "revert" commit.
>       
>      +    When this option is in use, the first line of the pre-filled editor
>      +    buffer becomes a comment line that tells the user to say _why_.  If
>      +    the user exits the editor without touching this line by mistake,
>      +    what we prepare to become the first line of the body, i.e. "This
>      +    reverts commit 8fa7f667 (do this and that, 2022-04-25)", ends up to
>      +    be the title of the resulting commit.  This behaviour is designed to
>      +    help such a user to identify such a revert in "git log --oneline"
>      +    easily so that it can be further reworded with "git rebase -i" later.
>      +
>           Signed-off-by: Junio C Hamano <gitster@pobox.com>
>       
>        ## Documentation/config/revert.txt (new) ##
>      @@ sequencer.c: static int do_pick_commit(struct repository *r,
>       -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
>       -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
>       +		if (opts->commit_use_reference) {
>      -+			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
>      ++			strbuf_addstr(&msgbuf,
>      ++				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>       +		} else {
>       +			strbuf_addstr(&msgbuf, "Revert \"");
>       +			strbuf_addstr(&msgbuf, msg.subject);
> 
>   Documentation/config/revert.txt |  3 +++
>   Documentation/git-revert.txt    |  9 +++++++++
>   builtin/revert.c                |  2 ++
>   sequencer.c                     | 33 ++++++++++++++++++++++++++++-----
>   sequencer.h                     |  1 +
>   t/t3501-revert-cherry-pick.sh   | 31 +++++++++++++++++++++++++++++++
>   6 files changed, 74 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/config/revert.txt
> 
> diff --git a/Documentation/config/revert.txt b/Documentation/config/revert.txt
> new file mode 100644
> index 0000000000..797bfb6d62
> --- /dev/null
> +++ b/Documentation/config/revert.txt
> @@ -0,0 +1,3 @@
> +revert.reference::
> +	Setting this variable to true makes `git revert` to behave
> +	as if the `--reference` option is given.
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index bb92a4a451..8463fe9cf7 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -117,6 +117,15 @@ effect to your index in a row.
>   	Allow the rerere mechanism to update the index with the
>   	result of auto-conflict resolution if possible.
>   
> +--reference::
> +	Instead of starting the body of the log message with "This
> +	reverts <full object name of the commit being reverted>.",
> +	refer to the commit using "--pretty=reference" format
> +	(cf. linkgit:git-log[1]).  The `revert.reference`
> +	configuration variable can be used to enable this option by
> +	default.
> +
> +
>   SEQUENCER SUBCOMMANDS
>   ---------------------
>   include::sequencer.txt[]
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 51776abea6..ada51e46b9 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -116,6 +116,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   			N_("option for merge strategy"), option_parse_x),
>   		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
>   		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +		OPT_BOOL(0, "reference", &opts->commit_use_reference,
> +			 N_("use the 'reference' format to refer to commits")),
>   		OPT_END()
>   	};
>   	struct option *options = base_options;
> diff --git a/sequencer.c b/sequencer.c
> index a5f678f452..96fec6ef6d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -221,6 +221,9 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>   		return ret;
>   	}
>   
> +	if (!strcmp(k, "revert.reference"))
> +		opts->commit_use_reference = git_config_bool(k, v);
> +
>   	status = git_gpg_config(k, v, NULL);
>   	if (status)
>   		return status;
> @@ -2059,6 +2062,20 @@ static int should_edit(struct replay_opts *opts) {
>   	return opts->edit;
>   }
>   
> +static void refer_to_commit(struct replay_opts *opts,
> +			    struct strbuf *msgbuf, struct commit *commit)
> +{
> +	if (opts->commit_use_reference) {
> +		struct pretty_print_context ctx = {
> +			.abbrev = DEFAULT_ABBREV,
> +			.date_mode.type = DATE_SHORT,
> +		};
> +		format_commit_message(commit, "%h (%s, %ad)", msgbuf, &ctx);
> +	} else {
> +		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
> +	}
> +}
> +
>   static int do_pick_commit(struct repository *r,
>   			  struct todo_item *item,
>   			  struct replay_opts *opts,
> @@ -2167,14 +2184,20 @@ static int do_pick_commit(struct repository *r,
>   		base_label = msg.label;
>   		next = parent;
>   		next_label = msg.parent_label;
> -		strbuf_addstr(&msgbuf, "Revert \"");
> -		strbuf_addstr(&msgbuf, msg.subject);
> -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
> -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> +		if (opts->commit_use_reference) {
> +			strbuf_addstr(&msgbuf,
> +				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> +		} else {
> +			strbuf_addstr(&msgbuf, "Revert \"");
> +			strbuf_addstr(&msgbuf, msg.subject);
> +			strbuf_addstr(&msgbuf, "\"");
> +		}
> +		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
> +		refer_to_commit(opts, &msgbuf, commit);
>   
>   		if (commit->parents && commit->parents->next) {
>   			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
> -			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
> +			refer_to_commit(opts, &msgbuf, parent);
>   		}
>   		strbuf_addstr(&msgbuf, ".\n");
>   	} else {
> diff --git a/sequencer.h b/sequencer.h
> index da64473636..698599fe4e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -49,6 +49,7 @@ struct replay_opts {
>   	int reschedule_failed_exec;
>   	int committer_date_is_author_date;
>   	int ignore_date;
> +	int commit_use_reference;
>   
>   	int mainline;
>   
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 8617efaaf1..a386ae9e88 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -159,6 +159,7 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
>   '
>   
>   test_expect_success 'advice from failed revert' '
> +	test_when_finished "git reset --hard" &&
>   	test_commit --no-tag "add dream" dream dream &&
>   	dream_oid=$(git rev-parse --short HEAD) &&
>   	cat <<-EOF >expected &&
> @@ -174,4 +175,34 @@ test_expect_success 'advice from failed revert' '
>   	test_must_fail git revert HEAD^ 2>actual &&
>   	test_cmp expected actual
>   '
> +
> +test_expect_success 'identification of reverted commit (default)' '
> +	test_commit to-ident &&
> +	test_when_finished "git reset --hard to-ident" &&
> +	git checkout --detach to-ident &&
> +	git revert --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git rev-parse HEAD^)." >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'identification of reverted commit (--reference)' '
> +	git checkout --detach to-ident &&
> +	git revert --reference --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'identification of reverted commit (revert.reference)' '
> +	git checkout --detach to-ident &&
> +	git -c revert.reference=true revert --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_done
