Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C561F453
	for <e@80x24.org>; Fri, 26 Oct 2018 23:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeJ0Hqr (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 03:46:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38085 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeJ0Hqr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 03:46:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id d10-v6so2831978wrs.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F92sOsA6vjMtdmgCX8WJcJR4oaDyQYZCJToAUDrYUI0=;
        b=OSolNkagVYrFH/kUx7kFmwwygWJy6fQf0CSNlPus710M3OwGuvBopDQ1/HuB54VChX
         bJrCJ0xsHTAP2FLul+cUqDvDbd+gy5CK0dR1pqJu6wz3ETaIj+DGW+jq59Cv/Mgy37Ah
         49p1wxKXgorOOpGb8Z2I+mSJ7RWfhyEvpuw0a5qsaa4i2K+mK53qdlrbuC4AvxhNCohf
         aOoCzKhVo0wQm6fhMHXCYiHMNdrKhqthlOQOF3IFuErPj+640cjX/TAQQj2KDqVw5t97
         vPqNNqLcDbULPxD6/1Mf8SpflKx+vpfgF67yhlf5mH8LmCvGzmK6TgxbyZF8VfjZppCw
         ls4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F92sOsA6vjMtdmgCX8WJcJR4oaDyQYZCJToAUDrYUI0=;
        b=sAgiE4Hpz9rfx0A1RzumnMBSOb+BAogfujONSvRCDz/cc3IBJsAsHUexS0/zEJaFSu
         BDoxycmqZy+jWuCmgAdm31275U7Ge9TLxW3McYlUKfxAH6ly7Mt189NzMWrxjcQ7SI8t
         9nMV5vY3dRatnDsJnAd+MLin5NK9R1cDAYyGjv0WLUYnlXurVvqDP2orNIUydhDaxbDl
         S1/uCPuM5B8OKKVnAOwItKkEA+3MLZZvWaaexKelq4eSZAEr8JHwHvdHBS00Seqy01RU
         ZMS8/reGBU9gPMYSAsbm8tDBAJVo2l5y9qJRwwHnSaK3m6Ns8TieG/Lun5D7QYAfxXHb
         AIbQ==
X-Gm-Message-State: AGRZ1gI5WWnZfDt1PKEOQTi+cQ+srihjxUIOaEtOqOeYau17gBkDfAKg
        RpxguNJwE1Q6VNq+HTrSodGEEc9yP4Q=
X-Google-Smtp-Source: AJdET5e+nqtAIK7prRUEK2brGi0P7KmTLQDlEWJFuc/3VeUp4zGWqbS54t9nufqxH4S65CezvJB5Ew==
X-Received: by 2002:adf:8224:: with SMTP id 33-v6mr7154563wrb.160.1540595269503;
        Fri, 26 Oct 2018 16:07:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5632830wmt.16.2018.10.26.16.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 16:07:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/8] fixes for unqualified <dst> push
