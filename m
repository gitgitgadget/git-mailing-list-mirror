Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681EE2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933199AbdGKSqG (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 14:46:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34295 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932818AbdGKSqF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 14:46:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so95156pfe.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iG08NNdJgGTX9X7NphkeNv3RoXQstFw27QWuJ/moYIo=;
        b=NuurAIgGTn6iiRQ83Xzg7Wy/UEp/3MHbu4p3pyT6nCZGs6Akntecezi5J4IWFfQz+4
         i3yWuLwHjSFPK02pTljxp4FcZlZs3xLLnPBocFmoWodOueXllKR24+NMzNqaWUMzl3mP
         z8P/EWAymNiyDbGZxNHeH5t4jY3t7WJ3AkYxapzebaCwUnTLdQ+gdbY+FFs0IHjWahYT
         2dLBRer1rWm6nBU7VlDHaGqfCyRxPrALrH6xclsJkg7kFsHKpExq8JXhA+OKX6z3DkSk
         FYh/zOkIcA2dzZMtd1iSRHgXS8KiB5x0wMPRYkPBhqTNe+8iVkG0rHvhmel14Xa6QoXG
         jF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iG08NNdJgGTX9X7NphkeNv3RoXQstFw27QWuJ/moYIo=;
        b=s3g1MnusdnWfp8k8/onFo6Ad60QLSNy2QUMt1ikwS30RyUiZu9REVYXCYJNReFvfka
         8PAwn3q8+83rGk4Hssu0XMw1PAI+AQGvw60gDqsMSkKJvMT2TwZQGk/WKPtC6zykWu4U
         h7dKHG3HewFk2KPBd5p+UmMzf1FwbfGmtxbuq19AWt8TAAftGFyBsj5iU90dlENS4Pi3
         gWXVlY9fhJ8HGiliqDa64VZHwQWmUxSEgEf7aFMT6UKL6rUB+r/+DbuAq2CuDCIC9PIw
         vipYdcMsi3kYHgl2BDvOVx8PX0CPj1I9UFQyUwsPBhrr04qEaSAwF3f33UM1JDP/C/Qu
         WPCw==
X-Gm-Message-State: AIVw112j7A4RqGvpQ28ew/QVO4TZK2NpazAcSeJAQ3uV9YdZ247MRcVn
        ZSeHAdboMGtYzA==
X-Received: by 10.84.149.197 with SMTP id a5mr1358330plh.3.1499798764870;
        Tue, 11 Jul 2017 11:46:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id e124sm66840pfc.76.2017.07.11.11.46.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 11:46:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, Ben Peart <peartben@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH] object store classification
References: <20170706202739.6056-1-sbeller@google.com>
        <xmqq7ezldlhe.fsf@gitster.mtv.corp.google.com>
        <c9a6f3f0-e338-a200-6b57-48b5d926d31c@gmail.com>
        <xmqq4luochtv.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbTzZLD5FDidDG8SUrKpgRGvA7f9HAu77w+iW8A8zLMAw@mail.gmail.com>
        <20170711180122.GG161700@google.com>
Date:   Tue, 11 Jul 2017 11:46:03 -0700
In-Reply-To: <20170711180122.GG161700@google.com> (Brandon Williams's message
        of "Tue, 11 Jul 2017 11:01:22 -0700")
Message-ID: <xmqqd1963j84.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>>   the_repository -> the_object_store
>>   but the object store is a complex beast having different hash tables
>>   for the different alternates.
>
> After looking at the patch and some of the comments here I think that
> this is probably the best approach with a few tweaks (which may be
> completely unfounded because I'm not familiar with all the object store
> code).
>
> In an OO world I would envision a single object (let's say 'struct
> object_store') which is responsible for managing a repository's objects
> no matter where the individual objects came from (main object store or
> an alternate for that repository).  And if I understand correctly the
> single hash table that exists now caches objects like this.

I would say that conceptually an object-store object has an
interface to answer "give me info on the object I can refer to with
this object name".  At the implementation level, it should have a
hashtable (lazily populated) for all the objects in a single
$GIT_OBJECT_DIRECTORY, grafts/replace info, and a set of pointers to
other object-store instances that are its alternate object stores.
You'd need to have a mechanism to avoid creating cycles in these
pointers, of course.


