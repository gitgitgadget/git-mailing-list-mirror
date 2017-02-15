Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B172013A
	for <e@80x24.org>; Wed, 15 Feb 2017 23:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbdBOXL3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:11:29 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33803 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdBOXL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:11:27 -0500
Received: by mail-pf0-f194.google.com with SMTP id o64so70076pfb.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oRfPTYNAQfIDMiCl+uxWal7faCr+62609rq5k3TQNfE=;
        b=pQMF+mj9XvF4w+RlpfCLwre1xBK7xXhWwlPTuMFoJrvFQ428VSQXlKjvYNq4UiF+D4
         /yjVS7e0UkyOxG2gd3ssG8zDwGEsssnngWtZUUo0++iSpP2Q9iDzLUza/eUwsv+XSKuL
         rhFnuoiQX4Sc+SZsC/vxnV7xObRpi512c8I+qZMj9vZ+WfvD9oZLLKi3xfW6++Nz9o2Q
         6p28Uk9dQpYvbzJJvqS8z7Q6pnnE6pR8STG/I/bigasilda7KDW683mj1mYPzIfUetx8
         +Uf+NwTKcnRMreKtHT5rEA0imW/6XxyfKbbnBn8RSMHqkpO310yYbNLMJ6JsahYfCnp/
         jZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oRfPTYNAQfIDMiCl+uxWal7faCr+62609rq5k3TQNfE=;
        b=dsWEh9OiI8CFXJagELgavC+LoOk73586Os3VH2tScvRJaLbwFPnKgRr61UtnRorByM
         C+raZV3vOrBSTdn7Y3zacddtHUWgDC7JjOdiBUbf7l6Q/AH4ODAvJ/jdMlS74Ecn1/ci
         HvwOzGqIFm35hdZm5zG4IYnWTrLOMJ+Lt5Fu26Ev8fUpy9QWRgYhmoFeoGb51cfahIZe
         Kc0KlhYLTSCp1zn4dhEg5guNfHgiKjkzcrbnrolhMFb9pyf3OyWuyrvM+t+puweDsEAs
         kfVnO6wGFxW6cVzYmMEsXjglNT/X7hxGSOkRHzVXLv6c9c2K8HmWxTKzsGiQorHFwkhm
         88RQ==
X-Gm-Message-State: AMke39lvwtPF5PB3Z6Ma0uDh/+08o3TJtfJHKN1P1r1bATMARKr9YwyM9Vym1Mm6+qzZpA==
X-Received: by 10.98.56.196 with SMTP id f187mr40505186pfa.131.1487200286504;
        Wed, 15 Feb 2017 15:11:26 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id a24sm9421354pfh.33.2017.02.15.15.11.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 15:11:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 15 Feb 2017 15:11:24 -0800
In-Reply-To: <xmqqy3x712if.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 15 Feb 2017 15:02:32 -0800")
Message-ID: <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> I had some time to look into this, and yes, command-line parameters
>> are too aggressively downcased ("git_config_parse_parameter" calls
>> "strbuf_tolower" on the entire key part in config.c).
>
> Ahh, thanks.  So this is not about submodules at all; it is -c var=VAL
> where var is downcased too aggressively.

Perhaps something like this?

 config.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index c6b874a7bf..98bf8fee32 100644
--- a/config.c
+++ b/config.c
@@ -201,6 +201,20 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
+static void canonicalize_config_variable_name(struct strbuf *var)
+{
+	char *first_dot = strchr(var->buf, '.');
+	char *last_dot = strrchr(var->buf, '.');
+	char *cp;
+
+	if (first_dot)
+		for (cp = var->buf; *cp && cp < first_dot; cp++)
+			*cp = tolower(*cp);
+	if (last_dot)
+		for (cp = last_dot; *cp; cp++)
+			*cp = tolower(*cp);
+}
+
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
@@ -223,7 +237,7 @@ int git_config_parse_parameter(const char *text,
 		strbuf_list_free(pair);
 		return error("bogus config parameter: %s", text);
 	}
-	strbuf_tolower(pair[0]);
+	canonicalize_config_variable_name(pair[0]);
 	if (fn(pair[0]->buf, value, data) < 0) {
 		strbuf_list_free(pair);
 		return -1;
