Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6C6202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 05:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbdJ3FCc (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 01:02:32 -0400
Received: from mail.javad.com ([54.86.164.124]:60849 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752501AbdJ3FC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 01:02:29 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6721761003;
        Mon, 30 Oct 2017 05:02:28 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1e92DS-0003j6-CJ; Mon, 30 Oct 2017 08:02:26 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     <git@vger.kernel.org>, "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to re-merge paths differently?
References: <87wp3g61ez.fsf@javad.com>
        <3655514352684AD398D17E83FF47F986@PhilipOakley>
Date:   Mon, 30 Oct 2017 08:02:26 +0300
In-Reply-To: <3655514352684AD398D17E83FF47F986@PhilipOakley> (Philip Oakley's
        message of "Sat, 28 Oct 2017 18:37:14 +0100")
Message-ID: <8737615iu5.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Sergey Organov" <sorganov@gmail.com>
>> Is there anything like this:
>>
>> $ git merge b
>> [... lot of conflicts ...]
>> $ git re-merge -X ours -- x/   # Leaves 0 conflicts in x/
>> $ git re-merge -X theirs -- y/ # Leaves 0 conflicts in y/
>> [... resolve the rest of conflicts manually ...]
>> $ git commit
>>
>> [*] I do mean '-X' above, not '-s'.
>>
>
> By this I presume you mean that you have paths x and y that ate the
> ones with conflicts within them following the `git merge b`.

I rather mean huge amount of conflicting paths in 'x' and 'y'
subdirectories of my working tree after a merge, plus a few conflicting
paths elsewhere.

>
> You then want a variant of the `git merge` command that will apply the
> `-X  ours` policy *specifically to path x* so that its particular set of
> conflicts is fully resolved in favour of 'ours'.

Almost. I mean to apply 'ours' option to the default 'recursive' policy for
all the files that reside in the directory 'x' of my working tree and
all its subdirectories (i.e., all the paths 'x/*')

>
> You then want to repeat those path specific resolutions, on a path by
> path basis, to either `-X ours` or `-X theirs` until they are done.

No. I mean to apply '-X ours' to everything under 'x/', and '-X theirs'
to everything under 'y/'. Avoiding to repeat anything is the intention. 

> You are also expecting that one or two conflicts will require to be
> fully manually resolved, until finally you can commit the result.

No, I expect no conflicts left in either 'x/' or 'y/' after "re-merge",
as neither 'theirs' or 'ours' should leave anything unresolved, and all
the other conflicting paths (left from original merge elsewhere) I mean
to resolve manually.
 
>
> Would that be right?
>
> Also, how do you intend to identify the 'x' and the 'y' paths, so that
> you can chose the ours/theirs/manual selection? (e.g. do you pre-know
> a regex/blob expansion)

All the 'x/*' paths need 'ours', and all the 'y/*' paths need 'theirs'.

>
> The answer for individual paths is probably in the mergetool of your
> choice.

There are a lot of files under 'x/' and a lot of them under 'y/'. My
intention is to automate a lot of manual labor, and I'm not aware of a
mergetool that provides either '-X ours' or '-X theirs' resolution
automatically for all the paths specified.

-- Sergey
