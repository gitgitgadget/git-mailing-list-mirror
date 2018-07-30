Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4301F1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeG3WWd (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:22:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54938 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbeG3WWc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:22:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so729882wmb.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ngC7t2gUzast8kEMCQKz7/EI5F328MfGRoPid3nVpz4=;
        b=fbG/GM1Lqn867CNeVDvxlQ9zAeXvUIj+tXQdvQ3qCaB73DjRf+NiD/IRFPzSymYtg0
         mducAYBl89e5enkiqSmi2yU6a+meEs3x8eEJQTRJKcVObgMmIfYihi/rkCnG3X28v3N0
         y+xxSSoPkxC69z5jedLXZyEdVzT44YK854iUq8E8VNsz0XIMSJGQs0u51AQKEesDNALm
         SNqxb2f5xQkN5QjSYOZ5tSajQbyLRaviQlilAu6K6vTt3YNMF/fdhjlNuYQXzn7dx3jV
         GS+41tmPA8iBrFtsJh4NaS61u9Ym4PtWUSXEzQjt2BGQdtG75H6v448VbkJuNcqMF8eW
         NTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ngC7t2gUzast8kEMCQKz7/EI5F328MfGRoPid3nVpz4=;
        b=MTTNSUA8rOGhD2PTRkkmRYbTSV+lik0FY9CZ6L6B2UKXVm2apKngle3WysVJJ0+WnY
         HU4pMjsIYfuiCZn7KfLt4Qb9xp0UBKZmKRF9WIBaHzXwJDXACYUI1dGlIbDbh68z/OpT
         6C3Iw2aPgf62W4ekweKsEBfH7K06+Nq43pZHaf+GyQAaFR5IwSGTi76MipOE18AOocJF
         u9GRW5Wwuy38yqxALs+CbG811M2s7yMBxZ2JAseE0FoS1fOAolP8Ck7raaPN/R+TgcS9
         NQTmW4ZVwO2pvuwiBxuzf7GsvGfV2JQ8VXgVTL8UTh+BKCvwG51VnDjHxKkf0QV7mpjY
         ZnNw==
X-Gm-Message-State: AOUpUlECM+D2W19TBC0cSzyS/nBmjEKEB+nZ5R0EKwzsAASQw30Zndqo
        FCsNgL/LA25HwkNmOYkwgzs=
X-Google-Smtp-Source: AAOMgpdAR6TjZnUEs0m0LlatP+nvpptrsP2SagN6lpkMI+i0dMsVbNrkm8je1M7rp7onyO3pi7qBxg==
X-Received: by 2002:a1c:28c2:: with SMTP id o185-v6mr498665wmo.40.1532983546711;
        Mon, 30 Jul 2018 13:45:46 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id t15-v6sm4502248wrn.34.2018.07.30.13.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:45:45 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:45:45 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 06/11] rerere: fix crash when conflict goes unresolved
Message-ID: <20180730204545.GH9955@hank.intra.tgummerer.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180714214443.7184-7-t.gummerer@gmail.com>
 <xmqqbmaohath.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmaohath.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/30, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Currently when a user doesn't resolve a conflict in a file, but
> > commits the file with the conflict markers, and later the file ends up
> > in a state in which rerere can't handle it, subsequent rerere
> > operations that are interested in that path, such as 'rerere clear' or
> > 'rerere forget <path>' will fail, or even worse in the case of 'rerere
> > clear' segfault.
> >
> > Such states include nested conflicts, or an extra conflict marker that
> > doesn't have any match.
> >
> > This is because the first 'git rerere' when there was only one
> > conflict in the file leaves an entry in the MERGE_RR file behind.  The
> 
> I find this sentence, especially the "only one conflict in the file"
> part, a bit unclear.  What does the sentence count as one conflict?
> One block of lines enclosed inside "<<<"...">>>" pair?  The command
> behaves differently when there are two such blocks instead?

Yeah as you mentioned below, conflict marker(s) that cannot be parsed
here would make more sense.  Will adjust the commit message.

