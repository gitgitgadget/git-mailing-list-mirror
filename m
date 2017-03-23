Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907D420323
	for <e@80x24.org>; Thu, 23 Mar 2017 00:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdCWAym (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 20:54:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34720 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbdCWAyl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 20:54:41 -0400
Received: by mail-pg0-f66.google.com with SMTP id w20so8204372pgc.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 17:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5BakMBgBTABZlVIC6UjM1yHI+0yTQpN37s5nq/5LEdU=;
        b=ETrhzrETM9li6GT37/+t8Su7TtbD8TNlHoxKR+7khq4G6q4mgKT+Z4LOaXEnnaQXha
         S0F3wmsKfa6t6aExY7XlfK5c0K/GB2PKbejJKRuJpF6XPlg/GgANdGXq14WJGf/1dCCV
         SCe+it9nlkXvoffgPALR563cKAQ2M5F071ctZjSXk2arMNDxbhF2e3YrjThhpvtrT1Pp
         tygDSh7Z+ETrJi9VW+dWT8oUOkUQiMTPApcc8WwDf0Ey38rNqP26V4Q8QzrxYyU8vT4u
         GYPp/0/ll3piJwpzy6Ep+9d/3OsjngrZKTvZTaogOBbU4HdSatIA2SoQ3fYAPGgyl+U7
         vJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5BakMBgBTABZlVIC6UjM1yHI+0yTQpN37s5nq/5LEdU=;
        b=lHrXbyOKSBa7swX/VTjsaAsi9SzRd1Ql5mY4QSjhW0cn6uXjQtMYMopgWYJKaFxhdd
         ezh/CfGVITtE1cgRDgC0COGoGO+iwFVmqTDQD9M9hNwxBpVMlT0yeL35WqKWrSIPDgIL
         tGQYQ3ZQo9wG7nGmT1Bw5XMlifaCKFZiuHc1Js9jPXKYRDZadBw8NvozWXQG/1GJafMM
         DV4/BmnOtfIA22s3PVGYtG4gQi3nJq6YjOzz0ufh1AOMrDz96MAwcFCbiOJD6iAUGAEH
         csq1vKQqs1ZNaZLxNvIYqn7kQoGrx7tXeAKFaJdhF+0arBlHus3otF9852ehkiCEbCM/
         pYhg==
X-Gm-Message-State: AFeK/H3+cLjMhRIli6D4e+avDuc6mNJYgpIfhkQifq2rRfK3FGJiWjKXK3w2kXNJcH1F+w==
X-Received: by 10.99.123.75 with SMTP id k11mr35368352pgn.150.1490230479545;
        Wed, 22 Mar 2017 17:54:39 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55f5:992d:bc78:c749])
        by smtp.gmail.com with ESMTPSA id f81sm6106958pfe.61.2017.03.22.17.54.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 17:54:39 -0700 (PDT)
Date:   Wed, 22 Mar 2017 17:54:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/3] submodule.c, is_submodule_modified: stricter
 checking for submodules
Message-ID: <20170323005437.GI26108@aiede.mtv.corp.google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323004329.15892-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323004329.15892-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> By having a stricter check in the superproject we catch errors earlier,
> instead of spawning a child process to tell us.

Plus the error message is clearer.

> ---
>  submodule.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
