Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13F52070D
	for <e@80x24.org>; Fri,  8 Jul 2016 20:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbcGHUa2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 16:30:28 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:36431 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbcGHUa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 16:30:27 -0400
Received: by mail-yw0-f181.google.com with SMTP id b72so46270619ywa.3
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 13:30:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OS/9meHYdza3LNa/gm+vM9xB2WdUExZRAsP79ub5kVU=;
        b=ao9dM6QDQy05Ip2oj831OAy9S/ZeVh6Nw5VnqWET7/y5+7fOtmyT3bHJEiJeG6gV1O
         uLHO3uxMSgIObcJq3trOalGjoZaEZ//PXXx559HBD9LK3wjqU5LIoWcygKIM9wALVuln
         lynPCghEW56jXtOeBDFS3BI++GE1ThusJPr/JhU/xH7n4utQp0vi13cH5VSNDRnKRYqn
         rAllKi7xnK4Ip3Zb5SVuIr6Sdx3f2Ag2fSXMulNQOzgpM+giuZOkwHx5QMmR0QLq7+HV
         qEi1WSrPMwXhfOCORlEWcIZIVuCM8+yzXUPmKNNRd180VSpmsYSv0HfLSm9lDkwMXr5a
         Fc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OS/9meHYdza3LNa/gm+vM9xB2WdUExZRAsP79ub5kVU=;
        b=YIla7oqFkpRakfWSgs7pWeUY8Etpv+N6/axiz2PC0DOFpc/KZEQhjeDsO8xMUSt8vW
         10331c6jbeimpgFeRI9kkTGC1x3r5+7p+MsiqwLAF8SHBdorD86WZysKqytmesUulRvK
         Ddd6v0JBRICjvE8rQIcuWJ1Fcrjf4dHW1++pd9llCTq7BIDCOej8uZ0ooQELHp+oetjY
         1UU+6Hpfqdn3Dn3t1BODFfwdz15JeXrG0PscZhpvobhHfOVZKQD4CUF6t0bJqkeTIhIQ
         2Nz/6lxGpIMQUhr6o9yfM4dHeO9QhvGqHZunq4BRZzgw60v7+8IazMNKNCCFa0AZ5Mra
         YiAQ==
X-Gm-Message-State: ALyK8tLB5uP/hJFm+CqqoQ55tOwMJ4EPoNdNayU7DGLK6t7xG3sYZNxgXsIqP6tsMXz+pKQvTWX23JGXoihUEg==
X-Received: by 10.37.37.151 with SMTP id l145mr5536310ybl.41.1468009826165;
 Fri, 08 Jul 2016 13:30:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Fri, 8 Jul 2016 13:30:06 -0700 (PDT)
In-Reply-To: <20160708192504.GL19871@thunk.org>
References: <20160708025948.GA3226@x> <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
 <20160708064448.GA18043@x> <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com> <20160708192504.GL19871@thunk.org>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 8 Jul 2016 13:30:06 -0700
X-Google-Sender-Auth: A1FebweWOwtEFxzihGMdXv1aC_k
Message-ID: <CAPc5daWDi1P-xFaEYf1zzz7m3g9wengQPjRzxhgu6jVM9AKtyQ@mail.gmail.com>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
To:	"Theodore Ts'o" <tytso@mit.edu>
Cc:	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 8, 2016 at 12:25 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Fri, Jul 08, 2016 at 10:14:33AM -0700, Junio C Hamano wrote:
>>
>> It cannot be "anything directly under .git that has all-caps name
>> that ends with _HEAD".  The ones we write we know are going to be
>> removed at some point in time (e.g. "git reset", "git bisect reset",
>> "git merge --abort", etc.).  We do not have any control on random
>> ones that the users and third-party tools leave behind, holding onto
>> irrelevant objects forever.
>
> What about anything that is all-caps and ends in _HEAD which has a
> mod-time within the last N days?  (Where N is 2-7 days.)  If it's
> older than that, it's almost certainly stale...

I can imagine I'd start hacking on a project that I rarely touch, give up
resolving a "git pull" from an unconfigured place (hence, some stuff is
only reachable from FETCH_HEAD), and after 2*N days, come back
to the repository and find that I cannot continue working on it.

Turning the rule to "*_HEAD we know about, and those we don't that
are young" would not change the situation, as I may be depending on
some third-party tool that uses its OWN_HEAD just like we use
FETCH_HEAD in the above example.

So I dunno if that is a good solution. If we are going to declare that
transient stuff will now be kept, i.e. keeping them alive is no longer
end user's responsibility, then probably we should make it end user's
responsibility to clean things up.
