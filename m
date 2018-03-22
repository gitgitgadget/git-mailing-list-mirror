Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DAA1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeCVRBp (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:01:45 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:38910 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeCVRBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:01:41 -0400
Received: by mail-wr0-f174.google.com with SMTP id l8so9441556wrg.5
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vsZJlcHWMpeAZoPfB9+wx3l9d8gBcEo2MPAKQcc45dM=;
        b=LJaimKlfahdOwMVl93TNbOjsjkJ5FnCSOg9DLG3ABUGOhI+lltm+F7V05QFvcRIQ1H
         HXjV9TUmkLWHDny2N8pNMxDs4rxWGALwFZJPoikLW5qankaQMUuiBZTqrclp5hdScfoA
         z52doIt7mm/vIxzA3huDZUfSTyhoNGs18Ni99LxB4W3zwRmqxi5mS8uFdAU0dI8thpGA
         R8thhfgNOVFdR2/8Up7jk4DAkJf7TospvZ50DbUj5NcBx+FcKri2NqmjY5xP02Dk6T6R
         wZsbzJ4BveIQ8YqSVQmPqxiLUUBuJaBW5EFB8hOsmda0Lk+Z9E80iccJU/I+D4ottkQg
         OBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vsZJlcHWMpeAZoPfB9+wx3l9d8gBcEo2MPAKQcc45dM=;
        b=jJytuEK3JUuM8Ai+UGQtp2hCAbhHGqgeWIsVAB1ltnQLid1tXc3F3/PBE+yktAEScQ
         WMGBu+bzg/HMGWJGYaF8wN8lBIaIh5hIbiSYpit+88Lzg73eMDgyreuPtKCZMk1zxtUR
         IAeZVDwVFvXsrONIAi1FtZF+NULwG7OKSmtf2rui423sfy9Q7LGX5J6AOSMlfKMx8NQz
         jgNQwAlQ1pB1Ym/DM7DAggNgXc8Wtt6G2EnIksSkLXaxGwBu0v1PpBVJzcCTJm4wEqKq
         A79Hv5nrZWBu0keS05EQ40JlMOyFaHyoEftJhvjkrjINu1ET2sbm5V7AA0zsQNXfQBxV
         cJww==
X-Gm-Message-State: AElRT7EmRdKGu54rFSkEGtEwl18xx2gB8xmunVAVnRUxaB/uKgfG4DXS
        fLcZLAn2rH6yoW6ziQqrlCgqD0n/
X-Google-Smtp-Source: AG47ELsMzRvCh+LL0nvQ+gpeN6NhUx+u14o5ZNf9nuLMf2BskG5oFJ2jhyTBIKq+9LlU/4z/GElZtw==
X-Received: by 10.223.162.203 with SMTP id t11mr21504447wra.88.1521738098459;
        Thu, 22 Mar 2018 10:01:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e136sm1464036wmd.10.2018.03.22.10.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 10:01:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuki Kokubun <orga.chem.job@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] filter-branch: consider refs can refer to an object other than commit or tag
References: <xmqqpo3xnqq4.fsf@gitster-ct.c.googlers.com>
        <xmqqwoy5pcno.fsf@gitster-ct.c.googlers.com>
        <20180321103504.9483-1-orga.chem.job@gmail.com>
        <1521646299-16193-1-git-send-email-orga.chem.job@gmail.com>
        <5ab2b606.86f5620a.c0c10.41b3@mx.google.com>
        <5ab3bd79.d14d650a.be5c0.8544@mx.google.com>
Date:   Thu, 22 Mar 2018 10:01:36 -0700
In-Reply-To: <5ab3bd79.d14d650a.be5c0.8544@mx.google.com> (Yuki Kokubun's
        message of "Thu, 22 Mar 2018 14:26:10 +0000")
Message-ID: <xmqq370sm4cv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuki Kokubun <orga.chem.job@gmail.com> writes:

>> Yuki Kokubun <orga.chem.job@gmail.com> writes:
>> 
>> >> Yuki Kokubun <orga.chem.job@gmail.com> writes:
>> >> 
>> >> > "git filter-branch -- --all" can be confused when refs that refer to objects
>> >> > other than commits or tags exists.
>> ...
>
> I meant the confusion is abnormal messages from the output of "git filter-branch -- --all".

OK, so it is not that the program logic gets confused and ends up
performing a wrong rewrite, but mostly that it gives confusing
messages.

> For example, this is an output of "git filter-branch -- --all":
>
> Rewrite bcdbd016c77df3d5641a3cf820b2ed46ba7bf3b4 (5/5) (0 seconds passed, remaining 0 predicted)
> WARNING: Ref 'refs/heads/master' is unchanged
> WARNING: Ref 'refs/heads/no-newline' is unchanged
> WARNING: Ref 'refs/heads/original' is unchanged

These are worth keeping, as I think existing users expect to see
them.

> error: object 1bf53b49c26465454e4ac377f2ed3f91bb1d6ac1 is a tree, not a commit
> error: object 1bf53b49c26465454e4ac377f2ed3f91bb1d6ac1 is a tree, not a commit
> fatal: ambiguous argument 'refs/replace/8a2016f3730cad8309c110f819c855403ed0a5b9^0': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> WARNING: Ref 'refs/replace/8a2016f3730cad8309c110f819c855403ed0a5b9' is unchanged
> WARNING: Ref 'refs/tags/add-file' is unchanged
> WARNING: Ref 'refs/tags/file' is unchanged
> error: object 1bf53b49c26465454e4ac377f2ed3f91bb1d6ac1 is a tree, not a commit
> error: object 1bf53b49c26465454e4ac377f2ed3f91bb1d6ac1 is a tree, not a commit
> fatal: ambiguous argument 'refs/tags/treetag^0': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> WARNING: Ref 'refs/tags/treetag' is unchanged

I think these warning messages should be kept, especially if we are
to keep the warning messages for the unchanged branches.  However,
the internal error messages are unwanted--these are implementation
details that reach the conclusion, i.e. the ref we were asked to
rewrite ended up being unchanged hence we did not touch it.

However, if we pre-filter to limit the refs in "$tempdir/heads" to
those that are committish (i.e. those that pass "$ref^0") like the
patch and subsequent discussion suggests, wouldn't we lose the
warning for these replace refs and non-committish tags.  We perhaps
could do something like:

	git rev-parse --no-flags ... >"$tempdir/raw-heads" || exit

	while read ref
	do
		case "$ref" in ^?*) continue ;; esac
		if git rev-parse --verify "$ref^0" 2>/dev/null
                then
			echo "$ref"
		else
			warn "WARNING: not rewriting '$ref' (not a committish)"
		fi
	done >"$tempdir/heads" <"$tempdir/raw-heads"

(note: the else clause is new, relative to my earlier suggestion).
