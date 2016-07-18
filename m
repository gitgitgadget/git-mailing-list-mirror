Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EF282018B
	for <e@80x24.org>; Mon, 18 Jul 2016 22:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbcGRWkJ (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 18:40:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33560 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbcGRWkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 18:40:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id i6so63288pfe.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 15:40:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YYEW9BeGSPf9GxLt3ihF1hOP7aoNGncSxUYpV2CMc1U=;
        b=ZbBxvSE9HjRDgWRlR6mP1JcNFqlxtNozpMNeebAwTIC2ZpzDwulHhP5waeWr6AoQtb
         bIwi80VFloWGpTThiSyw/qY3Eb06FwtB2dgEs1g/81YYz89Z9I8Y7B7m19fB4ljITd27
         xLfG5GImC79Fh3cJtv1PzA8WfXjrJPqjnHF9vnZV/vawnSaojVs7DpiNR3BdarHmBz0Y
         AswDur8dMle449xK3Uq0LifUW3WvH+GVNjXmEwdhzAjKE8jw0T+2QAFlBNyqYmnALru8
         Jh3VMFM3kk7neOXd+dD2Ji9QnO8kNIp/tnvvMp5sH6pVSeS2ea7ZUHOV6XR6dsHdaiTE
         3yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YYEW9BeGSPf9GxLt3ihF1hOP7aoNGncSxUYpV2CMc1U=;
        b=dwdMrv3gtmmi7yMaeMZjqnTIS/lBg4sW/tRZO2rDmtyPhgTBf6Tj6Jt9nkkxfL/kqu
         CjPrWUg1TprT/TNLTF0TJ+yZiWtUdNZ4ez6TPCfskx1ZPlsQAL96L6tIMQeo3A3I50sz
         qTSC4fc+ZdFnIKcjU2AVEVdIhTT5kwuXqXqyYSIfSZpKdXs0k5MKZii2yMs1zjWVDNJj
         mLzymeCy5DLtzzb38y4mj2oFo+ez9cLYEkbiAihdO17G2+Tq9jXqqcitDqJyonCVcc3P
         zpuZClRMIp6yUakoBIH/2WkRT4NZgfH26Jiug6REVxZ6MnNWUA8ZZXGz/z+iph9NHxJD
         t98w==
X-Gm-Message-State: ALyK8tL76LNP0WOb6F3ZJNV1mAR+RqoVODL9JqjsEk3nfvPQDSEWcxa54u+FjkR4OVW5Wg==
X-Received: by 10.98.135.13 with SMTP id i13mr50107613pfe.44.1468881607363;
        Mon, 18 Jul 2016 15:40:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9154:f831:1491:8d12])
        by smtp.gmail.com with ESMTPSA id d5sm7310006pfa.44.2016.07.18.15.40.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Jul 2016 15:40:06 -0700 (PDT)
Date:	Mon, 18 Jul 2016 15:40:04 -0700
From:	Jonathan Nieder <jrnieder@gmail.com>
To:	Jonathan Tan <jonathantanmy@google.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: Re: [PATCH v2] fetch-pack: grow stateless RPC windows exponentially
Message-ID: <20160718224004.GE29326@google.com>
References: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com>
 <1468880498-30235-1-git-send-email-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468880498-30235-1-git-send-email-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonathan Tan wrote:

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks again.
