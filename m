Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93BC6202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbdIVQdy (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:33:54 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:47840 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752108AbdIVQdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:33:51 -0400
Received: by mail-pf0-f172.google.com with SMTP id u12so797485pfl.4
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EMSgCoqV1BShMEoePZSB2E2GvT25rX4xChqsTnf5t9E=;
        b=j28z8Y8wyGcM7ldRNGQ0pbH8MNFCYZgQ/4wl25q3mDIMTKm4y7jwf+lVKmPPs3tagp
         j+5J6UWFJltVV745Dy3p4J+9ltsmBIUm6QgP232bILAQxlgzT0cNp0PXjjP9rPLP+O+u
         KgZD6HqY/9QxfT6wxb0mZq4w/YtsLIxSAIM1+MF0OyhpweA55QD9dEU+FPQ7UApwfwr8
         OOF7D5LXAMJi/XwiMIhmOEdUcy1V4tXlxrkay8tScIWwXbkgsphD71kUciTykcwY/w+q
         Z1zCEpf4KGJYxtpWVbajJ3iFObi+IsyisXkSS2HIxZUNI3hcGyiO2UnBHMUMF52YKX4+
         R56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EMSgCoqV1BShMEoePZSB2E2GvT25rX4xChqsTnf5t9E=;
        b=a/CE1dga4AMNf4OehLAmeNMLjfTeRDu7Vw+ED6F3FKKaLvL8agxbWhAjp2KyPZvAHj
         g95cgPEIdcZnbtTgssoPo1inOFTETfPCaZgTxBG3Aw95/HSCIRcU23jTcZnNX+5Z2w32
         WP4rvbB/dhcWXeSfk/TdAwF5dC5m2IIr3E8goEz+iygtycO236HIg4XxJfWwyhjBNoag
         QnDMP3bHdO91ZmeIE9skD44kSNwu2IB9O7L3ZvO1YeHUiPlGJaOWUy1ZHtYEMMLV+ebF
         FbJXlCDlGJenxD6R92Ta+BVJkxfobkqB3xQ4MfcTwKVbBh8g+A6PVXIgedQE94Euh8hA
         XVrg==
X-Gm-Message-State: AHPjjUgt84wUaGOH9jC6+nAYGc9OiHR+3FVeB+cJBKsIFp0auET4WVuq
        5mLLyWL8GAEyLEZfxSY7q7ccYFFAGEY=
X-Google-Smtp-Source: AOwi7QB9e9lwshbsUub4JTH/vPkEIaOWHAQJVyGpiL6Nu0I369oP9f/h8uzfjxwSQjah5n+8wT1bdg==
X-Received: by 10.98.149.69 with SMTP id p66mr9966511pfd.199.1506098030939;
        Fri, 22 Sep 2017 09:33:50 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1986:3ebf:8c68:2a02])
        by smtp.gmail.com with ESMTPSA id z24sm361433pfk.3.2017.09.22.09.33.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 09:33:49 -0700 (PDT)
Date:   Fri, 22 Sep 2017 09:33:48 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/3] branch: fix "copy" to never touch HEAD
Message-ID: <20170922163348.GC77641@google.com>
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
 <20170705231454.15666-1-avarab@gmail.com>
 <xmqq60f6h03t.fsf@gitster.mtv.corp.google.com>
 <xmqqvakbjpo5.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvakbjpo5.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/22, Junio C Hamano wrote:
> When creating a new branch B by copying the branch A that happens to
> be the current branch, it also updates HEAD to point at the new
> branch.  It probably was made this way because "git branch -c A B"
> piggybacked its implementation on "git branch -m A B",
> 
> This does not match the usual expectation.  If I were sitting on a
> blue chair, and somebody comes and repaints it to red, I would
> accept ending up sitting on a chair that is now red (I am also OK to
> stand, instead, as there no longer is my favourite blue chair).  But
> if somebody creates a new red chair, modelling it after the blue
> chair I am sitting on, I do not expect to be booted off of the blue
> chair and ending up on sitting on the new red one.
> 
> Let's fix this before it hits 'next'.  Those who want to create a
> new branch and switch to it can do "git checkout B" after doing a
> "git branch -c B", and if that operation is so useful and deserves a
> short-hand way to do so, perhaps extend "git checkout -b B" to copy
> configurations while creating the new branch B.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Let's send an updated one as a follow-up to the discussion thread
>    that it is a follow-up to.  The patch in this message is the same
>    as the one I previously sent; the proposed log message has been
>    updated somewhat.
> 
>  builtin/branch.c  |  9 +++------
>  t/t3200-branch.sh | 10 +++++-----
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 89f64f4123..e2e3692838 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -506,12 +506,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  				oldref.buf + 11);
>  	}
>  
> -	if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf)) {
> -		if (copy)
> -			die(_("Branch copied to %s, but HEAD is not updated!"), newname);
> -		else
> -			die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
> -	}
> +	if (!copy &&
> +	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
> +		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
>  
>  	strbuf_release(&logmsg);
>  
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 5d03ad16f6..be9b3784c6 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -422,7 +422,7 @@ test_expect_success 'git branch --copy is a synonym for -c' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'git branch -c ee ef should copy and checkout branch ef' '
> +test_expect_success 'git branch -c ee ef should copy to create branch ef' '

The new wording seems to be missing something.  Maybe it should read:
  
  'git branch -c ee ef should copy branch ee to create branch ef'

>  	git checkout -b ee &&
>  	git reflog exists refs/heads/ee &&
>  	git config branch.ee.dummy Hello &&
> @@ -431,7 +431,7 @@ test_expect_success 'git branch -c ee ef should copy and checkout branch ef' '
>  	git reflog exists refs/heads/ef &&
>  	test $(git config branch.ee.dummy) = Hello &&
>  	test $(git config branch.ef.dummy) = Hello &&
> -	test $(git rev-parse --abbrev-ref HEAD) = ef
> +	test $(git rev-parse --abbrev-ref HEAD) = ee
>  '
>  
>  test_expect_success 'git branch -c f/f g/g should work' '
> @@ -494,12 +494,12 @@ test_expect_success 'git branch -C c1 c2 should succeed when c1 is checked out'
>  	git checkout -b c1 &&
>  	git branch c2 &&
>  	git branch -C c1 c2 &&
> -	test $(git rev-parse --abbrev-ref HEAD) = c2
> +	test $(git rev-parse --abbrev-ref HEAD) = c1
>  '
>  
> -test_expect_success 'git branch -C c1 c2 should add entries to .git/logs/HEAD' '
> +test_expect_success 'git branch -C c1 c2 should never touch HEAD' '
>  	msg="Branch: copied refs/heads/c1 to refs/heads/c2" &&
> -	grep "$msg$" .git/logs/HEAD
> +	! grep "$msg$" .git/logs/HEAD
>  '
>  
>  test_expect_success 'git branch -C master should work when master is checked out' '
> -- 
> 2.14.1-929-g25eae544e9
> 

The rest of the patch lgtm.  I agree that this is probably a better UI
than without this patch.  Especially since the vanilla behavior of git
branch is to create a new branch without moving you to that new branch.

-- 
Brandon Williams
