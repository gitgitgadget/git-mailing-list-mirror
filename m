Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECC8F201CF
	for <e@80x24.org>; Wed, 17 May 2017 10:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753034AbdEQKO3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 06:14:29 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34815 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdEQKO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 06:14:28 -0400
Received: by mail-pf0-f170.google.com with SMTP id 9so5201457pfj.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LwThjnZBJ74WziyO/1GdEgET8x7PNveSTbaGykV303Y=;
        b=HFajX4VQJMEg0l+xjn4SUyKrzInAtS5nAmFOnJoQ6iujEdysSOU83qgi1qu88bmEJb
         9M4LV51FIavFd4jLzuHWWxt5C77vDtvNdSnZRqH2Bz7SsyvIFMhPPd66YIH7rkKGB6l0
         7sKFYMWcOqYNhO7sT4A5ZX4KnBvc1vusWzTis/hvECrvdHcJLOFUf5zLrOvNs6bMf4t3
         +CJE7U5VTqPTsZ1Luo7OwaUVYqjOFvYs/v4meuLLNAG49eY717uiuALuRMoL6q+JvCGQ
         H6259de924Q05GirTdJfAvdAY8memzANsSzwEY0ezYaOxQSGSe4soN+jXI7LaiIi48NX
         LW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LwThjnZBJ74WziyO/1GdEgET8x7PNveSTbaGykV303Y=;
        b=X6lAY5CJNGc64gupfy9otbqFb3iXsFcy8bVVCEwwD6Fe+YhQYt1R52pAe3EYTi4BS4
         mjdZFOPNOVBiXkXuxFRnz+dI4eGspH7RnYXXRfsPNOD2mQcl60+nI/AwS+3uIgt1FWDf
         V+qWxSTBvIpFUPkeyUGeCLA7NPxwq13uIjZeq888HBCwl0rTtui6Gmz9/PkZ8ljAs3ZC
         8Gliw3rIunUarabUeQCieWhZLw+Juhvio/gearm5MJz2b+lf7YKAYM9fZdJOGBtoRBRS
         asZXuJAjf6czxbjY3mPTqeMxdALxTVYjJ4QLF/DBkNPZFomG5Ou5Iqi+VdLOFot+5a6+
         YV/A==
X-Gm-Message-State: AODbwcAZ+Scvgb88DSoA0pYD3bVfWP9o8sISOlvMZBtnr7Nj4eXjvHDq
        AfhBpZA10YoKHg==
X-Received: by 10.98.112.134 with SMTP id l128mr2862140pfc.161.1495016067824;
        Wed, 17 May 2017 03:14:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id t198sm3317435pgc.33.2017.05.17.03.14.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 03:14:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 4/8] dir: hide untracked contents of untracked dirs
References: <20170516073423.25762-1-sxlijin@gmail.com>
        <20170505104611.17845-1-sxlijin@gmail.com>
        <20170516073423.25762-5-sxlijin@gmail.com>
        <xmqqo9usvv1m.fsf@gitster.mtv.corp.google.com>
        <CAJZjrdXVzYZ_77Eod6oq-CB+tn5wdF4B3nWzN5zQvjduL9Lnfw@mail.gmail.com>
Date:   Wed, 17 May 2017 19:14:26 +0900
In-Reply-To: <CAJZjrdXVzYZ_77Eod6oq-CB+tn5wdF4B3nWzN5zQvjduL9Lnfw@mail.gmail.com>
        (Samuel Lijin's message of "Wed, 17 May 2017 03:32:09 -0400")
Message-ID: <xmqqfug3x01p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

>>         /* And our single-liner comments look like this */
>>
>>> +             for (i = 0; i < dir->nr; i++) {
>>> +                     if (!dir->entries[i])
>>> +                             continue;
>>> +
>>> +                     for (j = i + 1; j < dir->nr; j++) {
>>> +                             if (!dir->entries[j])
>>> +                                     continue;
>>> +                             if (check_contains(dir->entries[i], dir->entries[j])) {
>>> +                                     nr_removed++;
>>> +                                     free(dir->entries[j]);
>>> +                                     dir->entries[j] = NULL;
>>> +                             }
>>> +                             else {
>>> +                                     break;
>>> +                             }
>>> +                     }
>>> +             }
>>
>> This loop is O(n^2).  I wonder if we can do better, especially we
>> know dir->entries[] is sorted already.
>
> Now that I think about it, dropping an `i = j - 1` into the inner loop
> right before the break should work:

Actually, I think you should be able to do this in a single loop and
write in such a way that it is clearly O(N), perhaps like:

	for (src = dst = 0; src < nr; src++) {
		if (!dst ||
		    !is_a_directory(array[dst - 1]) ||
		    !contains(array[dst - 1], array[src])) {
			array[dst++] = array[src];
		} else {
	                /* 
	                 * Otherwise, src is inside (dst-1), so 
			 * we just can discard it.
			 */
			free(array[src]);
			array[src] = NULL; /* not needed */
		}
	}
	nr = dst;

That is, dst points at the next place to save the final elements of
the array, and dst-1 is the last one that is known to be the final
set.  src points at the element we are inspecting.

If dst-1 does not exist (i.e. we are looking at the first element),
if dst-1 is not a directory, or if dst-1 does not contain the src,
then we need to keep the src in the final set. Otherwise we discard.
