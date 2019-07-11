Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B001F461
	for <e@80x24.org>; Thu, 11 Jul 2019 20:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfGKU5N (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 16:57:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40003 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbfGKU5N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 16:57:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so3644675pla.7
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=079XwwZUmO4gFUA3RePm25XlIW3tDNvr7RQcxBCYpu4=;
        b=j8Gl3RZ0IM5J59V2GXeWQ66a5jxva28FBEtGsAbEq1hRJEjrJWZeB1JKeWYtDfyub9
         CRTlLluRQUgijtRE4tRcAv5EtjnS0knoW3gEHUkPd6ZkdauUdh8Z0BZaZ5wfw2VzWWEk
         5EZ+r0fVqp4wgrGQbimQQRiK06tnuLp6p0pfSb334FUK6663+3rW+fCHBhSWX1ztkWMS
         B3PkmKMnKTtEpsREQJslIPL96RA9rg5COvEqYl2BvgVipU9ULab8PZyQFrDG7lL6CItv
         wSquEwwFfG8HIhlpBq/INAl96MMK8Yfk4WS9zrx4gluDRhGJzJ1RJzFTqVxS3DPkyqAz
         OJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=079XwwZUmO4gFUA3RePm25XlIW3tDNvr7RQcxBCYpu4=;
        b=e6ptDG+GKV/2hbtJzjeJDmwJ7Ho90TYXKhhiGdfz4EpOP55iD6yCoiGZD2DkpP45tA
         k6pox/MbUIu/yJzjLSrDY/lKihHyghdV4gAYpRFDa/XPOW3K1Ca8a7VmqBOYmESJ8Qit
         md/rtxAgFh+sZPqPF8wFBXskCzzB0izWodaacxGMYJfJMeimLstyoTHdF1vT+0ATtxsc
         hvPcT3Cy3KF4/SnIff6wrFLE69GMA0lYiW+/ovphkqECvs3ru3alSO1z2j+viZ1zi9Ha
         lfSOR7tcp8KGqKUzGaazrcsZjF8nf/AxQinOnvtI8pjkDHe0+YjQ3AEZx7HisjhafTHd
         tZ9g==
X-Gm-Message-State: APjAAAX5hzRLoHYvSZAiF8iKPrbJKNv3jharg4TMVHBccB9g9mEMMzoL
        lfkvSnYNUS9Bflo4ECCWH6BFDg==
X-Google-Smtp-Source: APXvYqzlnih1ugbvc5DVXZntSxFy7Btkkh9UKoLZ7IJfQN0sPbAwHYONl7MUak3WpCi24fMALuoQ+Q==
X-Received: by 2002:a17:902:8547:: with SMTP id d7mr6979431plo.171.1562878632428;
        Thu, 11 Jul 2019 13:57:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id u137sm6118838pgc.91.2019.07.11.13.57.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 13:57:11 -0700 (PDT)
Date:   Thu, 11 Jul 2019 13:57:06 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in
 push_refs_with_push
Message-ID: <20190711205706.GD113966@google.com>
References: <20190709211043.48597-1-emilyshaffer@google.com>
 <xmqqpnmhu6mh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnmhu6mh.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 10, 2019 at 10:44:22AM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
> > +	# Setup upstream repo - empty for now
> > +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
> > +	git init --bare "$d" &&
> > +	test_config -C "$d" http.receivepack true &&
> > +	up="$HTTPD_URL"/smart/atomic-branches.git &&
> > +
> > +	# Tell up about two branches for now
> 
> -ECANTPARSE "Tell up" part.

s/up/"$&"/ - thanks.

[snip]
> Up to point, I have no possible improvements to offer ;-)
> Very well done.

This is nice to hear, thanks! :)

> > +	# the failed refs should be indicated
> > +	grep "master -> master" output | grep rejected &&
> 
> I'd rather see the effect, i.e. what the command did that can be
> observed externally, than the report, i.e. what the command claims
> to have done, if it is equally straight-forward to verify either.

Hmm. I'd like to argue that part of the requirement is to show the user
what happened; for example, in an earlier iteration I was not
successfully reporting the "collateral damage" refs to the user, even
though they were not being pushed. To that end, I'd rather check both.

> 
> That can be done by making sure that the output from "git -C "$d"
> rev-parse refs/heads/master" match output from "git rev-parse
> atomic2", no?  That ensures 'master' in the receiving end stayed the
> same.

Sure, I agree.

> 
> > +	# the collateral failure refs should be indicated
> > +	grep "atomic -> atomic" output | grep "atomic push failed" &&
> > +	grep "collateral -> collateral" output | grep "atomic push failed"
> 
> Likewise for the other two.  
> 
> FWIW, these three can further lose a process each, i.e.
> 
> 	grep "^ ! .*rejected.* master -> master" output
> 
> even if we for some reason do not want to check the effect and take
> the claim by the command being tested at the face value (which I do
> not think is a good idea).

Will swap, wasn't sure on preference between regex or process count.
Thanks.

 - Emily
