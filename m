Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0206B1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 21:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438926AbeKWHyK (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 02:54:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56318 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438808AbeKWHyK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 02:54:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so10092541wmc.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 13:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2qeDZ+DchvlSnpSoyLMk4w34nuyuSH5fs5NbRv9wvL8=;
        b=fHG3NnX1fWDCso4CtI0JnBhN3/iqZNpRevAsDqa3fPr/hci+6TvtvnOE6wYUGJIeMn
         H6XKIii7X4o5QWEqlQxE9G3tV1qijuoRXrROdXufjztlZhZRnsV2iHgyv4iLEi8d/BHe
         QK64qTzGz+9d3iHMyMghUA5uDBQX8tUD9VpHhFvxNH8JR/GuQkJ1OFRwvBEqaZ+QsVSd
         W5Qz4mihql3USPPxLi03feuwM3VoW0i6ari8JhZ86FOWBzSIG01p59XHnyicUwBupa+2
         tB8H8aRJ3YTE5o9xqPkAIuSbsk/FushfLEPJwA0PfMKbJ+chlOSFKxH0ocC/6+sGvKd8
         PtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2qeDZ+DchvlSnpSoyLMk4w34nuyuSH5fs5NbRv9wvL8=;
        b=S5TcgZ6qQ8lITt6jujpNLJ3aaWgXbc3Dst/YNz0Qr+ulxBUDJByniBwGggSF0wLe46
         i+iUOsfJeY7qy58GlzvzORLN1ch2YrK5iM/Tf/eLmvleofrfN9EDKHpBkZzeAX1wpBTx
         hFSCiwH6OpyFBJkgSHzod+dtKRYwcg4rb+VrKTt8GNyW9CjUVhTxJEIECnz+MPeih+y9
         V4oppugIVQS/5w5vbyKQvv0i1IrCgFtt9z4CbmSMXXqK2kqupFrYG0OvvHleBi/xbS3J
         woMXPgi9PBp/VjljnUx71N3k9gfe9Mz4R90aphcp2obZLfYDSwWE+Q8KFao9ih7LRu76
         4mtA==
X-Gm-Message-State: AGRZ1gK9Pj0elHSBK/g+axE5gLWSfNMPGEpUbljbyO2nd8gGZLpraOOS
        xKVg7JhTba9lnf4iXHCj/T8UItz+VNA=
X-Google-Smtp-Source: AFSGD/XtQX847ErjEM5PXMWcnZNczBgSsIx2g2tAutIanUZLeOcAALW2JZcPMld/p0pU0JFWiUd15g==
X-Received: by 2002:a1c:e354:: with SMTP id a81mr10975848wmh.142.1542921179106;
        Thu, 22 Nov 2018 13:12:59 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 5sm8775229wmw.8.2018.11.22.13.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 13:12:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] format-patch: pre-2.20 range-diff regression fix
Date:   Thu, 22 Nov 2018 21:12:46 +0000
Message-Id: <20181122211248.24546-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com>
References: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Dropping LKML & git-packagers from CC]

On Thu, Nov 22 2018, Eric Sunshine wrote:

> On Thu, Nov 22, 2018 at 10:58 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> There's a regression related to this that I wanted to send a headsup
>> for, but don't have time to fix today. Now range-diff in format-patch
>> includes --stat output. See e.g. my
>> https://public-inbox.org/git/20181122132823.9883-1-avarab@gmail.com/
>
> Umf. Unfortunate fallout from [1].
>
>> diff --git a/builtin/log.c b/builtin/log.c
>> @@ -1094,9 +1094,12 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>>         if (rev->rdiff1) {
>> +               const int oldfmt = rev->diffopt.output_format;
>>                 fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
>> +               rev->diffopt.output_format &= ~(DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY);
>>                 show_range_diff(rev->rdiff1, rev->rdiff2,
>>                                 rev->creation_factor, 1, &rev->diffopt);
>> +               rev->diffopt.output_format = oldfmt;
>>         }
>>  }
>
> A few questions/observations:
>
> Does this same "fix" need to be applied to the --interdiff case just
> above this --range-diff block?
>
> Does the same "fix" need to be applied to the --interdiff and
> --range-diff cases in log-tree.c:show_log()?

No, that seems to do the right thing, but perhaps tests are lacking
there too. I haven't looked.

> Aside from fixing the broken --no-patches option[2], a goal of the
> series was to some day make --stat do something useful. Doesn't this
> "fix" go against that goal?

The goal was to fix the regression introduced in 73a834e9e2
("range-diff: relieve callers of low-level configuration burden",
2018-07-22). One aspect of having fixed that is we might in the future
do stuff with --stat.

> The way this change needs to be spread around at various locations is
> making it feel like a BandAid "fix" rather than a proper solution. It
> seems like it should be fixed at a different level, though I'm not
> sure yet if that level is higher (where the options get set) or lower
> (where they actually affect the operation).
>
> Until we figure out the answers to these questions, I wonder if a more
> sensible short-term solution would be to back out [1] and just keep
> [2], which fixed the --no-patches regression.

I think that patch leaves range-diff itself in a good state without
any bugs, and it would be a mistake to revert it.

But this interaction with format-patch --range-diff is another
matter. As noted in 2/2 I think in practice this series sweeps the
current bugs under the rug.

But as also noted there I think re-using what we get from
setup_revisions() in format-patch for the range-diff was a mistake,
and is always going to lead to some confusion. It should be split up
so we can supply those diff options independently.

> [...]
> [1]: https://public-inbox.org/git/20181113185558.23438-4-avarab@gmail.com/
> [2]: https://public-inbox.org/git/20181113185558.23438-3-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  format-patch: add a more exhaustive --range-diff test
  format-patch: don't include --stat with --range-diff output

 builtin/log.c         |  7 ++++++-
 t/t3206-range-diff.sh | 15 ++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.20.0.rc0.387.gc7a69e6b6c

