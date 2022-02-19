Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB4BC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 00:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbiBSAWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 19:22:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiBSAWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 19:22:06 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0AD6663C
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 16:21:46 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id p7so17930041qvk.11
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 16:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7BmDxO8N7t1w6xZ73g/IjZ4dILZCsdMZc6gqnJJ/Ijk=;
        b=jEl1jss/RcXLN3sRqLFleXz2caIJBE8iGaDnAAH2oCSNccqgaLfiY90CQ444VoHjhH
         QDX39RsUtzlzjpG62ZyuGkHxAFfrp6DOUsb8alznTAlXaTnaHoL6XWJhnDJ0zHy7FRWs
         L9Fs0Gadsc8rFtC8pDqPlWitfg6BRjMyDImYHzEHRIlS0VlmDtsM0L5WE+Icnfp2pmb+
         NjA9pQHupZdltFZ3UXLhW5xpBL9t/eCqFSty3OKY7/c2kIsgTI28b5gi6Cp4/xO6T35A
         T668NCBV4Ld89MHBDGpbsRpGvjXyrVKciHCEN3hR8cEwzvrJJ4mORZuzJR1oyzQD8GIq
         Xe2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7BmDxO8N7t1w6xZ73g/IjZ4dILZCsdMZc6gqnJJ/Ijk=;
        b=jHCoqCcMUeR7jqHIdYbHwbW0x4E7aFCMR6WX8gY+hEZTSe17ZrPa55dmppPp0jZBwW
         WM5yUzSxW89mrWRpBRxQNcGEGzAje1xkc2l8XcORgfxUpzDuUckPjZmBIc+Ve4NgbeGo
         hKVyS0xcYQTB6jYQshrTTtYZkwivBBLW29pUYwkUr7TN4P/rCdNhSSzrHx1xKTA2xWIz
         rwqjqKEvXYa/9w0JD+iYNCnOC0DLkjdnsx+Qc7lv6k5dTHacg7ae96UepXwNoOgqD5ZZ
         CCf5z+7Jp6ibJEPGo3D5s8CAmdn2ZnvQkyBbnvoPci5hhEqTtBYo0t87N6VQJGzNzh3y
         QrBA==
X-Gm-Message-State: AOAM532kPX6tL0iRTSgeiNJh8KG0WnoXNr7UOyew6hhe9/DB/8mrtY19
        R9Ocy6xhxVrrTMgMAzXPz5DKcw==
X-Google-Smtp-Source: ABdhPJzhsSo0HWPwmM2GAq38q7AnzkclDPeqgzNjjGB4O+lP9UVSPK02cKGl7sYGhr2HDiRUMJeHvw==
X-Received: by 2002:a05:6214:238b:b0:430:842c:1863 with SMTP id fw11-20020a056214238b00b00430842c1863mr7698626qvb.105.1645230105241;
        Fri, 18 Feb 2022 16:21:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e12sm664633qtj.41.2022.02.18.16.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:21:44 -0800 (PST)
Date:   Fri, 18 Feb 2022 19:21:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 3/3] stash: call reflog_delete from reflog.c
Message-ID: <YhA4F5qb7/TIxMcB@nand.local>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <bcc1eae053124f6e68f60a7a02cbee4744a022f0.1645209647.git.gitgitgadget@gmail.com>
 <220218.86o834gej9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220218.86o834gej9.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 18, 2022 at 08:20:13PM +0100, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/builtin/stash.c b/builtin/stash.c
> index d0967b3d3c3..7b939576720 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -635,11 +635,9 @@ static int reflog_is_empty(const char *refname)
>
>  static int do_drop_stash(struct stash_info *info, int quiet)
>  {
> -	int ret;
> -	ret = reflog_delete(info->revision.buf,
> -			    EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE,
> -			    0);
> -	if (!ret) {
> +	unsigned int flags = EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE;
> +
> +	if (!reflog_delete(info->revision.buf, flags, 0)) {
>  		if (!quiet)
>  			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
>  				  oid_to_hex(&info->w_commit));
>
> But, having written that I notice that we have *_REWRITE twice there, so
> I almost just carried forward a new bug in 3/3 when composing this :)
>
> So one should be EXPIRE_REFLOGS_UPDATE_REF, presumably.

Thanks for pointing it out. Just thinking aloud here, the old code ran:

    git reflog delete --updateref --rewrite

where `--updateref` sets the `EXPIRE_REFLOGS_UPDATE_REF` bit and
`-rewrite` sets the `EXPIRE_REFLOGS_REWRITE` bit.

So yep, you and I have the same conclusion there, and one of these flags
should be the UPDATE_REF variant.

> And perhaps it's a big pain, but that suggests that the code isn't
> either used at all, or that we're missing a test for it.

I think this is much more in the "lacking test coverage" category than
the "unused features we should remove" one.

Thanks,
Taylor
