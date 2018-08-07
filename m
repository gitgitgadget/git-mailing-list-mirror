Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4A1208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 23:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeHHBmR (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 21:42:17 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:46109 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbeHHBmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 21:42:16 -0400
Received: by mail-io0-f201.google.com with SMTP id c5-v6so208925ioi.13
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FoWbM7qQamKOzylSvRlP7mNZwIy9yFTDfhi2/Hhw01U=;
        b=h5tNqZS7fQCM+e4UVf1WJXF8pC3HE/83GshYmYaCXaWMe1qN60gJ148y+2ye3JM8lR
         VjmmsDzH4Dmwv5EQw618l/fImBKMyrbHdgCZ+7QtMWN4g7N+EenK8xrisWoxeX+T3JWM
         3CkKNWJwiclFEm4UreJ4N6genF5kgOEvbao8fiwtRB0mo0ibNoLeETLidePYonH9Llds
         Qn3wS/duVq38DCkj/5r1Lq3ZFWzzkw+JHudY8tDbuHrMUyDrrGgmjkG86hYlNpQ2kGzb
         3d8vCVoTuOw8+Uy4blxEqtYH+PPjLGqbg/I11fBGeyAirRg1ARxINAht35reg5CFq0p5
         EdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FoWbM7qQamKOzylSvRlP7mNZwIy9yFTDfhi2/Hhw01U=;
        b=bhpBoUnyhDjKQGPihL8djZk4ZwN5l1pU7z3bs/svlHv9y79fNf//8o9+2FNOvrwDrL
         CrKPsT02mzx56+6Be4ciFcvrU9+ILHwcuHK/XIlKvpNZkJd39QU9JZd6qKY/7tje5KYY
         tu6FY57PYESI3zqQUlEZp99o1QRZsgcavV/vxKuqO4NO0dzJIFADp6ECEejeWqBRoL2O
         nxKMahjL9qpc6UVN0jnLYf0SUQodOgO6lB62inuTNlYwaTs+MaO70E1p/UzC/jNJBa0h
         +56WzBFohugQgsBRAxEjDu/a2T9HNSReyeGB6oFa3rI7+3I+vjRvWFA5lBj8y1gWLz0h
         TlXg==
X-Gm-Message-State: AOUpUlF8YqZz1pfobNldpw/d333cZjMXoO27aPFjciYAwtkjFsHgQbNW
        ltZZtQml3PEYtBYZnk+aCUvbbKejZ2DxWtsekCVa
X-Google-Smtp-Source: AA+uWPyN0M2hlLhV9n6yf3yaImGYPW6tI16n+0HHz8FKAkjF8IEYgzer29sN/gDUT2ninKPnDhHmQgGCresQuEN1822c
X-Received: by 2002:a6b:d413:: with SMTP id l19-v6mr211051iog.34.1533684331138;
 Tue, 07 Aug 2018 16:25:31 -0700 (PDT)
Date:   Tue,  7 Aug 2018 16:25:28 -0700
In-Reply-To: <xmqq7el1kdlt.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180807232528.182492-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq7el1kdlt.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3.dirty
Subject: Re: [PATCH 2/2] repack: repack promisor objects if -a or -A is set
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Just a note (and a request-for-sanity-check) and not meant to be a
> request to update the code, but with a still-in-pu 4b757a40 ("Use
> remote_odb_get_direct() and has_remote_odb()", 2018-08-02) in
> flight, repository_format_partial_clone is now gone.
> 
> I've tentatively resolved the above to read like so:
> 
> 		if (has_remote_odb())
> 			repack_promisor_objects(&po_args, &names);
> 
> but I am not sure if it makes sense to always require odb helper to
> be present for any promisor.  As long as you do not have need to
> actually access these missing objects, you do not need any remote
> odb access at all, in which case requiring has_remote_odb() as a
> precondition to concatenate the promisor packs to coalesce them into
> one pack does not make sense---you only want to know if there are
> any .promisor packs.
> 
> In other words, I suspect that the world is not black (i.e. partial
> clone, which always has remote-odb) and white (i.e. full repository,
> without remote-odb).  4b757a40 makes it impossible to have a gray
> (i.e. partial clone, but no access to remote-odb), which I am not
> sure if it is a good thing.

Thanks for the heads-up. This makes me realize that even the current
precondition (repository_format_partial_clone) is not an exact one - I
should only be doing this if I know that there is at least one promisor
object (if not, in the rare case that a repo is configured to be partial
but does not have any promisor objects, repack will generate an empty
packfile). In the next reroll, I'll take care of this, which should
avoid this merge issue too.
