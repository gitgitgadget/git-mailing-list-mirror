Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EE041FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 12:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbcFPMMA (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 08:12:00 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35015 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbcFPML7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 08:11:59 -0400
Received: by mail-io0-f175.google.com with SMTP id f30so39378977ioj.2
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 05:11:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vSK3V3ic+8HymTJyaXzbk7Sc+eBc9KoX+VJUHV3ob2o=;
        b=OxAqTpCe6YEabt7MzvPmh9T2EAteW0Hsw3BR4MBXyIyv8V1VBI1EYjpf7RTYXFX4TK
         ZZv4Jt/iQ/jceS8r47RA/DR/fxgBxwsYKjktM/swN2b72kWwdAeH3TRXr7N85hjilJAJ
         u8yR4oziHtg38+gb3rpLwIIwX5IWy6GnX4PKdb/UpG/8fXrxVIaMCactKQ9Nd+VNJXGJ
         5AlPYcM/Qm2MXst9jj48eazAj0ji/+e0jHnCnglOhUiBY7cg9lswTEaykj4Q/Ryau2K/
         Wvjb7CWhISq3Te7iIduBG2T5RP8eCA9K7J6SCbAu7h3mLAoFWgfB+F/gNQhy9cgIh+fh
         IvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vSK3V3ic+8HymTJyaXzbk7Sc+eBc9KoX+VJUHV3ob2o=;
        b=mNoQb66yKEUz+kJ0fPIie4hIobMHbTIOLjECDGDob5qZLiYZ4iDS8/n3d0N4lNcRiW
         +IozxOMZRT2fbrVytkBaSfvFtZAG1iQBt14Qb/KyOzi3skAWPG+nTBHFCXhsaCDL4Tgf
         z+U/RRleiJ9O+JofgLtw2vPgskrlHpvAmLNAQTGEhqMFo0AJirhzmV7QoDFFrBW/gb8F
         6/+Wua46Q5jT47mzu6OyY4zGXAjQYrHXgmIWShpn6Mzn8OLXVqoM2jI5mak/Ttw2oQVb
         oeuxm3N8dCGZMMxVZSx4ABdOHDRA1KW9toPcUkUVm9gNDkqpCwxXBegAD7tyHu/CDe5d
         MySw==
X-Gm-Message-State: ALyK8tKr63b/AIe4Wgf6jf28rH3eJNOVc3187oPmq2GnXlLCu+RbYGzVhVrIDM4RGrH8WlYc6E+JrzADhWUyMA==
X-Received: by 10.36.130.130 with SMTP id t124mr25321903itd.42.1466079118953;
 Thu, 16 Jun 2016 05:11:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.173.167 with HTTP; Thu, 16 Jun 2016 05:11:29 -0700 (PDT)
In-Reply-To: <20160616114452.GA21930@hashpling.org>
References: <20160616065324.GA14967@hashpling.org> <20160616074709.GA24412@duynguyen-vnpc.vn.dektech.internal>
 <20160616094749.GA20681@hashpling.org> <CACsJy8Bp6Mv2D1QCsR6MWhW2XMedo2svQKHBrx8AgA1Le56Grw@mail.gmail.com>
 <20160616114452.GA21930@hashpling.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 16 Jun 2016 19:11:29 +0700
Message-ID: <CACsJy8AdHMdj9y6WnqqNyEaaW-OHhqR3KTN0Gvd8sPqnbnaY+g@mail.gmail.com>
Subject: Re: [PATCH] grep: fix grepping for "intent to add" files
To:	Charles Bailey <charles@hashpling.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 6:44 PM, Charles Bailey <charles@hashpling.org> wrote:
> On Thu, Jun 16, 2016 at 05:57:18PM +0700, Duy Nguyen wrote:
>>
>> "git grep --cached" searches file content that will be committed by
>> "git commit" (no -a). An i-t-a entry will not be committed (you would
>> need "git add" first, or do "git commit -a"). So if I say "search
>> among the to-be-committed file content, list files that do not match
>> abc" (git grep -l -v --cached abc), the i-t-a entry will show up
>> because its fake content is empty (i.e. not contain "abc"), even
>> though it's not in the "to-be-committed" list. So yeah, correctness
>> issue.
>
> OK, I think there is an issue there but it's not with "-l -v --cached"
> but rather with "-L --cached". If my understanding is correct, "-l -v"
> means "has a line that doesn't match" whereas "-L" means "has no line
> that matches".
>
> Does this sound correct? I'll try adding a new test.

Yeah "-L --cached" should work the same, I think.
-- 
Duy
