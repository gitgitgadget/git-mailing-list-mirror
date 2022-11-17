Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7FCC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 18:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiKQSZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240485AbiKQSZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 13:25:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E74285167
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 10:25:16 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kt23so7191246ejc.7
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 10:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FlpN3Mr3IS5ZJy9P0zYwsiame7WY7TyELq9PBntl8s=;
        b=D7kfRx3+9huzfoIJ6oWjsXExJONSCqmmq36vk5Ig1YP/o5bs59s4pgJX6NUHoCRYJs
         KRNfWR1mpvOV14i6vlNRfSXvwnYD6uQ6ePIN4mUJZjfR5FoyyUuoyZiyHGXEzT9RxTV7
         v0fpu1tUFkuRotZ7xCtmkPfTNowWJeBhc+PMnk+6sgBojVVYC6t7P+FBMORRT15xwsaj
         5rUXJSv9lt1xAScZcO2DLCPC4cBlFsPv6Ptfoe7vFpifYg0qIAIA3Vs8UJ0EH8n8HwQC
         papaXjrtROIYNUlKy2fTtoCcBU3FP9nvhsqXojyMvEr4G6TA+ZC3CARWr8J/owiukO3z
         Ubpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FlpN3Mr3IS5ZJy9P0zYwsiame7WY7TyELq9PBntl8s=;
        b=gPzZuogpDtUTURe9FEWyWADZIFL479BJPJIQUGokiShH6CIQigblT1giGrjK4Rg6IP
         o+ceSizcytmhSR4Jp8DvE8B0ejlT4zdTjQHq9JF9HktoG9t1o6o61lKyh0DGoSexz8Vb
         Sl4cHbV/aJNiElCea6Zl1jVaqSKJk3feZ8D04ru0EUY2esWxCVNtbyVlWQup9Qc8mfCf
         6mwVDDq73+OpUejbFhlKOo+QjJR0eklXkt0845p8NqHGadA7DoyRFxQcLTsV4tuWl0gd
         NHaSVdjJ64aWiY2h7y58ZJj9jmbLOv0d/Qh4V21ZEJ660PVqCgkvNYEfcg6ezqJsKrH9
         qi+A==
X-Gm-Message-State: ANoB5pkvIPFAcJL00wPb0t7Zb7LfaSRPYTQ815FivCRiJ2u3FBorWT8s
        lxhzRA/d1HEuOXeB8KaYY6g=
X-Google-Smtp-Source: AA0mqf7UBvZh7jUuC7cEqMp1QHpX3sMn2JQMXZKfvqJSmpc7Msk+q3sjtyS+VplVQKcCkeNSUyXRGg==
X-Received: by 2002:a17:906:fa19:b0:78d:9002:fe3b with SMTP id lo25-20020a170906fa1900b0078d9002fe3bmr3102348ejb.769.1668709514693;
        Thu, 17 Nov 2022 10:25:14 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709061daa00b007b2a3cad2cfsm677324ejh.132.2022.11.17.10.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:25:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovjZZ-004x9E-28;
        Thu, 17 Nov 2022 19:25:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] range-diff: support reading mbox files
Date:   Thu, 17 Nov 2022 19:24:06 +0100
References: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
Message-ID: <221117.86leo9h20m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 15 2022, Johannes Schindelin via GitGitGadget wrote:

> +		if (starts_with(line, "diff --git ")) {
> +			struct patch patch = { 0 };
> +			struct strbuf root = STRBUF_INIT;
> +			int linenr = 0;
> +			int orig_len;
> +
> +			state = MBOX_IN_DIFF;
> +			old_count = new_count = 0;
> +			strbuf_addch(&buf, '\n');
> +			if (!util->diff_offset)
> +				util->diff_offset = buf.len;
> +			line[len - 1] = '\n';
> +			orig_len = len;
> +			len = parse_git_diff_header(&root, &linenr, 1, line,
> +						    len, size, &patch);

Try this with SANITIZE=leak, e.g. this seems to fix 1/4 leaks that pop
up if you try the command noted in the patch:
	
	diff --git a/range-diff.c b/range-diff.c
	index 77fa9b970b1..7ff33f92e39 100644
	--- a/range-diff.c
	+++ b/range-diff.c
	@@ -142,6 +142,7 @@ static int read_mbox(const char *path, struct string_list *list)
	 			orig_len = len;
	 			len = parse_git_diff_header(&root, &linenr, 1, line,
	 						    len, size, &patch);
	+			free(patch.def_name);
	 			if (len < 0) {
	 				error(_("could not parse git header '%.*s'"),
	 				      orig_len, line);

Maybe it really should segfault, I didn't check carefully, but your test
passes with SANITIZE=address with this, so if so it's missing
coverage...
