Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98B0203C2
	for <e@80x24.org>; Fri, 15 Jul 2016 21:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbcGOVT0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 17:19:26 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35846 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbcGOVTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 17:19:25 -0400
Received: by mail-yw0-f179.google.com with SMTP id w127so114084763ywf.3
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 14:19:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WhD3+fgE09MAO16W/RZfluA13nhJJA1z2Ym0awqUwk8=;
        b=Udf28f2rvhJLBbyMOvDeVuYGaaOtf2F4q6QBLqEYyxCwvhGWNEqgOexVzSev1miTF7
         TKn0As28iwj81LGDOqbTx1QTvRt7Dr8T/4A1TfgipiN8CV5tGPfPg/ZKm8561T0u9zrf
         1ZV7M/j8a3Q5+hbvpnhSrBt8Z5A1j5gsdwdzIBQ6MDjVZO3ZzoJA0Hw92PVDIwzlApzp
         6YBwBQDPhT8XyR6dQGfKzhTs9SgSdsaJkK5TIYJ7/XTrS+4zS1mSAPc6C+TwOKBcEE5Q
         vrFapYGTZ5QyvRI+OA7PCpS0TYHjpO/czVgW0W5pqAY22UwVUnCIVRUWzPVY1dI8jnuB
         gkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WhD3+fgE09MAO16W/RZfluA13nhJJA1z2Ym0awqUwk8=;
        b=lSat3JegvtH8ieIJI7S5zfZmmhTnQgKXBTS/er69w8vypXmU6GVMibYZJAWUnnoD/S
         lUn5RjxnsCkkaBJx5auQh6FF+EuzsZCrs6Bxwvyt9GwfBEx9Mz6h4HNO0bnyxUwNZeGg
         un96+/+QUgkUNPp5TfBYddN8so2qHH7VHZX3b/ckj4ZZ6WkhNMLLo9KynBA0wlswIL0/
         FO6+7NIdKGwB5nm+v4BeX6v14fOiZslF956pnWm4kWZgJq9LZqt0BuvTzgEQw47HAysp
         zVxGWIWBZLCN/h53GTBAPS+P5tR7qL500ldP7/WNAs4Mq1mSjqlLnO3DW6oIqI0T3L/o
         mh5w==
X-Gm-Message-State: ALyK8tIT7fQ+k6ud2ZClsTQJu3lQU7c3F9+Oc7N77HxNGj7GLLgEU1D3IsAF08VibBimFqVsH6oJMd6zhgfx+w==
X-Received: by 10.37.0.137 with SMTP id 131mr14612142yba.28.1468617563956;
 Fri, 15 Jul 2016 14:19:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Fri, 15 Jul 2016 14:19:04 -0700 (PDT)
In-Reply-To: <2ED67396-2530-4D1C-8F21-1C30983DB9DC@kellerfarm.com>
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com> <2ED67396-2530-4D1C-8F21-1C30983DB9DC@kellerfarm.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 15 Jul 2016 14:19:04 -0700
X-Google-Sender-Auth: gIAGH40PnfBj_4dpbJ-vqfhoyL0
Message-ID: <CAPc5daWZofdZnE0VQyFX2sBQyEDvAPmU+4rmHe5rvh7eH001ZA@mail.gmail.com>
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
To:	Andrew Keller <andrew@kellerfarm.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 1:30 PM, Andrew Keller <andrew@kellerfarm.com> wrote:
> Am 15.07.2016 um 12:34 nachm. schrieb Andrew Keller <andrew@kellerfarm.com>:
>
>> I pulled out the source for version 2.9.1 and briefly skimmed how run_commit and
>> prepare_to_commit work.  It seems that Git already understands that a pre-commit
>> hook can change the index, and it rereads the index before running the
>> prepare-commit-msg hook: https://github.com/git/git/blob/v2.9.1/builtin/commit.c#L941-L951
>
> Quick question: Why does Git reread the index after the pre-commit hook runs?

Offhand I do not think of a good reason to do so; does something break
if you took it out?
