Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E1BC7EE23
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 21:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBYVae (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 16:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYVad (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 16:30:33 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D1CA19
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 13:30:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n6so1675034plf.5
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 13:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1M52T5e9ZEACJIFlZbsz31LCbU4RrD4jj/uZmv6qUPA=;
        b=eUIwS73S28fZ9nSF0fqU4QNp0c38OELIq9s+obwgUU/tDLmSUPJOidnHmD1SjqlfXA
         JhP5JcJB228/aKQs/CbgrezflpIpJ8mb1PvVk0kTfdX7rolxRcykEoK02p1T50abdcbd
         2pJfYAwu+RGvzEzcbwHaRtSMqwJ62/br8P1j5L+OHiVkfUSU2qKS4mizuasfgl7Q37QY
         2FJ+CdCW6xrmyPtz5cN0pN5hcgsg3Pg83/DmaV/lQebvtRsL6M/NutFIAFOmdTo9pwXQ
         pUs3+Kg0nDYVkb5EqCWMU5W5PpaO3/4aa4ZMev6u+m/XX0VjedV7+wm2/gThWc9JzK/2
         lcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1M52T5e9ZEACJIFlZbsz31LCbU4RrD4jj/uZmv6qUPA=;
        b=7w6eAIvl1ZKe0XSFzIUjy64iRd6R5WZB6tfgNnwUri4h1HEX1b3W1eFo5XTx33y+ZW
         Jq2sY2O0ZjszlUUfP6CfMv6NJlBLelcW/wH5vnO3XV3pI2pX7DLxWoVNOB8W4FUmyBNw
         bSknfzPIrs7kwuL/AliZJ6d/8V+GIFZbWkRhYSkvDi3zeTqOoaGs4MGfsg5lieO/QvdD
         IB+RLzKfJoa2ICHi3XZA5gHKFSHLhGalkdbk18wM/ouI7Ye3TtiKxf/zOtO824ECy3Rn
         wJgixVhMGYF0wrEm3fenHFIyML97636bzuutYQGZj9O+xVhrzCY9GzszmfWnMxjDiQj0
         vpzA==
X-Gm-Message-State: AO0yUKUNXnD75/Qkw5ttbrjjC5OENIY3cDK+7XIBQXfIF0ChnsogfmOq
        yZWIp+lWpYPnfdwO1g4Nbze3qbwLPjw=
X-Google-Smtp-Source: AK7set8aztKIinT3kCgtPpZ1N2g1OAGyl0cX5//1ZW8synSAdY4AStd2z27/vYIcZicqp3Xn84HXhQ==
X-Received: by 2002:a17:903:1247:b0:19c:be03:d18b with SMTP id u7-20020a170903124700b0019cbe03d18bmr10032321plh.22.1677360631845;
        Sat, 25 Feb 2023 13:30:31 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id ja17-20020a170902efd100b00196025a34b9sm1684317plb.159.2023.02.25.13.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 13:30:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 3/3] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <cover.1677136319.git.dyroneteng@gmail.com>
        <d5a6c74792c15e2f83c2ed0758fb99eac11a8174.1677136319.git.dyroneteng@gmail.com>
Date:   Sat, 25 Feb 2023 13:30:30 -0800
Message-ID: <xmqqk005v3ex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> +static void parse_messages(struct string_list *messages, struct note_data *d)
> +{
> +	size_t i;
> +	for (i = 0; i < messages->nr; i++) {
> +		if (d->buf.len)
> +			insert_separator(&d->buf, d->buf.len);
> +		strbuf_insertstr(&d->buf, d->buf.len,
> +				 messages->items[i].string);
> +		strbuf_stripspace(&d->buf, 0);
> +		d->given = 1;
> +	}
> +}

The two callers of this function prepares the string_list, and have
this function consume it by concatenating its contents to d->buf.
After calling this function, neither of them talks about messages,
which means we are leaking the strings kept in the string_list.

I could eject the topic from today's integration run (because the
topic is not ready to be merged to 'next' as-is; "-C/-c" codepaths
need to be adjusted, at least), but as I took a look already, I'll
queue this fix-up on top of the topic for now.  Feel free to squash
it in (or address the leaks in your own way) when sending in an
update.

Thanks.

 builtin/notes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git c/builtin/notes.c w/builtin/notes.c
index 97c18fc02f..cd7af76e2f 100644
--- c/builtin/notes.c
+++ w/builtin/notes.c
@@ -220,7 +220,8 @@ static void insert_separator(struct strbuf *message, size_t pos)
 		strbuf_insertf(message, pos, "%s%s", separator, "\n");
 }
 
-static void parse_messages(struct string_list *messages, struct note_data *d)
+/* Consume messages and append them into d->buf */
+static void concat_messages(struct string_list *messages, struct note_data *d)
 {
 	size_t i;
 	for (i = 0; i < messages->nr; i++) {
@@ -231,6 +232,7 @@ static void parse_messages(struct string_list *messages, struct note_data *d)
 		strbuf_stripspace(&d->buf, 0);
 		d->given = 1;
 	}
+	string_list_clear(messages, 0);
 }
 
 static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
@@ -451,7 +453,7 @@ static int add(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_add_usage, options);
 	}
 
-	parse_messages(&messages, &d);
+	concat_messages(&messages, &d);
 	object_ref = argc > 1 ? argv[1] : "HEAD";
 
 	if (get_oid(object_ref, &object))
@@ -622,7 +624,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		usage_with_options(usage, options);
 	}
 
-	parse_messages(&messages, &d);
+	concat_messages(&messages, &d);
 
 	if (d.given && edit)
 		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
