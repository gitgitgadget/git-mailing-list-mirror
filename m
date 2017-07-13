Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B454D2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 21:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbdGMVta (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 17:49:30 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33768 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdGMVt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 17:49:29 -0400
Received: by mail-pf0-f181.google.com with SMTP id e7so35531607pfk.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CX4rC4ONws44nNLPNwFzWye7vY60WbSXPatSJ0bJ7FU=;
        b=MPJWWuMmu9rC42U63fnaC57HGa1VwHrjfVOYQx69Q6E6SALkVrCact/XITe4dI2s7a
         iTANzbl9ZnCLglVclD/LWYWSLpkProemP/Z1aEXEUQf/nfP55pZRJGtdrtLu3/ieGYE9
         O1loqtReGQkAS6M33CmOg5ussP+xGeBpX6WnoYVKyOhxMCJcbOdaIDX7E3jLpHn4C7qO
         Tskf0HUc40ngZqPYxx6xqxM+5yGk3eaPXlU2ng4lzi+94Z/wAz9IRoXvcylv52MkvhlH
         rhyPnNzf8WpNdgg712+QdRdmM8mJgAp2YJf+gDgSqaHIcc5YX4g0sLdCPHmtaHxQCO9M
         aeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CX4rC4ONws44nNLPNwFzWye7vY60WbSXPatSJ0bJ7FU=;
        b=m3U0Gp+dJcAevrqj+Q29uZe6GIRgZetGg/T25F2jzEgMMdnymxsNI0sZQwNDlsxuvY
         t85mhqLafc8h5GTuplinmHVSaawVPTH7aynYsZ+cUiCCFPquisnKBqNhXwR11R2+SMIk
         RjGGZNC2WPD4j/qkKS8fBR730FSDg2QZtacDrDDBFjW2MVzFSwE3YgAakRn12rqqAMN2
         1i7+tSXd4F7fBuO63I6nv5Acs0+cRxsv/4zA2WlHVZzRpIDCE7zgnn3OkQyQKy2z5K9X
         UcVPoN1lFmj39S5/UPQzspXUWkmcmYEl4O/62NsHa4GpEvoTfH9TGiZxAqN3YFz2Xme2
         QFNA==
X-Gm-Message-State: AIVw112CsrE7cSALTBnbcM0nXkE5uAgIFaKUQ9TAXClHB/SXtCvV8SOi
        +HPjThnfrvY/4b0V5AQ8OzAVAl7OtJTS
X-Received: by 10.99.144.65 with SMTP id a62mr11366828pge.108.1499982568714;
 Thu, 13 Jul 2017 14:49:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 14:49:28 -0700 (PDT)
In-Reply-To: <xmqqvamwt4ju.fsf@gitster.mtv.corp.google.com>
References: <20170713004415.5051-1-sbeller@google.com> <20170713004415.5051-2-sbeller@google.com>
 <xmqq4lugukju.fsf@gitster.mtv.corp.google.com> <CAGZ79kb3_K8NxpHuzAdHhSLWUcbw_X3qVVspPeuSNA4sAeT-Kw@mail.gmail.com>
 <xmqqvamwt4ju.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 14:49:28 -0700
Message-ID: <CAGZ79kZOCtk9YM0=dUic5MHMWLZgb8xeYsFX0VaMNbFrjw=sUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tag: convert gpg_verify_tag to use struct object_id
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 2:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Jul 13, 2017 at 1:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
>>>> index f9a5f7535a..ed8329340f 100644
>>>> --- a/builtin/verify-tag.c
>>>> +++ b/builtin/verify-tag.c
>>>> @@ -56,20 +56,21 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>>>>       }
>>>>
>>>>       while (i < argc) {
>>>> -             unsigned char sha1[20];
>>>> +             struct object_id oid;
>>>>               const char *name = argv[i++];
>>>> -             if (get_sha1(name, sha1)) {
>>>> +
>>>> +             if (get_oid(name, &oid)) {
>>>>                       had_error = !!error("tag '%s' not found.", name);
>>>>                       continue;
>>>>               }
>>>
>>> This part is already done, it seems, in bc/object-id topic, even
>>> though other parts are not yet done?
>>
>> Oops. I assumed the latest bc/object-id would have been in master
>> already, but after checking it is not. 967635dc3c2
>> (builtin/verify-tag: convert to struct object_id)
>> converts this part, although there are 2 differences:
>> * I added a stray newline before get_oid
>> * The argument to gpg_verify_tag is a sha1 or oid
>>
>> So yes, this produces a merge conflict. :/
>
> That is OK.  This actually shouldn't create any meaningful conflict.
> Both try to do the same code, with only a blank-line difference.
>
> As Brian said bc/object-id would be rerolled, I was wondering if I
> should queue these two patches (even though I already queued them)
> myself, or it would be better for you to send them to Brian to make
> it part of his series.

+cc Brian

Snarkily I wanted to link to an essay "large patch series
considered harmful"[1], but could not find any. So a couple
of bullet points:
(a) humans dislike larger series, hence fewer reviewers
(b) the likelihood of a mistake in new code is proportional to its size
  We can use the number of patches as a proxy for size
(c) If a mistake is found, the whole series needs rerolling.
  The effort of rerolling a series can be approximated with
  its size as well.

From combining (b) and (c), we conclude that the effort to
land a patch series is O(n^2) with n as the number of patches.
Also from (a) we conclude that two smaller series containing
the same output as one large series, has better code quality.
So with that, we conclude that all series shall be as small
as possible.

So I'd ask to queue these 2 separately, asking Brian to drop
"builtin/verify-tag: convert to struct object_id"

[1] https://www.cs.princeton.edu/~dpw/papers/hotos.pdf, 2005
    seems interesting to me in hindsight.

I can also send my patches to Brian, as you (both) like.

Thanks,
Stefan
