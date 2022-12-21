Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFC6C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 01:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLUBx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 20:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiLUBx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 20:53:26 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA071F9EF
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 17:53:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gt4so14269030pjb.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 17:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jtj94THtPaFkfIhyY7ONlTckk9CVCPCyPN+0FPVpzlU=;
        b=Zd8cAT1PUF5jezQkfIUT4qEcQoOAy9nxhRKIxMcizzyub7l8M22nkjxqOr7UvXk1ZI
         d5xcLwtmLVR/+QA6KLC8IfqCUV5IDBosvibTk9xxwwyQvf6nbJfSqQOVSV0QW/1L9R25
         3BUEjdV4YOKQ+eoOAAWjKOaBbGjBDV14smsfaq+Msf3THwEj46L4cqAoH379Z2OeFb4G
         9XHWRkm4QCvo4tOy2E6QZvg/eaISK2Jk6qB1CFvUbq7jdWhz1onCwbh15WewMzNPluNb
         qMA9InVSfnB1qt9HUxly1Nyp89zwdEw/IepfKJaH0t+GOBJIDbNNpU1qKiRQlnfpJxtS
         oORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtj94THtPaFkfIhyY7ONlTckk9CVCPCyPN+0FPVpzlU=;
        b=b7riikkTpUHgOHZmcpaelkJobnXyRs6XL76O426lTg+7csZxP8NN4N/YlA174KRsmM
         cvOiwK3XdsyXaFLys5ZabAP3aJTxUogNyQieg1NQnMRqbfkuRPBw09nYmTFQQmJVwF4I
         G85djgz2D639kZ/p/bgMTrEMjpcE9va6T8lRmO/2YhgaW+TosAqjP186+XbhFdZTIMLi
         nmAL0kyHN/HQbLQSMG+zNUyjEgMR4iZZ2VXyQCnO41p/i70MnPGajyfzuKEVEE4384r0
         q2rDy9b9cJ29BpiuJ7qH10a/R7Qi29T0KIaBqgznjAXjGejtiqffcn/4bErXbUhNtEqU
         BS0A==
X-Gm-Message-State: AFqh2kpM/pWNcl+Ce24kGHOvvXrOEUtIC6vxa97Y0gmAVeIfekY4XnoG
        ed81ANJ9l014CWJcNHPSwGheGvPPd9Q=
X-Google-Smtp-Source: AMrXdXtU3xnz0K1a7jwEp+a/wwkdPIsXiY5iNh4uDxUBh7ZmzZ8O5wlqMm6yswfGEriU4aWZmLJoXQ==
X-Received: by 2002:a17:902:7291:b0:189:6b31:dc50 with SMTP id d17-20020a170902729100b001896b31dc50mr146232pll.31.1671587605506;
        Tue, 20 Dec 2022 17:53:25 -0800 (PST)
Received: from localhost ([2001:ee0:50c6:3450:b0ce:46ff:fe04:76aa])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001895d871c95sm10035249plh.70.2022.12.20.17.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 17:53:24 -0800 (PST)
Date:   Wed, 21 Dec 2022 08:53:21 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Chris Webster <chris@webstech.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ci (check-whitespace): suggest fixes for errors
Message-ID: <Y6JnEQY2VWU8gSZX@danh.dev>
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
 <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>
 <a2b5f3e87d6ef62d8005cff5568ad3afc4af3771.1671496548.git.gitgitgadget@gmail.com>
 <Y6Fle8gzVU5si3T/@danh.dev>
 <CAGT1KpV0igMKk4FvapuZCdJ7kFS+_cNe2ouczQsomheOGhgLZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGT1KpV0igMKk4FvapuZCdJ7kFS+_cNe2ouczQsomheOGhgLZg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-20 11:55:57-0800, Chris Webster <chris@webstech.net> wrote:
> > I think this change is getting too long to be embeded in a yaml file.
> > I think it's better to move the shell code into its own script, so we
> > can have better code highlight in editor and a proper shebang (/bin/bash).
> 
> That would need to be a separate patch?

Yes, I think, a patch to move the whole block into a script, maybe in
ci/ folder.
> 
> > > +          echo "Run \`git rebase --whitespace=fix ${lastcommit}\` and \`git push --force\` to correct the problem." >>$GITHUB_STEP_SUMMARY
> >
> > When move this block into its own script, we can use single quote
> > string here, too.
> 
> I am not sure what you mean.

I mean we can write:

	echo 'Run `git rebase ...` to correct the problem'

With single quote, we need less escape.


-- 
Danh