> > next 'git rerere' will then pick the rerere ID for that file up, and
> > not assign a new ID as it can't successfully calculate one.  It will
> > however still try to do the rerere operation, because of the existing
> > ID.  As the handle_file function fails, it will remove the 'preimage'
> > for the ID in the process, while leaving the ID in the MERGE_RR file.
> >
> > Now when 'rerere clear' for example is run, it will segfault in
> > 'has_rerere_resolution', because status is NULL.
> 
> I think this "status" refers to the collection->status[].  How do we
> get into that state, though?
> 
> new_rerere_id() and new_rerere_id_hex() fills id->collection by
> calling find_rerere_dir(), which either finds an existing rerere_dir
> instance or manufactures one with .status==NULL.  The .status[]
> array is later grown by calling fit_variant as we scan and find the
> pre/post images, but because there is no pre/post image for a file
> with unparseable conflicts, it is left NULL.
> 
> So another possible fix could be to make sure that .status[] is only
> read when .status_nr says there is something worth reading.  I am
> not saying that would be a better fix---I am just thinking out loud
> to make sure I understand the issue correctly.

Yeah what you are writing above matches my understanding, and that
should fix the issue as well.  I haven't actually tried what you're
proposing above, but I think I find it nicer to just remove the entry
we can't do anything with anyway.

> > To fix this, remove the rerere ID from the MERGE_RR file in the case
> > when we can't handle it, and remove the corresponding variant from
> > .git/rr-cache/.  Removing it unconditionally is fine here, because if
> > the user would have resolved the conflict and ran rerere, the entry
> > would no longer be in the MERGE_RR file, so we wouldn't have this
> > problem in the first place, while if the conflict was not resolved,
> > the only thing that's left in the folder is the 'preimage', which by
> > itself will be regenerated by git if necessary, so the user won't
> > loose any work.
> 
> s/loose/lose/
> 
> > Note that other variants that have the same conflict ID will not be
> > touched.
> 
> Nice.  Thanks for a fix.
> 
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  rerere.c          | 12 +++++++-----
> >  t/t4200-rerere.sh | 22 ++++++++++++++++++++++
> >  2 files changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/rerere.c b/rerere.c
> > index da1ab54027..895ad80c0c 100644
> > --- a/rerere.c
> > +++ b/rerere.c
> > @@ -823,10 +823,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
> >  		struct rerere_id *id;
> >  		unsigned char sha1[20];
> >  		const char *path = conflict.items[i].string;
> > -		int ret;
> > -
> > -		if (string_list_has_string(rr, path))
> > -			continue;
> > +		int ret, has_string;
> >  
> >  		/*
> >  		 * Ask handle_file() to scan and assign a
> > @@ -834,7 +831,12 @@ static int do_plain_rerere(struct string_list *rr, int fd)
> >  		 * yet.
> >  		 */
> >  		ret = handle_file(path, sha1, NULL);
> > -		if (ret < 1)
> > +		has_string = string_list_has_string(rr, path);
> > +		if (ret < 0 && has_string) {
> > +			remove_variant(string_list_lookup(rr, path)->util);
> > +			string_list_remove(rr, path, 1);
> > +		}
> > +		if (ret < 1 || has_string)
> >  			continue;
> 
> We used to say "if we know about the path we do not do anything
> here, if we do not see any conflict in the file we do nothing,
> otherwise we assign a new id"; we now say "see if we can parse
> and also see if we have conflict(s); if we know about the path and
> we cannot parse, drop it from the rr database (because otherwise the
> entry will cause us trouble elsewhere later).  Otherwise, if we do
> not have any conflict or we already know about the path, no need to
> do anything. Otherwise, i.e. a newly discovered path with conflicts
> gets a new id".
> 
> Makes sense.  "A known path with unparseable conflict gets dropped"
> is the important change in this hunk.
> 
> > diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> > index 8417e5a4b1..34f0518a5e 100755
> > --- a/t/t4200-rerere.sh
> > +++ b/t/t4200-rerere.sh
> > @@ -580,4 +580,26 @@ test_expect_success 'multiple identical conflicts' '
> >  	count_pre_post 0 0
> >  '
> >  
> > +test_expect_success 'rerere with unexpected conflict markers does not crash' '
> > +	git reset --hard &&
> > +
> > +	git checkout -b branch-1 master &&
> > +	echo "bar" >test &&
> > +	git add test &&
> > +	git commit -q -m two &&
> > +
> > +	git reset --hard &&
> > +	git checkout -b branch-2 master &&
> > +	echo "foo" >test &&
> > +	git add test &&
> > +	git commit -q -a -m one &&
> > +
> > +	test_must_fail git merge branch-1 &&
> > +	sed "s/bar/>>>>>>> a/" >test.tmp <test &&
> > +	mv test.tmp test &&
> 
> OK, so the "only one conflict" in the log message meant just one
> side of the conflict marker.  More generally, the troublesome is
> to have "conflict marker(s) that cannot be parsed" in the file.
> 
> > +	git rerere &&
> > +
> > +	git rerere clear
> > +'
> > +
> >  test_done
