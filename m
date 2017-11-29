Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91EF720954
	for <e@80x24.org>; Wed, 29 Nov 2017 02:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbdK2CB2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 21:01:28 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:32831 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbdK2CB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 21:01:27 -0500
Received: by mail-io0-f194.google.com with SMTP id t196so2113837iof.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 18:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qlot8qvy7sOyx6qnF+aYuLdntTugjyci2H3Y7OAeAfY=;
        b=KUjviq95y2BG6TFyIAgH/Fi4LBMrorjuUXmUvM0N+rYb1al2hbddKZa0cBhEychgTX
         CVC9QdNTTBJSAgSUiXHbCCaMpNqbhUQmKhr2+ji6UvxVY6SVwJXdTSJpVYPvPrRbc2pD
         B1Jdvmqug2GBJTHLTM7NF5nWpqfv2vixplodmDO99G37fRjYpz+E8AEydL6DabOBx19a
         agZc9hnK5wkwSB3Llhhr8yJDem8A7XmU0ODqYi5EKkGp15OPkrOMjVj0WYbm7ZA2+boy
         bcpHj/nVRj88L80i7JtPYwXFZ2A438mRxw4Ic1Qoh/MwGJl9F7fWpA2yNjDhoG9VzpkK
         izyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qlot8qvy7sOyx6qnF+aYuLdntTugjyci2H3Y7OAeAfY=;
        b=pFuJ8bECd1TamXOfZxAHaqBat1nPYgGz5+WfOtiq/aprw2zaQ2fZSdluC63+fas+Kk
         tCPPGenIL7it76+sgLSMwvoB3soV25OXXRxvArQnI/ZMlgfq9a9FnP2CLiMccWR5ELG3
         xcJw11s2iY+i7AiNRYLgLzrLxTpyJVfEGpB3HmPV11Y72SEclRS8qB10E/ZqXorUlW0v
         2LIoAArUARqNhBlyioUACKAH2b0IocpR6oEX75Nm6Wt0vISfeLUMZ0lKdOx+2bsjQowu
         1sn3/1Wx+B8Yz0nqhMYljAMcGVfjl6E/QoyLIWDFql6eOgSGgJmkCqwBzEtgyFxsOLa5
         v32g==
X-Gm-Message-State: AJaThX54fnmJ6KMNo1QdKAsuY7X9deQq4L7Xy7pgxQMwugJZJWEw6n8w
        XrIlVvIRZMN1kRzBK+WUkEA/0ayZ6+w=
X-Google-Smtp-Source: AGs4zMZinNWIS6MqPz6Id4AuF4a1/p+uiEArEt5Nwvg6dbyhcPPPn02VNFGFGzG9T1Sv6x0z5ezmng==
X-Received: by 10.107.148.3 with SMTP id w3mr1573452iod.161.1511920886685;
        Tue, 28 Nov 2017 18:01:26 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id e203sm466667itb.32.2017.11.28.18.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 18:01:26 -0800 (PST)
From:   liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH 3/5] rebase -i: add exec commands via the rebase--helper
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171127045514.25647-4-liambeguin@gmail.com>
 <xmqq609we20v.fsf@gitster.mtv.corp.google.com>
Message-ID: <46cf2ed9-ea95-5ba9-e0f1-3ed7b524279e@gmail.com>
Date:   Tue, 28 Nov 2017 21:01:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq609we20v.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 27/11/17 12:14 AM, Junio C Hamano wrote:
> Liam Beguin <liambeguin@gmail.com> writes:
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index fa94ed652d2c..810b7850748e 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2492,6 +2492,52 @@ int sequencer_make_script(int keep_empty, FILE *out,
>>  	return 0;
>>  }
>>  
>> +int add_exec_commands(const char *command)
>> +{
> 
> As the name of a public function, it does not feel that this hints
> it strongly enough that it is from and a part of sequencer.c API.
> 
>> +	const char *todo_file = rebase_path_todo();
>> +	struct todo_list todo_list = TODO_LIST_INIT;
>> +	int fd, res, i, first = 1;
>> +	FILE *out;
> 
> Having had to scan backwards while trying to see what the loop that
> uses this variable is doing and if it gets affected by things that
> happened before we entered the loop, I'd rather not to see 'first'
> initialized here, left unused for quite some time until the loop is
> entered.  It would make it a lot easier to follow if it is declared
> and left uninitilized here, and set to 1 immediately before the
> for() loop that uses it.
> 

I agree that moving 'first = 1' just above the for() loop makes it
more obvious. I'm not quite fond of how this is implemented, I just
'translated' the shell code and was hoping on maybe a few comments
on how to improve it.

>> +
>> +	strbuf_reset(&todo_list.buf);
>> +	fd = open(todo_file, O_RDONLY);
>> +	if (fd < 0)
>> +		return error_errno(_("could not open '%s'"), todo_file);
>> +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
>> +		close(fd);
>> +		return error(_("could not read '%s'."), todo_file);
>> +	}
>> +	close(fd);
> 
> Is this strbuf_read_file() written in longhand?

Thanks for pointing this out! I'll update. And as Johannes pointed out,
I've copied this from surrounding functions, I'll add a preparatory path
to update those too.

> 
>> +	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
>> +	if (res) {
>> +		todo_list_release(&todo_list);
>> +		return error(_("unusable todo list: '%s'"), todo_file);
>> +	}
>> +
>> +	out = fopen(todo_file, "w");
>> +	if (!out) {
>> +		todo_list_release(&todo_list);
>> +		return error(_("unable to open '%s' for writing"), todo_file);
>> +	}
>> +	for (i = 0; i < todo_list.nr; i++) {
>> +		struct todo_item *item = todo_list.items + i;
>> +		int bol = item->offset_in_buf;
>> +		const char *p = todo_list.buf.buf + bol;
>> +		int eol = i + 1 < todo_list.nr ?
>> +			todo_list.items[i + 1].offset_in_buf :
>> +			todo_list.buf.len;
> 
> Should bol and eol be of type size_t instead?  The values that get
> assigned to them from other structures are.
> 

Will do.
Thanks, 

Liam
