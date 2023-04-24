Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB23DC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 21:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjDXVcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjDXVcx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 17:32:53 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658CE5B90
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:32:52 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-187993bab0cso4017430fac.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682371971; x=1684963971;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feCPe9wY6yBXqmb/ZlnTmAD2MmxcgePzx+ntmqNXV70=;
        b=LM1o7ITourfEcP0k6qA63Te9GBMgxmmseIsDoFwdwTHkdyPf32tp1fTR9XUdXo+jbh
         2rbuj9P6/GwRp088JnLVGOxLqVcCC06I68IKtIEY0etbipBn9NrKabx1Q36TKQDWzJba
         +iTgkEyXtDFa3XpSB7PtJsC6t/ub9oTeb66Cf8OMLrUwvXpeU9p0RWBe+4Kxz2fP4mNH
         6MGp97IaX6xOaikiZ5shW9dmdcpWyRm4m/2x66VoRhL75QmzpOxLz4aop/5Qx40GLNfZ
         ndM05AqmfOr8X+lxbdotlY2Mk+DYqe8IDgdKTuzLdJfI73LV0KBVXfu4k58ew36dXY6d
         upjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682371971; x=1684963971;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feCPe9wY6yBXqmb/ZlnTmAD2MmxcgePzx+ntmqNXV70=;
        b=QPshHeqDCYNVV46BPiITuDlDHBIDqDyjCOxYuoAKqHO1Q3DmA4OcHI8Mx9rLwmsAA9
         O2i3eJnVGX3KxxioapZhHmJp0k1zlV2ktdose0z6uwGOKRuPfYCbevRqkyJ7TCaQ+xo+
         08PKlZWD5B4vP/+xX6ssenJfvO58iA838RZx4Uf1Iy6FYWfuGuiawhP/kmRxBWI0o9Dr
         jyBkNDb9Gbhc3FXD/QykIki+18pNaBSspSiiG4QTxkavmr8Mzc1HdJUmyXdc89/cTXlE
         aKWwBWPgzOCKLhPHIuOMD3BufoYIPwQx/dkHTEXl5XUwCV7GCqGk+r6HDFLB8kH1WAAC
         6T1g==
X-Gm-Message-State: AAQBX9fNR99jjxZQdQcmwFOwDiaNNV4ATi2V4s81xygSkkZk3ZB4Udyo
        uMhtC7YnCLy8Yalj+IZC+I73P33pKgE=
X-Google-Smtp-Source: AKy350ZLClBBz4SC3WcVb2MRql3vMlW6uIk3/QxztOhSF+JsJVy/3rXKOFNgV0ElOwMCFJamztZlTw==
X-Received: by 2002:a05:6871:b26:b0:180:3b6:82bd with SMTP id fq38-20020a0568710b2600b0018003b682bdmr9634360oab.33.1682371971599;
        Mon, 24 Apr 2023 14:32:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id x8-20020a4aaa08000000b00525240c6149sm5218372oom.31.2023.04.24.14.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 14:32:51 -0700 (PDT)
Date:   Mon, 24 Apr 2023 15:32:50 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     i o <lvsil4@outlook.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <6446f5824dd5d_cd6129459@chronos.notmuch>
In-Reply-To: <PA4PR09MB65161C38AEFBC07B3D7A1C62B0679@PA4PR09MB6516.eurprd09.prod.outlook.com>
References: <PA4PR09MB65161C38AEFBC07B3D7A1C62B0679@PA4PR09MB6516.eurprd09.prod.outlook.com>
Subject: Re: Proposal: adding --soft and --mixed options to git checkout
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

i o wrote:
> I suggest adding `--soft` and `--mixed` options to `git checkout`, that act
> similarly to the corresponding options of `git reset`, i.e. `git checkout
> --soft <tree-ish>` should move the HEAD to <tree-ish> without affecting the
> working tree or index, and `git checkout --mixed <tree-ish>` should move the
> HEAD to <tree-ish> and update the index to match it without changing the
> working tree.

In my opinion it's pretty clear `--soft` and `--mixed` were terrible names and
I suggested in the past to rename them to `--no-stage` and `--stage` [1]. We
should not repeat those mistakes with `git checkout`.

If the new options were:

 * git checkout --no-stage
 * git checkout --no-work-tree

I think it would be pretty clear what is intended without explanation (as
opposed to `--soft` and `--mixed`).

> The difference between this and `git reset` of course would be that, unlike
> the latter, this doesn't 'drag' the current branch along with HEAD; instead
> the usual behaviour would apply depending on what exactly <tree-ish> is, i.e.
> `git checkout [--soft|--mixed] <commit>` would detach HEAD and point it to
> <commit>,

In my mind the whole point of `git checkout` is to update the work-tree, if the
command is not going to do that, then I don't think it should be `git
checkout`.

In theory all these three would do the same, correct?

 * git checkout --no-stage --no-work-tree <commit>
 * git reset --no-stage --detach <commit>
 * git update-ref --no-deref HEAD <commit>

My preference would be `git reset --no-stage --detach <commit>`.

> whereas `git checkout [--soft|--mixed] <branch>` would move HEAD
> and switch from the current branch to <branch>.

If we are going to switch the current branch, then `git switch` makes more
sense:

 * git switch --no-stage <branch>

Then, for the case of a commit we could do:

 * git switch --no-stage --detach <commit>

The advantage of limiting ourselves to `git switch` is that it doesn't have the
historical of `git checkout`/`git reset`.

Cheers.

[1] https://lore.kernel.org/git/20130829180129.GA4880@nysa/

-- 
Felipe Contreras
