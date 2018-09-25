Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00221F453
	for <e@80x24.org>; Tue, 25 Sep 2018 21:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeIZD01 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 23:26:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43751 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeIZD00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 23:26:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id z14-v6so7298047wrs.10
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1xEL2woNfG6Dkh66gNSt56hCz2gVS9L1/qWW9wj1eDk=;
        b=NCHlg7FaIFeJeAJmyD+xGOIRo11MOB2O+8GcAaJejF3qF7UYbMuGfZ8mVKsQh0JSlR
         VxS5oOooHQwTzi3EwxVLykg9dAVeFdDqx+HGUO3nkJ2xHecTdaphly6h84ZdfcBzc2S2
         0C9j+S59R3DxX4O5vjxtQR+wshutaOftd7Y5TnRjuqQ7RlgzV7mX0ZcoRTk4n/Pg/v9v
         RrNySAy/yXUhqGj05xMrXXQyUMF39Zk4APEiz3u65oc3wX7iC4vj8SntO7AziHpv8e5d
         p6gpxufxxWpPSJO/Y7PiXQeYni2lWstmtcpt79xQl4kWuwbqewQLy0FGOB97IOzJikFn
         AjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1xEL2woNfG6Dkh66gNSt56hCz2gVS9L1/qWW9wj1eDk=;
        b=kBCMZCcpnyPt/MwwMVt3tDoNde41WoeZgOloetjG9NoiCxo8i8s2QIGpt9tb36iGCH
         SyHiYeUgye+Z5SMphSSO1KBTsHieYQfE6PRl4SaalAUPZIOgQmr0TRiWEoNdJEQ6sQDS
         NnpuXCYerapiO10vLnQDya5SISmu3UFp/9S/Uk2ctHvPTgaI4sztMxkaeKNTevhbnwjt
         CZg7ztCva0QyykinmhH0fi1nnp9D7rGWj9mwTGyMUb2pQLdM4W63Wq7f6t97ovyysJFN
         ELfTGiQrTr4gldfzLt3n4ph817qFKfMn/qjf6/Z6/L1UZLk6GmFOnurvLuksEY2dIKVt
         sc8w==
X-Gm-Message-State: ABuFfohiYbtMNfTP3+aigGK7CeFfvZpGi8oSbwLnMLv0gIS8jZZdNq5l
        xs2JfPSwGrNYJW6vRiRcNuo=
X-Google-Smtp-Source: ACcGV60qhEVhYmKTO9zlCafVusrtx438l7A94s+Y8uq3lRc7h2lBE1radI7qY4e8tIYN0p0ObcLyQA==
X-Received: by 2002:adf:f701:: with SMTP id r1-v6mr2605903wrp.85.1537910215037;
        Tue, 25 Sep 2018 14:16:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j66-v6sm5219841wrj.28.2018.09.25.14.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:16:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] refs: new ref types to make per-worktree refs visible to all worktrees
References: <20180922180500.4689-1-pclouds@gmail.com>
        <20180922180500.4689-4-pclouds@gmail.com>
Date:   Tue, 25 Sep 2018 14:16:53 -0700
In-Reply-To: <20180922180500.4689-4-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 22 Sep 2018 20:04:55 +0200")
Message-ID: <xmqqy3bpnupm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The main worktree has to be treated specially because well.. it's
> special from the beginning. So HEAD from the main worktree is
> acccessible via the name "main/HEAD" (we can't use
> "worktrees/main/HEAD" because "main" under "worktrees" is not
> reserved).

I do not quite follow.  So with this, both refs/heads/master and
main/refs/heads/master are good names for the master branch (even
though the local branch names are not per worktree), because
in the main worktree, refs/bisect/bad and main/refs/bisect/bad ought
to mean the same thing.

	side note: Or is this only for pseudo-refs
	(i.e. $GIT_DIR/$name where $name consists of all caps or
	underscore and typically ends with HEAD)?  Even if that were
	the case, I do not think it essentially changes the issue
	around disambiguation that much.

The disambiguation rule has always been: if you have a confusingly
named ref, you can spell it out fully to avoid any ambiguity, e.g.
refs/heads/refs/heads/foo can be given to "git rev-parse" and will
mean the tip of the branch whose name is "refs/heads/foo", even when
another branch whose name is "foo" exists.

