Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6941F462
	for <e@80x24.org>; Thu, 23 May 2019 20:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfEWUJd (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 16:09:33 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:39686 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfEWUJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:09:33 -0400
Received: by mail-pf1-f169.google.com with SMTP id z26so3845315pfg.6
        for <git@vger.kernel.org>; Thu, 23 May 2019 13:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YixxO4E0z9WvK4EdUY0g8kZAifn6GhjMFqDFJrg6QgE=;
        b=JTDIg3ks+Dl9nTqSsjgPdgec3sDa2ZTaxAxEtOnDX0Cc9pyVzHp5B0BqXIiXIMWFr3
         R4qHU43aNnIzKMCcoiAbcsNRIc6ksfDHjB1Sjy0RSDW1pnXee5eNApt3IOY7vDh+NL3p
         k+lsjqa+xXCOtYWYuCGdNL1HlJ34vC2TTBgkTWMXCebDJeAM+NSSACaF7GUz4Ujubzpw
         u3SitEd13K7dwOew2Gw1RncX/cYG/plB7tKlJ/y05yESe+E/q/Ru36GbiPo4urbIjQ9C
         v3BAtT5Q7vICLY9Y93T8GDsNJab2YKjofqj++jRYx82Le++fEZ7LtBnUGFReJAsLcYAJ
         MqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YixxO4E0z9WvK4EdUY0g8kZAifn6GhjMFqDFJrg6QgE=;
        b=tgrmKojgR4YDyzcPBnv+LKvoelAvFkNsbDYcNpbz5K2AE0EImcbayYolREIZ1AAOE6
         +JG2YJbJ4BX9nvrb6lyLxDXNKB71/3neJ+eaJAXSRBfxYyyxKiFRmJqZFN4o8u4WWw9o
         rkhUjmjQO4UcHphtPfvggWwTX9TO/I3Qod7EQpE5CGcrd0EEm3Wt6npHC++eP2EKMx43
         Yihw5SAQFZ2Hbq449lSF+CxPCqyLYQo7vDP4VlwCWkdaA2En+FvlsG4M2XIirrrA9cRV
         yuQPGo2RGp3uPJc6BBl7FdKobHgyQu7d71ZW2kxy7uWPJEP32HgH2VTYTrKZQ1gMgvkb
         4OPg==
X-Gm-Message-State: APjAAAVnzviP2+e6L/XuJc3jBOJ33k3rOB3iSt9f50ZRolTnf6rdo3ob
        Jmzr23aJF+PAPpSnfLAOMxRzMFTg
X-Google-Smtp-Source: APXvYqyNmPcHJlwlqovT93oJ9ZhlmbdBV8Alk1HHvO4I1hk6FjUSJfWqYl6OuNUS8pYL7PZ3pjqydg==
X-Received: by 2002:aa7:99c7:: with SMTP id v7mr107337882pfi.103.1558642171813;
        Thu, 23 May 2019 13:09:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id t15sm178072pjb.6.2019.05.23.13.09.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 13:09:31 -0700 (PDT)
Date:   Thu, 23 May 2019 13:09:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
Message-ID: <20190523200929.GA70860@google.com>
References: <20190521013250.3506B470485F@snark.thyrsus.com>
 <86h89lq96v.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86h89lq96v.fsf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jakub Narebski wrote:

> I think Documentation/technical/hash-function-transition.txt misses
> considerations for fast-import format (it talks about problem with
> submodules, shallow clones, and currently not solved problem of
> translating notes; it does not talk about git-replace, either).

Hm, can you say more?  I think fast-import is not significantly
different from other tools that want to pick an appropriate object
format for input and an appropriate object format for output.

Do you mean that the fast-import file should have a field for
explicitly specifying the input object format, and that that doc
ought to call it out?

[...]
> For security, all references in Merkle-tree of hashes must use strong
> verification hash.  This means that you need to be able to refer to any
> object, including commit, by its verification hash name of its
> verification hash form (where all references inside object, like
> "parent" and "tree" headers in commit objects, use verification hashes).

This kind of crypto agility weakens any guarantees that rely on
strength of a hash function.  The security level would be that of the
weakest of the supported hash functions.

In other words, usually the benefit of supporting multiple hash
functions as a reader is that you want the strength of the strongest
of those hash functions and you need a migration path to get there.
If you don't have a way to eventually drop support for the weaker
hashes, then what benefit do you get from supporting multiple hash
functions?

Jonathan
