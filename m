Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D31C38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 19:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjA0TSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 14:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjA0TSe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 14:18:34 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44A47B43F
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:18:33 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so8680530pjq.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01Dc9saU8SWQ5gqillbfP4dq3fliIcoJ+ReLPCx2ESk=;
        b=SUrMT1Z+QMMmtBfRUOv09ttvdesYYqcWHGgXGOtam31CG/KDMm/OakudlpA7+JNiso
         I85FjNBWNH/pYP3yTzoda1EB118/BQE4ZqQmiGxwVX9whYjzvV87Lh3n7saHL7E8GqOi
         gvSapLkA5TXP/tnkYDlcQWmEDhB6aFMRmbYkSaCBs8mSo9+P8jQjy1uxv4uvUEawOVcL
         bJ0MOK5GWld+yMI8pCqrAgKbqP8hHt0dV/f1w5eqBZ8QifvulqOqAXeuEGtzF/cArkzp
         FIznf0Lu75PqCnDCVW+foBPK06CsdADBy45HFjsGAdeoL0MBSqgXTY5feQw7ol8yG/0I
         FYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01Dc9saU8SWQ5gqillbfP4dq3fliIcoJ+ReLPCx2ESk=;
        b=cKWn+7Gh46rbBroAHwFNlbrBCovLwcb6H5jRDCOjPtPTrAsA4jfnHSFptBxDsN6PVg
         NoWIZHVsKdxSubpGytWjzmlAbxazRmKHCoebFchte7UReGoePPjSGRfkW3dIfpsnl6e1
         zy1P77JOKLgrNdCcC/cydL4MDfsuXn10glj7gpX2Vuc8TK5OR5TDDWLKm/vkgeWVD2q1
         4E71RIqKSWAvFoU3fn67ku02v/tBoYxqHzyNqTQzTlHnQK5DIvSlo/FULy7a9IWimZdy
         DYE9wQo+YVyTQ3WAp+ZsnFDWnhGZ9lB6yPcvNrkS5sbKOlEEK1oZbQaWWuSbUZVOMMlF
         0vuA==
X-Gm-Message-State: AO0yUKUadIrTX1wvj7CrYN2+2s5cvPvF/mfrMzMTAbowwj+7AZYHTftn
        3WO/lSUEj7reAB7vocT/dp36
X-Google-Smtp-Source: AK7set+977L3dREKeqw5J0XjvwCN9P0FrO8JvywhCwR2v+0aeGp2n5hTKifpoO3AVtZ8dmLUTDk7YA==
X-Received: by 2002:a17:902:e747:b0:196:13cd:19a with SMTP id p7-20020a170902e74700b0019613cd019amr18851055plf.6.1674847113458;
        Fri, 27 Jan 2023 11:18:33 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id bb3-20020a170902bc8300b001930b7e2c04sm3174999plb.287.2023.01.27.11.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 11:18:33 -0800 (PST)
Message-ID: <f219288e-93c8-7791-0b1c-b36f658f8697@github.com>
Date:   Fri, 27 Jan 2023 11:18:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 08/10] fetch: fetch from an external bundle URI
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <59e57e049683e42248c270b3bfcad2d72769219d.1674487310.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <59e57e049683e42248c270b3bfcad2d72769219d.1674487310.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> @@ -2109,6 +2110,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
>  int cmd_fetch(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> +	const char *bundle_uri;
>  	struct string_list list = STRING_LIST_INIT_DUP;
>  	struct remote *remote = NULL;
>  	int result = 0;
> @@ -2194,6 +2196,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	if (dry_run)
>  		write_fetch_head = 0;
>  
> +	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri)) {
> +		if (fetch_bundle_uri(the_repository, bundle_uri, NULL))
> +			warning(_("failed to fetch bundles from '%s'"), bundle_uri);

nit: these conditions don't need to be nested and could instead be joined
with '&&' in the outer 'if ()' (unless you plan to add more to this block in
a future series - I didn't see anything in later patches here).

Everything else (tests, doc updates since the last version) looks good.

