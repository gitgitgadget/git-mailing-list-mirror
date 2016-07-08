Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5601A2070F
	for <e@80x24.org>; Fri,  8 Jul 2016 18:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095AbcGHS5Z (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 14:57:25 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37065 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662AbcGHS5W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 14:57:22 -0400
Received: by mail-it0-f51.google.com with SMTP id f6so10680471ith.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 11:57:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rJ8oz+z6W0EHDObzO+niexlHFwbS7fj0UEJL8JvrHEM=;
        b=CS11FyCEBDOqwDTLvhslP4TKOyCd4FCTO15N6KkcZ/gJppPav2Ie64Xk5h+e/gZYMj
         vtynuB47DZ7aW+OKAQS8vuNam/y26rBwFZPQKuX9xp9DdvmXTMo7A3NOQGw4kvLq6IJS
         9eLpYRrKNXayjCxdPkTUUpWJ6MxL/K7OFb4g/Cx23vrwMg8nyC8NmJhkddzxFUUQa0tO
         SkEN527A2reG45wbypa3KGrRwgDbl0OvnkJIYVQHTmemDlf7G7QX8CkOAF0GZo4D/zgb
         3SpHswQprj+PbESgG9fWO24hB7Tvh0ocp++o6YUBJfQm5fhrZ1lIu6IYVwiSiPo0lf7F
         KPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rJ8oz+z6W0EHDObzO+niexlHFwbS7fj0UEJL8JvrHEM=;
        b=esJ715QIJUJ6ijoH31zY6OH6ZdlrZwkMp6s1EML3sy/4hSZ6c2CMwstfumiMYPpr9m
         2TnoM1aDYpqK5M8senFL5WKrkdmuKT0uHdbqUgUtBIt6MJJArAK2j7U8Ipjn7J98xTvL
         SL+hkw8STWTx4RxhmDABHJzE4IQhFM3g3RC8xM2+SQ6QRI51YOB3WUw7tmVrXqOADfMb
         BYebH2Otml7IM+qKlVo8jvKQj3Tck/Etz8Ftq4Q4iUDaGhBycr3nf8wxEggp750Ethnm
         /1vr/ZSdghLtekuq8BPRktsjq6nZc/iWHI76FTg8NlADSGloW/UhRWOLgpvCw/X4Xc7E
         +/wg==
X-Gm-Message-State: ALyK8tKRnsdtpa+usB0NiFQQNOeLof8F0EBa4dTQsKka3clo2lFfjo6u8CJ2nBtL5AqPLLDDmsSqlyd6E9i/PlcI
X-Received: by 10.36.95.146 with SMTP id r140mr4790499itb.49.1468004240813;
 Fri, 08 Jul 2016 11:57:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 8 Jul 2016 11:57:20 -0700 (PDT)
In-Reply-To: <xmqqshvkkm86.fsf@gitster.mtv.corp.google.com>
References: <20160707011218.3690-1-sbeller@google.com> <20160707011218.3690-3-sbeller@google.com>
 <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com> <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
 <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com> <20160708175821.GA29326@google.com>
 <xmqqshvkkm86.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 8 Jul 2016 11:57:20 -0700
Message-ID: <CAGZ79ka8eHOx28Ja+S6DOGEOrV_ijUvi_NnjprhuzQ+3O9BAoQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 8, 2016 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Hi,
>>
>> Junio C Hamano wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>
>>>>> More importantly, if we plan to make this configurable and not make
>>>>> the limit a hardwired constant of the wire protocol, it may be
>>>>> better to advertise push-options capability with the limit, e.g.
>>>>> "push-options=32" (or even "push-options=1024/32"), so that the
>>>>> client side can count and abort early?
>>
>> Sorry to butt into the conversation late, but: I am not yet convinced.
>>
>> Is the idea that if the push options were very large, this would save
>> the client from the cost of sending them?
>
> Not really.  I have no strong opinion on the benefit of limiting
> number/size.  Stefan limited the number/size at the receiving end
> and made receiving end die with its message.

Jeff claimed we'd need some sort of DoS protection for this feature,
so I considered just die-ing enough for an initial implementation.

> I was merely trying to
> tweak the arrangement so that the sending end can complain with its
> own message, possibly in its own language, especially because it was
> unclear to me if the die() message on the receiving end would always
> go back to the sending end correctly.

I'm currently implementing Jonathans suggestion as it seems to be a reasonable
trade off (client hasn't sent a lot of data when it is decided it
doesn't go through,
the server can complain with a reasonable error message, only downside: no
i18n localisation support on the client side as the server will
currently report the
error in English).

That method will make heavy use of rp_error that uses the side band for
communicating the actual error message.

>
>> But this comes with a
>> downside: the server doesn't get to send an error message about
>> where
>> the maximum number of push options can come from (e.g., with a link to
>> a page where the limit can be adjusted, or with an explanation of when
>> clients tend to run into this problem and what they should do
>> instead).
>
> Hmm, interesting point.  That would be better told by the receiving
> end, as the way to configure it (if offered) would be different from
> installation to installation.
>
>> So I'd like to propose an alternative. What if the client tells the
>> server the number of push options early on (and possibly also a cap on
>> the length of those push options)?  That way, the client doesn't have
>> to waste bit sending the push options but the server gets an
>> opportunity to send a helpful error message on sideband 3.
>>
>>       server> HEAD\0push-options ...
>>       client> ... commands ...
>>       client> push-options 2
>>       client> my-first-option
>>       client> my-second-option
>

Another (slightly offtopic) observation:
If in the future we'll need to transmit push options >64k, instead of
splitting the push option to multiple packets, we could invent "large
packets". The current upper bound for packets is artificailly low, such
that the server is able to interleave sideband information with the actual
data in a fetch and have the client display the progress in a timely manner.
When pushing to the server we'd not need to have progress information
(the server doesn't care, and the client knows the size it is pushing).

As of today a packet consists of 4 bytes (hex characters) to indicate
the length and then the payload follows. So instead we could transmit
"v" (that is not a hex character) followed by a variable length integer for
the length and then the payload which has no upper bound.

In the release notes for 2.3 you wrote:
> * "git push" and "git fetch" did not communicate an overlong refname
>   correctly.  Now it uses 64kB sideband to accommodate longer ones.

That could also make use of these "large packets" instead.

Thanks,
Stefan
