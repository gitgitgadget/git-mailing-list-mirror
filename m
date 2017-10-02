Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C607D20281
	for <e@80x24.org>; Mon,  2 Oct 2017 14:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdJBOen (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:34:43 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:52175 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbdJBOem (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:34:42 -0400
Received: by mail-qt0-f171.google.com with SMTP id q4so7478255qtq.8
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FRw6IM6xc3cVNDNYFn9YbEPErfDLvFT2SfFpAgQp8H8=;
        b=mxB0Wn1xrmCv3MHiZP2RW+j7a+l+rR087hszdiT9wxTB0gBzckFCO0uqmbnHBfIVkT
         CFI9TRkhwj61kfA5P42Q4Cgbh6X+9nTHrAStPpy5bGcuwySOiLo9POIFUyJK2HjUZoLk
         72Uy3xwVIR62CQrwpy/X8+sNlbBHQDBaprjCYpkpFjiMrrcxHFdhjhOfWuLxvEEw2gEZ
         yE8h5pJlPRBeP+1UP3gDvq3/8owrpadrUl4fLzTLJVNG0mjDnzRIdVcp5Mf8avSc1M5z
         OmRJ+kPT62gYa7FpIMc5sdZ2Nolxic7qxJwbXhb429o6pvkqTjWK4yziFThthSxgGhoZ
         gZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FRw6IM6xc3cVNDNYFn9YbEPErfDLvFT2SfFpAgQp8H8=;
        b=Ujlee/aPhcIR6QC43uVjD9MLutGm35Tcfdz4oIdp/Nq12+mh7It7rGwYiNzVMRLoam
         IvJnIhlpBY8CnqijXT3AhdEF2QySle0T3Zgwf3DJWMiOG/8LcgxTKwXsYbyr3u8YMKIi
         uCTuJ6ZH1qoEHxCM4jtmS8J8Df+47mBB1rqsplcGEJGl1cYcdFnmtVcGG0NAgZHdPSJl
         3jFiL9dlohk0kJEdTPRnZqWVxbuo5BhCyYPXl9UO+7wSGw32MRIHgKyU4i6UMRvtvuTZ
         Hadzm00oViC+0//ef0oQYItXBxCXB9sB8WR4txDCXDwQvugtMvT8cJfZUIQF3DZbUMHM
         G52A==
X-Gm-Message-State: AMCzsaXOqG3VRgdFMnpq+trOgB/IQ6Tm8mkdOIigfh6ON74wZg5K3c47
        ygyNJeNLScf1A4V9g3bqzT8=
X-Google-Smtp-Source: AOwi7QDXislmr/7+sIpR7JrA5yHPTlEPo9mB1rFO9J6PXG0MwijYJff1FsTE+1Wrjt/izqevo0Yrew==
X-Received: by 10.200.35.67 with SMTP id b3mr1591178qtb.109.1506954881717;
        Mon, 02 Oct 2017 07:34:41 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k37sm1309043qte.64.2017.10.02.07.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 07:34:40 -0700 (PDT)
Subject: Re: [PATCH v6 09/40] Add initial external odb support
To:     Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
 <20170916080731.13925-10-chriscool@tuxfamily.org>
 <20170919104553.494d7d3b@twelve2.svl.corp.google.com>
 <CAP8UFD2D2NkKKy9oT-1Mwe0Gq6=UG+15t9GENKKbV-PbRf3Kkw@mail.gmail.com>
 <20170929133614.1c0cd68ad80139fafdf68b86@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <903cb956-464e-fdab-fac1-00a2b48b942c@gmail.com>
Date:   Mon, 2 Oct 2017 10:34:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170929133614.1c0cd68ad80139fafdf68b86@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/29/2017 4:36 PM, Jonathan Tan wrote:
> On Wed, 27 Sep 2017 18:46:30 +0200
> Christian Couder <christian.couder@gmail.com> wrote:
> 
>> I am ok to split the patch series, but I am not sure that 01/40 to
>> 09/40 is the right range for the first patch series.
>> I would say that 01/40 to 07/40 is better as it can be seen as a
>> separate refactoring.
> 
> I mentioned 09/40 because this is (as far as I can tell) the first one
> that introduces a new design.
> 
>> I don't think single-shot processes would be a huge burden, because
>> the code is simpler, and because for example for filters we already
>> have single shot and long-running processes and no one complains about
>> that. It's code that is useful as it makes it much easier for people
>> to do some things (see the clone bundle example).
>>
>> In fact in Git development we usually start to by first implementing
>> simpler single-shot solutions, before thinking, when the need arise,
>> to make it faster. So a perhaps an equally valid opinion could be to
>> first only submit the patches for the single-shot protocol and later
>> submit the rest of the series when we start getting feedback about how
>> external odbs are used.
> 
> My concern is that, as far as I understand about the Microsoft use case,
> we already know that we need the faster solution, so the need has
> already arisen.
> 
>> And yeah I could change the order of the patch series to implement the
>> long-running processes first and the single-shot process last, so that
>> it could be possible to first get feedback about the long-running
>> processes, before we decide to merge or not the single-shot stuff, but
>> I don't think it would look like the most logical order.
> 
> My thinking was that we would just implement the long-running process
> and not implement the single-shot process at all (besides maybe a script
> in contrib/). If we are going to do both anyway, I agree that we should
> do the single-shot process first.
> 

I agree with Jonathan's feedback.  We already know the performance of 
single shot requests is insufficient as there are scenarios where there 
will potentially be many missing objects that need to be retrieved to 
complete a git operation (ie checkout).  As a results, we will need the 
long running process model so, overall, it will be simpler to focus 
entirely on that model and skip the single-shot model.

If the complexity of the process model is considered to be too high, we 
can provide helper code in both script and native code that can be used 
to reduce the cost/complexity.  I believe we have most of this already 
with the existing sub-process.c/h module and the packet.pm refactoring 
you have done earlier in this series.

Providing high quality working samples of both is another way to reduce 
the cost and improve the quality.

>>> And another possible issue is that we design ourselves into a corner.
>>> Thinking about the use cases that I know about (the Android use case and
>>> the Microsoft GVFS use case), I don't think we are doing that - for
>>> Android, this means that large blob metadata needs to be part of the
>>> design (and this patch series does provide for that), and for Microsoft
>>> GVFS, "get" is relatively cheap, so a configuration option to not invoke
>>> "have" first when loading a missing object might be sufficient.
>>
>> If the helper does not advertise the "have" capability, the "have"
>> instruction will not be sent to the helper, so the current design is
>> already working for that case.
> 
> Ah, that's good to know.
> 
>>> And I think that my design can be extended to support a use case in
>>> which, for example, blobs corresponding to a certain type of filename
>>> (defined by a glob like in gitattributes) can be excluded during
>>> fetch/clone, much like --blob-max-bytes, and they can be fetched either
>>> through the built-in mechanism or through a custom hook.
>>
>> Sure, we could probably rebuild something equivalent to what I did on
>> top of your design.
>> My opinion though is that if we want to eventually get to the same
>> goal, it is better to first merge something that get us very close to
>> the end goal and then add some improvements on top of it.
> 
> I agree - I mentioned that because I personally prefer to review smaller
> patch sets at a time, and my patch set already includes a lot of the
> same infrastructure needed by yours - for example, the places in the
> code to dynamically fetch objects, exclusion of objects when fetching or
> cloning, configuring the cloned repo when cloning, fsck, and gc.
> 

I agree here has well.  I think smaller patch sets that we can 
review/approve independently will be more effective.

I think Jonathan has a lot of the infrastructure support in his partial 
clone series.  I'd like to take that work, add your external ODB work + 
Jeff's filtering work and come up with the best of all three solution. :)

>>>   - I get compile errors when I "git am" these onto master. I think
>>>     '#include "config.h"' is needed in some places.
>>
>> It's strange because I get no compile errors even after a "make clean"
>> from my branch.
>> Could you show the actual errors?
> 
> I don't have the error messages with me now, but it was something about
> a function being implicitly declared. You will probably get these errors
> if you sync past commit e67a57f ("config: create config.h", 2017-06-15).
> 
>>> Any reason why you prefer to update the loose object functions than to
>>> update the generic one (sha1_object_info_extended)? My concern with just
>>> updating the loose object functions was that a caller might have
>>> obtained the path by iterating through the loose object dirs, and in
>>> that case we shouldn't query the external ODB for anything.
>>
>> You are thinking about fsck or gc?
>> Otherwise I don't think it would be clean to iterate through loose object dirs.
> 
> Yes, fsck and gc (well, prune, I think) do that. I agree that Git
> typically doesn't do that (except for exceptional cases like fsck and
> gc), but I was thinking about supporting existing code that does that
> iteration, not introducing new code that does that.
> 
