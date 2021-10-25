Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5762CC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368D0604E9
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhJYV3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhJYV3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:29:46 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F37C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:27:23 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id gh1so8127805qvb.8
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aXPM65nBx2SiViMEig1eggAn5964TqpQoYnOgSrtpyc=;
        b=jItrGNDoNy/UP10ThLAuXZg1tcDb6GCa+EOVHPSJS00SLGz9CE/uSz25y51AeILXJe
         TAVTcxoKU7wRYOfxSdjEYVyJFsLqqnLqY5XF3HwYfa9ffDU5GhwK9VIMoYLLD40YZsGc
         fG6vViYH8CoQIZGBHkRRUlIA9prLKwaZqQImF5RuILeUZYoxD3SHHeWBoZLxjo2hnYuN
         o9OdWN/5S4YAcwwYTS2e8xPVtKQteegiqaY2J8zI2qzccTcdYLPw/N00z/V3DDq2YCEj
         nbkg8ZCfv9VgDJQPo3xctt4zGVCf6KuOyXZRNQ7pEbXxt7aUfz9q2eSDpx2g1NylP9qo
         FbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXPM65nBx2SiViMEig1eggAn5964TqpQoYnOgSrtpyc=;
        b=YhBRnoogIn9ClIb/KtbiRstumOL1Oc+8sfg7r7orjZBQishkQrYbvtwEr0Q7oRKunQ
         d/O1Jr63noHlJ9FcpwPwrt7KblTpeIEOd0yOrGmrAKU1YR48qecrduSwU3/oHpbrtT+2
         rzOYOSKFzPECWMiKsocm7nOo/EXUsC3BOtNR8LMiDI7m1Ev2jIF7lVDjyA0VXIz8raXu
         Sr64b9IYuY72oDE3lt8+8cRIxmL6IJ2rtZCeaJyVeZjoSHYcdeSvwsGNzO3gHY0zUdj/
         YKhuRdkkJjEK/wgSYaEwajsQl6K+YONBpIe1+s85cIw1M45eRmy/HQV0NZq2IBwrM1NS
         03yQ==
X-Gm-Message-State: AOAM532ysmOv7aTJVUKP76KqSpkSMWojyziZsF+IeAaP3orI1fb41uQN
        C0aUK0qgpAiZf1mWfAsVN/BMcSEntA7dQA==
X-Google-Smtp-Source: ABdhPJwWfcGYyVXdLPy2J5XC1fjhCQmI9+QRhNh1VwxSSStkyXAnrhHi9Di4FD/rDB+1vNbfPFpR1g==
X-Received: by 2002:a05:6214:21a5:: with SMTP id t5mr10427496qvc.35.1635197242282;
        Mon, 25 Oct 2021 14:27:22 -0700 (PDT)
Received: from localhost.localdomain (bras-base-ktnron0919w-grc-11-76-71-43-238.dsl.bell.ca. [76.71.43.238])
        by smtp.gmail.com with ESMTPSA id bk13sm9288672qkb.58.2021.10.25.14.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:27:21 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org, carenas@gmail.com, gitster@pobox.com,
        bagasdotme@gmail.com, avarab@gmail.com
Cc:     tbperrotta@gmail.com
Subject: [PATCH v8 0/2] send-email: shell completion improvements
Date:   Mon, 25 Oct 2021 17:27:05 -0400
Message-Id: <20211025212707.188151-1-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <87fst7lkjx.fsf@evledraar.gmail.com>
References: <87fst7lkjx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> ...I think that re-indentation is better left alone for the patch
> readability.

Reverted the `GetOptions` indentation. Noise is now gone :-)

> First, in your 1/3 you're adding a \n, but in 2/3 we end up with \n\n. I
> think you can just skip 1/3, maybe mention "how it also has a "\n" in
> the commit message.

I don't quite see how this would fit into the commit message. A comment in the
code seems to fit better to account for this detail. That's what I did, but if
you still disagree, please elaborate where in the commit message this sentence
should be added.

> You then strip out "--" arguments from the combined list, but isn't this
> something we do need to emit? I.e. it's used as syntax by the bash
> completion isn't it? (I just skimmed the relevant C code in
> parse-options.c).

I interpreted that standalone `--` as an extraneous / useless token. If it's
there intentionally, then I am reverting my stripping of it. At the end of the
day whether to include it or not is a small detail, but FYI, when I do:

  $ git clone -<TAB>

in bash, nothing happens. I would have expected it to be expanded to "--"
because of the explicit "--", but it doesn't. Therefore my conclusion is that
"--" in the output of "--git-completion-helper" is useless. Am I missing
something? What would be the function of the standalone "--" then?

From my local testing, whether the options are sorted or not, whether
they are repeated or not, whether they follow a specific order with
respect to "--" or not, all of those details seem not to matter. Bash
completion seems to handle all of those cases just fine interactively.

In fact, here's another example:

$ git init --git-completion-helper | tr ' ' '\n'  | grep -C1 '^--$'
--no-template
--
--no-bare

...there are --no-* options both _before_ and _after_ the --. I really
cannot see the point of the -- in the output, it seems to be just noise.

I readded -- to the output anyway since you requested it, but if it
needs to follow a certain spec w.r.t. ordering, we should have tests for
it. This specific part (the -- and the --no- order thing) of the commit
is something I am not keen to doing though, at least not in this patch
series; sorry, it already goes far beyond the scope of my original
intent. Anything else you ask for that is inline with the original
intent (like generating options programatically instead of hard-coding
them) I am fine with though, and in fact I believe I have addressed all
comments so far, if there's anything else I may have missed let me know.

> I.e. we should not simply strip the trailing "=" etc., we need to parse
> those out of the Perl GetOptions arguments, and come up with mapping to
> what we do in parse-options.c. I think that's basically adding a "=" at
> the end of all options that end with "=s", ":i", "=d", ":s" etc.

OK, I see. This is a valid point, I updated the code to reflect this desired
behavior. PTAL. If needed we could make it more DRY, but as it is now it
seems quite readable.

> We then don't want to emit "-h", but you strip out "--h", first we
> mapped "h" to "--h" in the loop above, so we should do that there. But
> better yet we have a "%dump_aliases_options" already, maybe it +
> "git-completion-helper" can be moved to another "%not_for_completion"
> hash or something.

OK, done. Introduced a "not_for_completion" hash. Doesn't seem to make a
huge difference compared to just using `grep` though.


Differences from V7:

As per Ævar's comments:

- completely drop 1/3 since we'now using split instead of print to incorporate
  format-patch options. Side effect: then-extraneous '\n' is now gone.

- revert indentation (tabs) on GetOptions to eliminate diff noise (as per Ævar's
  interpretation of original Carlos's comment)

- re-add "--" to the output of "git send-email --git-completion-helper"

- introduce a "not_for_completion" hash to remove undesired options from the
  output

- add trailing = to send-email options that expect a string or an integer
  argument, consistently with format-patch options

Thiago Perrotta (2):
  send-email: programmatically generate bash completions
  send-email docs: add format-patch options

 Documentation/git-send-email.txt       |  6 ++-
 contrib/completion/git-completion.bash | 11 +----
 git-send-email.perl                    | 56 +++++++++++++++++++++-----
 t/t9902-completion.sh                  |  3 ++
 4 files changed, 54 insertions(+), 22 deletions(-)

-- 
2.33.1

