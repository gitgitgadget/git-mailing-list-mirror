Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72DB1F4B7
	for <e@80x24.org>; Fri, 30 Aug 2019 00:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfH3AYj (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 20:24:39 -0400
Received: from smtp67.ord1d.emailsrvr.com ([184.106.54.67]:52763 "EHLO
        smtp67.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbfH3AYj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Aug 2019 20:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1567124678;
        bh=uKp3uw8AfygRnVIKlgnM2SMeXELTzifKjNJ36LoMZZ4=;
        h=Subject:To:From:Date:From;
        b=hGo1EkHSuRwKrKGhkpIPU9D3ahOAKziXkWsmEhqTCK40UMuRVYjEB+7gMJYcFHVeT
         wJ/GByK8UNkbx1ySDqQvRhZl1cNcl1sAzBbpNy8q4ZYy94IZAwt91hj+ErXX3ouQt4
         uxqxiQuUKO1igqRTYT/kDZlgAXM/WVLzwcH3O1uE=
X-Auth-ID: jon@jonsimons.org
Received: by smtp17.relay.ord1d.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 1201C20196;
        Thu, 29 Aug 2019 20:24:37 -0400 (EDT)
X-Sender-Id: jon@jonsimons.org
Received: from simonsj-mba2.hsd1.ca.comcast.net (c-73-223-68-105.hsd1.ca.comcast.net [73.223.68.105])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 29 Aug 2019 20:24:38 -0400
Subject: Re: [PATCH v2 1/2] list-objects-filter: only parse sparse OID when
 'have_git_dir'
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
References: <20190829223811.12072-1-jon@jonsimons.org>
 <20190829223811.12072-2-jon@jonsimons.org>
 <CAPig+cQDPsXvOYa3HYo_cYeVq4PhJE_2RGw9n+92=t3BA0-yaw@mail.gmail.com>
 <d8f1b891-4ff7-9815-2405-76e53506027c@jonsimons.org>
 <CAPig+cTUEY9Z7KBqXXcvrjBzRVQJ6pJUi72BrevquN1xfvwZag@mail.gmail.com>
From:   Jon Simons <jon@jonsimons.org>
Message-ID: <c5ec26a3-c9a3-89ce-e83b-a7a831203770@jonsimons.org>
Date:   Thu, 29 Aug 2019 17:24:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTUEY9Z7KBqXXcvrjBzRVQJ6pJUi72BrevquN1xfvwZag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/19 4:48 PM, Eric Sunshine wrote:
> On Thu, Aug 29, 2019 at 7:12 PM Jon Simons <jon@jonsimons.org> wrote:
>> On 8/29/19 3:45 PM, Eric Sunshine wrote:
>>> On Thu, Aug 29, 2019 at 6:38 PM Jon Simons <jon@jonsimons.org> wrote:
>>>> +       test_write_lines /* >sparse-src/all-files &&
>>>
>>> Hmm, does this work correctly? I would expect the /* to expand to all
>>> names at the root of your filesystem, which isn't what you want. You
>>> want the literal string "/*", which means you should quote it (with
>>> double quotes inside the test body). [...]
>>
>> Oof, thanks -- yes, this is incorrect.  I will revert this back to
>> 'echo'.  I misapplied your initial suggesttion to all three lines.
> 
> Curious. Did the test still pass even with the unquoted "/*"? If so,
> does that indicate a flaw in the test or somewhere else?

Yes, the test also passes with the unquoted "/*".  I think this showcases
that the test really is a bare minimal sanity check that clones providing
a sparse filter argument are able to run to completion.  As-is the test
does not further assert any behavior of the filter, just that the BUG is
avoided.


-Jon
