Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF52203E2
	for <e@80x24.org>; Thu, 10 Nov 2016 17:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965544AbcKJRqL (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 12:46:11 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35732 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965078AbcKJRbi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 12:31:38 -0500
Received: by mail-yw0-f195.google.com with SMTP id b66so7414120ywh.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 09:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g5TyBnzSkpqZjz0H3bfuov+S7Ug+f6O8LPfgXBp0RMA=;
        b=LbWim9o4v5Ctqo6EuTZMb9f9OvIYJTthlAn5Ok/M/gLGqsgrPuBmYjaD3XmloVC7yu
         J1a1SUqL809QhO9gkfjL0/4DQBGFojUweZP+YJNSLMqiUzuq+1X8kHxB7MctJ8xAYkrF
         wPT5NQ1L+ix3Q8tMAxQGQLR9W++GNSfENeGf17/dmntQ1xdLWciARdRdwE3VA7Bvm0uO
         V94fJtktGiCFyUIJwqKZKA0PIX9+5LhebRiSp123OfaSDTIRzLN0bAF9ximjY03E+Af8
         GIt7kWcNyL2U7BkfTH+LdwncL24kZ5CZJVwDtmnwOnUdgUl2E84A3uMnFfF/kBjJcoeL
         8cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g5TyBnzSkpqZjz0H3bfuov+S7Ug+f6O8LPfgXBp0RMA=;
        b=jRrNlKJr6+Ht1hdeOqG+Ei1WyW/ulzCboeFyl1SdVYgLLnxivUz7c0UgFTsf4WjCfY
         ZjvncwI4Xci4mzhypILyvvcP2V+4B0tDfuHJDqU6e6zHvYuAllzIWCIV1vX1Luqe89Wv
         IzKkJCknGvnoKMOdIJ5H56Uvrwv+kQnsF6WT3r954eiNIDahLa9oze0hLseVUy3auGv5
         0lNnL68KLnXuQNrc0gpHw8SvBzuqY8jBuwWG7L/AG+AM9BR2ka2ekdX2+8eQ9S4yrfP9
         YqKW9hZs50Rv/SRLpneR9huM4+d07o2gCMhemdD+8u7Np+WACPHfkoQhXFBlydSiwEzs
         O71g==
X-Gm-Message-State: ABUngvcfe3f/FOyoIMqwaLYOUJhcw9K/gqV+dm2i20833lfzcQmgPQRzT7UbOaOVUMNKaRPrn+PmRaIOftpwbw==
X-Received: by 10.129.85.11 with SMTP id j11mr6000317ywb.123.1478799095962;
 Thu, 10 Nov 2016 09:31:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Thu, 10 Nov 2016 09:31:05 -0800 (PST)
In-Reply-To: <CA+P7+xoavgQ=NK8GGGXf90ESuPs+mFwHzEWbsnjWjZ4V7TWpjw@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-4-Karthik.188@gmail.com>
 <CA+P7+xoavgQ=NK8GGGXf90ESuPs+mFwHzEWbsnjWjZ4V7TWpjw@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Thu, 10 Nov 2016 23:01:05 +0530
Message-ID: <CAOLa=ZQCP2KtgLQie5p+PBiFjiNVFduUh=AmuLWcOKX5QA_BXA@mail.gmail.com>
Subject: Re: [PATCH v7 03/17] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 4:52 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Ok. How does this handle whitespace? The previous if implementation
> treated whitespace as trimming to ignore. Does this require an exact
> whitespace match? It appears by the code that strings must match
> exactly. Would it make more sense to always trim the value of
> whitespace first before comparison? Hmm.. I think we should avoid
> doing that actually.
>

This does not trim whitespace what so ever and requires an exact match.
I don't see the reason behind trimming whitespace though.

>>  In addition to the above, for commit and tag objects, the header
>>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 8392303..44481c3 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -22,6 +22,8 @@ struct align {
>>  };
>>
>>  struct if_then_else {
>> +       const char *if_equals,
>> +               *not_equals;
>
> Ok so we add both if_equals and not_equals values. Could we re-use the
> same string?

If we use an union then we'll be saving space, but that comes at the
disadvantage that
we'd need an indicator to show which subatom we're using (i.e
if_equals or not_equals)
for the checks made in the code below.

At the expense of keeping two pointers we avoid the extra indicator
while keeping the code
elegant. Either ways not too keen on this, up for discussion :)

>
>>         unsigned int then_atom_seen : 1,
>>                 else_atom_seen : 1,
>>                 condition_satisfied : 1;
>> @@ -49,6 +51,10 @@ static struct used_atom {
>>                         enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>>                         unsigned int nlines;
>>                 } contents;
>> +               struct {
>> +                       const char *if_equals,
>> +                               *not_equals;
>
>
> Same here, why do we need both strings here stored separately? Could
> we instead store which state to check and store the string once? I'm
> not sure that really buys us any storage.
>

same as above, we utilize the fact that its easier to check the strings like

    if (if_equals)
        ...
    else (not_equals)
        ...

else we'd have to have an indicator to know which to check.

-- 
Regards,
Karthik Nayak
