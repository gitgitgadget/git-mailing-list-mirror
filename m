Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11672035A
	for <e@80x24.org>; Tue, 11 Jul 2017 20:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933298AbdGKU2B (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 16:28:01 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35073 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932577AbdGKU2B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 16:28:01 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so345152pgc.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 13:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UsGM2beZmaMdHTrDjsm/M/Yx3zULro403F+R314eQV0=;
        b=NrKze03KsR9OKgi9pPWDlTLcHuXwAtDXkGodhLTs8/ReMXTAYvT4QjvGLb8AoE8+CH
         Cx4WKyB/mPNQzKtyeQ+vszRGhpc0B2EKpeN0owLv+J3bUY3Ul4//Hpw/Kjaps5DUkdkJ
         TxmdzwHkEw26PwsTfv5cp5/nVnEOqVXqjtiCozUgCgrHDbE18se3ThD5xSpFssjs/v56
         vlxGuwGcrjYeOAYrX62ldOEXeyTgsZtwowJDm7gK4hOhrw+vfRG0YcNICHTQF6sFnQe2
         uaZIdhYdPi7dm1qyIA/nor32U9iLad5IFEB3hDjMZ8oYtoejoocj2zS2AiaxzDz6FNfC
         18pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UsGM2beZmaMdHTrDjsm/M/Yx3zULro403F+R314eQV0=;
        b=g1j4SfvsCHl4weZPC3OVFyrEl2WMUU850wjs/2wBKXtYLsi3YbxhY9XCL6gGilZwKF
         lW625N3RUjMOnxOKeC4n3O9CnWuGQg8mnkXSG0+dPquBdMdUdbaUl0MyqFNaybHgChIs
         lDBKKcqvBLlCCqZF6qKxtkJ66H+lkxvJ5JPFYVKPZXn2Y+J0mOOFOVJleB3tz01pVFTq
         l/3G0S3i4JJC9neJl+qLmCHvHexKDcYh34DG+yDttvhdQB4XeVE+aSCZS6mTRyGOIFXK
         sETm4Y4WLCgp5NMb2gv4NbsmwSQjzsfMyGzUwUWrw7Rv8YYZMZptI8J6RlwxM2gGDiCL
         z5sQ==
X-Gm-Message-State: AIVw112Do9Y9iujhgxnBvorUWxqPgOSMXUXiTgnJQIhyO29qkLco9/gf
        WAUVkn8ELoBbQA==
X-Received: by 10.84.171.197 with SMTP id l63mr202887plb.167.1499804880188;
        Tue, 11 Jul 2017 13:28:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id g12sm317058pgr.16.2017.07.11.13.27.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 13:27:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Ben Peart <peartben@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH] object store classification
References: <20170706202739.6056-1-sbeller@google.com>
        <xmqq7ezldlhe.fsf@gitster.mtv.corp.google.com>
        <c9a6f3f0-e338-a200-6b57-48b5d926d31c@gmail.com>
        <xmqq4luochtv.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbTzZLD5FDidDG8SUrKpgRGvA7f9HAu77w+iW8A8zLMAw@mail.gmail.com>
        <20170711180122.GG161700@google.com>
        <xmqqd1963j84.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaCXLtauL5UNT-8gCpzs5A+LU6Ed41+_LdBO7zDyW1Dyg@mail.gmail.com>
Date:   Tue, 11 Jul 2017 13:27:58 -0700
In-Reply-To: <CAGZ79kaCXLtauL5UNT-8gCpzs5A+LU6Ed41+_LdBO7zDyW1Dyg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Jul 2017 12:49:43 -0700")
Message-ID: <xmqq4lui3ei9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> At the implementation level, it should have a
>> hashtable (lazily populated) for all the objects in a single
>> $GIT_OBJECT_DIRECTORY, grafts/replace info, and a set of pointers to
>> other object-store instances that are its alternate object stores.
>
> So one repository has one or more object stores?

One repository foo/.git/ has one foo/.git/objects/ directory, so it
has its own single object store.  That object store may refer to
another object store by having foo/.git/objects/info/alternates.

Similarly, foo/.git/objects/info/grafts and foo/.git/refs/replace/
would belong to the single object store repository foo/.git/ has.

> I would expect that most of the time the question from above
> "give me info on the object I can refer to with this object name"
> is asked with the additional information: "and I know it is in this
> repository", so we rather want to have
>
>   lookup_object(struct *repo, char *name);
>
> instead of
>
>   lookup_object(struct *object_store, char *name);

Absolutely.  That is why repository has its own single object_store,
which may refer to other object_stores.
