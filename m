Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E892202AC
	for <e@80x24.org>; Wed,  5 Jul 2017 01:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbdGEB4K (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 21:56:10 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33163 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbdGEB4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 21:56:10 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so29230065pgb.0
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 18:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=66ndpc2c1e2pyapxgkUFq4aBk4fC1CtDInr1RyvwQhE=;
        b=eVIePHtq52y0u3gZJqaMfg6Xg1mOfTCsbUr+OcuOANUy8N2da6918qUH7iknGzieUt
         1Ssmwdr25cNpJoQ9IKK7yShpxVbfBie4K0upK12ISwnbdynxV0uEZcAimP5oElMdryH9
         gLvpR+ZlO2oNxgrM7DMNGDnjguLM3U07qHX20dwNNAR4X6lKAqGYkjdoJiIaZhaGrXHN
         XYdG++u2HmoZwG6bkVVtB+r+mgXUtm6XWa9biCCm+sbdp9dJDkp/LPNeeqTBof+ZAeBZ
         xy/K9JHTA+ICakzmGX28Ip8qQBgWzzgQ7hA7c5cy5XCJd1EIV4/PviH1WZMJ5j4IhvJp
         opPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=66ndpc2c1e2pyapxgkUFq4aBk4fC1CtDInr1RyvwQhE=;
        b=it7GGkujqV+ykfWpxVrqJdaLz+opUHmkhAILVlGUD1kEEYurXaSWYKTII0oaeczacy
         8qyXmnrLJHXiNqCcfeR2FlfBNV5t/OEuGzmzpV5ilzl+ExJ1DRqpcvLw3AvK4yZIugaN
         4Apdy+7zpfF3w18H1sWFjtniEmj8cxCfxP6hsbC0ar5UE0A0TzWqN/i6ZPNd7GU/B+yA
         ptWpsu3Q2bIMqr5pPQuxxkNuWku1eKtYDjqev4VoFI7kEdiWRUOWUKOq6+LvhvZwrr+d
         aR6Kjajjod+G2gYPUsUkqiTbnEVXwFlIO9tgCEjpjUa1b69xJIYEyp6BqFH8aj8RYgzi
         FnQQ==
X-Gm-Message-State: AIVw111LlIyVWHwo6a2tzV1HUF5cGsT65sUmD8lGRVpxeRo8j09zK7dq
        VKK3l/W2To+NN8LEZr0=
X-Received: by 10.98.65.76 with SMTP id o73mr17755941pfa.88.1499219764382;
        Tue, 04 Jul 2017 18:56:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:58ac:d78a:789c:c809])
        by smtp.gmail.com with ESMTPSA id r9sm46890738pfi.114.2017.07.04.18.56.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 18:56:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v3 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
References: <20170701220547.10464-1-avarab@gmail.com>
        <20170627121718.12078-1-avarab@gmail.com>
        <20170701220547.10464-3-avarab@gmail.com>
        <xmqqa84lmonj.fsf@gitster.mtv.corp.google.com>
        <874lutclie.fsf@gmail.com>
        <xmqq4luskt9l.fsf@gitster.mtv.corp.google.com>
        <87fuebbyvl.fsf@gmail.com>
        <CAGZ79kZqF3_PyrCnCMDyLNAUMRnvq96L3yoE0j=yzMigu4LUzg@mail.gmail.com>
Date:   Tue, 04 Jul 2017 18:56:02 -0700
In-Reply-To: <CAGZ79kZqF3_PyrCnCMDyLNAUMRnvq96L3yoE0j=yzMigu4LUzg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 4 Jul 2017 17:36:20 -0700")
Message-ID: <xmqqinj7k5ot.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jul 4, 2017 at 3:50 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>
>>
>> I think some invocation of "git submodule update ???" will do the same,
>> but I can't from the docs see what that is right now.
>
> '--remote' is what you are looking for.
>
> When we have the branch field configured, the workflow for *creating*
> the patch sent
> to Junio might be different than it currently is. Currently, you would
> send a patch that is
> produced as:
>
>   git -C sha1collisiondetection pull origin master
>   git add sha1collisiondetection
>   git commit -m "serious reasoning in the commit message"
>
> This could be 'simplified' to
>
>   git submodule update --remote
>   git add sha1collisiondetection
>   git commit -m "serious reasoning in the commit message"
>
> but as we had different branches in the submodule field,
> I wonder how much of an ease this is.
>
> For Junio the workflow stays the same, as he would just
> apply the patch, so I understand why he might see the
> branch field as pollution.

My reaction was more about "the rest of us", not me or those who
choose to bind a new/different commit in the submodule to the
superproject.

I was recalling a wish by submodule users in a distant past that
lets "submodule update" to detach to the tip of the named branch in
the submodule, regardless of what commit the superproject points at
with its gitlink.  

When those merely following along with this project did "pull &&
submodule update", I do not want the submodule directory to check
out the commit that happens to be at the tip of their 'master'
branch.  If "submodule update" requires an explicit "--remote"
option to work in that way, then my worry is allayed, greatly.

Thanks.
