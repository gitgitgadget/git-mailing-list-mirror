Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6648C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 20:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbiCBUXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiCBUXD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 15:23:03 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1FCA0D0
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 12:22:20 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so2686446otl.6
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 12:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Ce2nekec6G78wMEafGlkJAv8ibYxMV2jVoRuXdOlIM=;
        b=Yl6v/Pqye0PlHvDhhaP7Z4WLuzIpqty/oJ3Ag9lKGuzhZyo8VzBPuEsa3SVnVjNgZo
         lshi5to5bXncptIznooXd34EWP711hVB1TdVYr81spvqmHgQpOSR/EgdB5JJSeXZv5Pc
         4ew1k/Ef3f2SmigmNTrnkwK+X5zHKf5YNXb9gx7J34B0eumn4RVH6wAF41RVSlNGhTH8
         ed60UXobLROtXo67VE/geb1L+/YVpK+NCehUYEHF6EfNmWVbk13EEtH5JMolOPC+EtVr
         GVtvapQK4E1LxXTot34mw6KWP3vBJ5apbANwwxn9RQRmkvvPgZxbTAjDvINSXORe+gfn
         8GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Ce2nekec6G78wMEafGlkJAv8ibYxMV2jVoRuXdOlIM=;
        b=FIiYRcVfxniID8OdENmSfNWaKU23Nnz9TlNCdws9zXtpxwOaQP+L0ZLYBcqMIqad5K
         TwQLWY/9F7D4ryb4/AJgqn8i7KuvZdTuwvzsEWTVgZXH1fLYicvWLy8hXTMCYLKpzJyA
         m6urwZUEvKeGcao0DKyP0YzbL/q91fd7fWfA3xwnZkSOhjxKJVO6l7SmgxLgyrCfALut
         l9eM4ATz61z1HdHZLWFjcWNo/N4gO/+TpVGq/0pWUjDWxmf1r7Itw2JmukX77ZiexoMm
         C6O+6w1lQFy0fwWXU9aHcOBItIywZbntQF5/vYUrZkzI8S7qDNJGTmM3Ls9xw1l5toQu
         hV3w==
X-Gm-Message-State: AOAM533fBvk9lCy7RRSpZiq1WaVb9FvKt+ikI8F933PdNSHSQYitRe7S
        jID6QArNW/JHWmhXkxGMwP4m
X-Google-Smtp-Source: ABdhPJxNaffoIgr1ksEL9zg5R1fGH1YBohI34jcjzFrP4NIK9D9S9+Fd1Wq3Bco6qEBSnwRgXjjD9A==
X-Received: by 2002:a05:6830:11c8:b0:5ad:10dd:48b5 with SMTP id v8-20020a05683011c800b005ad10dd48b5mr16990909otq.220.1646252539867;
        Wed, 02 Mar 2022 12:22:19 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l84-20020aca3e57000000b002d97bda3872sm147398oia.55.2022.03.02.12.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 12:22:19 -0800 (PST)
Message-ID: <66eeada0-f2b4-6849-bf14-029bb6c6083d@github.com>
Date:   Wed, 2 Mar 2022 15:22:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 02/17] pack-mtimes: support reading .mtimes files
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     tytso@mit.edu, gitster@pobox.com, larsxschneider@gmail.com
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
 <101b34660c0c5028ba591d052dc587bb8918ccb2.1646182671.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <101b34660c0c5028ba591d052dc587bb8918ccb2.1646182671.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 7:58 PM, Taylor Blau wrote:
> To store the individual mtimes of objects in a cruft pack, introduce a
> new `.mtimes` format that can optionally accompany a single pack in the
> repository.
> 
> The format is defined in Documentation/technical/pack-format.txt, and
> stores a 4-byte network order timestamp for each object in name (index)
> order.
> 
> This patch prepares for cruft packs by defining the `.mtimes` format,
> and introducing a basic API that callers can use to read out individual
> mtimes.
...
> +int load_pack_mtimes(struct packed_git *p)
> +{
> +	char *mtimes_name = NULL;
> +	int ret = 0;
> +
> +	if (!p->is_cruft)
> +		return ret; /* not a cruft pack */
> +	if (p->mtimes_map)
> +		return ret; /* already loaded */
> +
> +	ret = open_pack_index(p);
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	mtimes_name = pack_mtimes_filename(p);
> +	ret = load_pack_mtimes_file(mtimes_name,
> +				    p->num_objects,
> +				    &p->mtimes_map,
> +				    &p->mtimes_size);
> +	if (ret)
> +		goto cleanup;

This looked odd to me, so I supposed that you had some code
that would be inserted between this 'goto cleanup' and the
'cleanup:' label, but I did not find such an insertion in
the remaining patchs. This 'if' can be deleted.

> +cleanup:
> +	free(mtimes_name);
> +	return ret;
> +}

Thanks,
-Stolee
