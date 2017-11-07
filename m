Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33AD202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 16:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757930AbdKGQHp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 7 Nov 2017 11:07:45 -0500
Received: from marcos.anarc.at ([206.248.172.91]:36954 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754793AbdKGQHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 11:07:41 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 96E681A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Thomas Adam <thomas@xteddy.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 3/7] remote-mediawiki: show known namespace choices on failure
In-Reply-To: <20171107104526.ywnapdat57vi66xy@laptop>
Organization: Debian
References: <20171102212518.1601-1-anarcat@debian.org> <20171106211953.27910-1-anarcat@debian.org> <20171106211953.27910-4-anarcat@debian.org> <20171107104526.ywnapdat57vi66xy@laptop>
Date:   Tue, 07 Nov 2017 11:07:40 -0500
Message-ID: <87bmke2htf.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-07 10:45:27, Thomas Adam wrote:
> On Mon, Nov 06, 2017 at 04:19:49PM -0500, Antoine Beaupré wrote:
>> If we fail to find a requested namespace, we should tell the user
>> which ones we know about, since those were already fetched. This
>> allows users to fetch all namespaces by specifying a dummy namespace,
>> failing, then copying the list of namespaces in the config.
>> 
>> Eventually, we should have a flag that allows fetching all namespaces
>> automatically.
>> 
>> Reviewed-by: Antoine Beaupré <anarcat@debian.org>
>> Signed-off-by: Antoine Beaupré <anarcat@debian.org>
>> ---
>>  contrib/mw-to-git/git-remote-mediawiki.perl | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
>> index a1d783789..6364d4e91 100755
>> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
>> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -1334,7 +1334,8 @@ sub get_mw_namespace_id {
>>  	my $id;
>>  
>>  	if (!defined $ns) {
>> -		print {*STDERR} "No such namespace ${name} on MediaWiki.\n";
>> +		my @namespaces = map { s/ /_/g; $_; } sort keys %namespaces_id;
>
> Oops.  This was my typo from my original suggestion.  The hash is
> '%namespace_id', not '%namespaces_id'.  However, how did this slip through
> testing?  I'm assuming you blindly copied this from my example, which although
> quick to do, is only being caught because of my sharp eyes...

I must admit I did not test that at all. Honestly, I'm just trying to
finalize this so we can move to GitHub and I can move on other
things. :)

I rerolled with your fix.

A.
-- 
If builders built houses the way programmers built programs,
The first woodpecker to come along would destroy civilization.
                        - Gerald Weinberg