Date:   Fri, 26 Oct 2018 23:07:33 +0000
Message-Id: <20181026230741.23321-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181026192734.9609-1-avarab@gmail.com>
References: <20181026192734.9609-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After sending out v2 I noticed I didn't update the examples in a
couple of the commit messages, and figured I'd finish this up by
adding a patch to document how this works in the "git-push"
manpage. This behavior has never been properly documented. range-diff
with v2:
    
    1:  ca8eb6dc28 = 1:  ca8eb6dc28 remote.c: add braces in anticipation of a follow-up change
    2:  b0e15b6ff1 = 2:  b0e15b6ff1 i18n: remote.c: mark error(...) messages for translation
    3:  052fc5860e = 3:  052fc5860e push: improve the error shown on unqualified <dst> push
    4:  e6aa2e360f = 4:  e6aa2e360f push: move unqualified refname error into a function
    5:  57840952b2 ! 5:  dcf566e16e push: add an advice on unqualified <dst> push
        @@ -13,8 +13,10 @@
                 error: The destination you provided is not a full refname (i.e.,
                 starting with "refs/"). We tried to guess what you meant by:
         
        -        - Looking for a ref that matches newbranch on the remote side.
        -        - Looking at the refname of the local source.
        +        - Looking for a ref that matches 'newbranch' on the remote side.
        +        - Checking if the <src> being pushed ('v2.19.0^{commit}')
        +          is a ref in "refs/{heads,tags}/". If so we add a corresponding
        +          refs/{heads,tags}/ prefix on the remote side.
         
                 Neither worked, so we gave up. You must fully-qualify the ref.
                 hint: The <src> part of the refspec is a commit object.
    6:  a2d98855cc = 6:  92ff753437 push: test that <src> doesn't DWYM if <dst> is unqualified
    7:  4e1953da82 ! 7:  58eeb0f3f3 push: add DWYM support for "git push refs/remotes/...:<dst>"
        @@ -3,22 +3,44 @@
             push: add DWYM support for "git push refs/remotes/...:<dst>"
         
             Add DWYM support for pushing a ref in refs/remotes/* when the <dst>
        -    ref is unqualified, e.g.:
        +    ref is unqualified. Now instead of erroring out we support e.g.:
         
        -        git push origin refs/remotes/origin/master:upstream-master
        +        $ ./git-push avar refs/remotes/origin/master:upstream-master -n
        +        To github.com:avar/git.git
        +         * [new branch]            origin/master -> upstream-master
         
             Before this we wouldn't know what do do with
             refs/remotes/origin/master, now we'll look it up and discover that
             it's a commit (or tag) and add a refs/{heads,tags}/ prefix to <dst> as
             appropriate.
         
        +    The error message emitted when we still don't know what to do has been
        +    amended to note that this is something we tried:
        +
        +        $ ./git-push avar v2.19.0^{commit}:newbranch -n
        +        error: The destination you provided is not a full refname (i.e.,
        +        starting with "refs/"). We tried to guess what you meant by:
        +
        +        - Looking for a ref that matches 'newbranch' on the remote side.
        +        - Checking if the <src> being pushed ('v2.19.0^{commit}')
        +          is a ref in "refs/{heads,tags}/". If so we add a corresponding
        +          refs/{heads,tags}/ prefix on the remote side.
        +        - Checking if the <src> being pushed ('v2.19.0^{commit}')
        +          is a commit or tag in "refs/remotes/*". Then we infer a
        +          corresponding refs/{heads,tags} on the remote side.
        +
        +        None of those worked, so we gave up. You must fully-qualify the ref.
        +        hint: The <src> part of the refspec is a commit object.
        +        hint: Did you mean to create a new branch by pushing to
        +        hint: 'v2.19.0^{commit}:refs/heads/newbranch'?
        +
             I'm bending over backwards and assuming that someone might have hacked
             in remote tracking tags (see [1] for a discussion of how that can be
             done), but punting on any tree or blob objects found under
             refs/remotes/*.
         
             This is the first use of the %N$<fmt> style of printf format in
        -    the *.[ch] files in our codebase, but it's supported by POSIX[2] and
        +    the *.[ch] files in our codebase. It's supported by POSIX[2] and
             there's existing uses for it in po/*.po files, so hopefully it won't
             cause any trouble. It's more obvious for translators than to have a
             3rd argument to the function identical to the 2nd, by re-using the 2nd
    -:  ---------- > 8:  bc171b0312 push doc: document the DWYM behavior pushing to unqualified <dst>

Ævar Arnfjörð Bjarmason (8):
  remote.c: add braces in anticipation of a follow-up change
  i18n: remote.c: mark error(...) messages for translation
  push: improve the error shown on unqualified <dst> push
  push: move unqualified refname error into a function
  push: add an advice on unqualified <dst> push
  push: test that <src> doesn't DWYM if <dst> is unqualified
  push: add DWYM support for "git push refs/remotes/...:<dst>"
  push doc: document the DWYM behavior pushing to unqualified <dst>

 Documentation/config.txt   |   7 +++
 Documentation/git-push.txt |  27 ++++++++
 advice.c                   |   2 +
 advice.h                   |   1 +
 remote.c                   | 124 +++++++++++++++++++++++++++++--------
 t/t5505-remote.sh          |  57 +++++++++++++++++
 6 files changed, 193 insertions(+), 25 deletions(-)

-- 
2.19.1.759.g500967bb5e

