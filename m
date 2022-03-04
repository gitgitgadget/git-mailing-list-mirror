Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506E5C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 07:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiCDHXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 02:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbiCDHW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 02:22:58 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590E4190B45
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 23:22:11 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id r13so15618686ejd.5
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 23:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=JC6iT8L4uNv9RSKGgQP36HPga5BIMG2WVaR7zppgxDU=;
        b=WWTiLEHwMNPsel2jy0IFLTif9CM30ujodJJSSt/0156A3WeoxK7p00Z/MjB5HYbgkj
         DUTD4erhXjOejbHfTiImMBFxMUj/eeukIh3r6pR/XgVBk78Dj+iD0UG9/I0GWLDf3vcz
         XETNqb72C8DVuOzgZj+zCNWLoqiTZ0uT2bVBjfGLfoSl82epNLdzVhcnrQRZzoAJ6Nx0
         JEg4ld+7Bl06dNIWKzIH7b2QX+4tC3dmAIZCxOUfPPvVhN7SHaGcWVNtlQVYW+lPYNMC
         BRsiyhlsn2NRDI0GjtzWufYftTLfVCCogMq2tX2diJzcraEgHK9tyH9RifnY3MTHRpz9
         0DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=JC6iT8L4uNv9RSKGgQP36HPga5BIMG2WVaR7zppgxDU=;
        b=rPOScWsABmawH5NNc//VED3qEnPPaS+QZ0mul+Fc/84+xTDQfBWNkL2WnKYRjeDIOJ
         CsWn8HZopOQ7pV01L61ddPQ+ex4S/cZAu1VPRNtkbf0hAVF/Lh9vr6X4TAHrIcGaMNQt
         /N4sQ/B2USX8lX51QdsmCU9U/v8MY7X8BiDdwYMsfftcJKJ+1CgRIhG2AQ1fBXH3p+gw
         WPVEhwv749HSy049AiJSz0c+16HtjyIOCvck3Z/cWEp5mMjl1BuBfG8Ch4q1lcshMari
         AAUF6/pvYyzPTGjgy3rIqaxOu0tma15xIz2hY37aNmdMC1vqQHKxHoP+8ijNkEUWHk7q
         sC+Q==
X-Gm-Message-State: AOAM532tZ0ebR5RBXsgdmXbuP6xY55DeeaMTkv8vlUsEYC7blnHYf4q4
        idyM5+41DH1GH1U/SV7NIGE=
X-Google-Smtp-Source: ABdhPJxu08qy+XoYG/jETSfFsKLny1Lbo0P4Yphs13wUISPsoJUqFEUnl3Z1pJw/U5zWRMNGypLhQg==
X-Received: by 2002:a17:907:c11:b0:6da:64e6:8ffe with SMTP id ga17-20020a1709070c1100b006da64e68ffemr8747575ejc.356.1646378529764;
        Thu, 03 Mar 2022 23:22:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm1721431edz.29.2022.03.03.23.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 23:22:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQ2GO-0007EE-Nr;
        Fri, 04 Mar 2022 08:22:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Silly 'git am' UI issue
Date:   Fri, 04 Mar 2022 08:14:47 +0100
References: <CAHk-=wi2HkQ648sYe3BusCEh5tBYjJbQ9c5T-DrykfEdgRbi=g@mail.gmail.com>
 <xmqqlexq8zqo.fsf@gitster.g>
 <CAHk-=wjQP8PwYZMYUhKu3s9wMhE2yDqdAO_OKagqXuvPrHRyAQ@mail.gmail.com>
 <xmqq1qzi4bpk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq1qzi4bpk.fsf@gitster.g>
Message-ID: <220304.86r17ifahr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> [...]
>> +static int parse_opt_whitespace(const struct option *opt, const char *arg, int unset)
>> +{
>> +	struct apply_state dummy = { };
>
> It is rare to see a completely empty initializer in this codebase, I
> think.
>
>> +	if (parse_whitespace_option(&dummy, arg))
>> +		return -1;
>> +
>> +	return parse_opt_passthru_argv(opt, arg, unset);
>> +}
>
> Looks good.
>
>>  static int git_am_config(const char *k, const char *v, void *cb)
>>  {
>>  	int status;
>> @@ -2355,9 +2365,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>>  		OPT_CALLBACK_F(0, "quoted-cr", &state.quoted_cr, N_("action"),
>>  			       N_("pass it through git-mailinfo"),
>>  			       PARSE_OPT_NONEG, am_option_parse_quoted_cr),
>> -		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
>> +		OPT_CALLBACK(0, "whitespace", &state.git_apply_opts, N_("action"),
>>  			N_("pass it through git-apply"),
>> -			0),
>> +			parse_opt_whitespace),
>>  		OPT_PASSTHRU_ARGV(0, "ignore-space-change", &state.git_apply_opts, NULL,
>>  			N_("pass it through git-apply"),
>>  			PARSE_OPT_NOARG),

Perfect shouldn't be the enemy of the good & all that, and this is an
improvement.

But having looked at this the general problem is that any
OPT_PASSTHRU_ARGV without a PARSE_OPT_NOARG has the same potential issue
in the case of "am", and I don't see how we can resolve the ambiguity
without calling e.g. parse_whitespace_option(), i.e. we need to call
whatever the validation function is for each one.

This change leaves the same problem in place for --exclude, --include,
and also -C, -p (but one is less likely to do -Cname).

A more general solution would be some continuation of this, i.e. we can
use the "defval" in "struct option" as a pointer to a validation
function for any arguments.

diff --git a/builtin/am.c b/builtin/am.c
index 0f4111bafa0..fa922fda200 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2355,9 +2355,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "quoted-cr", &state.quoted_cr, N_("action"),
 			       N_("pass it through git-mailinfo"),
 			       PARSE_OPT_NONEG, am_option_parse_quoted_cr),
-		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
+		OPT_PASSTHRU_ARGV_CHECK(0, "whitespace", &state.git_apply_opts, N_("action"),
 			N_("pass it through git-apply"),
-			0),
+			0, parse_whitespace_option),
 		OPT_PASSTHRU_ARGV(0, "ignore-space-change", &state.git_apply_opts, NULL,
 			N_("pass it through git-apply"),
 			PARSE_OPT_NOARG),
diff --git a/parse-options.h b/parse-options.h
index 685fccac137..8348343bf59 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -356,6 +356,8 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru }
 #define OPT_PASSTHRU_ARGV(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru_argv }
+#define OPT_PASSTHRU_ARGV_CHECK(s, l, v, a, h, f, c) \
+	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru_argv, (c) }
 #define _OPT_CONTAINS_OR_WITH(name, variable, help, flag) \
 	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
 	  PARSE_OPT_LASTARG_DEFAULT | flag, \


