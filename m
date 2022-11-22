Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC60C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiKVT5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKVT5O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:57:14 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C765A2897
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:57:13 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l4-20020a170903244400b00188c393fff1so12197919pls.7
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzaDcgE06qKShbsT3ozNOcSkfD8Vwc4IvgodUhm3saM=;
        b=K1C0/13cyUVYiUwFdEOsscVGUK1HXHIUsB0N+ECuX5RosT56onimvtpavqNc3uJeX4
         FrjTNvN1i0M4Bhbz9LcIhHYMNra4jC5xUAbst3TABnlySqb0yxuzXommS16mejDJu3F9
         FKYEvB5Se4H0ri5loeEAtmWDhy6b5Gl5bGOTYdzqjqWCRs/8C0sr5E5B+Z16QvcLIMfB
         qwTnAUb7wrHL+cz+T2Vmwo/BXP9IrEnGnvm3fickl7N8kpOUENC4tGtm0c152e2vFNoJ
         m9B1yJhAAr+LVA4xmqpZ4ZJCR3rf7qeq5J1MxR/uC61ddJtPzs2duhYGZfSekage/1PT
         +nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qzaDcgE06qKShbsT3ozNOcSkfD8Vwc4IvgodUhm3saM=;
        b=SKw/E2JDWxGF35TxAJzPC53Hbi4MiddGYoPXAD5EzeHtY99xtcJ6kE8LZqAfBj0rsO
         1QpSZGEyUQjSOFUQRDLMHJbznvuY4SRYl5GW+xt56eo9EBZJWiPDVorok9qror32b7Tx
         hThr/02+7R/Y2JqYg8fxAMJ2HXkLoN975B8y6pm2QcecLY/QBHzsP1f9EIhL6zhgPeio
         AIaBlEAHyYzZadkp5rFn+HGBqENgNo7HImMrgJx1wl0iSWcc/1hUKCwaRgajr9HidyNd
         ZjeKBERKfnOhKtMvcaQFFB6K9K4SUNItlV2QFMTDMyWiUYh8dvA4akyRT8tzgHJOBvzl
         CsYg==
X-Gm-Message-State: ANoB5pm3OBP/BtH+iXcqKfMRFJCx2CsMx/VEFciS+fCyln1UF0+fZbwo
        C2PtC2uC/bfCSDBWTrQrtIQVdNr5ui4O8A==
X-Google-Smtp-Source: AA0mqf7M6vF+gGCsnPu4P8XussumiwGb8cTreYZFYeHii7VusH2m+lXWy0MCzUHWcdhdYVanc9GR6zMeN2Xffw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ab1d:b0:188:f5de:a8e4 with SMTP
 id ik29-20020a170902ab1d00b00188f5dea8e4mr6139659plb.133.1669147032675; Tue,
 22 Nov 2022 11:57:12 -0800 (PST)
Date:   Tue, 22 Nov 2022 11:57:11 -0800
In-Reply-To: <patch-v3-8.9-f952fa3d01f-20221119T122853Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com> <patch-v3-8.9-f952fa3d01f-20221119T122853Z-avarab@gmail.com>
Message-ID: <kl6lcz9eep9k.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 8/9] read-tree: add "--super-prefix" option, eliminate global
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> @@ -2149,7 +2140,7 @@ int submodule_move_head(const char *path,
>  			strbuf_release(&gitdir);
> =20
>  			/* make sure the index is clean as well */
> -			submodule_reset_index(path);
> +			submodule_reset_index(path, NULL);
>  		}
> =20
>  		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {

Here, and..

> @@ -312,7 +314,7 @@ static int check_submodule_move_head(const struct cac=
he_entry *ce,
>  	if (o->reset)
>  		flags |=3D SUBMODULE_MOVE_HEAD_FORCE;
> =20
> -	if (submodule_move_head(ce->name, old_id, new_id, flags))
> +	if (submodule_move_head(ce->name, NULL, old_id, new_id, flags))
>  		return add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
>  	return 0;
>  }

here I think we should be passing a non-NULL value to super_prefix.

Perhaps this was missed when going through the v2 feedback [1]?

[1] https://lore.kernel.org/git/kl6lv8nhnpba.fsf@chooglen-macbookpro.roam.c=
orp.google.com
