Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4652F1F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 11:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbdKMLYh (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 06:24:37 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:11105 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbdKMLYg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 06:24:36 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id ECqvezOOzmITaECqweEzsl; Mon, 13 Nov 2017 11:24:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510572274;
        bh=Z+tTen451QCGMJh+2ElIBo8cJZcUBLoANfn4smjzLs0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Kh2ovt4j+SgfDEMn+kBAKYbAd46ksbZIcXRXkZH0exShaAwF8RBnR190z6Y+YB4MS
         uqaC+O2IOK/1Qc5AW8vKVB7exwNBGmqvSK4F9ANYm88c3LpAqtNq3Es4ReQja7uX67
         6AGLUH8D+KzQ1Gb8id2uxg115fAXZinTV6xcdvHc=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=ktaJCbe_-ckrqRQWzx4A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/9] sequencer: dont't fork git commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171110110949.328-1-phillip.wood@talktalk.net>
 <xmqqo9oadjn5.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <f1c0efa2-fb8a-43bc-f229-c22dada95b03@talktalk.net>
Date:   Mon, 13 Nov 2017 11:24:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9oadjn5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDahYavHQ4cPYmgvNESqUzJZAEeQFs4X0rF6Ql94AfBnPrbgeqepLlR1MHXdUi88bNeq1lFk7CLo6h74fE+JXdXyUtgW5q1NjTiFNG1kvemWF+FBIZgn
 emskfj3+/uSP3r4ehzCoyEQnLxe4my299H76cIpFxtPxKVhR+5QO0Upj4dGKKZAa5R7WpWL6DoSqtVUWmftwQ16cEczYbbQ0hwg0pdSuiAGWesgVzoF1DCkU
 iGD8MEa5W3cqnp8d4M+QglP+YjpHQjGc9249COHMpAyG25OXHg0DNZH7gUq4FS4s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/17 19:21, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> Here's the summary from the previous version
>> These patches teach the sequencer to create commits without forking
>> git commit when the commit message does not need to be edited. This
>> speeds up cherry picking 10 commits by 26% and picking 10 commits with
>> rebase --continue by 44%. The first few patches move bits of
>> builtin/commit.c to sequencer.c. The last two patches actually
>> implement creating commits in sequencer.c.
> 
> Thanks.  The changes since the initial iteration seems quite small
> and I didn't find much objectionable.
> 
> Here are some style fixes I needed to add on top to make the output
> of "diff master HEAD" checkpatch.pl-clean.  I think 3/9 and 9/9 are
> the culprits.

Thanks, I'll update the patches.

Are you happy with the '--signoff' is handled (I didn't modify my
changes in the last iteration as you were still thinking about it)?

In the last patch commit_tree_extended() can die in write_loose_object()
which means that the current command is not rescheduled as it should be
when rebasing. write_loose_object() already an error if there is a
problem opening the file, but dies if there is a problem creating the
file contents or writing that contents.

Best Wishes

Phillip

> diff --git a/sequencer.c b/sequencer.c
> index 1f65e82696..a989588ee5 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -592,7 +592,7 @@ static int read_env_script(struct argv_array *env)
>  	return 0;
>  }
>  
> -static char *get_author(const char* message)
> +static char *get_author(const char *message)
>  {
>  	size_t len;
>  	const char *a;
> @@ -1104,7 +1104,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
>  	}
>  
>  	if (update_head_with_reflog(current_head, oid,
> -				    getenv("GIT_REFLOG_ACTION"), msg, &err)){
> +				    getenv("GIT_REFLOG_ACTION"), msg, &err)) {
>  		res = error("%s", err.buf);
>  		goto out;
>  	}
> @@ -1121,7 +1121,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
>  	return res;
>  }
>  
> -static int do_commit(const char *msg_file, const char* author,
> +static int do_commit(const char *msg_file, const char *author,
>  		     struct replay_opts *opts, unsigned int flags)
>  {
>  	int res = 1;
> @@ -1521,7 +1521,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
>  			strbuf_addstr(&msgbuf, ")\n");
>  		}
> -		if (!is_fixup (command))
> +		if (!is_fixup(command))
>  			author = get_author(msg.message);
>  	}
>  
> diff --git a/sequencer.h b/sequencer.h
> index 27f34be400..e0be354301 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -72,7 +72,7 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
>  		       enum commit_msg_cleanup_mode cleanup_mode);
>  int update_head_with_reflog(const struct commit *old_head,
>  			    const struct object_id *new_head,
> -			    const char* action, const struct strbuf *msg,
> +			    const char *action, const struct strbuf *msg,
>  			    struct strbuf *err);
>  void commit_post_rewrite(const struct commit *current_head,
>  			 const struct object_id *new_head);
> 
> 

