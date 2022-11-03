Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB84C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 00:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKCALi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 20:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKCALh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 20:11:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8226476
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 17:11:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p184so132931iof.11
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dH2QsTL7WFWXZQ4sQOu7WyTjPE2gL+eRlOQ8VFLRqk=;
        b=iajA9KJ+OJF9WLd0xBfzC2mCMvxpIzh5EeZE2r+zmgSJoysojJxKmx5f05tozYOYi4
         fPQIzxleVxet/klEQLBLGd0F85Qf/gj6T6zUj1UT4vK+ofSm8RNVxmSkNB5ob/nuzc6L
         U0s/g/3zHf15UZ4QVG5cn1jUP80/ZBfD41qrENZ0h8cyiymmv5a5Y2Ar/RY7AB8YMsIQ
         7j4Zea66OdXNt1oKmi0Q0Il+LFHSjlwWqSrW+xj27YO5v+IBZDGUrj0fCSCvc0EMXM/s
         cXBQ1RY0NDfCJ7dn3klYy04oD3gW9AoFtasszPg1/DheqNu7WTtUZcOC9kSfPBN+xM5k
         lPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dH2QsTL7WFWXZQ4sQOu7WyTjPE2gL+eRlOQ8VFLRqk=;
        b=EfPOtNXq9QC4pL2ivi4FPOL8LVZp5cgIRP6SYqt0OuAxj+GNW6ruy3T6K0WV6uIqAU
         jS/2UHuyMXkaB6XSUKJWTMt1a4c9ezjOWPYjWT2BA/2lKhKao1ZaIig/HgD0qjA7T84y
         SHmtoFfjaks23ThzdPi3dfzFJyqjjANKIJ4BbvollDx+xSbZYIYhLil7dtJhXxYUxLh9
         2Zk06Ai1tj5OlwWA36I97HUcNArCP851jZzxmWWFq+wIpNhBT10isIQpCaVdIFd99cJ/
         2bdFt0TgLB4QWrlCffw0kIT9ScLSvRBMWMQi3mKKflnyVNlUhGIMqfGBHGpMM0a5Il1G
         hXDQ==
X-Gm-Message-State: ACrzQf0svp5j09LeX6tcPeS2p0foAo/YSsn0fE9926JqJdEhjb8vBKWr
        wBWvWHk7NIBN8ejANo93AWvZCQ==
X-Google-Smtp-Source: AMsMyM45UsL9ofO/b/o80LK1D26yZ+ZK1RgY7qeRswllyhEeuSdKFXRf9UtNIWfx6gopgMxafQ/ung==
X-Received: by 2002:a05:6638:3e11:b0:375:8e1a:c0d3 with SMTP id co17-20020a0566383e1100b003758e1ac0d3mr1468068jab.185.1667434295645;
        Wed, 02 Nov 2022 17:11:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j12-20020a02cb0c000000b0036332a07adcsm486615jap.173.2022.11.02.17.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:11:34 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:11:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Soo <johh.soo@arista.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <dscho@github.com>, git@vger.kernel.org
Subject: Re: safe.directory and ACLs
Message-ID: <Y2MHNeSrhxfH1Ayf@nand.local>
References: <CAJyRyRo7oVAfLx8MONO=Y8KhLvL+tJgDTbCUezR1AFa73R5pbw@mail.gmail.com>
 <Y2LgzmTvElmRTsoe@tapette.crustytoothpaste.net>
 <CAJyRyRqMPX93-Oa5XMvZtDTRxh0SisUhOFAWhv-6hXR5sEkQpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJyRyRqMPX93-Oa5XMvZtDTRxh0SisUhOFAWhv-6hXR5sEkQpA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 04:41:15PM -0700, John Soo wrote:
> Hi brian!
>
> > No, the permissions of a repository, whether standard Unix permissions
> > or ACLs, are not relevant to ownership.  The question here is whether
> > the owner of the .git directory (that is, the value of the `st_uid`
> > field when calling lstat(2) on it) is equal to the effective user ID.
> >
> > When you the path in `ls`, you can see the owner and group of the file
> > specified, and that owner is what matters here.
>
> I see. Is that by design or an implementation detail?

It is by design. See 8959555cee7 (setup_git_directory(): add an owner
check for the top-level directory, 2022-03-02) for details.

Thanks,
Taylor
