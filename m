Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE6AC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 05:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9476A60FDB
	for <git@archiver.kernel.org>; Tue, 18 May 2021 05:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbhERFeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 01:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241023AbhERFeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 01:34:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DD5C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 22:32:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z4so2253265plg.8
        for <git@vger.kernel.org>; Mon, 17 May 2021 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i38TMWczsm1KGqhLrnqvbkPoHGlw2GFz3tlHGLQe47M=;
        b=f5oq6UYSO+p3bfafKP9AL+umWIXrBrDVAhFMVQM9nQ1REosb/ViLkKnXqIRzq2mEiQ
         Iaz54yU+jakPtw6HGXOyWHi0Xto+g3pt9P0xuMtihwwR5Vx1BDIt0AU4w04vIznCYX2O
         lI+a1qV8SWmln+yKrriSGHs36xHUJ5L/EaefpKAvMVI8qCyxhvS2e9pkTBej29tMMevL
         6D3GyoimLKd0Zq0sx43guwu1vIbi3xd1MVu57A5uF25xAs9pDuET53B5N7BZto4WaIvW
         vHIl4ZPLUWGyYkYk3u12JUWIyfNINfWRF7Pkb9Dsz5FjXq0aB1eJm2qd+vOusoT6ZOC0
         JbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i38TMWczsm1KGqhLrnqvbkPoHGlw2GFz3tlHGLQe47M=;
        b=WTIszrjJ71JGXkCJq/4BC+7bIcIbKgH/N4VXBbULv0VNynB3tv8FOIAxQeBhP+wpWJ
         /rHi1563UEn/T2suIkJumh9rJpIIQj+t8wzrYeG5RCaLyZ6kEDYXuvt6MKuUcDdOr/FN
         xF3e0pBjKDCIaUeEDwDobBDhGaVr1vL0O3e/sA2JnQdyD2Pv4q/lAqtRZZLNwo32Pvwx
         zB7lhyh/3/V3ygRMcodxBehAXkKclLuT8Icz9X3Ah9JIqS4hVMhBNZKa1bQedNHLB9Er
         p8El7mHus6U9/2pfTLqGCDj9t4eqZPvY8KBEa4l/naS3eN4HMIuD/kesBI5l0Nbu5Ijb
         YHMw==
X-Gm-Message-State: AOAM533zm1gU1sYgpspAskjdN9h/W4gW0kvzUpQ0gbiTL+WvTUBFJQ/F
        jNkJwLE0EY50g7cPhf8cNCHtDxgP+UY=
X-Google-Smtp-Source: ABdhPJw9YPc0KTScFJ/nr4Yg8QXsur8fPrqrxcKDQX85b6U1IdgzOsCrW5o+OEXHAPEzGbuXkvy3Bg==
X-Received: by 2002:a17:902:b183:b029:ee:ff72:f580 with SMTP id s3-20020a170902b183b02900eeff72f580mr2666926plr.26.1621315974637;
        Mon, 17 May 2021 22:32:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ea96:bdac:27b4:8cdc])
        by smtp.gmail.com with ESMTPSA id 184sm4304037pfv.38.2021.05.17.22.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 22:32:54 -0700 (PDT)
Date:   Mon, 17 May 2021 22:32:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     dwh@linuxprogrammer.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
Message-ID: <YKNRg691mu8x7Pua@google.com>
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
 <87lf8mu642.fsf@evledraar.gmail.com>
 <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
 <20210513202919.GE11882@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513202919.GE11882@localhost>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

dwh@linuxprogrammer.org wrote:

> I think we should make one last breaking change for digests and not go
> with the existing SHA-256 implementation but instead switch to
> self-describing digests and digital signatures and rely on external
> tools that Git talks to using a standard protocol. We can maintain full
> backward compatibility and even support full round tripping using some
> of the similar techniques that Brian came up with.

Forgive my ignorance: can you describe what compatibility break you
mean?  Do you mean _removing_ support for gpgsig-sha256?  If so,
why --- couldn't you get the same benefit by introducing the new
functionality you're describing without getting rid of historical
functionality at the same time?

