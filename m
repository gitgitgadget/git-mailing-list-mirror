Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601D320229
	for <e@80x24.org>; Fri, 11 Nov 2016 05:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbcKKF1e (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 00:27:34 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34745 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbcKKF1d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 00:27:33 -0500
Received: by mail-yw0-f196.google.com with SMTP id a10so390713ywa.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 21:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sC7PrYYw52XGAMmqdfyVGjoscP88WgT7ly508FpSaUg=;
        b=aAWK3SKyYAkIL+l+4gu9/t1Kba0XFE+jvYagC3/EM6xv3kiGlaBZerVjhzMpPYKo0y
         ntvE9rpLMhuEzsEf3n9rqrdB/x7BcEPROVji0pWtzizxT9O80MpaLeb6QwlHf6rQpUUq
         2gjtGN4Yp/UMvbVgOOImZ2uSHE9fKxFhlBi1fyG5yW9kVg8jJLNKHUimPPYQzGExahEJ
         wF/d1pgabAtzgESt0T1T16oqGBpJPv1BbXOT8W/Uz7CsNnGAXfAJMzFQtmconk8/Mp0Q
         G0m4qQ7JPCN1kUhNntky5ipasdY9NgDIEFOrAvSn8k3k3HmJ7xyQqGzYyfm48TUjrmpv
         VAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sC7PrYYw52XGAMmqdfyVGjoscP88WgT7ly508FpSaUg=;
        b=P7BUbJwSICWEhLltfWJtW7kJYwXMbQm1Nj3PjaPL687OTbBJVhjIePMJkXjQXwCGuF
         h8Zx3sZPdNLb1a9CSj96MtttZpbF8RN/OfmzfnQahoBJ6a+lAw7ckaa0m92YIi1YtEtq
         5W4tTnKbe/VGLynck+mVnvajWHRzxug+CuWWOVuDBaVI6SWJjLPWvGMhO5KWI9hy0ual
         TrHgiJES+8WINx1+XNrASfKdv5YdzX/prWLcXMDFLn4vvt1/JccMwNu2a3MdLdQ6XNBH
         4V2IuWDVQbWh7HRJwBXiwag7LynpbVPsdPm9+kgiuLz5C2GNMQMg7rrG6wocx3s0ro7e
         NCBw==
X-Gm-Message-State: ABUngvehKzQc4R2GurxX0VgTp6N0rJmD60pUFIR4rCqn3wh6muRbApElB5nq2luIyl0MSEugB2pJGW5aRkYr6Q==
X-Received: by 10.129.74.65 with SMTP id x62mr1117556ywa.59.1478842052966;
 Thu, 10 Nov 2016 21:27:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Thu, 10 Nov 2016 21:27:11 -0800 (PST)
In-Reply-To: <CAOLa=ZQCP2KtgLQie5p+PBiFjiNVFduUh=AmuLWcOKX5QA_BXA@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-4-Karthik.188@gmail.com>
 <CA+P7+xoavgQ=NK8GGGXf90ESuPs+mFwHzEWbsnjWjZ4V7TWpjw@mail.gmail.com> <CAOLa=ZQCP2KtgLQie5p+PBiFjiNVFduUh=AmuLWcOKX5QA_BXA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 10 Nov 2016 21:27:11 -0800
Message-ID: <CA+P7+xomLnpgM65W0TCUgO_n6XUu05jKkmQKgbUS9XxJu_46RQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/17] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 9:31 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Wed, Nov 9, 2016 at 4:52 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> Ok. How does this handle whitespace? The previous if implementation
>> treated whitespace as trimming to ignore. Does this require an exact
>> whitespace match? It appears by the code that strings must match
>> exactly. Would it make more sense to always trim the value of
>> whitespace first before comparison? Hmm.. I think we should avoid
>> doing that actually.
>>
>
> This does not trim whitespace what so ever and requires an exact match.
> I don't see the reason behind trimming whitespace though.
>

The comment was made in reference to the fact that %(if)<atom>%(then)
essentially trims whitespace, since if the <atom> prints only
whitespace it does not match.

Thus, it might make sense to keep it all the same and have this trim
as well. However, I think there is no benefit or reasoning to do so in
this case.

Thanks,
Jake
