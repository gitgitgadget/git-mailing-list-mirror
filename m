Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D394C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 10:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiK3KA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 05:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiK3KA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 05:00:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA3D2FA70
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:00:27 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so40047472ejc.4
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRbj/dIu6AbcIJXTuwGRdqiOFpFWuWkGrcV1pHzu1fY=;
        b=GtSXzxkvZzB0nXAWgdoB4wm237c+CLnkLwQsQ62nCanVB8E3JBiS67aiI+In9VNKGK
         ZQQQtWc3GfAA/zSt5ytB/tNW0LTfX6ynoyh8Pv1tR6hxvTHfXFMGvlq/Fp384HGklks8
         7Je5NG9rCBTsbX5idksv6UAKrGUH1SMEYPQbiHqilrgo4ksFHJnHxReJLQeLWhlw5Zis
         u4WQXuab//UktHFU41DMxMioN0qe71L/O6geadKPzelfTEsIxKBDcCXeSeyy4fWKiXvr
         oolJVCBThd64BIBOqm4khJ7oEDzKbn5u2acw5UlMR7PgiIUDYOvz6Y0SO4Wpl9nytBTV
         GmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRbj/dIu6AbcIJXTuwGRdqiOFpFWuWkGrcV1pHzu1fY=;
        b=ond2kwUctOT7LWBHC2QkZ33YTM8Tl9SaCswkEezNPqJqXcMUr/gi9piSIEu8QR3GaY
         NpKdkBOwZYUZtI4C+Q/UHNZiz8P7Xs5eTxMf1J2SyghZrkmt4IC0eycyxAVFNuRSWTJc
         xV5B1ZbNjEGcFIMEKNU/TA1bLbb1mfP99Tgc/nYWoqB58+Aw9tHYyHYfYnAIw69oCKr/
         5GXwX5UCdnnGXbI3cUH4qw2tcfij4JoDQqGtiALXJDL1H/CFf9gS/3hY4FDnzyBBrgfv
         HTdaYy7L7i0VltL8WUGZ4dPdiTb8bnvD86mxZB369GDlCdBMwHLRtdUrf0XQYYm7EAzi
         F38A==
X-Gm-Message-State: ANoB5pkY2QUf+x4wo2C9vFboejankii6aIQB0EXlNpwd+5ojrvNqtWa5
        d2Ezh5N5uL/Xzj+q4BhvOiODx//7Emyx1g==
X-Google-Smtp-Source: AA0mqf5fUUrKC2vah6qpefCs+wjouVSNHFriZ7r54o7KzFty7uMCgx7u4BZfu+IomzwanLm5outZFg==
X-Received: by 2002:a17:906:2810:b0:7b2:7b45:2bf6 with SMTP id r16-20020a170906281000b007b27b452bf6mr35313166ejc.467.1669802425089;
        Wed, 30 Nov 2022 02:00:25 -0800 (PST)
Received: from gmgdl ([109.38.157.167])
        by smtp.gmail.com with ESMTPSA id d8-20020a50fe88000000b00463c475684csm435877edt.73.2022.11.30.02.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:00:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0Jt9-001y9b-2L;
        Wed, 30 Nov 2022 11:00:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        emilyshaffer@google.com, phillip.wood123@gmail.com,
        myriamanis@google.com
Subject: Re: [PATCH v4 1/5] run-command: add duplicate_output_fn to
 run_processes_parallel_opts
Date:   Wed, 30 Nov 2022 10:53:10 +0100
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
 <20221108184200.2813458-2-calvinwan@google.com>
 <kl6lo7spqqzg.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6lo7spqqzg.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221130.86lensiwy0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 29 2022, Glen Choo wrote:

> Calvin Wan <calvinwan@google.com> writes:
>
>> @@ -1680,8 +1683,14 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
>>  	for (size_t i = 0; i < opts->processes; i++) {
>>  		if (pp->children[i].state == GIT_CP_WORKING &&
>>  		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
>> -			int n = strbuf_read_once(&pp->children[i].err,
>> -						 pp->children[i].process.err, 0);
>> +			struct strbuf buf = STRBUF_INIT;
>> +			int n = strbuf_read_once(&buf, pp->children[i].process.err, 0);
>> +			strbuf_addbuf(&pp->children[i].err, &buf);
>> +			if (opts->duplicate_output)
>> +				opts->duplicate_output(&buf, &pp->children[i].err,
>> +					  opts->data,
>> +					  pp->children[i].data);
>> +			strbuf_release(&buf);
>>  			if (n == 0) {
>>  				close(pp->children[i].process.err);
>>  				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
>
> A common pattern is that optional behavior does not impose additional
> costs on the non-optional part. Here, we unconditionally do a
> strbuf_addbuf() even though we don't use the result in the "else" case.
>
> So this might be more idiomatically written as:
>
>         int n = strbuf_read_once(&pp->children[i].err,
>         			 pp->children[i].process.err, 0);
>  +      if (opts->duplicate_output) {
>  +          struct strbuf buf = STRBUF_INIT;
>  +          strbuf_addbuf(&buf, &pp->children[i].err);
>  +        	opts->duplicate_output(&buf, &pp->children[i].err,
>  +        		  opts->data,
>  +        		  pp->children[i].data);
>  +          strbuf_release(&buf);
>  +      }
>
> which also has the nice benefit of not touching the strbuf_read_once()
> line.

We should also use "size_t n" there, not "int n", which is what it
returns. It won't matter for overflow in this case, but let's not
truncate for no good reason, it makes spotting actual overflows in
compiler output harder.

And why does "&buf" exist at all? Why can't we just pass
&pp->children[i].err, and if this callback cares about the last thing we
read let's pass it an offset, so it can know what came from the
strbuf_read_once() (I don't know if it actually cares about that
either...).

That would avoid the copy entirely.
