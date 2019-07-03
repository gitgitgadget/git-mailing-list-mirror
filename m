Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C451F461
	for <e@80x24.org>; Wed,  3 Jul 2019 00:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfGCAg4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 20:36:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46782 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfGCAgz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 20:36:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so531973oid.13
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 17:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iXSksdUcIjPbKraUPsfKguPmUWVdWyt9kRg+N+WYc4w=;
        b=YmwvV7tc9/pWmEnR9doTZGrSUK544GOnfbi/PvRm1b3RkqOVQsyAyhpBUPGqx7q+Jm
         KCvGH8/w+vUnXNAmFUt714K48MbKbVBDO/00WvXQhH6WtnnjxNmDc8HZwZ5x+W6C917U
         FHrvGgCGnUp/QCTZkYoMT7rr517sSyO/bhG7QO56+2+i48qYZvWyJA8g2QrrxxhclbGE
         xotK9GxsvfWVRAuIhqhCk5Ss04PE2W8bn7/JRXeK3Imydtma8sK4GfKSDO5WvKW7yLn6
         QSTkwdA+4phaWAVVhWOgU0rCaKccmtZWOoW0Fj/r0X5A+1I9IXCYWKch6ShilByphiid
         7ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXSksdUcIjPbKraUPsfKguPmUWVdWyt9kRg+N+WYc4w=;
        b=kMasfw5eWSklZN5mh4kQ4S+1txZJ+NydG/b8mclJ7ZVHaj9nni4GvQX+jfVt9OSCe/
         +UVs79kWndkFvG5nzQLCLRgsrHP6LyY+OQyl9/vyFKxTuehSJmxBgrcrLuy8GorO4+M2
         /aL7zADMzt/bbo5biPmbAf+Al/wFnQSXKXQOoegruUyCetFHlaymHaGVR2GG3V1Q1WgK
         OO7Hr1rN54WiziXURFJjogjb65/H9MW6bftFgrE6mrd5iCHv5EEToJ84EEFXvPaVGW3D
         M6iN9uL2evqRLRY5y+hcdCdYiktuc0W4AQgDa/h98RG1FwHGN6QezAWEPGb+BnGmNPe9
         7+QQ==
X-Gm-Message-State: APjAAAXv+1oGMNlq0pLVR6xzqHyLtivs/Xd43VwCjHXzWCtlsrnxYMNr
        suTNUmiMwu8rxI90cXlVupo6MVyR7wsPdA==
X-Google-Smtp-Source: APXvYqw0sYGqfrNmFyc6ZWRkXTB6wpZS3jZlR+nOzSZembvQt1vrMlz63QN/9jn+71q1jtAAndqnVQ==
X-Received: by 2002:a65:5202:: with SMTP id o2mr30922070pgp.199.1562112602806;
        Tue, 02 Jul 2019 17:10:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id c10sm142966pjq.14.2019.07.02.17.10.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 17:10:02 -0700 (PDT)
Date:   Tue, 2 Jul 2019 17:09:57 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
Message-ID: <20190703000957.GB121233@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <xmqqk1d02nv5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1d02nv5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 02, 2019 at 01:16:46PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
> > +			for (struct ref *it = remote_refs; it; it = it->next)
> > +				switch (it->status) {
> > +				case REF_STATUS_NONE:
> > +				case REF_STATUS_UPTODATE:
> > +				case REF_STATUS_OK:
> > +					it->status = REF_STATUS_ATOMIC_PUSH_FAILED;
> > +				default:
> > +					continue;
> > +				}
> > +		}
> 
> 
> Let's write this more like so
> 
> 		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
> 			for (struct ref *it = remote_refs; it; it = it->next)
> 				switch (it->status) {
> 				case REF_STATUS_NONE:
> 				case REF_STATUS_UPTODATE:
> 				case REF_STATUS_OK:
> 					it->status = REF_STATUS_ATOMIC_PUSH_FAILED;
> 					break;
> 				default:
> 					break;
> 				}
> 		}
> 
> to prevent compilers from giving "implicit fallthru" warnings.

Done, thanks.
