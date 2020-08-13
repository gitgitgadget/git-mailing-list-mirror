Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F51C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43DC2078D
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+PJ1oFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHMOiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgHMOiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 10:38:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECCFC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 07:38:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so6488465wmc.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TpEIKW2mSicXXxUwkJZZlu7ihU/UGneIh5GFRhN0Inc=;
        b=Q+PJ1oFCxvvxN8wxDFEd/vufTfedbLMpRXmgm535Qe3ZIXzUgc4MQsNMezSam6WLgb
         9vT5e3uZNERDPdv0vu/HNT0ol2ErKSM+5uPERXayU7L4fSRFpoYGsuNDG/uG4wvvB06t
         ztjhn6zDOD5nu+KS34j8rO/TtQ3aHgKfQ1zghrXI/gvrGeZXyxP2VBQrbbn1lkiUGnmh
         Wa674TcGaVrRJJJh/nQvStN+4gAmIDB7kM1r2+V5FsqCEmCj74uHA05pUrmtzsa85rR2
         oCwisU0IXO7uLMoYSRAMYxIQ5ysgqoHA4Jes/YNZ/kDgflN/9g6YPp6dzGM5yXLOiaE9
         jbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TpEIKW2mSicXXxUwkJZZlu7ihU/UGneIh5GFRhN0Inc=;
        b=hNsXdXFlUVoN8NwNJ0T/cjd9/kcBB0jmih3wG7kK1LlSSvtLqT8UEvYx0WSxLRSpc7
         7PFuZwVzX9R8iNyY8FfV65tEXXvucgXAzEJywxUXqGxvTYCJmX1myT3NWDvGy3RQoAjc
         Q6GmtFeU4uoj2AB/fLyxE+O/uIbgWDlppNgeatpOs5u68poukiWO58Yus+Cwa5WuAHzn
         kJDAv7HEAI3IJ2BQ+JWGg2JDnqLw3YnUTL/j+EARwGTxGaGUZxQKqistA0Hr4/1NEMzW
         9ZTK8HlxTGPDxBr/p130lsaCOmbaXwJzXKfcOtsxGh6Dbdz4Z7QObY0aj8LTseUSyHB0
         TSqw==
X-Gm-Message-State: AOAM530XBRpYyE65HfM8HOoTjsmpIfd5KHMZpKquN58MYhgZ2ThNjz/7
        Mm9pWfy0wpp8b2EqL7LCXMU=
X-Google-Smtp-Source: ABdhPJxbNrcvFfoOl0dezFkFNuZdWEwaF/+P5nDSFcxjQGebpnr03v0qBXgdZW7dDIkpHZAnxLPKXw==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr4858657wmi.165.1597329494216;
        Thu, 13 Aug 2020 07:38:14 -0700 (PDT)
Received: from [192.168.1.240] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id q19sm10037943wrf.48.2020.08.13.07.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:38:13 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] rebase -i: Fix possibly wrong onto hash in todo
To:     Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?Antti_Ker=c3=a4nen?= <detegr@rbx.email>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Jussi_Ker=c3=a4nen?= <jussike@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200812183326.224782-1-detegr@rbx.email>
 <3ba6c005-e71f-3a0d-46ba-a90a68e88d3e@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <51ba9326-26fb-103b-d04b-acf50c2b9104@gmail.com>
Date:   Thu, 13 Aug 2020 15:38:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3ba6c005-e71f-3a0d-46ba-a90a68e88d3e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antti & Alban

On 13/08/2020 11:41, Alban Gruin wrote:
> Hi Antti,
> 
> Le 12/08/2020 à 20:33, Antti Keränen a écrit :
>> 'todo_list_write_to_file' may overwrite the static buffer, originating
>> from 'find_unique_abbrev', that was used to store the short commit hash
>> 'c' for "# Rebase a..b onto c" message in the todo editor. This is
>> because the buffer that is returned from 'find_unique_abbrev' is valid
>> until 4 more calls to `find_unique_abbrev` are made.
>>
>> As 'todo_list_write_to_file' calls 'find_unique_abbrev' for each rebased
>> commit, the hash for 'c' is overwritten if there are 4 or more commits
>> in the rebase. This behavior has been broken since its introduction.
>>
>> Fix by storing the short onto commit hash in a different buffer that
>> remains valid, before calling 'todo_list_write_to_file'.
>>
>> Found-by: Jussi Keränen <jussike@gmail.com>
>> Signed-off-by: Antti Keränen <detegr@rbx.email>
>> ---
>>   sequencer.c                   | 5 +++--
>>   t/t3404-rebase-interactive.sh | 6 ++++++
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index fd7701c88a..e2007dbb8c 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -5178,13 +5178,14 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>>   		    struct string_list *commands, unsigned autosquash,
>>   		    struct todo_list *todo_list)
>>   {
>> -	const char *shortonto, *todo_file = rebase_path_todo();
>> +	char shortonto[GIT_MAX_HEXSZ + 1];
>> +	const char *todo_file = rebase_path_todo();
>>   	struct todo_list new_todo = TODO_LIST_INIT;
>>   	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
>>   	struct object_id oid = onto->object.oid;
>>   	int res;
>>   
>> -	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
>> +	find_unique_abbrev_r(shortonto, &oid, DEFAULT_ABBREV);
>>   
>>   	if (buf->len == 0) {
>>   		struct todo_item *item = append_new_todo(todo_list);
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 4a7d21f898..1b4fa0843e 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -1760,6 +1760,12 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>>   	test_i18ngrep "middle of a rebase -- cannot amend." err
>>   '
>>   
>> +test_expect_success 'todo has correct onto hash' '
>> +	GIT_SEQUENCE_EDITOR=cat git rebase -i no-conflict-branch~4 no-conflict-branch >actual &&
>> +	onto=$(git rev-parse --short HEAD~4) &&
>> +	test_i18ngrep "^# Rebase ..* onto $onto" actual
>> +'
>> +
>>   # This must be the last test in this file
>>   test_expect_success '$EDITOR and friends are unchanged' '
>>   	test_editor_unchanged
>>
> 
> Looks good to me.

It looks good to me too, thanks Antti

>    Acked-by: Alban Gruin <alban.gruin@gmail.com>
> 
> This makes me wonder if it's worth to do the same change in
> todo_list_to_strbuf().  #leftoverbits, perhaps?

In todo_list_to_strbuf() we append the short oid to an strbuf before we 
call find_unique_abbrev() again so I don't think it should be a problem 
there

Best Wishes

Phillip

> Cheers,
> Alban
> 
