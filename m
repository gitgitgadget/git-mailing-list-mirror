Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01AC1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 23:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752808AbcKRXjE (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 18:39:04 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34415 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752752AbcKRXjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 18:39:04 -0500
Received: by mail-qk0-f178.google.com with SMTP id q130so284251751qke.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 15:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kKZQCOgQZ/9su3tf5jZalgMA9nDO3UcvIoD4DVXpOJI=;
        b=BWB11AV1gBlckzX/+YJVJQdr7zYsLsdZzpqudoO8X4QDbCpBYPDzqoALSnH6B7/hEk
         i/fbybPzpWb8abvNnuVYp2Sv4aBT3Z2cLrhYaHG+xLJIwVh8RH32fA0WDpOWQy7s77He
         bf72sw9BQ5KOCFWr2b1teXV/z1SCEindwP+2Bd12+TWU7hY3WIQFrP8Oxtmu1Dp4OR1p
         rtBQUunRQn8ZRdiH52muNEUc6MNp5iJtwKdjFP5cEhUuBpabTvHpD6Lu7cIZeaFUFSSy
         F/DkgkxZ7aXafZHG0d32ZP9WkCCynd3evHNVjye02bH3W23XLgE8FJdyqd6TXNGFYizl
         BeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kKZQCOgQZ/9su3tf5jZalgMA9nDO3UcvIoD4DVXpOJI=;
        b=iL8TYfm4D50C56zi0l8K5w7pWnnEWRjR4yz8KRhF3/hZ67TWp/RiPrnrmK/SbLqNm6
         uam/0IKecfvdhGR121PRbc082BgtVqkGP+wyMpjTMnB0ZnIXUPPAMSr0hgIyeMrmX6wl
         0+oCWWTLrHO2I8wpRuJ9h2uPwU0D0EQKQGu5Fnnh4SJ+/fm8YH6Q498Z41BsluPTjDKw
         9UbkkW3gRt2FoA/LoSWnp/NFw2Jmff6CK6LvkZJ7IA0QYmgpHpJE29aQba7Yayk55/5U
         3vn6y7BLi71/GsS4fc/zbQmfrwE04Vcp5bgXmJ7FC0for7h02uS3UQ2nxYlnvnKOvMNu
         d0TQ==
X-Gm-Message-State: AKaTC03tPYIauc7tijbb7S0i+ah2kcRynBXhuTR4biZUr4JxRBfAl1mz3X6CH6N+/Y1BniwwXw7Lzi2wY+O+x9mI
X-Received: by 10.55.105.129 with SMTP id e123mr3013988qkc.173.1479512342984;
 Fri, 18 Nov 2016 15:39:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 18 Nov 2016 15:39:02 -0800 (PST)
In-Reply-To: <20161116002520.GI66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-14-sbeller@google.com>
 <20161116002520.GI66382@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Nov 2016 15:39:02 -0800
Message-ID: <CAGZ79kbxd6PxkBkdyGJOOV4f_LwroStXBDwNZ7RAEX+cL1m51w@mail.gmail.com>
Subject: Re: [PATCH 13/16] submodule: teach unpack_trees() to update submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 4:25 PM, Brandon Williams <bmwill@google.com> wrote:
> On 11/15, Stefan Beller wrote:
>> +                     int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
>
> For readability you may want to have spaces between the two flags

done

>
>> +     if (o->index_only
>> +         || (!((old->ce_flags & CE_VALID) || ce_skip_worktree(old))
>> +             && (o->reset || ce_uptodate(old))))
>> +             return 0;
>
> The coding guidelines say that git prefers to have the logical operators
> on the right side like this:

fixed all the coding style issues.
