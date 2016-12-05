Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60391FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 20:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbcLEUi1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:38:27 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33445 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbcLEUi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:38:26 -0500
Received: by mail-qt0-f170.google.com with SMTP id p16so325682127qta.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 12:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dFvglp8Re6fP5wIM7+eVz5CYkt0VkoYZucGc0T2wT3w=;
        b=aPnY9HfUr1zQ+jfEhEF4ue6Y3xPiz7hi3551k4RbXnR2wor4LoiCisFsFwz3Rqg9uZ
         OlKqISQApB4yV06gYxUF1W2h+IzRFLYoJ++JZtEl7yl2It9Qf7MW43o0QZ3Lb//+MD23
         9ZCfmiqMwZ9H49YPODkSPvXA2ZxyO3YrmCPhH6V0cyym92VykFAVTBAeWERfVCRmHZfX
         ucHhcdMKihCaQLyfAolHXJYLTEwzEkrbS7Y4R0MbdsXvNyI7oTXXaiKdGkTenXEQt3/9
         We6nk1mJBb0+PIB/srPCdsl9M+HLKCSg9QmPT72rCmYm/y25O0qfS/OOFqEP3D15CANO
         p8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dFvglp8Re6fP5wIM7+eVz5CYkt0VkoYZucGc0T2wT3w=;
        b=g9oSiD0HStYQ7XOp04xzJzqpCWhgX3jqAS6eZHooSxldVdnlVUymr3902FcRlz8zh8
         s/IvzX7MTcGebvh51dJ21JYCI+s5afrrQxNmupwNwR1Tix9hXwMw10++AHH6jfAFjpwL
         Pq6iXIlU5m7zDiZqsTs1vp7avK1N6WBpuD+RNZJ8G+ixYdDjSyVe7LRhcRwqYyda7OXa
         ZQFRUE90zdYtIaa2S3xv36dlcF0oil3cme5G81jWxx+Dm6DmU01/7eUSW2ePW9+5TYnZ
         T7KQiGJko2n9u9o02OumidkFXUMYIY/rmEITgRKXpy1gyOlXu9MezPBz0uJrY4PjpVoF
         NRBA==
X-Gm-Message-State: AKaTC00cwpNbqca5NVEQiahuc+CLwjwApr2hiul1yTeoupmbsG8kB6rkb1izHfo21MTTLKsmsgZmOo6MFsQ9pAmE
X-Received: by 10.200.53.9 with SMTP id y9mr50461531qtb.176.1480970305761;
 Mon, 05 Dec 2016 12:38:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 5 Dec 2016 12:38:25 -0800 (PST)
In-Reply-To: <20161205201237.GD68588@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com> <CAGZ79kauPdE1uiFSvBALkNiwXbnV6d6xhwLdWNQwRir_8rTG6Q@mail.gmail.com>
 <20161205201237.GD68588@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Dec 2016 12:38:25 -0800
Message-ID: <CAGZ79kbNMS-Hy=6y6EupcnwL58bhM=pesA8Mk_G+tjkL4yNNVA@mail.gmail.com>
Subject: Re: [PATCH] real_path: make real_path thread-safe
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 5, 2016 at 12:12 PM, Brandon Williams <bmwill@google.com> wrote:

>> > +       if (path->len > 1) {
>> > +               char *last_slash = find_last_dir_sep(path->buf);
>>
>> What happens when there is no dir_sep?
>
> There should always be a dir_sep since that only gets run if the passed
> in path at least contains root '/'

Oh, sure, that makes sense. When porting/running this on Windows, does
the assumption still hold?

>>     if (strbuf_getcwd(&sb))
>>         die_errno(_("unable to get current working directory"));
>>
>> Not sure if aligning them would be a good idea?
>>
>> Going by "git grep die_errno" as well as our Coding guidelines,
>> we don't want to see capitalized error messages.
>
> K I can use the other msg.

Well this wasn't a rhetorical question, but I was genuine wondering
if that was worth it.

When having different error messages in different places,
it makes debugging easier, because you have fewer starting points.

But this function is deep down in the stack, such that you would expect
other error messages to also show up , so I dunno.

>> > +               } else if (S_ISLNK(st.st_mode)) {
>>
>> As far as I can tell, we could keep the symlink strbuf
>> at a smaller scope here? (I was surprised how many strbufs
>> are declared at the beginning of the function)
>
> Yeah I can push it down in scope.  There will be a bit more allocation
> churn with the smaller scope but multiple symlinks should be rare?
> Alternatively the 'next' buffer can be reused...I decided against that
> initially due to readability.

I'd second to not reuse 'next'. :)
I guess we could keep the less churn-y version then.

>  And yes, lots of string manipulation
> requires lots of strbufs :)
