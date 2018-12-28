Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE191F804
	for <e@80x24.org>; Fri, 28 Dec 2018 22:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeL1WxZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 17:53:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41790 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbeL1WxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 17:53:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so22062784wrs.8
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 14:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hIDoDdeYgFy+fp/q1aVSaqMxfN1BpIj/PZGwlnRigMY=;
        b=LBQC1h2Kr/52Vg8CWSqXkJhSSIgFEcw9ckc/Tx97cjB9u1po+ZuBxrOj1OYHJ3fKVG
         ZaCzyG3JyVFYbBwMJnx6DRThvkSlyVI43Nhuf5NiSk/wu9R1R9BUIP+0qwYFhdB8Fl1M
         IRyXE/hZme+cfwR/CGJZwvNTh+S1xiwvXwPjFUXKfVtJXKE9ibanWK6CFwCa/+LH+PpZ
         YZXb0vnXyFe8hdZX/g1looMvkdSFdiuRQjYDJ8wmCYZmn31QAJ33mvv4RL/yk+a5dddf
         wBwDD92rl1ALnNYAI9S1PndBUZQ7hp1iXid/5lrbliISEpflEK9tu7khkcn9UxjTDWFV
         WoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hIDoDdeYgFy+fp/q1aVSaqMxfN1BpIj/PZGwlnRigMY=;
        b=m5oIEfkctVah+donQ3Pt7xxq2Bvh1jGx9ZylxIO2SMFHMrf4BTHW22Cam5YptAutlF
         KNCCBOUhUMLiSjGWezKxfCEns5cfFFQ86DT4+JLi4WfGdPoDf0OkCWL4l4IUIbgWuJ56
         yagTblrG0hHexbGTcReucuve82i0K6HOCWHOp5yaJQgMT8+ivpZOtLkHew4JPgrhvQh+
         VO3HnymW1mFY2o7xnWeqDx33j+mYn5Hz7S1YpCpTio6T8EQQGl0jNlahVMY8WkN/Qtma
         XmDDSar9l+c09d5n0QQ6q5dZZbVb1OU0dH5IFGAsfjyQ2y8bc9VCYnXE7ltiWwpnjrd9
         40tA==
X-Gm-Message-State: AJcUukcWTDRZiP9+MdmezA3GyXt5kTK+gUrhtYpfsJ1iGMk3/LvgnXmr
        34RSCfWM7KPsSaqqUp1pWHM=
X-Google-Smtp-Source: ALg8bN7/Hba2VdPwF7A4kPh/4wkvF8/fsbM/eRHxgJFCuHRLA/lytx99WSpDasBZPiajA6P4k0Lusw==
X-Received: by 2002:adf:80cf:: with SMTP id 73mr26576429wrl.57.1546037602120;
        Fri, 28 Dec 2018 14:53:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l6sm28634813wrv.70.2018.12.28.14.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 14:53:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     orgads@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Rebase: Run post-checkout hook on checkout
References: <20181224212425.16596-1-orgads@gmail.com>
        <20181224212425.16596-3-orgads@gmail.com>
Date:   Fri, 28 Dec 2018 14:53:19 -0800
In-Reply-To: <20181224212425.16596-3-orgads@gmail.com> (orgads's message of
        "Mon, 24 Dec 2018 23:24:25 +0200")
Message-ID: <xmqqimzdl0v4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

orgads@gmail.com writes:

> From: Orgad Shaneh <orgads@gmail.com>

> Re: [PATCH 2/2] Rebase: Run post-checkout hook on checkout

There is no explanation here?  

Is this a regression fix (i.e. scripted version of "rebase" used to
run the hook)?  Or a new feature (i.e. no earlier version of
"rebase" run the hook but you think it ought to run it)?

> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>  builtin/rebase.c              | 11 +++++++++--
>  t/t5403-post-checkout-hook.sh | 20 ++++++++++++++++++++
>  2 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b5c99ec10c..7f7a2c738e 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -530,6 +530,7 @@ static int run_specific_rebase(struct rebase_options *opts)
>  
>  #define RESET_HEAD_DETACH (1<<0)
>  #define RESET_HEAD_HARD (1<<1)
> +#define RESET_HEAD_RUN_HOOK (1<<2)

Would it be plausible that the only possible hook that can be run by
reset_head() function will always be post-checkout and nothing else,
I wonder?  Shouldn't this bit be called *_RUN_POST_CHECKOUT to make
sure it is specific enough?

> @@ -537,6 +538,7 @@ static int reset_head(struct object_id *oid, const char *action,
>  {
>  	unsigned detach_head = flags & RESET_HEAD_DETACH;
>  	unsigned reset_hard = flags & RESET_HEAD_HARD;
> +	unsigned run_hook = flags & RESET_HEAD_RUN_HOOK;
>  	struct object_id head_oid;
>  	struct tree_desc desc[2] = { { NULL }, { NULL } };
>  	struct lock_file lock = LOCK_INIT;
> @@ -636,6 +638,10 @@ static int reset_head(struct object_id *oid, const char *action,
>  			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
>  					 UPDATE_REFS_MSG_ON_ERR);
>  	}
> +	if (run_hook)
> +		run_hook_le(NULL, "post-checkout",
> +			    oid_to_hex(orig ? orig : &null_oid),
> +			    oid_to_hex(oid), "1", NULL);
>  

This function is never about checking out paths from tree-ish/index
and is always about checking out a branch, so hardcoded "1" is
justified here.  Good.

> @@ -1465,7 +1471,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>  					    options.switch_to);
>  				if (reset_head(&oid, "checkout",
> -					       options.head_name, 0,
> +					       options.head_name,
> +					       RESET_HEAD_RUN_HOOK,
>  					       NULL, buf.buf) < 0) {
>  					ret = !!error(_("could not switch to "
>  							"%s"),
> @@ -1539,7 +1546,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	strbuf_addf(&msg, "%s: checkout %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
>  	if (reset_head(&options.onto->object.oid, "checkout", NULL,
> -		       RESET_HEAD_DETACH, NULL, msg.buf))
> +		       RESET_HEAD_DETACH | RESET_HEAD_RUN_HOOK, NULL, msg.buf))
>  		die(_("Could not detach HEAD"));
>  	strbuf_release(&msg);

So... among 6 callers of reset_head(), these two whose *action is
"checkout" gets the RUN_HOOK bit.  Makes sense.

> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index 9f9a5163c5..5b4e582caa 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -13,6 +13,8 @@ test_expect_success setup '
>  	EOF
>  	test_commit one &&
>  	test_commit two &&
> +	test_commit rebase-on-me &&
> +	git reset --hard HEAD^ &&
>  	test_commit three three
>  '
>  
> @@ -51,6 +53,24 @@ test_expect_success 'post-checkout receives the right args when not switching br
>  	rm -f .git/post-checkout.args
>  '
>  
> +test_expect_success 'post-checkout is triggered on rebase' '
> +	git checkout -b rebase-test master &&
> +	rm -f .git/post-checkout.args &&

Read the title of this whole test script file; it should verify what
is in the file before removing it.

> +	git rebase rebase-on-me &&
> +	read old new flag < .git/post-checkout.args &&

No SP between "<" and ".git/post-checkout.args".

> +	test $old != $new && test $flag = 1 &&
> +	rm -f .git/post-checkout.args
> +'

Regarding the clean-up of this file, see my review on the previous
one.


> +test_expect_success 'post-checkout is triggered on rebase with fast-forward' '

The same comment as above applies to this.


Thanks.
