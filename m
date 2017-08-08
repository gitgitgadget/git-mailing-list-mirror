Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12F3520899
	for <e@80x24.org>; Tue,  8 Aug 2017 20:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbdHHUp4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 16:45:56 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34238 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbdHHUpz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 16:45:55 -0400
Received: by mail-pg0-f45.google.com with SMTP id u185so19338025pgb.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wj3CNjxQ+e984+zJ40/h1l9o3MERPx/Ct1FfHhigux8=;
        b=nwYLYZ2HgcLBYCqPkbDrd4lsgiSo8Ob3udHjD3LzK4Q0VyugtzfSDpn8FUE27n8lhH
         t+l3zDSU7XsYYbF14PiKdZq58ay0+Ij9Ox3EGDBB+Bbk8+26eS47yqiKQwY4rd1dU/E+
         uX6ll2Ns5pC/kioy04BfNyd/BI5WlhnU4EvPwaWm769v/wKKpa0q7KvLrUi4inlyHOLr
         tF/WEajkPUdBcA6qsdhQfbmw5Dd+iHH/jx9+2j04vfmEApha7CABVsy/bnUVdx1cipAL
         HL5VVyTC57hXdR6OvttOVaLILdnlUIUWyz2FbAaBCmN9Eqfc49CqpVKkG4+/3kd4864w
         P6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj3CNjxQ+e984+zJ40/h1l9o3MERPx/Ct1FfHhigux8=;
        b=DNRNeoqFeHZ/BpufdriIVVGXedeYN72c0ZTiIEXNbrc8lLA54dy94FAbw30EHENmyM
         Otvz8kdRIY3Lqup5BZmzpE5QLw2WGdwRAZBknoWJ0IQ/WCg+kObHvk91GB857+4Nm6qU
         YuhTkoBR73e4+ewtOQeJtqnk+BRsBZju21b6wsXtopC+waMKTKawvc8tvfsFns5/hWVP
         Dyb0KwMIZRWvx1cupQH4YO9DaZngMYtsnvSgUG6yvoDn12qsfSQdeGpWJs6MneAl3lm8
         rBBNYd0Dk7E7amuhVZ4KxHyWElQPGlv7YUX+uXRMACDSGR0HG+o3auQJdgSGpke8ttbQ
         6+eQ==
X-Gm-Message-State: AHYfb5h003czN0lg79bdawPNo0QvzE2/UiRbA7tvMfAIaNmsNjkI1L0F
        MiBPae2D19xy9w0M7SmnuQ==
X-Received: by 10.99.116.77 with SMTP id e13mr5291699pgn.324.1502225154339;
        Tue, 08 Aug 2017 13:45:54 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:3038:f339:86a3:23e0])
        by smtp.gmail.com with ESMTPSA id n23sm4502684pfh.133.2017.08.08.13.45.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 13:45:54 -0700 (PDT)
Date:   Tue, 8 Aug 2017 13:45:51 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 04/10] pack: move open_pack_index(),
 parse_pack_index()
Message-ID: <20170808134551.440466b2@twelve2.svl.corp.google.com>
In-Reply-To: <xmqq8titbyno.fsf@gitster.mtv.corp.google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
        <cover.1502220307.git.jonathantanmy@google.com>
        <02e77a90110bdd6dad13c60aa08107b6345a60b9.1502220307.git.jonathantanmy@google.com>
        <xmqq8titbyno.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 08 Aug 2017 13:19:23 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> > ---
> >  builtin/count-objects.c |   1 +
> >  cache.h                 |   8 ---
> >  pack.c                  | 149 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  pack.h                  |   8 +++
> >  sha1_file.c             | 140 ---------------------------------------------
> >  sha1_name.c             |   1 +
> >  6 files changed, 159 insertions(+), 148 deletions(-)
> 
> This patch is a bit strange...
> 
> > diff --git a/pack.c b/pack.c
> > index 60d9fc3b0..6edc43228 100644
> > --- a/pack.c
> > +++ b/pack.c
> > ...
> > +static struct packed_git *alloc_packed_git(int extra)
> > +{
> > +	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
> > +	memset(p, 0, sizeof(*p));
> > +	p->pack_fd = -1;
> > +	return p;
> > +}
> > +
> > +struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
> > +{
> > +	const char *path = sha1_pack_name(sha1);
> > +	size_t alloc = st_add(strlen(path), 1);
> > +	struct packed_git *p = alloc_packed_git(alloc);
> > +
> > +	memcpy(p->pack_name, path, alloc); /* includes NUL */
> > +	hashcpy(p->sha1, sha1);
> > +	if (check_packed_git_idx(idx_path, p)) {
> > +		free(p);
> > +		return NULL;
> > +	}
> > +
> > +	return p;
> > +}
> 
> We see these two functions appear in pack.c
> 
> > diff --git a/sha1_file.c b/sha1_file.c
> > index 0de39f480..2e414f5f5 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > ...
> > @@ -1300,22 +1176,6 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
> >  	return p;
> >  }
> >  
> > -struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
> > -{
> > -	const char *path = sha1_pack_name(sha1);
> > -	size_t alloc = st_add(strlen(path), 1);
> > -	struct packed_git *p = alloc_packed_git(alloc);
> > -
> > -	memcpy(p->pack_name, path, alloc); /* includes NUL */
> > -	hashcpy(p->sha1, sha1);
> > -	if (check_packed_git_idx(idx_path, p)) {
> > -		free(p);
> > -		return NULL;
> > -	}
> > -
> > -	return p;
> > -}
> > -
> 
> And we see parse_pack_index() came from sha1_file.c
> 
> But where did alloc_packed_git() come from?  Was the patch split
> incorrectly or something?
> 
> When I applied the whole series and did
> 
>     git blame -s -w -M -C -C master.. pack.c
> 
> expecting that pretty much everything has come from sha1_file.c but
> noticed that some lines were actually blamed to a version of pack.c
> and these functions were among them.

alloc_packed_git() in pack.c is a duplicate of the function of the same
name in sha1_file.c in this patch, because at this patch, there are
still functions in both files using this function. A subsequent patch in
this patch set will remove it from pack.c.

I'll add a note explaining this to this patch in the next version.
