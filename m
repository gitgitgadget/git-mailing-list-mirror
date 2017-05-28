Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006381FD09
	for <e@80x24.org>; Sun, 28 May 2017 13:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdE1NGG (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 09:06:06 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34787 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdE1NGF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 09:06:05 -0400
Received: by mail-pg0-f41.google.com with SMTP id u28so11961083pgn.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WXV2yWdpesQ4/WXv92ihMFCmU5JSahP2/6hG6NlQUNs=;
        b=Ch9A2ODMkY8cXwUjszVVYyABHJ2VSfES45+3NlcNccN1TUG5/i9qTdAc9vj+3oL0QT
         N7PUDuRzIRwJmRGcBL3g9NYOalel5+Jm44llKNLhDf6aNPcbIzMSptFdLb5YAp3GAR02
         YGoAvGIhONVxUDFHssC+LLBgg2SqB0AGWQRE7JYEqQZglz/mSSxyraCpL1QoYhrvqcCV
         Yvzj5oGwunDIxYlMehedD9wlf2w/nGx9nLLYVWkqnznXrOKFl0qxC1RX1Qc5f3lt0ZDq
         8VqQU84zdM7TIJsNkJL+iMQHn6lPfYM7yXYB4NHnSYSSxKX9+dbVhaOfGWnxtwnQIiba
         c0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WXV2yWdpesQ4/WXv92ihMFCmU5JSahP2/6hG6NlQUNs=;
        b=sfUtOVhbE6ZzM65I8Xp8rLVcaHvL73JjINh7YUsJVjEsDWb1aw/3OaxrCAP4OgaU3g
         ftZAxPY0j3wYB9EHFPyC2Q05Rd3gUQ9iNhs8XPGVxCJOidz7OXESW4povt89ca4ly6fD
         yMa9kzSjSZDvkT5Y6/vXssHuhGNLyAymHyriboi+WkBDJQ5KBQ/8zD3bJ7HcteyJisj0
         X6WekDecvzPoLtxvACL1jJWAewBmfN7TWRUc+iFBJ5zbDUOVKdxxc3wmjyTDxU+9GwEe
         l+o2q+TJ3W3g8ifb6lF3NqRA9zIn8O91aKBS/eKvdv3KIe0Sfk/h4em692xuC8c0/Ecw
         e4Nw==
X-Gm-Message-State: AODbwcAAXBdZ04FTvRSrZUjCYRXsDQSB/zO4VGHASW9oeHlDqQ0xSHdn
        fHzpa8ycVM8vxg==
X-Received: by 10.99.96.70 with SMTP id u67mr13488302pgb.101.1495976764741;
        Sun, 28 May 2017 06:06:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bd10:cbc8:82cc:8993])
        by smtp.gmail.com with ESMTPSA id f24sm11798049pfk.66.2017.05.28.06.06.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 06:06:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: mergetool: what to do about deleting precious files?
References: <8CEDDC40C7D24404976929CF3E7AF6FC@PhilipOakley>
        <xmqq37bpbx5t.fsf@gitster.mtv.corp.google.com>
        <D689F4F80DA24C78B5E0FB025B9548E6@PhilipOakley>
Date:   Sun, 28 May 2017 22:06:03 +0900
In-Reply-To: <D689F4F80DA24C78B5E0FB025B9548E6@PhilipOakley> (Philip Oakley's
        message of "Sun, 28 May 2017 11:24:43 +0100")
Message-ID: <xmqqpoet9lms.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> So I do not think this is not limited to "new file".  Anything that
>> a tree-level three-way merge would resolve cleanly without having to
>> consult the content-level three-way merge will complete without
>> consulting the merge.ours.driver; per-file content-level three-way
>> merge driver (which is what merge=<drivername> mechanism lets you
>> specify via the attributes mechanism) is not something you would
>> want to use for this kind of thing.  It is purely for resolving the
>> actual content-level conflicts.
>>
> That (that Git knows best) sounds just wrong.

Don't twist my words.  I never said Git knows best.  

The user-level merge driver is a mechanism to affect conflict level
three-way merges.  The interface to the content level three-way
merge driver feeds three versions of blobs and the driver is
expected to give a merged result.  The interface as designed is
incapable of passing "here is the common ancestor", "our side is
missing" and "their side is this content".

So if we want a mechanism that can affect the outcome of tree-level
three-way merge, we need a _new_ mechanism.  The existing merge
drivers that are written by end users (at least the ones written
correctly to the spec, anyway) are not expecting to be called with
"in our tree, there is no blob here", and trying to piggyback on it
will break existing users.
