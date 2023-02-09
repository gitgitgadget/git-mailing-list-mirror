Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65201C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 09:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBIJJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 04:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjBIJJs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 04:09:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A03B59E73
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 01:09:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id br9so2298447lfb.4
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 01:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxK06NL26LZudWnTFVjiz+icg+c+o180Ji7d6gedUZ0=;
        b=lF83r9cYenKaJruNrvi5BTNipQoDuQHcuyRFgb92fZoiPFDTIXbmaZ8nNW7ZU3gE65
         c/xD7cGHfpH4Bc++kpTW8e/LMKT39FY5sONA0nuxSiWDA+wuGkYUgG9TIBvAMApbPMX4
         SZ6rdDcbKtNnvEIWEgCn2CliboMIC3yPz+FuEyR7zyDPn9ox243psXp8Yg/gYZ/uarUe
         dxA65XC1rQ0nPxLbXBSwwUAyUONKhgft05mQeKAt0d9KmhC1YIfxs9NEd5OBOjz5TdfW
         ofmYMiYQjAyQJHAMUXrQb0QNRplqMSK58pZYGw6oxGQ5LcfyijLMR+fSgbr7zGsoL/Gs
         DbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxK06NL26LZudWnTFVjiz+icg+c+o180Ji7d6gedUZ0=;
        b=rO3Vfab8biEAIMONZ4HTQvw3HJepLWmZhfi+dIpdOA/WCtavKzBMR+IDzUPDXNacVz
         0g7L51vhSortR0tifDH4babPKXoDo1YNMzTY/LS74NxMySmywAbDuLXFjGVK9LkWm3Zj
         fYxLKQRJKF0kuxShafRO7mKp5psmcxWxzMuN2sJzhO5yIwW0SFJuKdV7W16Gx9Jme6DS
         0McKcWksJnv+OJXneEaHpJAEgEsrZCKhBU86Jd8TmvK+wfYqxpwY8Dmdhf9EDlJot11U
         +rDHkLujwvTN2YEVfCfxxJgdg0IP0nPTL0GCfJMJKmAJFBo8e1Z9lpfXOUTKdqXf6EAh
         aWPQ==
X-Gm-Message-State: AO0yUKXQBBV9UP7KRZ4KKSPZ/TNLK1N1ikgMnaONkukkpf4SU5n1qjLM
        sBkFdOdO9YnC6JTIIRIFm5A+4ipQdLsw06G1wJuimn4S+P4=
X-Google-Smtp-Source: AK7set9CX+f5kDz2qW3YCqXzvdxuvdj1+uAiUqCzXzSkwaFzF3PDpvMkfncrgvqKvx/v6GTMU6lgNhKfJleb0H/EiqE=
X-Received: by 2002:ac2:5a0b:0:b0:4d2:381c:87dc with SMTP id
 q11-20020ac25a0b000000b004d2381c87dcmr1656768lfn.124.1675933783421; Thu, 09
 Feb 2023 01:09:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com> <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk> <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
In-Reply-To: <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Feb 2023 01:09:30 -0800
Message-ID: <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
To:     John Cai <johncai86@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John and Phillip,

On Tue, Feb 7, 2023 at 9:05 AM John Cai <johncai86@gmail.com> wrote:
>
[...]
> > Perhaps I'm over simplifying but having read the issue you linked to I couldn't help feeling that the majority of users might be satisfied by just changing gitlab to use the patience algorithm when generating diffs.
>
> Right, I recognize this is a judgment call that may be best left up to the list.
>
> We don't have a way in GitLab to change the diff algorithm currently. Of course
> that can be implemented outside of Git,

Well, the below doesn't allow users to make diffs better for
*individual* files of interest, but if you agree with me that we
should just make diffs better for all users automatically, it's a
two-line change in git.git that I'd love to eventually convince the
project to take (though obviously doing that would also require some
documentation changes and some good messaging in release notes and
whatnot).  I've used it for a good long while, and had a few dozen
users using this patch too, all without complaint:

diff --git a/diff.c b/diff.c
index 329eebf16a..77a46d5b7d 100644
--- a/diff.c
+++ b/diff.c
@@ -55,7 +55,7 @@ static int diff_relative;
 static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
-static long diff_algorithm;
+static long diff_algorithm = XDF_HISTOGRAM_DIFF;
 static unsigned ws_error_highlight_default = WSEH_NEW;

 static char diff_colors[][COLOR_MAXLEN] = {
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index b298f220e0..2f663eab72 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1549,7 +1549,7 @@ test_expect_success 'short lines of opposite
sign do not get marked as moved' '
        this line should be marked as oldMoved newMoved
        unchanged 4
        EOF
-       test_expect_code 1 git diff --no-index --color --color-moved=zebra \
+       test_expect_code 1 git diff --diff-algorithm=myers --no-index
--color --color-moved=zebra \
                old.txt new.txt >output && cat output &&
        grep -v index output | test_decode_color >actual &&
        cat >expect <<-\EOF &&


I used histogram above rather than patience, since (a) it's what git's
merge backend uses, (b) it produces roughly similar results to
patience from a user perspective, (c) past testing has shown it to be
somewhat faster than patience, and (d) we've potentially got some
leads in how to speed up our histogram implementation from the README
over at https://github.com/pascalkuthe/imara-diff.  But, if you really
wanted to use patience as the default, it'd also be an easy tweak.

Anyway, just some food for thought.
