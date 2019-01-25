Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6621F453
	for <e@80x24.org>; Fri, 25 Jan 2019 15:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfAYPdy (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 10:33:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39983 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYPdy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 10:33:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so6978055wmf.5
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UnsyPtmRbzYvk/OH83dVLMcBfnAb3KlWimhoKXzeDuI=;
        b=pdCe2nIDQdzvcuc2M2VBW4vqkBBYhaBkWWYSt3r/uJpTKTWJAOuHgXbOC0fpZXE5c2
         Msqx6L67xzCkD5FRZd+oeR+xkuNC4C5K/O/eCSZJhtzD8opkLT6UmhPJDSYgystgPaBr
         5bPvMROhuvBGpW0IKbeVvmBlrJhIzUVUrRu7ocH19tU5UFYGzNRwB3rsRs3CHZCoWuSB
         3TpZjpC8Xe34QuLVve/rawd2p02oJ4xDIF/S3TDSUVsGUoAizgV6pmBeobT/7MvkKcQg
         r+3os7oJ6sFFLn495VgdltnzEsDvBI35Gxar2BsMZMS+dTCF2wjFSBlS2LnpxfNDswgg
         U1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UnsyPtmRbzYvk/OH83dVLMcBfnAb3KlWimhoKXzeDuI=;
        b=YNXgPUJZWtUjqd4XoxuMJk4nDhBpzVfQDvnpMisXbKLdkGoOIm5+n6ONblulE4ULiH
         f5QBnaPk16JQAJIGEkTkHHtX84lYuOOP1FQPHtke/NscmwMLl4GPI9vK8vghfgCtbHOk
         HJgswYP26Pr2ikWpWpJErKB8d8sfs4IRG15rImEpQ1ARzIyheCWoB+0skVNOrEn10/gz
         z5kR+/0mbGoyD0jjo/xV+msmPh11/AhaM2Q2BxidmHXFLm8iJxvX+WqpzNEmR56EBOj+
         f8CnuppGq5AuJiFCbALNmrrCyQBMTELo+pJM7od4o+/WsipHiVwqCVX5TIlOgiDII/Nd
         qFoA==
X-Gm-Message-State: AJcUukcPzRWzQeQzPBx6SxAXpg5txgLHCKm8teKqfTSzuXJh5mtt/ymF
        uiWqPn37JCbvMFPl2Vi6OA+okxcf
X-Google-Smtp-Source: ALg8bN5kIJHvJ+ZCQZmjwNEfHxZPFTvTAuG54VazNvhMN8GZ+JEGb5eItYCoDtsuMLpuoZ18YvNBjw==
X-Received: by 2002:a1c:bbd6:: with SMTP id l205mr6870172wmf.97.1548430431516;
        Fri, 25 Jan 2019 07:33:51 -0800 (PST)
Received: from szeder.dev (x4db9b7c2.dyn.telefonica.de. [77.185.183.194])
        by smtp.gmail.com with ESMTPSA id 67sm164573325wra.37.2019.01.25.07.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 07:33:50 -0800 (PST)
Date:   Fri, 25 Jan 2019 16:33:48 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Regression in: [PATCH on sb/more-repo-in-api] revision: use commit
 graph in get_reference()
Message-ID: <20190125153348.GF6702@szeder.dev>
References: <20181204224238.50966-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181204224238.50966-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 02:42:38PM -0800, Jonathan Tan wrote:
> When fetching into a repository, a connectivity check is first made by
> check_exist_and_connected() in builtin/fetch.c that runs:
> 
>   git rev-list --objects --stdin --not --all --quiet <(list of objects)
> 
> If the client repository has many refs, this command can be slow,
> regardless of the nature of the server repository or what is being
> fetched. A profiler reveals that most of the time is spent in
> setup_revisions() (approx. 60/63), and of the time spent in
> setup_revisions(), most of it is spent in parse_object() (approx.
> 49/60). This is because setup_revisions() parses the target of every ref
> (from "--all"), and parse_object() reads the buffer of the object.
> 
> Reading the buffer is unnecessary if the repository has a commit graph
> and if the ref points to a commit (which is typically the case). This
> patch uses the commit graph wherever possible; on my computer, when I
> run the above command with a list of 1 object on a many-ref repository,
> I get a speedup from 1.8s to 1.0s.
> 
> Another way to accomplish this effect would be to modify parse_object()
> to use the commit graph if possible; however, I did not want to change
> parse_object()'s current behavior of always checking the object
> signature of the returned object.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This is on sb/more-repo-in-api because I'm using the repo_parse_commit()
> function.
> 
> A colleague noticed this issue when handling a mirror clone.
> 
> Looking at the bigger picture, the speed of the connectivity check
> during a fetch might be further improved by passing only the negotiation
> tips (obtained through --negotiation-tip) instead of "--all". This patch
> just handles the low-hanging fruit first.
> ---

I stumbled upon a regression that bisects down to this commit
ec0c5798ee (revision: use commit graph in get_reference(),
2018-12-04):

  $ ~/src/git/bin-wrappers/git version
  git version 2.19.1.566.gec0c5798ee
  $ ~/src/git/bin-wrappers/git commit-graph write --reachable
  Computing commit graph generation numbers: 100% (58994/58994), done.
  $ ~/src/git/bin-wrappers/git status
  HEAD detached at origin/pu
  nothing to commit, working tree clean
  $ ~/src/git/bin-wrappers/git -c core.commitGraph=false describe --dirty
  v2.20.1-833-gcb3b9e7ee3
  $ ~/src/git/bin-wrappers/git -c core.commitGraph=true describe --dirty
  v2.20.1-833-gcb3b9e7ee3

It's all good with only '--dirty', but watch this with '--all
--dirty':

  $ ~/src/git/bin-wrappers/git -c core.commitGraph=false describe --all --dirty
  remotes/origin/pu
  $ ~/src/git/bin-wrappers/git -c core.commitGraph=true describe --all --dirty
  remotes/origin/pu-dirty

IOW if the commit-graph is enabled, then my clean worktree is reported
as dirty.

And to add a cherry on top of my confusion:

  $ git checkout v2.20.0
  Previous HEAD position was cb3b9e7ee3 Merge branch 'jh/trace2' into pu
  HEAD is now at 5d826e9729 Git 2.20
  $ ~/src/git/bin-wrappers/git -c core.commitGraph=true describe --all --dirty
  tags/v2.20.0

It's clean even with '--all' and commit-graph enabled, but watch this:

  $ git branch this-will-screw-it-up
  $ ~/src/git/bin-wrappers/git -c core.commitGraph=true describe --all --dirty
  tags/v2.20.0-dirty

Have fun! :)


>  revision.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/revision.c b/revision.c
> index b5108b75ab..e7da2c57ab 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -212,7 +212,20 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
>  {
>  	struct object *object;
>  
> -	object = parse_object(revs->repo, oid);
> +	/*
> +	 * If the repository has commit graphs, repo_parse_commit() avoids
> +	 * reading the object buffer, so use it whenever possible.
> +	 */
> +	if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT) {
> +		struct commit *c = lookup_commit(revs->repo, oid);
> +		if (!repo_parse_commit(revs->repo, c))
> +			object = (struct object *) c;
> +		else
> +			object = NULL;
> +	} else {
> +		object = parse_object(revs->repo, oid);
> +	}
> +
>  	if (!object) {
>  		if (revs->ignore_missing)
>  			return object;
> -- 
> 2.19.0.271.gfe8321ec05.dirty
> 
