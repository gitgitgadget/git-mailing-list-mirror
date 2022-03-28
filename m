Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966EFC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 17:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiC1RNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 13:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244450AbiC1RNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 13:13:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C5263520
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 10:12:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e696b18eb4so123237577b3.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rVFzhNu/ZaPOgbuOPDl14EA6+Tcd+LiArBeW91cIGP8=;
        b=f6eAW6HLCwQBszl/hm8u+yTeB5bTYBXpRH8cJlbldaJbd9E8VvcA1PgkBq92ev9R9W
         AS0Uo1NDLdIKNdHLCxWfzhl3wNx12X66/uJqX3iSKgb/LdzZkMtOqGSBG5wHThxmj5G6
         PaLRK/2dBi6iMn2EEOvsIOE8Jjzl5M9iBOYoyIq+eljY+2Ul0kuxfiRbo/QvSKFMMOBo
         PT6O3S5iRjsn4PBqs188arnuxOC7Ob/Wi51yx3zrEOVxekrL7rft49cR7kmIDsJXvyG9
         IkF3nFRkXdRLeEbh9iWCua9Q3SvEcE0n1eyrkOKZqAC+LPpaSEL2HRB1tl3YlbkgZq4A
         LqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rVFzhNu/ZaPOgbuOPDl14EA6+Tcd+LiArBeW91cIGP8=;
        b=Z4M6nHlpOmqNqMnwzoeZbFwuCN3hlWqdeDA0olJgqi0m/f0czion9tZiV7OjAOkJBx
         SsenE6EbXHdiF5huoggu81hVqjpdD6CWcvjE410tDcONQOIzwu1BivUsKoCZ0rV0ZDqj
         mlG+6Jmd4Ld7PS5y5bII3f/pcfBWlG9legW+7ZbL6w2EQ7SQfsQyQDI6zgwVzT9dS4MC
         NQ8rynH7KB56Yoy3+CWTwYGvEYYIk+ygaL2OJRVG4FQ+cEjoZoYChQ2pog/FlppqQsX7
         +p+sL7nFDcuF3WYUlWx++JS1XbI/86hJYrNS217Do9rJRbKmRMUqQQGzQZshJ7fNbyUx
         SnTA==
X-Gm-Message-State: AOAM530/LxpgFUCQZIsZ+RmXDQyEajAwPJ8QjOqIKtIoxLkZmykxeaHn
        TgamAHeEUooo8zGHSJUO3vWLln1B+m7AnA==
X-Google-Smtp-Source: ABdhPJyVfy1hAQHkU/aRKyaKUvOZ7WY20PLBQzrG+HeYqxrW22LnieICPBPJICsbSv1pIspJmBPYcn+Z9d2/Gw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:86cf:0:b0:633:8702:1bb3 with SMTP id
 y15-20020a2586cf000000b0063387021bb3mr23594945ybm.515.1648487530218; Mon, 28
 Mar 2022 10:12:10 -0700 (PDT)
Date:   Mon, 28 Mar 2022 10:12:07 -0700
In-Reply-To: <xmqqwnge2ghe.fsf@gitster.g>
Message-Id: <kl6l7d8et314.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
 <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com> <xmqqwnge2ghe.fsf@gitster.g>
Subject: Re: [PATCH v3] tracking branches: add advice to ambiguous refspec error
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/branch.c b/branch.c
>> index 6b31df539a5..5c28d432103 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -18,9 +18,15 @@ struct tracking {
>>  	int matches;
>>  };
>>  
>> +struct find_tracked_branch_cb {
>> +	struct tracking *tracking;
>> +	struct strbuf remotes_advice;
>> +};
>> +
>>  static int find_tracked_branch(struct remote *remote, void *priv)
>>  {
>> -	struct tracking *tracking = priv;
>> +	struct find_tracked_branch_cb *ftb = priv;
>> +	struct tracking *tracking = ftb->tracking;
>>  
>>  	if (!remote_find_tracking(remote, &tracking->spec)) {
>>  		if (++tracking->matches == 1) {
>>  			string_list_append(tracking->srcs, tracking->spec.src);
>>  			tracking->remote = remote->name;
>>  		} else {
>>  			free(tracking->spec.src);
>>  			string_list_clear(tracking->srcs, 0);
>>  		}
>> +		/*
>> +		 * TRANSLATORS: This is a line listing a remote with duplicate
>> +		 * refspecs, to be later included in advice message
>> +		 * ambiguousFetchRefspec. For RTL languages you'll probably want
>> +		 * to swap the "%s" and leading "  " space around.
>> +		 */
>> +		strbuf_addf(&ftb->remotes_advice, _("  %s\n"), remote->name);
>>  		tracking->spec.src = NULL;
>>  	}
>
> This is wasteful.  remotes_advice does not have to be filled when we
> are not going to give advice, i.e. there is only one matching remote
> and no second or subsequent ones, which should be the majority case.
> And we should not make majority of users who do not make a mistake
> that needs the advice message pay the cost of giving advice to those
> who screw up, if we can avoid it.
>
> Instead, only when we are looking at the second one, we can stuff
> tracking->remote (i.e. the first one) to remotes_advice, and then
> append remote->name there.  Perhaps we can do it like so?
>
> 	struct strbuf *names = &ftb->remotes_advice;
> 	const char *namefmt = N_("  %s\n");
>
> 	switch (++tracking->matches) {
> 	case 1:
> 		string_list_append(tracking->srcs, tracking->spec.src);
> 		tracking->remote = remote->name;
> 		break;
> 	case 2:
> 		strbuf_addf(names, _(namefmt), tracking->remote);
> 		/* fall through */
> 	default:
> 		strbuf_addf(names, _(namefmt), remote->name);
>                 free(tracking->spec.src);
>                 string_list_clear(tracking->srcs, 0);
>                 break;
> 	}
> 	tracking->spec.src = NULL;
>
> For a bonus point, remotes_advice member can be left empty without
> paying the cost to strbuf_addf() when the advice configuration says
> we are not going to show the message.
>
> Thanks.

Hm, what do you think of an alternate approach of storing of the
matching remotes in a string_list, something like:

  struct find_tracked_branch_cb {
  	struct tracking *tracking;
  	struct string_list matching_remotes;
  };
  
  static int find_tracked_branch(struct remote *remote, void *priv)
  {
  	struct tracking *tracking = priv;
  	struct find_tracked_branch_cb *ftb = priv;
  	struct tracking *tracking = ftb->tracking;
  
  	if (!remote_find_tracking(remote, &tracking->spec)) {
  		if (++tracking->matches == 1) {
  			string_list_append(tracking->srcs, tracking->spec.src);
  			tracking->remote = remote->name;
  		} else {
  			free(tracking->spec.src);
  			string_list_clear(tracking->srcs, 0);
  		}
  		string_list_append(&ftb->matching_remotes, remote->name);
  		tracking->spec.src = NULL;
  	}

then construct the advice message in setup_tracking()? To my untrained
eye, "case 2" requires a bit of extra work to understand.
