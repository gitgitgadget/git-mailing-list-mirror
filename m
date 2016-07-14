Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C60F203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 21:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbcGNVlg (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 17:41:36 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:33471 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbcGNVk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 17:40:58 -0400
Received: by mail-it0-f52.google.com with SMTP id f6so5438844ith.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 14:40:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nacHRf1OXcNEO1WhAK0g7kBdW/g06c2aoyaWTYeLMA0=;
        b=SMRfzCr5B5MJtr2t8hT9r82veLfZwfo2ELay7QB2dZaYzIKNKHdPxED2AZxtxKaDxk
         Igx/IVO+fa4t70p7f8Ey+Kw+P4NYnMSzeUSr0csjZRtDK9Jv1UEhiXAokyH8DR1HJoAf
         42JCgKRwHtDpvDNBDphW0stRWh4+5ZgX4dVEtC9RClv1EA8yjt+w+PIZ/R3MMy+U0MF2
         N9Zevef6xkBAsgnqoi1FFruZ946P0gVOvxZMWoP5ICgafdqXXny2rKdRLoV8+biAhES3
         TASQI4WxxEQgYA6puyUwacKFA8cJwROu8GyzsfW6h1ruC9kg0WAi5C5NbNXzl61L9SLd
         XMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nacHRf1OXcNEO1WhAK0g7kBdW/g06c2aoyaWTYeLMA0=;
        b=L1SZzg5eS8pY5/pWQJ/K8NKEh0dKaPoZhuT2XpKpB9DYmfMoPdT2Rp4pXtQ9hnFOdp
         LDVM5GKNot55e5mlNhsLuZhbh4nJPI2ditHYRPRQFt0gB4kjugZwFipgZ9SC6SC7Y5Kk
         NwZ06USfEHWDxTwza7RZGTItFGMNqqHXigKUdjo5eRoFLL+RhfvKuR7a8DHZcgOGHLjh
         +Kz6q87GjjSCBHu5AmrECcpHtnpF4KsibS8Ia1lW/88EhIxCgd7IFUJ1+0zW6xxMDJcz
         qdyU4qa2iD+hQOHnErsHb3O8g0TKcCUhr0uHeVS/KIsRXCG6CCjf10R3q4bQNI78oe56
         XLEQ==
X-Gm-Message-State: ALyK8tKTMo/05PwxdqHSGCnTz55CxUxp+6aCCeWhLlrnpQ0J7cSl4d9C3r0ClM/N2MhFTMB9LKMnjJ+oMGZoWYE8
X-Received: by 10.36.250.132 with SMTP id v126mr3209037ith.46.1468532457934;
 Thu, 14 Jul 2016 14:40:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 14 Jul 2016 14:40:57 -0700 (PDT)
In-Reply-To: <20160714213534.GB20645@sigill.intra.peff.net>
References: <20160714212454.16643-1-sbeller@google.com> <20160714213534.GB20645@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 14 Jul 2016 14:40:57 -0700
Message-ID: <CAGZ79kbu8H9=SX-KKupaNnLUu_VseNQmm5BTsOP4EopMwbqWuA@mail.gmail.com>
Subject: Re: [PATCHv6 2/4] receive-pack: implement advertising and receiving
 push options
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Eric Wong <e@80x24.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 2:35 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 14, 2016 at 02:24:54PM -0700, Stefan Beller wrote:
>
>> # interdiff to v5:
>> [...giant deletion...]
>
> Much nicer. :)
>
>> +static struct string_list *read_push_options(void)
>> +{
>> +     struct string_list *ret = xmalloc(sizeof(*ret));
>
> This struck me as a little non-idiomatic for our code base. The usual
> technique is to take a pointer to a stack-allocated struct, and write
> into that.

Oh, right! :(

    That's what you get when you grow up with object orientation all along.
    read_push_options() mentally mapped to "create a push options object if any"
    such that I can see if it is NULL or not.

I'll reroll a more idiomatic thing. Thanks,
Stefan

>
> I guess that here:
>
>> @@ -1774,6 +1806,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>>               const char *unpack_status = NULL;
>>               struct string_list *push_options = NULL;
>>
>> +             if (use_push_options)
>> +                     push_options = read_push_options();
>> +
>
> You will want to later check whether push_options is NULL. But you can
> also just check push_options.nr.
>
> -Peff
