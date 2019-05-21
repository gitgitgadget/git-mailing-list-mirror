Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355561F462
	for <e@80x24.org>; Tue, 21 May 2019 02:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfEUC6R (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 22:58:17 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:34465 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfEUC6R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 22:58:17 -0400
Received: by mail-pf1-f174.google.com with SMTP id n19so8252072pfa.1
        for <git@vger.kernel.org>; Mon, 20 May 2019 19:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bmUIeg2HkF5SBLqiwsWd7wcW6qW7udrGvT3LyEwzzSs=;
        b=iZCq4dEboH/YykEoHUhXdpPiIYMOV78YqnfSUa0QHwWKnHHotRkWXGZoIVrZRB5I/k
         pf4tv+M9MLK1Lw1gjNZrGHKO5tCfROZSDfb3q/Ns7qxpjtiH6HDeUQzYlvK4WP2lsHhd
         8atOz+aDT/AF+0b2/Ur37nTm7oQMmKE92dX752npZ3frO/tSsBVQ6WLeC/zKrzVplmaa
         Q45ZxxSUXasZy04aSULYow6oZsnnM5TpcKzAZ76e+f5jDN9Y8N1832XhcaIT3d9j0mrJ
         PPQzgvCjt8zyNIeqV7Osl6qGMT1veXpIH6Df584XtzJEnMj+ug/Y4J806PqfK60+LqYO
         uGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmUIeg2HkF5SBLqiwsWd7wcW6qW7udrGvT3LyEwzzSs=;
        b=uVzWLW4TDcP9DEnyC426PeCsnlJHg7R9ij05NVb7YzbirnQwF4oR8x+P9F1QmS2pTA
         tT8WtckQflTHfhFOVAsKA7Ag+xUlJ8owzV3SqNvjQJqSxf6Hfj8vfsJkj6f1MGeUCfA8
         GaXHZNJnEC/FDEOULx54HiffnF5SJU/e0dbjDIlU7Guy26oQ0vA0KDeiB4KrhcWksJH+
         80a2jjdg8wOBhcl7YXZ4Fdf0HiIQWacOICRu1AlEizVSJgjvDljWt75uWgSgC4NLnFYR
         bdCrqTM8saKE1KLLnmGvI8VK3H7zi4HbJKzkY44mbE+MhRYBAby8R382SJQ5i5VvrJHN
         Esqw==
X-Gm-Message-State: APjAAAVcNkPmcs/xo0iNJnI/1j9Obsk9yREyqVG2UO/fwSWYywYR2LtZ
        iLr2NPed/02e3KGx/b0Qy3u8VKHS
X-Google-Smtp-Source: APXvYqxW0WTJoTna4/E8EB5Za5B110WCsIY+nM9z2HUofdBqKSqIN7TDJNIH184gGzMYkgYRFFCY1A==
X-Received: by 2002:a63:1c4:: with SMTP id 187mr52203633pgb.317.1558407495918;
        Mon, 20 May 2019 19:58:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id s66sm21208091pfb.37.2019.05.20.19.58.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 19:58:15 -0700 (PDT)
Date:   Mon, 20 May 2019 19:58:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Eric S. Raymond" <esr@thyrsus.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
Message-ID: <20190521025813.GA175422@google.com>
References: <20190521013250.3506B470485F@snark.thyrsus.com>
 <20190521015703.GB32230@google.com>
 <20190521023832.GA130381@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521023832.GA130381@thyrsus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Eric S. Raymond wrote:
> Jonathan Nieder <jrnieder@gmail.com>:
>> Eric S. Raymond wrote:

>>> One reason I am sure of this is the SHA-1 to whatever transition.
>>> We can't count on the successor hash to survive attack forever.
[...]
>> Have you read through Documentation/technical/hash-function-transition?  It
>> takes the case where the new hash function is found to be weak into account.
>>
>> Hope that helps,
>> Jonathan
>
> Reading now...

Take your time. :)

[...]
> I think it's a weakness, though, that most of it is written as though it
> assumes only one hash transition will be necessary.  (This is me thinking
> on long timescales again.)

Hm, can you point to what part of the doc suggested that?  Best to make
the text clearer, to avoid confusing the next person.

On the contrary, the design is very careful to be able to support the
next transition.

[...]
>                                    The same technique (probably the
> same code!) could be used to map the otherwise uninterpreted
> commit-IDs I'm proposing to lookup keys.

No, since Git relies on commit IDs for integrity checking.  The hash
function transition described in that document relies on
round-tripping ability for the duration of the transition.

Jonathan
