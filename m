Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A387202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbdGMSWQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:22:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36333 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbdGMSWP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:22:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id z6so8082900pfk.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KJyFKnM3GXlINgWcy1AzpCGSEZuqxmBDI6pINZXJeXU=;
        b=UeJAaDvm4QGuF57W7vdzpNjtkGCuW6ys01TKHVXBtz8IQO3TS0B/jaavYJAgW0KJOO
         pMjxogFGSqqLF2VWmCJGPhKoHI4UbXlqXnXP4+S6XLgL5hP9aV99ntWRRPu6oy+WFMeb
         528p7UtWQ9RvY+zVWmMeVdKXHxCN25GD4ySaIS7CHOncCBEc9OEuWSvltmt9zqXd8bqL
         9hVvtjZYIWD9ESJOdJXFBTbfQHx6FlrRIrZhVAsvd57F7hmO7DjwV7bIJYniaF6J5eEB
         2i2z7M3pxBkQo2UWakoMfxeyFX4EFjqX/Jf4sdKQyWd1MBFmbjiirCykelNkXHM0CVtn
         7GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KJyFKnM3GXlINgWcy1AzpCGSEZuqxmBDI6pINZXJeXU=;
        b=YOw4gKaNJwZ/w+2VWCE7xFh4bWsgYmolTSzeU7AeDR616Hx7e3UYm8oFh6xUwxduJU
         607hyzCzHR/mdZT/TFYgiXNzkwTaqdNNzyJk71R0Pxv8fkacPOpwGarjX/J2n32e8U0v
         DU7BZdU4k3GpdXYnk+Nn4xeT3/WA4Hs+ZXFMhe+yNbrQ7jqTaa0nTXSFNIEUiUCFnSlu
         B7BviXqjiIuuD394wCX68ToyblDq4B/aqu70B7k+TQ13NUOVs+XxK077WkSTmHtNM1fi
         r0DC32eznxP3t/oBJYw4THcdyRi9b2UuN8HPzEpTh7wXbYASGTItL+vQAR4iw6S3FYpL
         je5g==
X-Gm-Message-State: AIVw110YUvUoJ6CUAH8/3yGZr2+TXf43JUnqLo5GXlJupRebvydE3E1v
        ke544WXDj1V3Kg==
X-Received: by 10.99.123.17 with SMTP id w17mr10574071pgc.100.1499970134654;
        Thu, 13 Jul 2017 11:22:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id y2sm10166045pgy.60.2017.07.13.11.22.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 11:22:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Nikolay Shustov <nikolay.shustov@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "groups of files" in Git?
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
        <CAGZ79kZaf7=uwCPJoPoDiAO9QS21bchaKZvDzWJi=ewPZw9PXQ@mail.gmail.com>
Date:   Thu, 13 Jul 2017 11:22:12 -0700
In-Reply-To: <CAGZ79kZaf7=uwCPJoPoDiAO9QS21bchaKZvDzWJi=ewPZw9PXQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Jul 2017 10:18:00 -0700")
Message-ID: <xmqqiniwxkmj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jul 11, 2017 at 8:45 AM, Nikolay Shustov
>
>> With Git I cannot seem to finding the possibility to figure out how to
>> achieve the same result. And the problem is that putting change sets
>> on different Git branches (or workdirs, or whatever Git offers that
>> makes the changes to be NOT in the same source tree) is not a viable
>> option from me as I would have to re-build code as I re-integrate the
>> changes between the branches (or whatever changes separation Git
>> feature is used).
>
> you would merge the branches and then run the tests/integration. Yes that
> seems cumbersome.

Sometimes the need to make trial merge for testing cannot be avoided
and having branches for separate topics is the only sensible
approach, at least in the Git world.

Imagine your project has two components that are interrelated, say,
the server and the client, that have to work well with each other.
In addition, you want to make sure your updated server works well
with existing clients, and vice versa.

One way that naturally maps this scenario to the development
workflow is to have a server-update topic and a client-update topic
branches, and separate changes to update each side with their own
commits:

             s---s---S    server-update topic
            /
    ---o---o----o----M    mainline
            \
             c---c---C    client-update topic

And during the development of these *-update topics, you try three
merges:

 (1) Merge S to the mainline M and test the whole thing, to make sure
     that existing client will still be able to talk with the
     updated server.

 (2) Merge C to the mainline M and test the whole thing, to make
     sure that updated clients will still be able to talk with the
     existing server.

 (3) Merge both S and C to the mainline M and test the whole thing,
     to make sure the updated ones talk to each other.

If there is no significant development going on on the mainline in
the meantime, (1) and (2) can be done by trying out S and C alone
without making a trial merge with M.  The same for (3)---it can be
just a trial merge between S and C without updates that happened on
the mainline.

I'd love to hear from folks in Perforce or other world how they
address this scenario with their system.
