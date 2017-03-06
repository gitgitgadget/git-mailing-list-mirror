Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C195E20133
	for <e@80x24.org>; Mon,  6 Mar 2017 19:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932352AbdCFTWf (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 14:22:35 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:33494 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbdCFTWd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 14:22:33 -0500
Received: by mail-io0-f178.google.com with SMTP id f84so119337163ioj.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 11:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=U121YMIOTSZvXtyWE62KzfvkbtB8lGrSobgcNiIFo5Q=;
        b=My+PF+Yx7f+XfQfzYn8KfQo/W/HF8hO4FmJackS/Yp5mwPG3FOVNwLCXojU26WhaIY
         gcH40nQeMat9zXwI0q0u36Raes/g6Czh69QXkTN3zJV1kapVKi9q0l5VDgr2tP49s8j/
         gSiohZpWhrf7ksxlVyyUiE3yrrDufC20IhscRbr6hSmXL8WYk5+F1ftuzBoUAS9OSe72
         JoGt7wXNz1fVxoaNd09ci0/fkYDZ9utn9h2wCjEHur0l7R7kennJxlrhruNs7WA0Ikxu
         F0kJt7nKiuw3zMyN50IVQTX8iFuRJIwIxrj/MT0mFMQSNMleeC9MDvTjq/bgeiA74U5D
         ZRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=U121YMIOTSZvXtyWE62KzfvkbtB8lGrSobgcNiIFo5Q=;
        b=TPokddIWjMT/cCFuZOFBtXCnCQ92eTVSAt9JzhO6gKfygy9fwhZs13r361pb2GQl+k
         9kh/m1oSIL2YCyYo7Wt3Bsl2vY35qhDwSH8KrIlFAhmvfZ9bDAvPJxtqWSafgHHVZeTY
         63L6GHT5bOCa9ZQLLRnUiPojxBgV347KbE90EN9LuNrIIqocKLVW23EDlwm87Z2O6tR/
         iRUMm99DxP5eWOg6XN1dZHkrTe+qqMTCvGvlGpho0gnKZaU65+21wGG7zfHI9y+JTVA/
         bErpxx3mJ8ClaYwBz3Kl7H9TGp21zr7RSNJ6vItjzOKI6pTIoacWOG8yQagOPEpOKN97
         AR5Q==
X-Gm-Message-State: AMke39k54TswNLQ/Nv29Kr4gjNrbkUowkqS+Racq1gMj8fZWu4B8VDgjhEyiCydmBnPLbfh+/AB99Y8lqMAe8Q==
X-Received: by 10.107.178.137 with SMTP id b131mr14940931iof.50.1488828138558;
 Mon, 06 Mar 2017 11:22:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Mon, 6 Mar 2017 11:22:17 -0800 (PST)
In-Reply-To: <cdd7779a-acdb-99fd-a685-89b36df65393@google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net> <cdd7779a-acdb-99fd-a685-89b36df65393@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2017 11:22:17 -0800
X-Google-Sender-Auth: GtACV8AP1KbJNEQv2YKzUkaQlbQ
Message-ID: <CA+55aFxj7Vtwac64RfAz_u=U4tob4Xg+2pDBDFNpJdmgaTCmxA@mail.gmail.com>
Subject: Re: RFC: Another proposed hash function transition plan
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 6, 2017 at 10:39 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>
> I think "nohash" can be explained in 2 points:

I do think that that was my least favorite part of the suggestion. Not
just "nohash", but all the special "hash" lines too.

I would honestly hope that the design should not be about "other
hashes". If you plan your expectations around the new hash being
broken, something is wrong to begin with.

I do wonder if things wouldn't be simpler if the new format just
included the SHA1 object name in the new object. Put it in the
"header" line of the object, so that every time you look up an object,
you just _see_ the SHA1 of that object. You can even think of it as an
additional protection.

Btw, the multi-collision attack referenced earlier does _not_ work for
an iterated hash that has a bigger internal state than the final hash.
Which is actually a real argument against sha-256: the internal state
of sha-256 is 256 bits, so if an attack can find collisions due to
some weakness, you really can then generate exponential collisions by
chaining a linear collision search together.

But for sha3-256 or blake2, the internal hash state is larger than the
final hash, so now you need to generate collisions not in the 256
bits, but in the much larger search space of the internal hash space
if you want to generate those exponential collisions.

So *if* the new object format uses a git header line like

    "blob <size> <sha1>\0"

then it would inherently contain that mapping from 256-bit hash to the
SHA1, but it would actually also protect against attacks on the new
hash. In fact, in particular for objects with internal format that
differs between the two hashing models (ie trees and commits which to
some degree are higher-value targets), it would make attacks really
quite complicated, I suspect.

And you wouldn't need those "hash" or "nohash" things at all. The old
SHA1 would simply always be there, and cheap to look up (ie you
wouldn't have to unpack the whole object).

Hmm?

                   Linus
