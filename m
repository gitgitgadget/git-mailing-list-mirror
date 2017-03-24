Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B421FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754161AbdCXXHD (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:07:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35780 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbdCXXHB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:07:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id n11so597978pfg.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 16:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BN3DKiJRGFrguw05uf1RRnI6l7GOoZYBaBKnbRlhakg=;
        b=odZuy5f026QD8pYMuyXwGEb2vHDpPN3GF/boO35NSghs2UDQXoZe19SsO5lYQg5//8
         rt/vt+38Hx+vsdA5AvqmwZfulPGwEBA6JFJuIUQQenO/NK6W6MBtydR+w95mXA5bsGLM
         gG7Tr78HZLiTPbvcgO/SL+T/tyqhUgl5/dju1gWCQXuQga1ScFL4mxfe9lWVCZvl5fUH
         muVe2UhC0uenTUHGgJJgy6RjEMNLfX/ri+O/k2IupgWNzganJ52iKz9MevWUcEt4cxMz
         I+hLMfjLOXeVgrgh0h/0DhOUfmnkWH1tkr2NrYlBJPG3oy0YrXHa838BgmcvquKkfuSA
         u8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BN3DKiJRGFrguw05uf1RRnI6l7GOoZYBaBKnbRlhakg=;
        b=L29WHDomrBAli3KLeIZogkd2WfdlUx+1iHRr5BT1uT1DLydeJ3O0ht+vZ/J7lZqFl3
         UmCpEKGpEa4bfX0rA3K4BYPwNjDgrcq0euKX1qlf2K+/GSyBR5zXtheM5tcVhc17UXJU
         9Bzj2gDo03Lhu5ZGPrBgEgymqA6AsoPd2xbDL4kQ2cnxyTgp3kyU4SH89E8dR/AWO1X6
         ls9VnMe5kDRyZwp1FZVtPNTl7FDc+yZUxre354o0vkDauGVPUgDm11BmVh4ZoddN+tkV
         cw6a0C04KW2Ynjka5cxJjBTRKPf0aFF7xliLBrpOXBO94iPSCs3Jqsz0OlxhYcg3mA1y
         AuBw==
X-Gm-Message-State: AFeK/H3o64PXjKF6WVWPmtWxSF1qe+xDX+IHsHr8TQXpsLoHL6HG971Spfc0Ol07vjD/1A==
X-Received: by 10.98.78.7 with SMTP id c7mr11950918pfb.138.1490396820222;
        Fri, 24 Mar 2017 16:07:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id l1sm6625168pfk.8.2017.03.24.16.06.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 16:06:59 -0700 (PDT)
Date:   Fri, 24 Mar 2017 16:06:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 6/7] short status: improve reporting for submodule changes
Message-ID: <20170324230657.GK31294@aiede.mtv.corp.google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
 <20170324182902.19280-7-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324182902.19280-7-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> +++ b/wt-status.c
> @@ -431,10 +431,19 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
>  		}
>  		if (!d->worktree_status)
>  			d->worktree_status = p->status;
> -		d->dirty_submodule = p->two->dirty_submodule;
> -		if (S_ISGITLINK(p->two->mode))
> +		if (S_ISGITLINK(p->two->mode)) {
> +			d->dirty_submodule = p->two->dirty_submodule;

This is to simplify because dirty_submodule is just going to stay as 0
in the !S_ISGITLINK(p->two->mode) case, right?

>  			d->new_submodule_commits = !!oidcmp(&p->one->oid,
>  							    &p->two->oid);
> +			if (s->status_format == STATUS_FORMAT_SHORT) {
> +				if (d->new_submodule_commits)
> +					d->worktree_status = 'M';
> +				else if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
> +					d->worktree_status = 'm';
> +				else if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> +					d->worktree_status = '?';
> +			}
> +		}

Makes sense.

This patch also goes past the right margin.  Maybe this code to compute
d->worktree_status could be its own function?

With or without such a change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/wt-status.c w/wt-status.c
index 9909fd0e57..0375484962 100644
--- i/wt-status.c
+++ w/wt-status.c
@@ -407,6 +407,16 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 	strbuf_release(&twobuf);
 }
 
+static char short_submodule_status(struct wt_status_change_data *d) {
+	if (d->new_submodule_commits)
+		return 'M';
+	if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+		return 'm';
+	if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+		return '?';
+	return d->worktree_status;
+}
+
 static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
@@ -435,14 +445,8 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			d->dirty_submodule = p->two->dirty_submodule;
 			d->new_submodule_commits = !!oidcmp(&p->one->oid,
 							    &p->two->oid);
-			if (s->status_format == STATUS_FORMAT_SHORT) {
-				if (d->new_submodule_commits)
-					d->worktree_status = 'M';
-				else if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-					d->worktree_status = 'm';
-				else if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-					d->worktree_status = '?';
-			}
+			if (s->status_format == STATUS_FORMAT_SHORT)
+				d->worktree_status = short_submodule_status(d);
 		}
 
 		switch (p->status) {
