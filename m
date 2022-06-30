Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A325C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 15:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiF3Puf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiF3Pud (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 11:50:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CC286C6
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 08:50:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c13so27121891eds.10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qGupxahPT/xS5YMn77XqJe59gjcc3+fgXWOIAQMSJUk=;
        b=JSEN/SagWDIOvRun2J2ubXOafIZl+UPM5x+8ICy/V52N4UuZy8UZDWwETD3j9iUOUD
         G+Dli3DHaOw1TPKOKsX+wmiMXC2K6CatFNuddUtm2VIotYhz4xqJ8NRK7fddNbbHecq+
         ZncuV49w5Jvv6G8ixQLb0vqBeHNRuuZ6BDTE2nVNYt1kGJoSfStJGGbx1Id12Xwlgb67
         bhst5o8YsBHgYu0YiI9RU25WDBN2UVJz3JsNKTIClkH+bvX1XyTAuSeeG61ZeMd9cv0C
         xmauO47aq6/hhOSnP1rxfvJhj/bv+jWPTF+UTiJiS3pJyZkZKbcII6lxoIOtoXf8ogXW
         FIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qGupxahPT/xS5YMn77XqJe59gjcc3+fgXWOIAQMSJUk=;
        b=x0t+99RFCzN+LfdjtVdpX89W0m3U59J/vg1QNLRxq6BE2kwYiRcUvhuQm7c1/YZeY1
         pzKzVPJxpa6ZhGTUaEXSSeVYE5yUN02cCraoTEUk2o6QyO/qOyEA5ckHEDjyyXdqGUhx
         skuly3y37pMj2vWvFOOYpOUYZ1GqMy6JB/i7h5ysyLjVCZ+MSn0+pbVf1TjuOppJ82IW
         /oL88MmE6mJABBv+Vfh9441GaFe/xVdiDuee1e7uoAEBCVMWENey40ASx5tgOZS1HlDx
         id49en0/Xx3do4kUCJjxrySCCjodM3Z6VJnPZt9CMlJfDvlLEUGjkSh5KuR61EmMJvW4
         52pA==
X-Gm-Message-State: AJIora+79fg2eFvdEQwP4lXq+kTH/bZlaYfvCtosRV7mW637ZjP/Bo3i
        gf28SWQCuOrsdaNoLn7Kjd0=
X-Google-Smtp-Source: AGRyM1vAcC1nixJAHsSpB0CkTS0P9qMwChkaUdEyC+0qxv0wt9L5vFQZb9YiJbudLV5iqVzrgNnsZw==
X-Received: by 2002:aa7:d88a:0:b0:435:6abb:1284 with SMTP id u10-20020aa7d88a000000b004356abb1284mr12606385edq.353.1656604231126;
        Thu, 30 Jun 2022 08:50:31 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id pv1-20020a170907208100b00726abf9cd8esm4977745ejb.125.2022.06.30.08.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 08:50:30 -0700 (PDT)
Message-ID: <61074b4c-c48f-da89-5d03-b280b9c4fedf@gmail.com>
Date:   Thu, 30 Jun 2022 16:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] cat-file: add mailmap support
Content-Language: en-GB-large
To:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220630142444.651948-4-siddharthasthana31@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220630142444.651948-4-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Siddharth

On 30/06/2022 15:24, Siddharth Asthana wrote:
> git cat-file is not a plumbing command anymore, especially as it gained
> more and more high level features like its `--batch-command` mode. 

cat-file is definitely a plumbing command as it is intended to be used 
by scripts. It has a number of features that are used by porcelain 
commands but that does not make cat-file itself porcelain.

> So
> tools do use it to get commit and tag contents that are then displayed
> to users. This content which has author, committer or tagger
> information, could benefit from passing through the mailmap mechanism,
> before being sent or displayed.
> 
> This patch adds --[no-]use-mailmap command line option to the git
> cat-file command. It also adds --[no-]mailmap option as an alias to
> --[no-]use-mailmap.

I don't think we need an alias for this option, it'll just end up 
confusing people.

> At this time, this patch only adds a command line
> option, but perhaps a `cat-file.mailmap` config option could be added as
> well in the same way as for `git log`.

As cat-file is a plumbing command that is used by scripts we should not 
add a config option for this as it would potentially break those scripts.

I like the idea of adding mailmap support to cat-file and I think this 
patch is definitely going in the right direction.

> +char *replace_idents_using_mailmap(char *object_buf, size_t *size)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	strbuf_attach(&sb, object_buf, *size, *size + 1);

I'm worried by this as I don't think we really own the buffer returned 
by read_object_file(). git maintains a cache of objects it has loaded 
and if this strbuf grows when the author is rewritten then the pointer 
stored in the cache will become invalid. If you look at the code in 
revision.c you'll see that commit_rewrite_person() is called on a copy 
of the original object.

> +	rewrite_ident_line(&sb, "\nauthor ", &mailmap);
> +	rewrite_ident_line(&sb, "\ncommitter ", &mailmap);
> +	rewrite_ident_line(&sb, "\ntagger ", &mailmap);
> +	*size = sb.len;
> +	return strbuf_detach(&sb, NULL);
> +}
> [...]
> +test_expect_success '--no-use-mailmap disables mailmap in cat-file' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-EOF &&
> +	A U Thor <author@example.com> Orig <orig@example.com>
> +	EOF
> +	cat >expect <<-EOF &&
> +	author Orig <orig@example.com>
> +	EOF
> +	git cat-file --no-use-mailmap commit HEAD >log &&
> +	grep author log >actual &&
> +	sed -e "/^author/q" actual >log &&

This line does not have any effect on the contents of log

> +	sed -e "s/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//" log >actual &&

I think you can simplify this series of commands to do
	git cat-file ... >log
	sed -n "/^author /s/\([^>]*>\).*/\1/p" log >actual

Best Wishes

Phillip
