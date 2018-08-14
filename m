Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE26F1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 22:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeHOBqA (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 21:46:00 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:39752 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbeHOBp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 21:45:59 -0400
Received: by mail-io0-f202.google.com with SMTP id x5-v6so17900864ioa.6
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 15:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S4v/7AifDVRMM9duBvv7tzqV1BDXFH08uTOHb0V48xg=;
        b=TlcVVeeWxEa63VXrc+8QAflar5pdtt/dP1ED1vuXxbZJnLP9sVh/agzgXRw/vv5mbB
         5VlofkLeB2KhrNdjn/VxFBWNktzyBaeTtV5Mrk+t+MqaoQmbMJBwoWlx/QlaYpvtrQfI
         CpWcREE4BaMNG3JrjY6kFGVUyFjkGPyejDaqrTYuCny3zEeI8xKDRYKrjCduWQtLkWd+
         fxsf4bf0tD+2T7tSUMzDAV+QBxQPiFZpRwRZswOIro/2Vd/fc+SRghcAT4i4rRobwL1U
         PoyJwKdAt6Nn7eu52KmJOQ+REULSUo9CHp+zhI9F8JMfA3rj7ViqEUM6XZ3gMuRBdier
         IyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S4v/7AifDVRMM9duBvv7tzqV1BDXFH08uTOHb0V48xg=;
        b=JccQ0/CnaHzU7Bitu8SpFQeU9o/YWLRT1s86gQ1/lYgWfyxtO/yskZG/YGApVsAK/9
         Lt9R0nCORogDHLS9gL6b4jPak2dN0Nr7MxvhrePgFdwJ6lZtRwzZSTLAi+TNqtwze8KG
         AoUd55OKguqBHxMScRtArPBZQQNyfmKEzC9YkvIDi3/NF+dLkJnzs24KSr+JVhMETuiA
         J4qiAxEAgZ2gU1uLoOYtEtI2TkKs8nbWOrv20KqhYIIM+cBICXfM7kUCmrwpwcHvFMzF
         WMoi9Jz9iypPIfrWmGXxhVG4Wx06heYOcC7eOKsSSgqtpQic+iTezX5+rNmcMP6EtwkE
         URBQ==
X-Gm-Message-State: AOUpUlHeMPVoFLPOmUYXN+hO9/WP7G8NTACD0lOB9CUi5lKTy5rs3YQe
        7aBh10vUvQ1OWM5z63/mfM7XI+TtSxOaaGUas9ID
X-Google-Smtp-Source: AA+uWPx63ZFaqfLZSmC2ITWlaZaRM8cqmEY7SYq3Xf4pw6Gkd/tk1AoLYRXrOfPUUIxSpPf2Qx4/tds3suxQ36qQ7SjC
X-Received: by 2002:a6b:b513:: with SMTP id e19-v6mr11115037iof.35.1534287396463;
 Tue, 14 Aug 2018 15:56:36 -0700 (PDT)
Date:   Tue, 14 Aug 2018 15:56:33 -0700
In-Reply-To: <CAMfpvh+2SeOynnzH_keOPE9g2PrMgfzrjOMHWxQxkuOf+T3Y7A@mail.gmail.com>
Message-Id: <20180814225633.90251-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAMfpvh+2SeOynnzH_keOPE9g2PrMgfzrjOMHWxQxkuOf+T3Y7A@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: Re: [PATCH v4 4/6] rev-list: handle missing tree objects properly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > @@ -373,6 +375,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
> > >       init_revisions(&revs, prefix);
> > >       revs.abbrev = DEFAULT_ABBREV;
> > >       revs.commit_format = CMIT_FMT_UNSPECIFIED;
> > > +     revs.do_not_die_on_missing_tree = 1;
> >
> > Is this correct? I would have expected this to be set only if --missing
> > was set.
> If --missing is not set, then we want to fetch missing objects
> automatically, and then die if we fail to do that, which is what
> happens for blobs.

This is true, and should already be handled. Pay attention to when
fetch_if_missing is set in builtin/rev-list.c.

do_not_die_on_missing_tree should probably be set to 1 whenever
fetch_if_missing is set to 0, I think.

(I acknowledge that the usage of this global variable is confusing, but
I couldn't think of a better way to implement this when I did. Perhaps
when the object store refactoring is done, this can be a store-specific
setting instead of a global variable.)

> So we don't want to die in list-objects.c. If we
> fail to fetch, then we will die on line 213 in rev-list.c.

Why don't we want to die in list-objects.c? When --missing=error is
passed, fetch_if_missing retains its default value of 1, so
parse_tree_gently() will attempt to fetch it - and if it fails, I think
it's appropriate to die in list-objects.c (and this should be the
current behavior). On other values, e.g. --missing=allow-any, there is
no autofetch (since fetch_if_missing is 0), so it is correct not to die
in list-objects.c.

> > As for --missing=allow-promisor, I don't see them being tested anywhere
> > :-( so feel free to make a suggestion. I would put them in t6112 for
> > easy comparison with the other --missing tests.
> Kept my allow-promisor test in t0410 since it requires partial clone
> to be turned on in the config, and because it is pretty similar to
> --exclude-promisor-objects.

OK, sounds good to me.
