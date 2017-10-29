Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2830202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 18:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbdJ2Sjp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 29 Oct 2017 14:39:45 -0400
Received: from marcos.anarc.at ([206.248.172.91]:53024 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751472AbdJ2Sjo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 14:39:44 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Oct 2017 14:39:44 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 71ABF1A00AD
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] remote-mediawiki: show known namespace choices on failure
In-Reply-To: <CAPig+cSkwD35wK7Z_qZZusKWWBC5CU6AnbF9g_g907uqpeYQsw@mail.gmail.com>
Organization: Debian
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-4-anarcat@debian.org> <CAPig+cSkwD35wK7Z_qZZusKWWBC5CU6AnbF9g_g907uqpeYQsw@mail.gmail.com>
Date:   Sun, 29 Oct 2017 14:31:50 -0400
Message-ID: <877evd9561.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-29 13:34:31, Eric Sunshine wrote:
> On Sun, Oct 29, 2017 at 12:08 PM, Antoine Beaupré <anarcat@debian.org> wrote:
>> if we fail to find a requested namespace, we should tell the user
>
> s/if/If/

fixed.

>> which ones we know about, since we already do. this allows users to
>
> s/this/This/
>
> Not sure what ", since we already do" means here.

we already have fetched the mapping, fixed.

>> feetch all namespaces by specifying a dummy namespace, failing, then
>
> s/feetch/fetch/

fixed.

>> copying the list of namespaces in the config.
>>
>> eventually, we should have a flag that allows fetching all namespaces
>> automatically.
>>
>> Reviewed-by: Antoine Beaupré <anarcat@debian.org>
>> Signed-off-by: Antoine Beaupré <anarcat@debian.org>
>> ---
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -1334,7 +1334,9 @@ sub get_mw_namespace_id {
>>         my $id;
>>
>>         if (!defined $ns) {
>> -               print {*STDERR} "No such namespace ${name} on MediaWiki.\n";
>> +               my @namespaces = sort keys %namespace_id;
>> +               for (@namespaces) { s/ /_/g; }
>> +               print {*STDERR} "No such namespace ${name} on MediaWiki, known namespaces: @namespaces.\n";
>
> Probably want to drop the terminating "." in the error message.

meh... i just respected what was already there, but it's true it can be
error-prone when copy-pasting, so removed.

a.
-- 
A ballot is like a bullet. You don't throw your ballots until you see
a target, and if that target is not within your reach, keep your
ballot in your pocket.
                         - Malcom X
