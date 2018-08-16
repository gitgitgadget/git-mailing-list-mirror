Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0AA1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 15:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391870AbeHPSLJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 14:11:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35469 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389008AbeHPSLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 14:11:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id g1-v6so4496917wru.2
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X6/OmJh861UMGMSM12gghTi2NEfdHOVY1IzrCA+E1aQ=;
        b=pO5MCiMNGwbrdTzXk6gKOZWPGvRJVpKxUwpWrHyEn8aT1l8FJJ8bJvoPIq/oFwoJP8
         0cxhQeX5G1omE49X90IjD2Jc6IGDyBq5iJRb2wJVIzU6+dcNS6QKnnP5SZCTHd/TCtuB
         ScQpL1M+a4gTg9S7pSHsfs6WDG+ZCRn+oD7Ork4PRS+JEpf0HYdBhvF6zTUwMyrdF6g1
         kaf1bMfwd3GQZY5yB6/wD+j9z/Pn4rNjQRbnu8O9Vf/mGcNbgqjNCzFhU5d+rjck8r9G
         rimveXPuXhkC+4mtc4D+NgouqG1hEzD8F7n+pqrKOPMcNJYN7aTglF/sk+ga9PN1BQX2
         hfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X6/OmJh861UMGMSM12gghTi2NEfdHOVY1IzrCA+E1aQ=;
        b=tNLWTe1c5M/Lq3wtaGLzcx6+7jF/S09Gp2O5ijBZPBSjWvcmc22on+S113jayenkhu
         kYz1o2DJl4F7xBjuUgsU265tGVkzR8twX5zTBhhTkYSJLS93JYpnvs/k7iFYtTh3lFlj
         pDx8eeDF49r1ZT+Wc0HM/N2WFOz6QUSFXd/nE6cgD/H4Gm+2IoRs+KsxuyGwavmPepIR
         3rKspr6fBkksbFPyxHLNkNurBc/l5HBbrCZtTr65GU8MaNg0T/tC4fnC+wW1OU5VVjoV
         WT+7dxzrdIe7dLA379FXC0Y57oW/VXQC4kfGUqK6X0G2cuGjsRG4pLfFK2vaO8h1bhY+
         Z+mQ==
X-Gm-Message-State: AOUpUlH6DT+8lsx8Vl7x/G+qVjUKBo9LDnH5LGzNUWwZrs6PZjavggzw
        S2AoaxCcc3adUHyVpbuop+E=
X-Google-Smtp-Source: AA+uWPxDJq6oh+BP+9CE+T6wx5uqH8nkaV0MLeHUGTAFoVUPNAh+TNIrtWrcFgRUU/t1B4PdxA0DDA==
X-Received: by 2002:adf:de84:: with SMTP id w4-v6mr20512068wrl.270.1534432322388;
        Thu, 16 Aug 2018 08:12:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a12-v6sm29052921wru.61.2018.08.16.08.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 08:12:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com
Subject: Re: [RFC PATCH 0/7] Unset the submodule URL in the superproject when no longer needed
References: <20180816023100.161626-1-sbeller@google.com>
Date:   Thu, 16 Aug 2018 08:12:01 -0700
In-Reply-To: <20180816023100.161626-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Aug 2018 19:30:53 -0700")
Message-ID: <xmqqd0uigxby.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>   Originally we have had the url in the config, (a) that we can change
>   the URLs after the "git submodule init" and "git submodule update"
>   step that actually clones the submodule if not present and much more
>   importantly (b) to know which submodule "was initialized/active".
>   
>   Now that we have the submodule.active or even
>   submodule.<name>.active flags, we do not need (b) any more.

Up to that point the description is sane.

>   So the URL turns into a useless piece of cruft that just is unneeded
>   and might confuse the user.
>
> Opinions?

You spelled out why you do not need for (b) but not for (a) and
worse it is is unclear if you never need it for (a) or under what
condition you need it for (a).  So there isn't enough information to
form an opinion in the above.  Sorry--readers need to go to the real
patches.

