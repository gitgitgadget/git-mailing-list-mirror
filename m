Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5439C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B462074A
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgD2KJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:09:35 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:19219 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgD2KJf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 06:09:35 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jTjem-000AII-8y; Wed, 29 Apr 2020 11:09:33 +0100
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <de8523c6-b8f0-b12d-20e4-b2418bbc18eb@iee.email>
 <20200428014926.GE61348@Carlos-MBP>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c64b8f26-7f59-c701-20d2-7ca2e52f686d@iee.email>
Date:   Wed, 29 Apr 2020 11:09:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428014926.GE61348@Carlos-MBP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,
Thanks for the clarification.
Philip

On 28/04/2020 02:49, Carlo Marcelo Arenas Belón wrote:
> On Mon, Apr 27, 2020 at 02:48:05PM +0100, Philip Oakley wrote:
>> On 27/04/2020 13:59, Carlo Marcelo Arenas Belón wrote:
>>> with the added checks for invalid URLs in credentials, any locally
>>> modified store files which might have empty lines or even comments
>>> were reported[1] failing to parse as valid credentials.
>>>
>>> using the store file in this manner wasn't intended by the original
>>> code and it had latent issues which the new code dutifully prevented
>>> but since the strings used wouldn't had been valid credentials anyway
>>> we could instead detect them and skip the matching logic and therefore
>>> formalize this "feature".
>>>
>>> trim all lines as they are being read from the store file and skip the
>> Does trimming affect any credentials that may have spaces either end?
> all credentials are url encoded so the only spaces that are affected are
> the ones that were added by careless editing of that file.
>
> as Eric pointed out, any tabs will be silently "cleaned" as well.
>
>> Should the trimming of leading/trailing spaces be mentioned?
> I wanted to keep that as an undocumented "feature" as it is just meant
> to help people to avoid a fatal error during the transition but didn't
> want to encourage people thinking it is a supported part or even worse
> encourage people to start editing their files to add tabs and spaces.
>
> Junio's suggested documentation fix[1] makes that clearer that I could
>
>> Also the git-credential page mentions that the credential must end with
>> a blank line ("don't forget.."). Should that be mentioned here, or have
>> I misunderstood?
> that is for the protocol part of it (which is used between git and the
> credential helper), the file format for this specific helper doesn't
> require that.
>
> Carlo
>
> [1] https://lore.kernel.org/git/xmqqv9lk7j7p.fsf@gitster.c.googlers.com/

