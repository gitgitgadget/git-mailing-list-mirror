Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1670201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 17:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdF3Rlm (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 13:41:42 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36755 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdF3Rll (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 13:41:41 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so66794181pgb.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UIjy8eveVL8HWhqFL3LDAgIS0YruDVRohQO/T/oO778=;
        b=NgX9AtOC+FowT0tUUJmy0ejhvCF7PuNkLAjn8rAaRGI3p2zeuGuTza4Uq4L0kJ+c4T
         ihMBhuiasLM1negutj0MDU6v0EpVi9+U2cIPtymMYauUmjBrpWJrBGflDnHjd2FUJv3G
         zv8GFusyQlTyeuMzLu4ShcxGlR9rLwSPdBI+oIbMNKZ3niFSrJuahaZ3IUcbuUA4JQIS
         AfPUI3Nlg4oXt87ollYS1iDwbSu6mIym3TnSLV6d6IwE1GT6BIRjUjSOUH06kN8qAL1H
         bAN1cpuleAwVWWMrEmmbGLO7oFd0D0lyS48ngG3xqHVNScqxaiLv98J1EJ9mcsTXDNNm
         WHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UIjy8eveVL8HWhqFL3LDAgIS0YruDVRohQO/T/oO778=;
        b=ZACoxGR1iMOZ1Z7BverLPipQp0VnG9MQEVTJlYVBBjrLzC0jNepJvilLaKlgJ0S0k5
         vkx6t7ctO/REVJNFRVi0bTKIQHtfGMh0Fu4R+/sJtI+d4SkRPTKu1MG0K8Au3rkNdvQJ
         X8Sl5B4+I+L4/qSGdWxNJGZ1vHK08csvy5p+ENUGNFHYujvr86n6XW+OoSt/VUkTaPjn
         IiCP+dbqiDCykLzeaIhQv4iVLildtsv3WA93nFuvxSsamlHLQUp5qSXMDmZmgbwXjsVM
         ZCTZ9Xbzc+QEq/G9Oyk9wdVcqVnFzhHdAOqwnY4qvfVJAyNH+GJs/V9aCCWdv3H1otTm
         g88A==
X-Gm-Message-State: AKS2vOyadKDTBrN6UX7ljaH4pTFX9pj6gBSyKIoPFReEabN2l8y67DOQ
        FXuMjG9AyZd+ZPqhKIdQ059HuXM2/6OK
X-Received: by 10.98.49.2 with SMTP id x2mr23197494pfx.48.1498844501049; Fri,
 30 Jun 2017 10:41:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 10:41:40 -0700 (PDT)
In-Reply-To: <xmqqlgo9s7li.fsf@gitster.mtv.corp.google.com>
References: <20170629011334.11173-1-sbeller@google.com> <20170629235336.28460-1-sbeller@google.com>
 <20170629235336.28460-2-sbeller@google.com> <xmqqlgo9s7li.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 10:41:40 -0700
Message-ID: <CAGZ79kbu2hqc41eBk_AtoeTviJGT4TTV7M6cYp0h4q=gJs2wRg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] hashmap.h: compare function has access to a data field
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 10:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When using the hashmap a common need is to have access to arbitrary data
>> in the compare function. A couple of times we abuse the keydata field
>> to pass in the data needed. This happens for example in patch-ids.c.
>
> It is not "arbitrary data"; it is very important to streess that we
> are not just passing random crud, but adding a mechanism to
> tailor/curry the function in a way that is fixed throughout the
> lifetime of a hashmap.

Ah yes, I forgot to fix patch1, when spending all time on the docs in p2.

>
>> diff --git a/hashmap.h b/hashmap.h
>> index de6022a3a9..1c26bbad5b 100644
>> --- a/hashmap.h
>> +++ b/hashmap.h
>> @@ -33,11 +33,12 @@ struct hashmap_entry {
>>  };
>>
>>  typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
>> -             const void *keydata);
>> +             const void *keydata, const void *cbdata);
>
> As I view the new "data" thing the C's (read: poor-man's) way to
> cutomize the function, I would have tweaked the function signature
> by giving the customization data at the front, i.e.
>
>         fn(fndata, entry, entry_or_key, keydata);
>
> That would hopefully make it more obvious that the new thing is
> pairs with fn, not with other arguments (and entry-or-key and
> keydata pairs, instead of three old arguments standing as equals).

Ok, let me redo the patch to have fndata at the front.

Looking at other places (that have a similar mechanism mechanically,
but are semantically different), such as the callback functions for
the diff machinery, we have the user provided pointer at the end
of the list. But that is because the diff_options are the objects that
should be in front row (they are bound to the callback more than
some caller needed data).

    typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
          struct diff_options *options, void *data);

    typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options
*opt, void *data);

Thanks!

> As I think the way we wish to be able to express it in a better
> language would have been something like:
>
>         (partial_apply(fn, fndata))(entry, entry_or_key, keydata)
>
> that order would match what is going on better.
