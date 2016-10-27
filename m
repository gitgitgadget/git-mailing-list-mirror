Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1A42022A
	for <e@80x24.org>; Thu, 27 Oct 2016 00:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbcJ0AIR (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 20:08:17 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36767 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932332AbcJ0AIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 20:08:16 -0400
Received: by mail-qk0-f181.google.com with SMTP id o68so24606213qkf.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 17:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=akLsrWp/qbrZxWPW8LzGN+55DAUBdBTbL+YMxcPSZNI=;
        b=gMn71pSdS76whfGM183zbFxjqJ2PMCVO+EFgmfNKYlDT66aNB7HG5TDZo6n66emLqx
         GcQ+PC+ZD7ThLHIoz+irVTmb9coAFBXLNr7s8p263YRp5Dn6uTPBaG0TdFNSBLSq9JCa
         8UxOC87nbgwGV0liEMkpRQ0g2ruVyPHDEyXg/ADGF7bYX+HWyqNhV2ABti//7NPTU9yz
         JSPCDKDSfDqFUgzRA6WORyX/ygVu9HkGRMnWw8viR+k+5fL05jy/POnTIX3w7fFemT5M
         +q2sgfLEiw6OfaXHxAucU167szbSszmbxjmBj5ht6AVNvBebd+n8i6IrVB9EeIPYqE/9
         C9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=akLsrWp/qbrZxWPW8LzGN+55DAUBdBTbL+YMxcPSZNI=;
        b=YwecYsp+/GwWpBKk3zmPeSKRyQ7Q1rWAuiqSlw9lMMKSuzWqalwRI2tWnXCUikF8fF
         Cji1LJ88nMtr/1kRS4NBgSHbLgjw0fiCVryVG0igkcpxQDKcOrzZmo9CKzFzeLvpYfrM
         45oQcXbntFSktFP31kNRHw5rUqUvO5Fd9mscb4H5Lm6QxGxVigBzc+7MUGOcCRtLUxRv
         DGDTY56BSsoBCaebXAcGAl84MWjETycLhOmhcqKuIenkTlfaMPNcRMDf0EDVReyABG8r
         PcDsL4ykE3XcBsWUzshcilbIuYX55nDsIICgOvxU5FL4pQGib5s+Bo32IKaV0RdkyL4W
         wtrg==
X-Gm-Message-State: ABUngvdv0hQTPJGIy53rKAk8s2VEXknKRTz/dyt77CVjzJTpdtKUmeDb8xTCsm1+nYrVgexqqgu08prbrOYWdvQF
X-Received: by 10.55.20.164 with SMTP id 36mr3801790qku.86.1477526895463; Wed,
 26 Oct 2016 17:08:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 17:08:14 -0700 (PDT)
In-Reply-To: <xmqqoa26aek6.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYhMVrKHhNGYcf_D9kWEYp+sC+tMGbuE+gnD8AU27dh8g@mail.gmail.com>
 <20161026224104.31844-1-sbeller@google.com> <xmqqoa26aek6.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 17:08:14 -0700
Message-ID: <CAGZ79kaR4DddoHQNUUvRAY=_PK5qqS=ws_Wkfa-EXT2seN5b=A@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 4:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -53,19 +57,32 @@ value of the attribute for the path.
>>  Querying Specific Attributes
>>  ----------------------------
>>
>> -* Prepare `struct git_attr_check` using git_attr_check_initl()
>> +* Prepare a `struct git_attr_check` using `git_attr_check_initl()`
>>    function, enumerating the names of attributes whose values you are
>>    interested in, terminated with a NULL pointer.  Alternatively, an
>> -  empty `struct git_attr_check` can be prepared by calling
>> -  `git_attr_check_alloc()` function and then attributes you want to
>> -  ask about can be added to it with `git_attr_check_append()`
>> -  function.
>> -
>> -* Call `git_check_attr()` to check the attributes for the path.
>> -
>> -* Inspect `git_attr_check` structure to see how each of the
>> -  attribute in the array is defined for the path.
>> -
>> +  empty `struct git_attr_check` as allocated by git_attr_check_alloc()
>> +  can be prepared by calling `git_attr_check_alloc()` function and
>> +  then attributes you want to ask about can be added to it with
>> +  `git_attr_check_append()` function.
>
> I think that my version that was discarded forbade appending once
> you started to use the check for querying, because the check was
> meant to be used as a key for an attr-stack and the check-specific
> attr-stack was planned to keep only the attrs the check is
> interested in (and appending is to change the set of attrs the check
> is interested in, invalidating the attr-stack at that point).
>
> If you lost that restriction, that is good (I didn't check the
> implementation, though).  Otherwise we'd need to say something here.

That restriction still applies. Though I think mentioning it in the
paragraph where we describe querying makes more sense.

> initialization?

done


>
> Grammo?  "either on the stack, or dynamically in the heap"?

done

>
> Having result defined statically is not thread safe for that
> reason.  It is not clear what you mean by "The call to initialize
> the result"; having it on the stack or have one dynamically on the
> heap ought to be thread safe.

done

>> -}
>> +     static struct git_attr_check *check;
>> +     git_attr_check_initl(check, "crlf", "ident", NULL);
>
> I think you are still missing "&" here.

