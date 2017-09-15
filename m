Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E6120281
	for <e@80x24.org>; Fri, 15 Sep 2017 21:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdIOVxI (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 17:53:08 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:45711 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdIOVxH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 17:53:07 -0400
Received: by mail-pf0-f178.google.com with SMTP id q76so2092008pfq.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 14:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xdnjQzmva53IILHaCSfIFTeDGVZecMx4+8o1pYLFLlc=;
        b=rmkqqlaVq54Baxzf871veD7DmnZIJd92T65xGhZeN2cOEUyHqFvSWb8MaWWS1LVomF
         0FU73y/lun+yltekAIYEG+4hU2UxyYXh/iLIwuTZ+ZUg95gW5l9gsvreN8JBNYJm4V/H
         +O1DVxB7Trc5nSfYYZrOvGkgOBFVp9nvp8ebQNQJDTzixAn5j6F5c+jrJ0pD/0z5o56N
         nuoRsDc/J4PbIzMkw5D+KI9kxFS+B9Pa6U8gjqWJn6N3+ddFB8Nz58BcHWmNlatfyyds
         RplnbCjTQWgy7IaC9YYi6lNGGxBrhObkfnnmVHXWjdagkBd6VF9u4me3GfIWqvAsF8Hb
         wBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xdnjQzmva53IILHaCSfIFTeDGVZecMx4+8o1pYLFLlc=;
        b=FHtCGLSHVJ0CzEQJu61j1U563+poDZlUiO41WQ2ZNpXhWE2rHJ+rjAm8PYllw1Kkcu
         Az/DHex+wspiinfIFBA+jBVfsqxtrOCrs/Dpmsx7BSsq61/sEgrvTj35y8/UO+qssytu
         zuJ2RXaWT7SZzsOJ451UEbYZnQoi/jlDh++F6jp9WBHgrmDDuo0hszpq0IrEWYnZ3ajI
         hyRcTyfG07MdRwX5J9F+gIWvQTrseTzo+xD2l56/tUBf7PiBb5OIeYHpZw4+L57wH5I7
         aVTJIZygDC18uzQdUAF2Q0EKjACQuoWSOQh1H1l6tdWl1kyAUIeLP+BhW76QQVQ4i7YA
         qD/g==
X-Gm-Message-State: AHPjjUgIpb17exWE5cZwjiVQk7Z/BXsfpiXFovkPcXS70jIIbgrvzKP9
        +T+a/+AOHiEAObGTOr4=
X-Google-Smtp-Source: ADKCNb7csG5Xg562/pKalfmCgpDa1NVV1DO+vlvSTLhWeM767CdCvpjckExJdwaYV5/eyxu6h43WLA==
X-Received: by 10.98.34.149 with SMTP id p21mr26062127pfj.322.1505512386403;
        Fri, 15 Sep 2017 14:53:06 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:40d3:83c7:2f82:80ea])
        by smtp.gmail.com with ESMTPSA id o19sm3857322pgn.76.2017.09.15.14.53.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 14:53:05 -0700 (PDT)
Date:   Fri, 15 Sep 2017 14:53:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jason Merrill <jason@redhat.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Aldy Hernandez <aldyh@redhat.com>
Subject: Re: [PATCH] Fix merge parent checking with svn.pushmergeinfo.
Message-ID: <20170915215303.GV27425@aiede.mtv.corp.google.com>
References: <20170915170818.27390-1-jason@redhat.com>
 <20170915175248.GT27425@aiede.mtv.corp.google.com>
 <CADzB+2mxyXcROYx72tac8cUxBMxi=ZxUNQYxpUR1CZ43e-j9gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADzB+2mxyXcROYx72tac8cUxBMxi=ZxUNQYxpUR1CZ43e-j9gA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Merrill wrote:
> On Fri, Sep 15, 2017 at 1:52 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Jason Merrill wrote:

>>> Subject: Fix merge parent checking with svn.pushmergeinfo.
>>>
>>> Without this fix, svn dcommit of a merge with svn.pushmergeinfo set would
>>> get error messages like "merge parent <X> for <Y> is on branch
>>> svn+ssh://gcc.gnu.org/svn/gcc/trunk, which is not under the git-svn root
>>> svn+ssh://jason@gcc.gnu.org/svn/gcc!"
>>>
>>> * git-svn.perl: Remove username from rooturl before comparing to branchurl.
>>>
>>> Signed-off-by: Jason Merrill <jason@redhat.com>
>>
>> Interesting.  Thanks for writing it.
>
> Thanks for the review.
>
>> Could there be a test for this to make sure this doesn't regress in
>> the future?  See t/t9151-svn-mergeinfo.sh for some examples.
>
> Hmm, I'm afraid figuring out how to write such a test would take
> longer than I can really spare for this issue.  There don't seem to be
> any svn+ssh tests currently.

Well, could you give manual commands to allow me to reproduce the
problem?

Then I'll translate them into a test. :)

FWIW remove_username seems to be able to cope fine with an http://
URL.  t/lib-httpd.sh starts an http server with Subversion enabled,
as long as the envvar GIT_SVN_TEST_HTTPD is set to true.  Its address
is $svnrepo, which is an http URL (but I don't see a username in the
URL).  Does that help?

Alternatively, does using rewrite-root as in t9151-svn-mergeinfo.sh
help?

[...]
> How about this?
>
>     git-svn: Fix svn.pushmergeinfo handling of svn+ssh usernames.
>
>     Previously, svn dcommit of a merge with svn.pushmergeinfo set would
>     get error messages like "merge parent <X> for <Y> is on branch
>     svn+ssh://gcc.gnu.org/svn/gcc/trunk, which is not under the git-svn root
>     svn+ssh://jason@gcc.gnu.org/svn/gcc!"
>
>     So, let's call remove_username (as we do for svn info) before comparing
>     rooturl to branchurl.

Looks good.

Thanks.

Jonathan
