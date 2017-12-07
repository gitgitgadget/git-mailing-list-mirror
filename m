Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6FE20C33
	for <e@80x24.org>; Thu,  7 Dec 2017 19:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbdLGTkv (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:40:51 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:43127 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdLGTkv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:40:51 -0500
Received: by mail-it0-f52.google.com with SMTP id u62so17483005ita.2
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R6sFJrNCIhyWhToWjuIbQqxvSZ5Ka0afitRkCSQ2Tnk=;
        b=WFGYsAOZWK8uHdlPCyI819gZujkBxiWB0VtIrcsIhdX6xVTpjvpyp5V4ryGTmktEY1
         82/GRE/k+h3gTWU8Hb1xG2RDBP87Nj5FY1mPCVnyXsENt5kYqJmk7DLQBm42vqw5Ketz
         cti3MjPaKnqaq4Q+iYSzRx3Iz4IseLjoLZsd+Kyx1Cl8VC3nSrmcQUhd6qUBVlDlbUoz
         jB7nFRYSn4qSykSsXVhd51PQRhbMjb+mnIZjuRWytCn9kQ6y2FIpAtUoYWGreX79xkmy
         DTQP/drg2TeclGlPUrmI6PHrYyJXRaiFn0FydXYvzQHHwfk1Ncg4pwLWW04Wg3JZnK7l
         eC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R6sFJrNCIhyWhToWjuIbQqxvSZ5Ka0afitRkCSQ2Tnk=;
        b=EhuDmSwexXXPo1mThfkPhyx5FBxG7NnL1jXgLk69unf3mh9SvBRBX66lXwKnWfrrPZ
         zx7K+XN5ckOdWnYKYhhghN3pzWqFwnJSzUJlwXFkxiUqHQJpq0palMszM5Q9Du7vl9HA
         +m4VhNbcZnW2fWASVv9tVj++pv/9tFtkGlnxAjyeJ6AXpRVu5ceWXxfrR+XTI10eA11F
         Jb2VKTW0QJeJjIK39kndPc6FmaAnaAGjK2H3BelQaL5JGHQb5y5BgHyQUYlOWqh6/O1a
         VXJXW1KEypquhLgmUR7kcuvr7ZNam8cS7J/22y9hDOzkoDwCMJ7Jy1gTZgX+fbNw+eZP
         6YkQ==
X-Gm-Message-State: AKGB3mKzXVAeZqD9QwYwjAjfnlRaRZz+ClNas12umMU0naO54ONqDw0O
        BKSri7/opK4uSyyTx9eVbxcp+Y2mEQM=
X-Google-Smtp-Source: AGs4zMaSLklsT4XEjssyfdY76Y0LaVbWDeFF9/c4O0sSqY2jTFFXkMeTrpI4K58FeGyGFLU4YyKMcA==
X-Received: by 10.107.12.81 with SMTP id w78mr17818716ioi.148.1512675649978;
        Thu, 07 Dec 2017 11:40:49 -0800 (PST)
Received: from google.com ([2620:0:100e:422:949a:89bd:af08:7a9c])
        by smtp.gmail.com with ESMTPSA id j21sm2850318ioe.25.2017.12.07.11.40.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 11:40:48 -0800 (PST)
Date:   Thu, 7 Dec 2017 11:40:47 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, christian.couder@gmail.com
Subject: Re: [PATCH v6 03/12] fsck: support refs pointing to promisor objects
Message-ID: <20171207194047.GD152943@google.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
 <20171205165854.64979-4-git@jeffhostetler.com>
 <20171207191852.GC152943@google.com>
 <20171207112726.6486768718085a359bf8deca@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207112726.6486768718085a359bf8deca@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Jonathan Tan wrote:
> On Thu, 7 Dec 2017 11:18:52 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > Instead of requiring that every test first removes 'repo', maybe you
> > want to have each test do its own cleanup by adding in
> > 'test_when_finished' lines to do the removals?  Just a thought.
> 
> If "test_when_finished" is the style that we plan to use in the project,
> we can do that.
> 
> But I think the "rm -rf" at the beginning of a test method is better
> than "test_when_finished", though. It makes the test independent (for
> example, the addition or removal of tests before such a test is less
> likely to affect that test), and makes it clear if (and how) the test
> does its own setup as opposed to requiring the setup from another test
> block.

You're right, at the end of the day you're just shuffling responsibility
to of cleanup somewhere else.

-- 
Brandon Williams
