Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D5B20248
	for <e@80x24.org>; Wed,  3 Apr 2019 07:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfDCHcd (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 03:32:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39700 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCHcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 03:32:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so19885325wrn.6
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 00:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=26buhicOCnYtzBNo+SiITSMGDgVEj4A+KLH2cwn/tqo=;
        b=QgZhwGEvoSqbs4n7Tq7lRbDb0k675vYbutgh6o4IGqOMCFfxUIQZgPAAVLAmuyoKZU
         JSDJInQFACttghQ5pY2C4R+NqiqI4eVax7A9KVg8BMHp6AZwTOGTOxWOgkaMsksKIwaE
         IiSvIn4oXFVFrHAR6X9iJT78gEOOXTP+v3+r2ZK8qIJP/y9isya1Q3pp9cpoBTc6Upzq
         OTAedgA/zYQ/NkTm/jrprkr4YUKRyUwlakISj53DeZOXqcpEBwCBF/5AEPXHztxOv5c9
         DNadVKT7ob4O50MxWcq0zp/DguGQKXDUYBE6syZZ1EWUJ4r4GSSM1xkhWKYYsGw1y9iE
         0yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=26buhicOCnYtzBNo+SiITSMGDgVEj4A+KLH2cwn/tqo=;
        b=oiKgoPFwbZEL6yRUBVGqqAZVIMFqNdZOfzHs9cAqcCdHCbUSFJRnDaCi/NURXqU0yg
         sSPiKFvGiA3fVLBrGm+pI1jIpF0QUK6OUchq4xAmsXR21nyXGClu1dW93MnDLBbP4d1G
         EUwzTN3dU5IXP4/vAwfOY5hW8SWhnigaI/SnkG3LFMpgfh7uzCtF1PNWvrt+trvFATmS
         3yNMcxFtjZwm3a/MQ3GT+LV/QgZD+qpdTFNcf8lHMqKMQMSAwRJYBePt8zfqXpamxqDu
         +Kurh1BLf7K7Tv8x0nlqXHxKKSS0fPaLmTr8b6iWMYilU6SsQM55+/zqCmOePGZZQdZq
         jeWw==
X-Gm-Message-State: APjAAAUGi6fLP6lRzNBgtKPcyuAd/mRW/1tRiYbXqAi5oXSMqg0l4Jin
        Vsoq3R/PGqzw9nmZfjzKFBVHsGsBvYI=
X-Google-Smtp-Source: APXvYqxZgYgS7pDKMWMY/QW5rXSK6j/NE0bW08RSfzoHRHPjWKa1Bp8vHEstQMYoSrKBYCuepw3mZQ==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr35053170wrq.119.1554276751176;
        Wed, 03 Apr 2019 00:32:31 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h9sm12782364wmb.5.2019.04.03.00.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:32:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
        <20190402230345.GA5004@dev-l>
Date:   Wed, 03 Apr 2019 16:32:27 +0900
In-Reply-To: <20190402230345.GA5004@dev-l> (Denton Liu's message of "Tue, 2
        Apr 2019 16:03:45 -0700")
Message-ID: <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This is the first use of the '%n$<fmt>' style of printf format in the
> *.[ch] files in our codebase, but it's supported by POSIX[1] and there
> are existing uses for it in po/*.po files, so hopefully it won't cause

The latter is a stronger indication that this should be OK than the
former ;-)  Thanks for digging and noting.

> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index 88620429ea..ec4f6ae658 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -90,4 +90,6 @@ advice.*::
>  	waitingForEditor::
>  		Print a message to the terminal whenever Git is waiting for
>  		editor input from the user.
> +	nestedTag::
> +		Advice shown if a user attempts to recursively tag a tag object.
>  --

In addition to 'advice', we may have to add a configuration to help
projects that wants to tag tag objects regularly so that they do not
have to keep typing "--allow-nested-tag".  But that can wait until a
participant of such a project comes forward and makes a case for
their workflow.

> +chain of custody by signing someone else's signed tag. However, in
> +practice, this is typically a mistake so we prevent it from happening by
> +default unless specifically requested.

I am not sure if this is so bad, actually.  Why do we need to treat
it as a mistake?  When a command that wants a commit is fed a tag
(either a tag that directly refers to a commit, or a tag that tags
another tag that refers to a commit), the command knows how to peel
so it's not like the user is forced to say "git log T^{commit}".

And if something that *MUST* take a commit refuses to (or more
likely, forges to) peel a tag down to a commit and yields an error,
I think that is what needs fixing, not the command that creates a
tag.

So, I am fairly negative on this change---unless it is made much
more clear in the doc and/or in the proposed log message what
practical downside there are to the end users if we do not stop this
"mistake", that is.

> +Automatically erroring on nested tags was introduced in Git version
> +2.22.0.

And please do not write something like this.  A feature gets in a
release when it is ready, and we may not ship this in 2.22.

"git tag --help" the user is running may or may not have the
paragraph about "nested tag", depending on the existence of the
feature in the version of Git the user is running, so there is no
need to say something like that.

And no, I do not buy arguments like "random web servers serve
different versions of documentation without identifying which
version of Git they describe".

