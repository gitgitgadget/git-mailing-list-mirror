Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B3BC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 08:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiJZIc0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 26 Oct 2022 04:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiJZIcX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 04:32:23 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3DA7CE11
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 01:32:20 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id bj12so19186059ejb.13
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 01:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpbOY0BnW22UrBohVE+490l4+tcQMDjNRfpnak5d3vA=;
        b=nUvnNaghV9zFNdeWJ1K8SETkVmq+JaW5XYYbNNalcUl/Z0tr47m7JYOW67ekCSafCJ
         rLWjZVYJlUuz+wTvV5W0UZR6/fEHXDA0NMEL5Fp3QenFnMnvwljQqCTGpnfWE60jEgNJ
         nxGMBzM3c4e/C/lOzh/Fm+oxQweyHbWeHhw6Pm0aRh8zWu5eMDKY4wcxSnCxePJsh+um
         nnnCzsxVbCAuyPwp2mXZbQV8Nt90DSzWXRCeV/xdWgDD7879cVnA0t+z4QvQgCwjIkCY
         o5Z0X4uK3r8/0dVabV+fsQ1gKX2qD7pWHF98h+P8UU+034D5XlXuDcWENy/RmD4CTIE+
         vO5A==
X-Gm-Message-State: ACrzQf24z8whYfQELxUKpr1H+ZNXDUiVi0LjwITpxUii6M7WzziKFjGN
        biGmMhFWw1tPqTWjwJ1B9b6YPEFCNir1if/6NOmWe593lTg=
X-Google-Smtp-Source: AMsMyM70KOEQ5FTjTwEaUREpnclIKQqn3+aK1OkFm3/5LOhifyLFrTJtRDQ4+jXUTn7y95jKnEblbjuy56EDoICeQqw=
X-Received: by 2002:a17:906:5dac:b0:78d:fc53:7db1 with SMTP id
 n12-20020a1709065dac00b0078dfc537db1mr35532579ejv.99.1666773138840; Wed, 26
 Oct 2022 01:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-15566df8-59d7-4597-b59d-2143ec978b12-1663845799823@3c-app-mailcom-bs01>
 <53a8b40f-1740-581f-e2df-709b13046ffc@iee.email> <CA+JQ7M-48KZmnqFYfWvNeoFTxFrQAndwEZf7uuMxOw9PZSHktg@mail.gmail.com>
 <trinity-1b24da2a-4ee4-420b-9cef-e88a8bbcb385-1666770562213@3c-app-mailcom-bs12>
In-Reply-To: <trinity-1b24da2a-4ee4-420b-9cef-e88a8bbcb385-1666770562213@3c-app-mailcom-bs12>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 26 Oct 2022 10:31:42 +0200
Message-ID: <CA+JQ7M-UxvhC4jvYdqv1i2267KV5yjc2Xxp0ShHz+=j=W0s2pQ@mail.gmail.com>
Subject: Re: Handling rebasing better
To:     djvortex@gmx.com, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 9:49 AM <djvortex@gmx.com> wrote:
>
> > > Perhaps git could even support the "reset-to-the-remote-history and then cherry-pick your new local commits" directly, to help the developer in this task (so that you don't need to write down any hashes and do all that manually). But even if this isn't really feasible, at least detecting the situation and the clearer messages would help enormously.
>
> > Are you aware of
> > git pull --rebase
> > ?
>
> I don't see how that helps anything. That *does* a rebase, it doesn't help dealing with a rebase someone else has done and pushed onto the remote

Actually, what it does is exactly the feature you asked for. It
attempts to cherry-pick your local changes on top of the changes on
remote. Rebase is essentially cherry-pick but with more bells and
whistles

> (which now conflicts with your local old history)

In case of conflict, those will naturally need to be resolved.
