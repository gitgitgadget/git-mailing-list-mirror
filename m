Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E0C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 19:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKDToK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 15:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKDToJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 15:44:09 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46925186D5
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 12:44:08 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s10so2765044ioa.5
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cY9AbcRSwl5teqjtTby4YA7XdZ4K95i3pjTjlSRBzw=;
        b=z1jxBhn1C9ZXi+I8/cqKN2x6ld7euJDLo97Y5qWaATQo8Teia+dydDulDqPe6YpjoL
         dGll5at3t/GbBgJm2W6b+9Hi6MFpssGIl8w9ndSrU0/EHmn66O3htL2ItWpK9FwOCN8l
         8KQdTiuIHJu5No0QKz0q7uzJL8n9aa5ockvM1qtSCpmP+WJywgs0qIgg0KIQiLXjOtM5
         yz7Bfvcuxp5KD3HH2X46OVo/MsEoPLmB1n0nLkbRFc+y2OLSvRQvfb4ja1ucIYOAdYoX
         D8XpsUaYD+DOdqmw/s2s0yEneKNtfBNeoo9QWXelg27o3ccuz1oDkCi+URq+ypWY7uxZ
         txeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cY9AbcRSwl5teqjtTby4YA7XdZ4K95i3pjTjlSRBzw=;
        b=X1o9UnEq85J9R4Gp0KbDFv2gJVpNVOkZ75JnnnAnzHD+g99Vs1gobKuaeXUH2G16fY
         nLjGNrvOpiyWeYEzXRhWqdKGIc/WuhG0V2GHVP2CCYDOwyuFmqrwz6+27dtvcUzfMS0e
         Y/8+PfL4zC3y886CRfdmdpTzuqXn6MJArKC6nwLJPi+Uq/Auoy6sPcV4vRSjPW/DjdeA
         VdNu2CUsD1MpCBsJQYDCudaM0Y6zUt0oc5xD9f+kEz8dOJhsqTmeAXg1eWJsShDvRhdn
         X80cPYU1dvmyejoTlx1zAFgRmnhTrS2JicHTtiZ+35aebAYeTO4ZU1/KoSzUIogrHM5n
         05vw==
X-Gm-Message-State: ACrzQf3gP4+3M1I1tS1CWusyXpY+1Yv2YEZkG4GNfjcrhiVkgJhA/6D1
        5cRXiYBxBbaxtv8CKVIbD6k/wA==
X-Google-Smtp-Source: AMsMyM6kwuYT5AZi2CpVFeuVV4lZ0PabLKKKaVGDatRq6eYIzwbx0R7znXnBnDzaEadASwqg7SpAWA==
X-Received: by 2002:a02:c507:0:b0:375:4d62:2cf7 with SMTP id s7-20020a02c507000000b003754d622cf7mr19308460jam.152.1667591047648;
        Fri, 04 Nov 2022 12:44:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s3-20020a02b143000000b00363781b551csm1513350jah.146.2022.11.04.12.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:44:07 -0700 (PDT)
Date:   Fri, 4 Nov 2022 15:44:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        "herr . kaste" <herr.kaste@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] rebase --update-refs: avoid unintended ref deletion
Message-ID: <Y2VrhR6b0SzG1HEA@nand.local>
References: <bf5bc739-cb88-61ff-ed6b-09b1316f2f35@github.com>
 <20221104165735.68899-1-vdye@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221104165735.68899-1-vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 09:57:36AM -0700, Victoria Dye wrote:
> However, because 'write_update_refs_state()' will not update the state if
> the 'refs_to_oids' list was empty, removing *all* 'update-ref' lines will
> result in the state remaining unchanged from how it was initialized (with
> all refs' "after" OID being null). Then, when the ref update is applied, all
> refs will be updated to null and consequently deleted.

Good catch.

I wonder, though: should we only add pending ref updates to the
update-refs state after we reach that point in the sequence?

IOW: there is no world where deleting an update-refs command means to
drop the affected branch, right? So the initial state would be an empty
list, which would cause us to not update any references.

Then as we proceed through the rebase, we accumulate update-refs
commands, and know their after_oid immediately. Then when we're done, we
can process the update-refs commands for the branches that we do have.

The more I think about this, the more that I am convinced that the bug
is in how we initialize the pending list, not our treatment of it later
on.

The bug fix works as-is, but I can't help wonder if the above approach
might be more direct.

Thanks,
Taylor