done

>> +     if (check)
>> +             return; /* already done */
>>       check = git_attr_check_alloc();
>
> You may want to say that this is thread-unsafe.

It is not; see the implementation:

void git_attr_check_append(struct git_attr_check *check,
               const struct git_attr *attr)
{
    int i;
    if (check->finalized)
        die("BUG: append after git_attr_check structure is finalized");
    if (!attr_check_is_dynamic(check))
        die("BUG: appending to a statically initialized git_attr_check");
    attr_lock();
    for (i = 0; i < check->check_nr; i++)
        if (check->attr[i] == attr)
            break;
    if (i == check->check_nr) {
        ALLOC_GROW(check->attr, check->check_nr + 1, check->check_alloc);
        check->attr[check->check_nr++] = attr;
    }
    attr_unlock();
}

>> +* Call `git_all_attrs()`.
>
> Hmph, the caller does not know what attribute it is interested in,
> and it is unclear "how" the former needs to be set up from this
> description.  Should it prepare an empty one that can be appended?
>

Good point on clarifying this one. It is just needed to have
NULL pointers around:

    struct git_attr_check *check = NULL;
    struct git_attr_result *result = NULL;
    git_all_attrs(full_path, &local_check, &result);
    // proceed as in the case above

All comments from above yield the following diff:

diff --git a/Documentation/technical/api-gitattributes.txt
b/Documentation/technical/api-gitattributes.txt
index 4d8ef93..d221736 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -67,19 +67,21 @@ Querying Specific Attributes
   Both ways with `git_attr_check_initl()` as well as the
   alloc and append route are thread safe, i.e. you can call it
   from different threads at the same time; when check determines
-  the initialzisation is still needed, the threads will use a
+  the initialization is still needed, the threads will use a
   single global mutex to perform the initialization just once, the
   others will wait on the the thread to actually perform the
   initialization.

-* Allocate an array of `struct git_attr_result` either statically on the
-  as a variable on the stack or dynamically via `git_attr_result_alloc`
-  when the result size is not known at compile time. The call to initialize
+* Allocate an array of `struct git_attr_result` either on the stack
+  or via `git_attr_result_alloc` on the heap when the result size
+  is not known at compile time. The call to initialize
   the result is not thread safe, because different threads need their
   own thread local result anyway.

 * Call `git_check_attr()` to check the attributes for the path,
   the given `git_attr_result` will be filled with the result.
+  You must not change the `struct git_attr_check` after calling
+  `git_check_attr()`.

 * Inspect each `git_attr_result` structure to see how
   each of the attribute in the array is defined for the path.
@@ -103,7 +105,7 @@ To see how attributes "crlf" and "ident" are set
for different paths.
         const char *path;
         struct git_attr_result result[2];

-        git_check_attr(path, check, result);
+        git_check_attr(path, &check, result);
 ------------

 . Act on `result.value[]`:
@@ -155,10 +157,20 @@ To get the values of all attributes associated
with a file:

 * Setup a local variables for the question
   `struct git_attr_check` as well as a pointer where the result
-  `struct git_attr_result` will be stored.
+  `struct git_attr_result` will be stored. Both should be initialized
+  to NULL.
+
+------------
+  struct git_attr_check *check = NULL;
+  struct git_attr_result *result = NULL;
+------------

 * Call `git_all_attrs()`.

+------------
+  git_all_attrs(full_path, &check, &result);
+------------
+
 * Iterate over the `git_attr_check.attr[]` array to examine the
   attribute names.  The name of the attribute described by a
   `git_attr_check.attr[]` object can be retrieved via
