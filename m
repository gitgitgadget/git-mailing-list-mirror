Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE72C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586FD23433
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbgLPSzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732480AbgLPSzg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:55:36 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3705EC061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:54:56 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id j12so24049266ota.7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TC9GGqfrNieuVUyzCz8oXJ0ep+9DVdPdF97HWubM/sE=;
        b=V8QosneOuWpkEMdQY8mM1tHCFciMkKW/GnA7x8oZJrYWH9+g7jS5rOmXb2JtFtj4jV
         ZvPXyvrm95KXq5EpMl2wzWVPurDQw63GGlS2RUO3TDXF+vctTEw2mLfq5wDYAYd72I9L
         O+PlzLQ7boxVeNqwf5NwGXPp4LWbId+VRh7QMUc5neM1wHxdw7K+KTFoVwa3smcydrhP
         zt/HKeiQnrOwP+9LtZXVG9jkUgmH3RPGz3KZh/CM8GsH+kJHLe70l7R7fKr1KSYN6zAr
         F8qhpwhtIHVXbuRTr8JX4ZNrKn2yFNNRpx9zo2VoqrBMmNcvZKzJYGrY0Q26MYM8Otor
         jJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TC9GGqfrNieuVUyzCz8oXJ0ep+9DVdPdF97HWubM/sE=;
        b=drWOIEyx1sJD2aYqy0SIfNlISM1imePALKVovPXe5S02TvEhnHNLmsAQVdIN4A/nxG
         i+5MEVpC8W2AFBMXuy+xtF3wVjhTW7i560vmTOeVYQVIWZhKjywdUUXuksfwkO8051Jq
         XlIwZ2aeXWwg/E4LZyHJJtDJbXVx+hnMJ5GnKrV9j7dYwRhhSAa+urYI/9GGqNExsCF2
         xPpF5uYF56ZdfALBTJlGJpWu7C5AlRlDjmDRnl34DUS6EDoZ3nmXv1J0Nvffza/+pJao
         tW2cif+hUZGkTQxOls1X5bPM4W+a1i25orBICamW5285NKAiti+ISUxD3P4aiWvIY7Vl
         DhvQ==
X-Gm-Message-State: AOAM530XZx6Jmj9puxZ+SowqfmcNyAxdNtyLKM3//8BsVhnF8nt9MKIS
        StJPts5kSHS7LBkacNTAKHs=
X-Google-Smtp-Source: ABdhPJyTXsZLYXjnhjZddvpamnwYbzyk0ccDIUo1dz29GfUU9lccI31yL8PICUj6IwN7YUhaAodj7Q==
X-Received: by 2002:a9d:22ca:: with SMTP id y68mr26123028ota.22.1608144892458;
        Wed, 16 Dec 2020 10:54:52 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 109sm629057otj.12.2020.12.16.10.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:54:51 -0800 (PST)
Date:   Wed, 16 Dec 2020 12:54:50 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Message-ID: <5fda57fa7bfd1_74ba20875@natae.notmuch>
In-Reply-To: <xmqqim914pfs.fsf@gitster.c.googlers.com>
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
 <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
 <4a4d9d29-ccba-8d39-a7cd-34b1ba785e22@gmail.com>
 <xmqqim914pfs.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH 1/3] merge-ort: copy a few small helper functions from
 merge-recursive.c
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > On 12/15/2020 12:53 PM, Elijah Newren via GitGitGadget wrote:
> >> From: Elijah Newren <newren@gmail.com>
> >> 
> >> In a subsequent commit, we will implement the traditional recursiveness
> >> that gave merge-recursive its name, namely merging non-unique
> >> merge-bases to come up with a single virtual merge base.  Copy a few
> >> helper functions from merge-recursive.c that we will use in the
> >> implementation.
> >
> > I'm sure these are copies, but...
> >
> >> +static struct commit_list *reverse_commit_list(struct commit_list *list)
> >> +{
> >> +	struct commit_list *next = NULL, *current, *backup;
> >> +	for (current = list; current; current = backup) {
> >> +		backup = current->next;
> >> +		current->next = next;
> >> +		next = current;
> >> +	}
> >
> > The naming of 'next' seems backwards to me, since it is really
> > the "previous" node. Using something like 'previous' makes it
> > clear that you are reversing when you say
> >
> > 	current->next = previous;
> 
> Hmph.  I took "next" commit_list as "list is the original one, and
> next is the reversed list, the next generation of what we received".
> 
> Calling it "previous" feels even more backwards when you view among
> three "struct commit_list *" pointers, one (the one that holds the
> eventual return value) is primarily used to denote the resulting
> list itself, and the other two are used to point individual elements
> on the original list.

Both feel awkward to me because to me previous/next are actually current
in my mind, and we should return current, not previous/next. Plus
there's no need for current, we can use list, as your example.

This is what I came up with:

  struct commit_list *current = NULL;
  while (list) {
          struct commit_list *tmp = list->next;
          list->next = current;
          current = list;
          list = tmp;
  }
  return current;

For completeness I checked how Linux does it, and surprisingly
llist_reverse_order() is very close to what I came up with:

  struct commit_list *new_list = NULL;
  while (list) {
          struct commit_list *tmp = list;
          list = list->next;
          tmp->next = new_list;
          new_list = tmp;
  }
  return new_list;

(obviously translated)

Maybe it's just me, but I find my version easier to read.

Cheers.

-- 
Felipe Contreras
