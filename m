Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B41F20954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbdLGT1a (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:27:30 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:46482 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdLGT13 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:27:29 -0500
Received: by mail-it0-f47.google.com with SMTP id t1so17354211ite.5
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 11:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wo5cGLVcUduU9RkEbidSBvT29lYAmDcpuHYOHWI4CJ8=;
        b=MpO10itLiJhIpPfVw6NFT4EboLht5byJdBbzZAuqAt0EV/7AUINpoacO2tOEcz5wfs
         g/12ZMH53SzqRpIli6T117PIJ9cXKqWGwA3pFxErHxoDR2toVBP+6ixUHIVuYE0XMwNS
         hocjprTqukGdPo4ix6/YxjJk8hwYSAgFBKlGR4Iyp6a3Vvx7ra2Qfdzb/dfRh7JD7kY6
         1TK0Qy2ckBBGMQl6s/wL2KKjBRYldCvTteEoQXTltuQtoTFqAGXXJdQvpzRFon+JHjUe
         bezrEz0aj4WA5fF4EVtppSKcdgiY8KwzbVdZ9OQ5Po+LXvftBEkmsLwCWhnE1gHe/ham
         I+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wo5cGLVcUduU9RkEbidSBvT29lYAmDcpuHYOHWI4CJ8=;
        b=UE3NjG9taS/W31cuCSJq8wpF7S7qrs7GNafRH0XpsEHkwtCTbJ01ZgEsGldolJI2WL
         tDs+uDpYYet/kCIGEe4+GbWSZHrqIJuewOTI+nl7fZSorG/sOqyBYt5IqL5he1LTQlpf
         x76LME9qEU20u5vz9FhyWqYJ3PIXypf6OgP+UngVi5PS9/eDwUx4xCP9B9zcXyhkjfVT
         iCLzwgyX9Wa1yLkzlQ6tuOPFNFKFBu09Yp/VGNCqqRUdy5V0crkaJ0DANbtiIt1LGS8Q
         7iFz8MrT3K6FiUYJ/9K42EAweeloeO0jglZjcESP5FsLZtAW2xyfAqOmPXJxBYMeq25d
         Xqqw==
X-Gm-Message-State: AKGB3mKhTta8o730vRakjwEc8BWEWlERXrU3YxUE2wLVhUfrcmnIi37h
        VoagIOCKNKPgJnc+21PBD9d29Q==
X-Google-Smtp-Source: AGs4zMZlxIvsIM50KIFIz7c7uGZlh7UiXTCr0CsN29erPQcV4LbzmVUpC9j9kLH+TtQ78wrXt1e6hA==
X-Received: by 10.107.201.206 with SMTP id z197mr2007044iof.98.1512674849120;
        Thu, 07 Dec 2017 11:27:29 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:bdde:559c:2e9f:3145])
        by smtp.gmail.com with ESMTPSA id c65sm2765564ioj.23.2017.12.07.11.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2017 11:27:27 -0800 (PST)
Date:   Thu, 7 Dec 2017 11:27:26 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, christian.couder@gmail.com
Subject: Re: [PATCH v6 03/12] fsck: support refs pointing to promisor
 objects
Message-Id: <20171207112726.6486768718085a359bf8deca@google.com>
In-Reply-To: <20171207191852.GC152943@google.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
        <20171205165854.64979-4-git@jeffhostetler.com>
        <20171207191852.GC152943@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 7 Dec 2017 11:18:52 -0800
Brandon Williams <bmwill@google.com> wrote:

> Instead of requiring that every test first removes 'repo', maybe you
> want to have each test do its own cleanup by adding in
> 'test_when_finished' lines to do the removals?  Just a thought.

If "test_when_finished" is the style that we plan to use in the project,
we can do that.

But I think the "rm -rf" at the beginning of a test method is better
than "test_when_finished", though. It makes the test independent (for
example, the addition or removal of tests before such a test is less
likely to affect that test), and makes it clear if (and how) the test
does its own setup as opposed to requiring the setup from another test
block.