A nice thing about signatures is that they don't change the semantics
of the object.  So some future version of Git can remove support for
verifying them, if they turn out

By the way, to be clear, the hash-function-transition doc in
Documentation/technical/ is not by Brian alone.  It is the result of
collaboration by various people on list (see its git history for
details).

[...]
> object 04b871796dc0420f8e7561a895b52484b701d51a
> obj 0ED_zgYrQg584bCrqKPoUvxaQ5aMis0GtnW_NrZFTTxUlHLUOyp77LanoZEGV6ajhYGLGTaTfCIQhryovyeNFJuG
> type commit
> tag signedtag
> tagger C O Mitter <committer@example.com> 1465981006 +0000
> signtype openpgp
> sign LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlRRWN
> CQUFCQWdBR0JRSlhZUmhPQUFvSkVHRUpMb1czSW5HSmtsa0lBSWNuaEw3UndFYi8rUWVYOWVua1
> hoeG4KcnhmZHFydldkMUs4MHNsMlRPdDhCZy9OWXdyVUJ3L1JXSitzZy9oaEhwNFd0dkUxSERHS
> GxrRXozeTExTGt1aAo4dFN4UzNxS1R4WFVHb3p5UEd1RTkwc0pmRXhoWmxXNGtuSVExd3QveVdx
> TSszM0U5cE40aHpQcUx3eXJkb2RzCnE4RldFcVBQVWJTSlhvTWJSUHcwNFM1anJMdFpTc1VXYlJ
> Zam1KQ0h6bGhTZkZXVzRlRmQzN3VxdUlhTFVCUzAKcmtDM0pyeDc0MjBqa0lwZ0ZjVEkyczYwdW
> hTUUx6Z2NDd2RBMnVrU1lJUm5qZy96RGtqOCszaC9HYVJPSjcyeApsWnlJNkhXaXhLSmtXdzhsR
> TlhQU9EOVRtVFc5c0ZKd2NWQXptQXVGWDJrVXJlRFVLTVpkdUdjb1JZR3BEN0U9Cj1qcFhhCi0t
> LS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo
[...]
> I think a good move to make right now would be to add a general function
> for stripping out any number of named fields from objects and also
> stripping out in-body signatures found in tags. That way we can add
> support in today's Git for stripping out fields/data for things like
> creating/verifying the object digest and/or digital signature.

Can you say a little more about the user-facing model here?  How does
a user know whether the signature verification result they're looking
at describes the part of the object they care about or has stripped it
out?

[...]
> Let me try to lay out the case for making a breaking change to sha256
> right now that will future-proof repos going forward.
>
> It has been known for a few decades now that cryptography has a
> shelf-life.

Yes, this is a key assumption of the hash function transition.  It is
meant to be repeatable, so that we are not stuck on a particular
cryptographic hash.

[...]
>                                       The end result is that in high
> security software, SHA-256 is being replaced with SHA-3 and Blake2
> digests.

Do you mean that practice is drifting away from the conclusion of
https://www.imperialviolet.org/2017/05/31/skipsha3.html?  Where can I
read more?

It took a while to decide on sha256 as the hash for Git to use to
replace sha1.  The process involved useful feedback from Keccak team
and others, and I feel pretty comfortable with how thoroughly it was
discussed, though of course I wouldn't be surprised if the state of
cryptanalysis has changed in some way since then.

The front runners were from the SHA2, SHA3, and Blake2 families.  The
main factor that led to deciding on SHA2 is the wide availability of
efficient and trustworthy implementations, in hardware and software.
See https://lore.kernel.org/git/alpine.DEB.2.21.1.1706151122180.4200@virtualbox/#t
and https://lore.kernel.org/git/20180609224913.GC38834@genre.crustytoothpaste.net/#t
for some of the discussion that led there.

[...]
> 4. switch to "late binding", "self describing" cryptographic constructs.

As Junio mentioned, Git does not impose a requirement on the signature
algorithm used in a signature block, including the digest involved.
However, signing history typically involves signing object names, and
object names use a cryptographic hash for other reasons.  If we want
Git to stop using a content addressable object store, that would be a
more fundamental changes to its design.

Thanks and hope that helps,
Jonathan
