Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823561F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeHOV1B (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:27:01 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:12592 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeHOV1A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:27:00 -0400
Received: from [192.168.2.201] ([92.22.33.100])
        by smtp.talktalk.net with SMTP
        id q0c1fxSKFoI6Lq0c2f4q5Q; Wed, 15 Aug 2018 19:33:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1534358022;
        bh=13puxsZ4KGrpGWtJWfkEGtiXjN2gbCg+xvmT1UvlcjQ=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VUVg7D7+2qeHRjCM6313Y/H5yQ7JK+FzoR0hGL4emz54/68h9+JtwMySqs1lf6qwR
         VN8StHjTSF+Ycxvd03EnZd9jeSKNR0Cicnd10efCh2bQema8l2tTtZWyGpe5J9NJf1
         1VE9+0jjJfrUmSIj8UXLrihAgRzqI8NDcRIhMr/4=
X-Originating-IP: [92.22.33.100]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=k9WtyX7eyn4O4XzWYcPtUg==:117
 a=k9WtyX7eyn4O4XzWYcPtUg==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=KsA2X16sb7UXRGOjbQQA:9 a=QON1P0EhrVgDu6Bz:21
 a=6CiBA-fpYx9FaRKM:21 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: fix numbering in squash message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180815094125.12530-1-phillip.wood@talktalk.net>
 <xmqqbma3ijyq.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <27c91e67-7567-f820-c641-c7980965fcef@talktalk.net>
Date:   Wed, 15 Aug 2018 19:33:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqbma3ijyq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfG0hsf2SpDrw+1Uyy7c713rwJwJapMY8PCnc8kTpvmBQ6wyqSWISP+hvu172Z11XhDtk9CnbGzk6qp3RBPUQJTKvuMoRluUv+lur0+8ceuDUddF8W3Ze
 WhI1a9mi5AMrCtqzQRk7oIHnHKD6UxKrmgnUvnZRmU+qwP9wikyG9GDHl6Waj9XCfah/KLDK8GTNYwfvyi35jOOGQcZLyqGUugylzG0a+4v/vef+pStyppLf
 VoA1upCW5tntDWfahr6YzTnlSMm2lzFxM0ZqiM+jwywGxb990jVYC0Qned3ncpPV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 15/08/2018 19:05, Junio C Hamano wrote:
> 
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Commit e12a7ef597 ("rebase -i: Handle "combination of <n> commits" with
>> GETTEXT_POISON", 2018-04-27) changed the way that individual commit
>> messages are labelled when squashing commits together. In doing so a
>> regression was introduced where the numbering of the messages is off by
>> one. This commit fixes that and adds a test for the numbering.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  sequencer.c                | 4 ++--
>>  t/t3418-rebase-continue.sh | 4 +++-
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 2eb5ec7227..77d3c2346f 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1387,13 +1387,13 @@ static int update_squash_messages(enum todo_command command,
>>  		unlink(rebase_path_fixup_msg());
>>  		strbuf_addf(&buf, "\n%c ", comment_line_char);
>>  		strbuf_addf(&buf, _("This is the commit message #%d:"),
>> -			    ++opts->current_fixup_count);
>> +			    ++opts->current_fixup_count + 1);
>>  		strbuf_addstr(&buf, "\n\n");
>>  		strbuf_addstr(&buf, body);
>>  	} else if (command == TODO_FIXUP) {
>>  		strbuf_addf(&buf, "\n%c ", comment_line_char);
>>  		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
>> -			    ++opts->current_fixup_count);
>> +			    ++opts->current_fixup_count + 1);
>>  		strbuf_addstr(&buf, "\n\n");
>>  		strbuf_add_commented_lines(&buf, body, strlen(body));
>>  	} else
> 
> Good spotting.  When viewed in a wider context (e.g. "git show -W"
> after applying this patch), the way opts->current_fixup_count is
> used is somewhat incoherent and adding 1 to pre-increment would make
> it even more painful to read.  Given that there already is
> 
> 		strbuf_addf(&header, _("This is a combination of %d commits."),
> 			    opts->current_fixup_count + 2);
> 
> before this part, the code should make it clear these three places
> refer to the same number for it to be readable.
> 
> I wonder if it makes it easier to read, understand and maintain if
> there were a local variable that gets opts->current_fixup_count+2 at
> the beginning of the function, make these three places refer to that
> variable, and move the increment of opts->current_fixup_count down
> in the function, after the "if we are squashing, do this, if we are
> fixing up, do that, otherwise, we do not know what we are doing"
> cascade.  And use the more common post-increment, as we no longer
> depend on the returned value while at it.
> 
> IOW, something like this (untested), on top of yours.

I think you'd need to change commit_staged_changes() as well as it
relies on the current_fixup_count counting the number of fixups, not the
number of fixups plus two. Having said that using 'current_fixup_count +
2' to create the labels and incrementing the count at the end of
update_squash_messages() would probably be clearer than my version. I'm
about to go away so it'll probably be the second week of September
before I can re-roll this, will that be too late for getting it into 2.19?

Best Wishes

Phillip

> 
>  sequencer.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 77d3c2346f..f82c283a89 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1331,8 +1331,9 @@ static int update_squash_messages(enum todo_command command,
>  	struct strbuf buf = STRBUF_INIT;
>  	int res;
>  	const char *message, *body;
> +	int fixup_count = opts->current_fixup_count + 2;
>  
> -	if (opts->current_fixup_count > 0) {
> +	if (fixup_count > 2) {
>  		struct strbuf header = STRBUF_INIT;
>  		char *eol;
>  
> @@ -1345,7 +1346,7 @@ static int update_squash_messages(enum todo_command command,
>  
>  		strbuf_addf(&header, "%c ", comment_line_char);
>  		strbuf_addf(&header, _("This is a combination of %d commits."),
> -			    opts->current_fixup_count + 2);
> +			    fixup_count);
>  		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
>  		strbuf_release(&header);
>  	} else {
> @@ -1387,18 +1388,19 @@ static int update_squash_messages(enum todo_command command,
>  		unlink(rebase_path_fixup_msg());
>  		strbuf_addf(&buf, "\n%c ", comment_line_char);
>  		strbuf_addf(&buf, _("This is the commit message #%d:"),
> -			    ++opts->current_fixup_count + 1);
> +			    fixup_count);
>  		strbuf_addstr(&buf, "\n\n");
>  		strbuf_addstr(&buf, body);
>  	} else if (command == TODO_FIXUP) {
>  		strbuf_addf(&buf, "\n%c ", comment_line_char);
>  		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
> -			    ++opts->current_fixup_count + 1);
> +			    fixup_count);
>  		strbuf_addstr(&buf, "\n\n");
>  		strbuf_add_commented_lines(&buf, body, strlen(body));
>  	} else
>  		return error(_("unknown command: %d"), command);
>  	unuse_commit_buffer(commit, message);
> +	opts->current_fixup_count++;
>  
>  	res = write_message(buf.buf, buf.len, rebase_path_squash_msg(), 0);
>  	strbuf_release(&buf);
> 
> 