Would we have a reasonable disambiguation rules that work well with
the main/ and worktrees/* prefixes?  When somebody has main/HEAD branch
and writes "git rev-parse main/HEAD", does it find refs/heads/main/HEAD
or $GIT_DIR/HEAD, if the user is in the main worktree?

It could be simply that the design is underdocumented in this patch
set (in which case I would have appreciated 'RFC' near 'PATCH'), but
I have a feeling that the code came way too early before such design
issues are fleshed out.

> diff --git a/refs.h b/refs.h
> index bd52c1bbae..9b53dbeae8 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -704,9 +704,11 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
>  int ref_is_hidden(const char *, const char *);
>  
>  enum ref_type {
> -	REF_TYPE_PER_WORKTREE,
> -	REF_TYPE_PSEUDOREF,
> -	REF_TYPE_NORMAL,
> +	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
> +	REF_TYPE_PSEUDOREF,	  /* refs outside refs/ in current worktree */
> +	REF_TYPE_MAIN_PSEUDOREF,  /* pseudo refs from the main worktree     */
> +	REF_TYPE_OTHER_PSEUDOREF, /* pseudo refs from other worktrees       */
> +	REF_TYPE_NORMAL,	  /* normal/shared refs inside refs/        */
>  };
>  
>  enum ref_type ref_type(const char *refname);
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 416eafa453..bf9ed633b1 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -149,6 +149,23 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
>  	return refs;
>  }
>  
> +static void files_reflog_path_other_worktrees(struct files_ref_store *refs,
> +					      struct strbuf *sb,
> +					      const char *refname)
> +{
> +	const char *real_ref;
> +
> +	if (!skip_prefix(refname, "worktrees/", &real_ref))
> +		BUG("refname %s is not a other-worktree ref", refname);
> +	real_ref = strchr(real_ref, '/');
> +	if (!real_ref)
> +		BUG("refname %s is not a other-worktree ref", refname);
> +	real_ref++;
> +
> +	strbuf_addf(sb, "%s/%.*slogs/%s", refs->gitcommondir,
> +		    (int)(real_ref - refname), refname, real_ref);
> +}
> +
>  static void files_reflog_path(struct files_ref_store *refs,
>  			      struct strbuf *sb,
>  			      const char *refname)
> @@ -158,6 +175,12 @@ static void files_reflog_path(struct files_ref_store *refs,
>  	case REF_TYPE_PSEUDOREF:
>  		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
>  		break;
> +	case REF_TYPE_OTHER_PSEUDOREF:
> +		return files_reflog_path_other_worktrees(refs, sb, refname);
> +	case REF_TYPE_MAIN_PSEUDOREF:
> +		if (!skip_prefix(refname, "main/", &refname))
> +			BUG("ref %s is not a main pseudoref", refname);
> +		/* passthru */
>  	case REF_TYPE_NORMAL:
>  		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
>  		break;
> @@ -176,6 +199,11 @@ static void files_ref_path(struct files_ref_store *refs,
>  	case REF_TYPE_PSEUDOREF:
>  		strbuf_addf(sb, "%s/%s", refs->gitdir, refname);
>  		break;
> +	case REF_TYPE_MAIN_PSEUDOREF:
> +		if (!skip_prefix(refname, "main/", &refname))
> +			BUG("ref %s is not a main pseudoref", refname);
> +		/* passthru */
> +	case REF_TYPE_OTHER_PSEUDOREF:
>  	case REF_TYPE_NORMAL:
>  		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
>  		break;
> diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
> index 0c2d5f89a9..46ca7bfc19 100755
> --- a/t/t1415-worktree-refs.sh
> +++ b/t/t1415-worktree-refs.sh
> @@ -33,4 +33,34 @@ test_expect_success 'refs/local are per-worktree' '
>  	( cd wt2 && test_cmp_rev local/foo wt2 )
>  '
>  
> +test_expect_success 'resolve main/HEAD' '
> +	test_cmp_rev main/HEAD initial &&
> +	( cd wt1 && test_cmp_rev main/HEAD initial ) &&
> +	( cd wt2 && test_cmp_rev main/HEAD initial )
> +'
> +
> +test_expect_success 'resolve worktrees/xx/HEAD' '
> +	test_cmp_rev worktrees/wt1/HEAD wt1 &&
> +	( cd wt1 && test_cmp_rev worktrees/wt1/HEAD wt1 ) &&
> +	( cd wt2 && test_cmp_rev worktrees/wt1/HEAD wt1 )
> +'
> +
> +test_expect_success 'reflog of main/HEAD' '
> +	git reflog HEAD | sed "s/HEAD/main\/HEAD/" >expected &&
> +	git reflog main/HEAD >actual &&
> +	test_cmp expected actual &&
> +	git -C wt1 reflog main/HEAD >actual.wt1 &&
> +	test_cmp expected actual.wt1
> +'
> +
> +test_expect_success 'reflog of worktrees/xx/HEAD' '
> +	git -C wt2 reflog HEAD | sed "s/HEAD/worktrees\/wt2\/HEAD/" >expected &&
> +	git reflog worktrees/wt2/HEAD >actual &&
> +	test_cmp expected actual &&
> +	git -C wt1 reflog worktrees/wt2/HEAD >actual.wt1 &&
> +	test_cmp expected actual.wt1 &&
> +	git -C wt2 reflog worktrees/wt2/HEAD >actual.wt2 &&
> +	test_cmp expected actual.wt2
> +'
> +
>  test_done
