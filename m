Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE83C2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 15:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758203AbcKCP5Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 11:57:25 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35951 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756406AbcKCP5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 11:57:24 -0400
Received: by mail-ua0-f175.google.com with SMTP id b35so42947029uaa.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=huF/qaWGXvVGdXVJ60C2uuc/r1awyC/Zlu//W3S9EbE=;
        b=cGNo6RMjBDqGRIT18epCaV6mbGodpPXgSEdTeauBqx86vTGCIM5QDKZFxAUUC93lDS
         P9hYjgAemN48gJAezz576l/+lmhBP8mYOlmYcfBTKzje2kEa2EiG1nTZ1qET2cC7lTsm
         VA6ejuYHN8FrBk8yXCBfmFRygw+bg965AauGXjlCnrH6PTs45pVLOtqfkMcx9vwttTMj
         VB2JZz1HDXu/u8Xer1uI9T6frA6K8eob2uOyXsIpszYYL02tnyBEyropdDIQoAMpbjWi
         5BsWcswJmR3LWTB6qbSRGflKW9i7WtFFl/HzNtGwntDPu916gk/dY+HUmZMn4JHegoEk
         wXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=huF/qaWGXvVGdXVJ60C2uuc/r1awyC/Zlu//W3S9EbE=;
        b=muRqcWEGoWLG2UxVWRWv/7lfz8yUmVb3j0kFlgjb61vGO+maQ9mPvSvGblm3tNeHvC
         ztHH3k1v2vAsnX3J5H7hS6KgB9bxmbEvyRePl80PuE29l+X4LizWSOMsezCKwLY35KY1
         DMydBMYWKlcc1SjyTjDxDExDl02jiOvLPUtSuQWI14PplvtCga1ZMxRzoSQb9fQBgNUa
         QgEi4Ur56Fj+lohTDF30gzOedUsu9kemRQBVuWl5xxtar5zTP0mSfhMLlcLZK37kbUZ9
         EXk2ZlyQZSDCMGN1fqBtQzmtNrKBFszrXZYcQJoDMu7GXuFCREy0ttNP4697OxQWNrGj
         m4jg==
X-Gm-Message-State: ABUngvfJTizWm0IJVO/iDxIKI5xpbiJx9hnyI5eItwcCd6+MaW7X69r9NlfwtenXP5R5U00xOaSyLLGV8N+qUw==
X-Received: by 10.176.82.161 with SMTP id v30mr7566348uav.23.1478188643718;
 Thu, 03 Nov 2016 08:57:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.205.131 with HTTP; Thu, 3 Nov 2016 08:57:23 -0700 (PDT)
From:   John Rood <mr.john.rood@gmail.com>
Date:   Thu, 3 Nov 2016 10:57:23 -0500
Message-ID: <CALj-rGcSrbAiyxPOYD1KCacK_gqi3T5_R=e0H_UfBTqLb5VRmg@mail.gmail.com>
Subject: ignore blank line removals
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the contents of a file initially are:
  one

  three
and on branch A there is a commit, removing the blank line:
  one
  three
and on branch B there is a commit, adding 'two':
  one
  two
  three
Normally, if you try to merge A into B (or B into A), git recognizes a
decision needs to be made between removing the second line or add
"two" to the second line. It would be convenient to have a merge
strategy that defaults to the latter in cases where the removed line
was a blank line (or a line containing only whitespace) ...something
like -Xignore-blank-line-removals.
