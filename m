Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C860B1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 23:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfAHXWz (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 18:22:55 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:47523 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbfAHXWz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 18:22:55 -0500
Received: by mail-qt1-f202.google.com with SMTP id f2so4989581qtg.14
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 15:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YcX06erOLMuh6y+iKv1JGIW27Bff0QpTzNPJpSZ5RdM=;
        b=azQ/WU6s7j7rQpUyRpgWjWkV8M/k/kaUw/86DuhS09WwXuEtWuAKuyi28j40gXNsxV
         jBSaLfOMtqXb0KAb9cvLclFy86HlnAKoYcvDQGtPumFvLjyE58rbfW7FVh0JftUa6DDn
         UVezZqwJd3WndBycddZvEyY7dLPc9Z35Ri5AEEz/ZEuduOVzqHRyzbFv6DlOl2v0JjYO
         WUq9EaVoOIa6tvKbVH/4LgoOiv+qPE2qOYd/c4/+Z84c4Cqmm+l1HrEIXXL5vb1WNhcJ
         aag+fQg7Dp1Sv/xo+puhu5hzTGOOZ72jsbV/TKt9AnTPGTfbBK074MamGDl/XflelhZL
         3iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YcX06erOLMuh6y+iKv1JGIW27Bff0QpTzNPJpSZ5RdM=;
        b=cwr5LJInbFx2gn2h7VJXJYHNiAmF196Z4lUuJVW3F67x4whRuusY1ETbaGmcF6pAXH
         RbuZuorJg2a/3Xfxp3aotrRnm4o7shaIFrSXoRk5RmO7qgJAbCN21/SHVFUH3Rt3HHJh
         jFrqOGbx5j7emwf612onzahCUKXlvolhyEblLdO3iEV4hRJYptrWGp2ghoJALRArROZK
         aafDPhXN5IB/LKVZuXNb+BfinCP7i8gPMpY/W6qEY+qW4CB6oYAFLzba0loQfBOFMSXC
         zsGkh3wLPun5tVVj7lKh6cGchOhyr3Kmx/h0crj2TdfBSAW4guHMZ4YnYnPakVLjF7Tn
         zmHw==
X-Gm-Message-State: AJcUukfyLYM9u364XpM3Ol+Vu44ancMEdBP+STHv2E1h89LJLnbD9uk9
        4VDjhWEcb+o4h8ugD7WwG8S6BofOHIKh2qvUwNLb
X-Google-Smtp-Source: ALg8bN5bpUBSn6rhTwtirD8QIY64UGHuZsuF664Pf5MrADFQExukZvwR3MwkG2d6NsnosU1oShBWsCjVisDpCHHNcpT7
X-Received: by 2002:a37:717:: with SMTP id 23mr2500823qkh.1.1546989774625;
 Tue, 08 Jan 2019 15:22:54 -0800 (PST)
Date:   Tue,  8 Jan 2019 15:22:51 -0800
In-Reply-To: <20190108020034.23648-1-jonathantanmy@google.com>
Message-Id: <20190108232251.37748-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190108020034.23648-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 2/2] tree:<depth>: skip some trees even when collecting omits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     matvore@google.com, git@vger.kernel.org, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > -static void filter_trees_update_omits(
> > +static int filter_trees_update_omits(
> >  	struct object *obj,
> >  	struct filter_trees_depth_data *filter_data,
> >  	int include_it)
> >  {
> >  	if (!filter_data->omits)
> > -		return;
> > +		return 1;
> >  
> >  	if (include_it)
> > -		oidset_remove(filter_data->omits, &obj->oid);
> > +		return oidset_remove(filter_data->omits, &obj->oid);
> >  	else
> > -		oidset_insert(filter_data->omits, &obj->oid);
> > +		return oidset_insert(filter_data->omits, &obj->oid);
> >  }
> 
> I think this function is getting too magical - if filter_data->omits is
> not set, we pretend that we have omitted the tree, because we want the
> same behavior when not needing omits and when the tree is omitted. Could
> this be done another way?

Giving some more thought to this, since this is a static function, maybe
documenting it as "Returns 1 if the objects that this object references need to
be traversed for "omits" updates, and 0 otherwise" (with the appropriate code
updates) would suffice.
