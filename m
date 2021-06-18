Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE0C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 22:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9719361284
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 22:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhFRWfA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 18 Jun 2021 18:35:00 -0400
Received: from elephants.elehost.com ([216.66.27.132]:34112 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFRWfA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 18:35:00 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 15IMWl7F088843
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Jun 2021 18:32:47 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathan Tan'" <jonathantanmy@google.com>,
        <emilyshaffer@google.com>
Cc:     <git@vger.kernel.org>
References: <YM0IpOFH4Sy9wWaE@google.com> <20210618215848.794617-1-jonathantanmy@google.com>
In-Reply-To: <20210618215848.794617-1-jonathantanmy@google.com>
Subject: RE: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
Date:   Fri, 18 Jun 2021 18:32:41 -0400
Message-ID: <020d01d76491$dcfe7c60$96fb7520$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLGDmhaeVA3rjEQY3rBzjnq2zAK/wGN6/M9qTCWnaA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 18, 2021 5:59 PM, Jonathan Tan wrote:
>> On Wed, Jun 16, 2021 at 04:31:47PM -0700, Jonathan Tan wrote:
>> >
>> > I have had to make several design choices (which I will discuss
>> > later), but now with this implementation, the following workflow is possible:
>> >
>> >  1. The remote repo administrator creates a new branch
>> >     "refs/heads/suggested-hooks" pointing to a commit that has all the
>> >     hooks that the administrator wants to suggest. The hooks are
>> >     directly referenced by the commit tree (i.e. they are in the "/"
>> >     directory).
>>
>> I don't really like that this is in the same namespace as branches
>> users could create themselves. Hm, I think for 'git maintenance'
>> prefetching we put those refs in some special namespace, right? Can we
>> do something similar in this case? Would that prevent us from treating
>> that ref like a normal branch?
>
>Do you mean that the server should put it in a different place, the client should put it in a different place, or both?

This brings up a very awkward question: How are enterprise git servers going to deal with this? I do not see the standard Pull Request mechanism available in GitHub handing placing hooks in different places during a merge operation. Or will this entire concept be omitted from PR?

It seems like changes to hooks have to be managed in a similar way to standard managed files rather than as exceptions.

-Randall

