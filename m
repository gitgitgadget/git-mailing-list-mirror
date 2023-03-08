Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82346C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCHJ0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjCHJ0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:26:25 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6CCF77A
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:26:21 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 678E11F47D;
        Wed,  8 Mar 2023 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1678267581;
        bh=OW7DkVzG0+hfCdi+acpnWkRt2Rfg89hI0+RNZOr16bM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XsIaZDZkeuqBXMdi6thwPD3rUHAOMfRA4mC9+PdeuClLHg79wh8sMTRKf6Q7ifZzA
         N3VOwwheHOJHhtM7A8p9RtC90UCRLIOghazYdwVRjjvMcTvx/YP/1bqPw0OaCjhD/g
         vHHe6qGObewCkmcvFnOl83ay0ATxSqGpjQd0+WBM=
Date:   Wed, 8 Mar 2023 09:26:21 +0000
From:   Eric Wong <e@80x24.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] test: simplify counts aggregation
Message-ID: <20230308092621.M321240@dcvr>
References: <20230308090536.2562917-1-felipe.contreras@gmail.com>
 <230308.86bkl3zjp3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230308.86bkl3zjp3.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Mar 08 2023, Felipe Contreras wrote:
> > +++ b/t/Makefile
> > +	'$(SHELL_PATH_SQ)' ./aggregate-results.sh '$(TEST_RESULTS_DIRECTORY_SQ)/t*-*.counts'

> > +++ b/t/aggregate-results.sh
> >  
> > -while read file
> > +for file in $1

Reading aggregate-results.sh alone looks wrong; but your patch is
correct overall because of how it's invoked from the Makefile.
I think that's too subtle...

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> I think we can go even further here, and just pass the
> $(TEST_RESULTS_DIRECTORY_SQ) as an argument to the script

Yes.
