Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB161FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 20:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932761AbcIBUBQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 16:01:16 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36408 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932403AbcIBUBP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 16:01:15 -0400
Received: by mail-vk0-f44.google.com with SMTP id w124so32493735vkd.3
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f/hJS/tcqaQqEu07TdjxA+ti5Siisk9hA4bzrSZglI4=;
        b=QmLjg6erC90F5D4QuR1iKVGZALOk6CB5vVh7O/+ukhw0V+kraSHqOCx/WlovtKStwZ
         qevYyD/iNURl/VcDesKN2dEqAGb0jdglCQgZw1AfGxZQNo7fbZ6wexwUP5r3yrum3Rdv
         BH6kpB3IAk5tZiJ5Wte9wHwsX9tCNgUwz3Ztc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f/hJS/tcqaQqEu07TdjxA+ti5Siisk9hA4bzrSZglI4=;
        b=WTT/Cz7pOWp0EsTALX8sXQqPL8T1PbKEPKQ3XkcaTz1/PKcpPv9nT2Y6bvOuv26+mp
         2jPmKOnXpn0u9cNeE9EQIgT4VT+TRUamFlyn/6/WMARjjpbEbSgi9TRFCugWdSXCJu6M
         5jOFFOlSG2gYNPE7krTW/v3D5w+F9rVQ2MfQa9SagIYz68oizLN9z7vBUs6HyQlWAWUh
         eAw7gdyBXqqcauVXOwHPSDjDa6G6SOYv5XmyESeEE69XFuRxqCJy+5I5x0byLWIRbcvg
         9I9zDIpNIbo+MMI7jCW4KFUvWLU+wYJtxKj8Qp2CnIMCPCiLk7XXR+QGcvccAVtsGTlj
         e1bQ==
X-Gm-Message-State: AE9vXwPCvYgqcBx8Zcb/rmp+aYvU83gfR0Kl25V7QvJLwLOoCoopTjdCI2fcJuF/gspS2knygFFW63IXJqt7Pg==
X-Received: by 10.31.108.27 with SMTP id h27mr15146885vkc.46.1472846474139;
 Fri, 02 Sep 2016 13:01:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.133.210 with HTTP; Fri, 2 Sep 2016 13:00:53 -0700 (PDT)
In-Reply-To: <CAGZ79kYWr09K2RXgSmmy4G=to65LbLfCi=GRkykhciq_vsyMZQ@mail.gmail.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
 <CAJo=hJssMohNq5zDU=wdb1gP4nW59m8pUmxP7eY4jnjr502z0w@mail.gmail.com> <CAGZ79kYWr09K2RXgSmmy4G=to65LbLfCi=GRkykhciq_vsyMZQ@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Fri, 2 Sep 2016 13:00:53 -0700
Message-ID: <CAJo=hJvGn-t_2TTVhsTNW3+nk+bg6FvKO5oJs_wwWE+aNAC2yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] connect: know that zero-ID is not a ref
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 12:56 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Sep 2, 2016 at 12:39 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> On Fri, Sep 2, 2016 at 10:15 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>>>
>>> +               if (is_null_oid(&old_oid)) {
>>> +                       if (strcmp(name, "capabilities^{}"))
>>
>> Its not the zero ID that is special, its the "capabilities^{}" name
>> that is special when its the first entry in the stream. In the wire
>> protocol a "x^{}" line is a modifier to a prior "x" line to add a
>> peeled object to the prior line. But if we see "^{}" on the first line
>> that is non-sense, there is no prior line to modify with this
>> identifier.
>>
>> Further ^{} is used here because its invalid in a name. A server
>> really cannot have a reference that ends with the sequence ^{}. And a
>> server should not have a reference named "capabilities" without a
>> "refs/" prefix on it.
>>
>> So the entire "capabilities^{}" on the first line is a bunch of
>> contradictions that violate a number of things about the protocol,
>> which is why clients should ignore it.
>>
>> I think the test should be about:
>>
>>   !*list && !strcmp(name, "capabilities^{}")
>>
>>> +                               warning("zero object ID received that is not accompanied by a "
>>> +                                       "capability declaration, ignoring and continuing anyway");
>>
>> Annoyingly a zero object ID is sort of possible; with a probability of
>> 1/2^160 or something. Its just a very very unlikely value. Slightly
>> stronger to test against the known invalid name.
>
> That ship has sailed long ago I would think?
> There are tests for null sha1 in the refs code, e.g. for
> deletion/creation of a branch
> we consider the null sha1 as the counterpart.
>
> So while it may be possible to have SHA1 producing a "0"x40, you
> cannot e.g. push it?

Indeed, you are correct.

I'm just stating the JGit client behavior is to look at
"capabilities^{}" in the first line as special, not the SHA-1.
