Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA3F1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeJ0Pwr (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:52:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52228 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeJ0Pwp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:52:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so3401821wmw.2
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=915H310ZcLEQH40QOx7mrEWXgoa/EsB9/+sT71j69wY=;
        b=cep8tzfaEAI0Bav9X00sztYMiHiuD8mljYC31YgfmKyyYuiLnwV1I8IT+jOrG2Xv2N
         LMzgUWdypQqOJuP1eufSoZk1qoKZkOY45EU0Y6gU+s2Rv8keAFyhc9lxuttjb7hFkMv3
         HODKDF8v33XxX/WibKYtlK63QyTTlWmwNila9TXEjZc6Bdd7xccKWOiUrOVs3yi5jbyZ
         FulcnfrFuVdLAlCrLJmKLSogmZR2N3ikFjauAUIE5GDDyfwduijm4tJC1UqBDfJiyjdm
         a5j0DPezeMHbFAx9RNioDXStkDjGgreYpRckfkJC5dKNXpg5ii1Zpf0JdMTFUwFShpYT
         DthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=915H310ZcLEQH40QOx7mrEWXgoa/EsB9/+sT71j69wY=;
        b=f/LDcvoKdyJ9DIpVinCgBiHHR5ZVcYa8bn6aXlqa7XjqnNGcAueTWYhpKz5XXo5ZaG
         aUgg7fu9t+m5VQuP9fE20FJCSKt+DKmyXyKd4uy0OB70kTP7dc5xrBU9oKjX83/AspZQ
         PQVKuMQWdC9foRvLoIZihhNIcrXuJpzphCy37OJfd+g/BFNtMgAKLFh438Eik965f3Pv
         SxMzZjgV8YNExqKA30Maaa1S8lz7Xo92qt8SCGiM8WamzxUIiBxgKy+3KGSfc3ic9bCV
         r9IJ2nQA94qazbrNQlgMeEpy6mUjT1enQUtevkFDVBWwmWT/S7aNhh+ZayHYe7Bw21Ao
         NiJQ==
X-Gm-Message-State: AGRZ1gLRl+zKbyZCzNiIl6FzCiKWjn8CleNrUGN2MAalO7hivPEeQzxu
        SQ4JexUtYkzUnbZpJ3jb27k=
X-Google-Smtp-Source: AJdET5fSCuUGqW49JiOlNb0Lx/cb3dIT0TJE+szNCwM1rb/CRAJ4v1vXKOqvY5E1Ze2IzF1lFRGuhA==
X-Received: by 2002:a1c:b30b:: with SMTP id c11-v6mr7359600wmf.150.1540624362495;
        Sat, 27 Oct 2018 00:12:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l4-v6sm18496122wrb.92.2018.10.27.00.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 00:12:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] Clear --exclude list after 'git rev-parse --all'
References: <20181023191758.15138-1-agruenba@redhat.com>
        <xmqqefcgotbk.fsf@gitster-ct.c.googlers.com>
        <CAHc6FU6YLeTBU02k-Md7+H5kJDq2RXZmAXMaq8ZkiuSmZFXbwQ@mail.gmail.com>
        <xmqqr2gfn1cy.fsf@gitster-ct.c.googlers.com>
        <CAHc6FU5CpBNpzfPs0hkNm9Hw1iYnALvUY4WL1z=sPVT10fq+zw@mail.gmail.com>
        <20181025104542.GA14455@sigill.intra.peff.net>
        <xmqqtvl9fv86.fsf@gitster-ct.c.googlers.com>
        <20181026074638.GA3119@sigill.intra.peff.net>
Date:   Sat, 27 Oct 2018 16:12:40 +0900
In-Reply-To: <20181026074638.GA3119@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 26 Oct 2018 03:46:38 -0400")
Message-ID: <xmqq5zxnc17b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I actually was hoping to see a test that contrasts "--all" (which
>> lacks the alleged "clear exclude" bug) with another option that does
>> have the "clear exclude", both used with rev-parse, i.e.
>> 
>>     $ git rev-parse --exclude='*' --glob='*' --glob='*'
>>     ... all the ref tips ...
>>     $ git rev-parse --exclude='*' --all --all
>>     ... ought to be equivalent, but is empty due to the bug ...
>> 
>> would have been a good demonstration that shows what bug we are
>> fixing d(and would have been a good test to accompany the patch.
>
> Yeah, I agree that would be fine, too. I think there are two dimensions
> in which to look at the problem, like so:
>
>          rev-list  rev-parse
>          --------  ---------
> --glob    clears    clears
> --all     clears    does not clear
>
> Testing either the row or the column (or both) works for me. :)

OK, so let's not leave this loose end untied.  This may be good
enough to squash in.

 builtin/rev-parse.c      |  1 -
 t/t6018-rev-list-glob.sh | 12 ++++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index f4847d3008..a1e680b5e9 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -760,7 +760,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--all")) {
 				for_each_ref(show_reference, NULL);
-				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (skip_prefix(arg, "--disambiguate=", &arg)) {
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index d3453c583c..b28075b65d 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -141,6 +141,18 @@ test_expect_success 'rev-parse accumulates multiple --exclude' '
 	compare rev-parse "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
 '
 
+test_expect_success 'rev-parse --branches clears --exclude' '
+	compare rev-parse "--exclude=* --branches --branches" "--branches"
+'
+
+test_expect_success 'rev-parse --tags clears --exclude' '
+	compare rev-parse "--exclude=* --tags --tags" "--tags"
+'
+
+test_expect_success 'rev-parse --all clears --exclude' '
+	compare rev-parse "--exclude=* --all --all" "--all"
+'
+
 test_expect_success 'rev-list --glob=refs/heads/subspace/*' '
 
 	compare rev-list "subspace/one subspace/two" "--glob=refs/heads/subspace/*"
