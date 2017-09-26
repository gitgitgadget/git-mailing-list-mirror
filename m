Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413E6202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 03:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964904AbdIZDpu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 23:45:50 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:47535 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935226AbdIZDpt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 23:45:49 -0400
Received: by mail-pg0-f45.google.com with SMTP id d8so5222031pgt.4
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 20:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hzfMPOmSm2tG8fKumO0BfR1n5YOwOQMa1gjUQzsdOxY=;
        b=ukU0VcH9Vsx9ENBYHQ/uXltvCA2hF1V5q5mMXHlZ8nzgJMEPdW1bvvMSOOCG+phi9C
         mfJ24xZ3d4HToqWOMs5Qyq7ZaD6j/gtu2VNJusnDFHhAb4bCV5oqAg4FZtjytTCOrG3D
         Jo9U92cC/aV+mmBJkFxUoH8MMOXizOHLYENTJzAT2GuEI/hK3ESSBoRphRMgdlQVN+2C
         eeJ+PPuWvhV94NHKvd480XrKdcskf+jup3rUV8PfTmtbf2NM6bOgtvGYPdLYPiRvYy1A
         xTQ1+KzuCAfjB5wTFbYRgbBNBeasAnpZTksYCqzHcWAchRDzlzFOF5kmgi8tt+8AVRUL
         Y82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hzfMPOmSm2tG8fKumO0BfR1n5YOwOQMa1gjUQzsdOxY=;
        b=MVPfUQS3kmNeYf6MIGEQtuH2Tu2w4dB8aD4Ohj6lbiyebjNB+E0P799Hp4U/TbwpHl
         evB6M2btFIgYkGtNu2UTAkwkpE+7Zbk6WVGW2eUVGcAsp1xNdo+nx+L7Rs7UhsifwyfQ
         xWkfZugfyjrz3dyFOR9n81LR63/C5Ce+LUqVE5RM3XI8mhM9WpQbRg1QYI1qYABtGIY0
         tddCj7z1+LFXyGNhInqExdnlLySu5H2yhUrOEBuX5ec+P089ul8KAFyS4N06sDcCdbPi
         FRwAbf9pQQGLrvuKqYLzNgnecLt0ooy/cL7hJhtjlW2Bv/nc9Ag0aOHekIckxbJyk3Th
         eneQ==
X-Gm-Message-State: AHPjjUg2tyLeDi5gnhcnN2umwGrkWSxl8qE4084tD+S3yIX3wdCc7ZMT
        X2YKZbgHcLVk0YM4L5eNEkYG4g7d
X-Google-Smtp-Source: AOwi7QBB+53YfgqKFx5JbEyJNH0Ijvebc7oJ10Y9G3ykg3gZ8P+ijfPmnMFUZ4RLooY+rehHuP9OrA==
X-Received: by 10.99.186.81 with SMTP id l17mr9634139pgu.170.1506397548452;
        Mon, 25 Sep 2017 20:45:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id l131sm14145069pga.24.2017.09.25.20.45.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 20:45:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: -s theirs use-case(s) Was: BUG: merge -s theirs  is not in effect
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
        <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
        <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
        <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
        <20170925144021.vhbd3wb3uqejs5wq@hopa.kiewit.dartmouth.edu>
Date:   Tue, 26 Sep 2017 12:45:46 +0900
In-Reply-To: <20170925144021.vhbd3wb3uqejs5wq@hopa.kiewit.dartmouth.edu>
        (Yaroslav Halchenko's message of "Mon, 25 Sep 2017 10:40:21 -0400")
Message-ID: <xmqqzi9iazrp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> writes:

> 1. As a workaround for absence of -m theirs I using mtheirs git alias:
> (I believe provided to me awhile back here on the list):
>
>     mtheirs = !sh -c 'git merge -s ours --no-commit $1 && git read-tree -m -u $1' -
>
> and it worked fine for my usecases
>
> 2. I think that if there is a reason for -s ours to exist, so there for -s theirs
> since it is just the directionality of merges which changes between the two

Just on this point.  They are not exactly symmetric.

Imagine there are some undesirable changes you want to vanquish from
the world, but they have already built on useful changes on top of
the undesirable changes.  A hypothetical history might look like
this:

                 B---C
                /
           X---X---A
          /
      ---o---o         your mainline

where 'X' denotes those unwanted changes.

With a "-s ours" merge, you can declare that changes on the other
branch will never be merged to your branch, i.e.

                 B---C
                /
           X---X---A
          /     \
      ---o---o---M     your mainline

and then you can safely merge A and C into your branch, without
having to worry about them bringing the unwanted changes to your
tree state.

                 B---C
                /     \
           X---X---A   \
          /     \   \   \
      ---o---o---M---N---O  your mainline

That is the primary reason why "-s ours" exists, i.e. you do not
control the branch where mistakes X were made because that is
somebody else's history.

The symmetiric case where _you_ have wrong changes do not need "-s
theirs".  These mistakes X are yours, so are the changes depend on
them:

                 B---C
                /
           X---X---A
          /
      ---o---o         their mainline

and you can just rebase A, B and C on top of their mainline while
getting rid of Xs yourself before publishing.

               B'--C'
              /  
      ---o---o---A'

The reason why ours and theirs are not symmetric is because you are
you and not them---the control and ownership of our history and
their history is not symmetric.

There may be valid workflows that benefit from "-s theirs", and I
would not be surprised at all if we found more of them in the past 9
years since we had the "why -s theirs does not exist" discussion in
2008.  But "because -s ours can be used in reverse to emulate" is
not a valid excuse to add "-s theirs".  It can be used a rationale
against adding it (e.g. "-s theirs generally is discouraged because
it forsters a bad workflow, but in a very rare case where it might
be useful, you can always check out their branch and merge yours
using '-s ours' to emulate it, so we do not lose any functionality
even if we did not add it"), though.
