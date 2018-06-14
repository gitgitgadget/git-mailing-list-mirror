Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D171F403
	for <e@80x24.org>; Thu, 14 Jun 2018 21:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964820AbeFNVoO (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 17:44:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54384 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755392AbeFNVoN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 17:44:13 -0400
Received: by mail-it0-f65.google.com with SMTP id 76-v6so302635itx.4
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 14:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lx/gFhCGwJDgzLHyhVl2sZZWgAhEgMzNybDmf54vCM=;
        b=TW0oGK8t7fklzSXFUQJ/2BkGV0dlKwaFfqNk+OKS61X4/swI9JW+qskZtz2yzRowyq
         AQYrdTILwCGnCGYL4cq6gXJi8X8DtKzbqVGO4UIR59aPfsCtkoWKNsXb0fW0hLC3ellM
         u+hysNgMSZqsjFAYFfeGJLjT904itCBpVFkyfdMpYVYL2GZiDLPWXmAEP26t5b0y/lUl
         TnCrcjDnzBNkZIYsWMjSzYMwJ0l52zl/WeaySbx7IMs0h3Wr7UFMsg9t2UDWXBJ0hCqh
         ifRSNc2OWCOR/0Ep96UcJW0N+5xpoqE+pGWZqrYQTFa4EvaLiRf629IIv+1/2pzPpDsb
         yKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lx/gFhCGwJDgzLHyhVl2sZZWgAhEgMzNybDmf54vCM=;
        b=TlwG+DcknDv/5TP4iiahDxIKimiVgUbeRXByp+To2cp32YlApSdt7/Du1i09488G0/
         Eavg9QI2gDLG6se3lrTae+qc5r2wF6z/a7Qs6GCqxshlEVVqsiMEOEfmyHvlAtXA5BWm
         KTIIv520RwIb7drUDB8ztQwSqjzSokZCA0hQSI27Fp8Uv/vtVaDRXIn56gHtnx1Q/+fK
         uXqB8kokelYdq7/Yh2BqyXQWPUzzmepOQxvMh5xJp1dYI7IVNZZPDcbezqDevXBfdbcz
         oPLPGPhBkjne5pc4ehRv/g+HW2Asj9RVYMaMojlmP/aXMQoVxMKItWnP+3nv/DCtFh/v
         Jd5Q==
X-Gm-Message-State: APt69E11jQ7bNPzWgpI4sh01Qdh6xzdyC1yJCo/d2WPgsK79OiYMHMpv
        d86dVCtp5g6wqLhHYuh/KKo=
X-Google-Smtp-Source: ADUXVKL067koW2xZJz4hSmEyy3MIaTa/rM284tvU4VqtPI5xuf9nk/9S1nVIfDuYO3AZ/BKbPUDDSw==
X-Received: by 2002:a24:1ad7:: with SMTP id 206-v6mr3854021iti.148.1529012652437;
        Thu, 14 Jun 2018 14:44:12 -0700 (PDT)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id u18-v6sm2183828iob.28.2018.06.14.14.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 14:44:11 -0700 (PDT)
Date:   Thu, 14 Jun 2018 17:44:05 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Juan Navarro <juan.navarro@gmx.es>
Cc:     git@vger.kernel.org
Subject: Re: (Bug report + fix) gitk "IgnCase" search doesn't ignore case
Message-ID: <20180614214405.GA26783@flurp.local>
References: <fc6b89c5-f0be-97c8-b0e1-247d9dd3e1f0@gmx.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc6b89c5-f0be-97c8-b0e1-247d9dd3e1f0@gmx.es>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 02:53:03PM +0200, Juan Navarro wrote:
> Gitk "find commit" search function doesn't follow the "IgnCase" option that
> is selectable with a combo selector on the right side of the window; it
> should be searching in a case-insensitive way, but it doesn't.
> 
> Steps to reproduce:
> [...]
> 3. In the "Find commit" bar, select "changing lines matching"
> 4. In the right side of the same bar, select "IgnCase"
> [...]
> 
> Proposed solution is almost trivial: check if the "IgnCase" option is
> enabled, and in that case add the flag "-i" to the git command. Now that we
> are at it, it's probably correct to add that option to all search modes.
> A diff is attached to this email, hoping that someone is able to apply it
> (sorry I'm not familiarized with contributing with patch files, but the diff
> is pretty small anyways).

Thanks for reporting this.

A different way to interpret the situation is that the user-interface
is being inconsistent. For instance, the "fields" pop-up next to the
"exact/ignore-case/regexp" pop-up does not seem to make sense for
search types other than "containing", so it probably ought to be
disabled for anything other than "containing". By extension, one could
argue that the "exact/ignore-case/regexp" pop-up also ought be
disabled for non-"containing" searches. The fact that they are not
disabled confuses people into thinking that they should be functional
for all searches, not just for "containing" searches, even though such
functionality was never implemented (and indeed, may be difficult to
implement fully).

Your proposed fix handles only the "ignore case" item; it does not
implement "regexp" functionality, so it could be considered
incomplete. A more complete fix would also disable the "regexp" item
to avoid misleading users, and to head off future bug reports similar
to this one saying that "regexp" doesn't work for non-"containing"
searches. (Bonus points for also disabling the "fields" pop-up for
non-"containing" searches when it's not applicable.)

Below is your fix wrapped up as a proper patch and sent in-line rather
than as an attachment. It's also slightly simplified by dropping the
unnecessary extra variable. You'll need to sign-off on the patch if it
is ever to be accepted. You can do so by adding it after my sign-off.
If you don't feel like re-sending the patch with your sign-off, you
can alternately reply to this email with a "Signed-off-by: Your Name
<your@email>" line.

Note, however, that the gitk project is, at best, deeply slumbering,
so it's not clear when or even if patches will be incorporated.
(Indeed, other recent gitk-related patches sent to the mailing list
have not yet been picked up.)

--- >8 ---
From: Juan Navarro <juan.navarro@gmx.es>
Subject: [PATCH] gitk: support "ignore case" for non-"containing" searches

The "Exact/Ignore Case/Regexp" pop-up control only affects "containing"
searches. Other types of searches ("touching paths", "adding/removing
strings", "changing lines matching") ignore this option. Improve the
user experience by also recognizing "ignore case" for non-"containing"
searches.

Note: This change only implements the "ignore case" option for these
other search types; it does not add support for the "regexp" option
(which still only affects "containing" searches). A more complete "fix"
would improve the user experience even more by making the UI more
consistent; namely, by disabling options which don't make sense or are
not easily implemented for non-"containing" searches. In particular, the
"regexp" pop-up item and the neighboring "fields" pop-up control ought
perhaps be disabled when a non-"containing" search is selected.

[es: wrote commit message; slightly simplified proposed "fix"]

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
diff --git a/gitk-git/gitk b/gitk-git/gitk
index a14d7a16b2..fbb75f7390 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4806,6 +4806,9 @@ proc do_file_hl {serial} {
 	# must be "containing:", i.e. we're searching commit info
 	return
     }
+    if {$findtype eq [mc "IgnCase"]} {
+	set gdtargs [linsert $gdtargs 0 "-i"]
+    }
     set cmd [concat | git diff-tree -r -s --stdin $gdtargs]
     set filehighlight [open $cmd r+]
     fconfigure $filehighlight -blocking 0
-- 
2.18.0.rc1.256.g331a1db143
