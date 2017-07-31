Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877B51F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbdGaUnH (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:43:07 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35838 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGaUnG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:43:06 -0400
Received: by mail-lf0-f52.google.com with SMTP id t128so88767023lff.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1x84QeMnvQFyEGz0i7e2UuOcTHIwoQ6BjTDxcSEIzB4=;
        b=cB+PPMd0sZnYH49JF84iHPdueZtXKCodQ2w0YPUsipoohJ6X1nLQ50oQaG0cqI7FT5
         uB/YXUsp5ITPEnM1MWs6NuizLsr6MAos0GyVL4dgms+QZacAcK36x73ye7PO1XgYtRcl
         efCBN5WKcOuPv8q8McPtxg139QtFgsRVti2EQLSiqek5AZthWNSoIfcWAhZKYQMw3oHR
         p6KesI//CXpdW9wOeXJkxgRbnISSlDQwT5MM+oe2TbY+UbNhNkchbyI57gtJrbfXAlmd
         p6zCuM4aMZ8pOuT9m55UekZ/hyjDx/9Oz+4vxpoYFSLCBFcC3k1j9IpnZjM7W0ImdA78
         BVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1x84QeMnvQFyEGz0i7e2UuOcTHIwoQ6BjTDxcSEIzB4=;
        b=bA0gDYavcndZvD++yVSLU1TWCV1zQlw1FEPxy8TNZfaNrF19OHn3gnr1CL18ATkAIC
         Tg0cfohUbTaR77jpUnivLPEWPNSBqA8rNn/I5HQnWjNAghhkZOFzcmLzBcNpGT/IAFjo
         djLHDkMXjtEUbFX9Fgym2AkgL/PFYTXEf2HU1UA5hrLd3IHQ28mX+YkwFRUkLEvyysWL
         2LfJ3r1vFM+FxJzdGGwVXkBtZQ9T5WtxTd0j9vr7NsZqLICUK6n3lKrFLYUaGb/nKTH1
         /oRDhAE6Iqv0kc0iVVdEEiWgluauLuSHLWNJpQ6e3p7l71H1vMSlgmRbSXDA3rxGQFTe
         R7nA==
X-Gm-Message-State: AIVw112o3oNdbzdJzqUlLj7xWT5smmCJIVByOtoIPJ6p1cZdt1wLPAXK
        54nNth/cKMhZkIUHje9XEMP5jqcOx/r0
X-Received: by 10.46.33.9 with SMTP id h9mr5981268ljh.52.1501533784664; Mon,
 31 Jul 2017 13:43:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 13:43:04 -0700 (PDT)
In-Reply-To: <a3650c9a-fa42-09e6-efcd-f912d5ffc042@web.de>
References: <20170725213928.125998-1-bmwill@google.com> <20170725213928.125998-3-bmwill@google.com>
 <CAGZ79kY9Pdk5C8=k-AQpCPwo3q9Jzfg9A93UQxGyyf_OyrMS_Q@mail.gmail.com>
 <xmqqwp6uq56s.fsf@gitster.mtv.corp.google.com> <a3650c9a-fa42-09e6-efcd-f912d5ffc042@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 13:43:04 -0700
Message-ID: <CAGZ79kZxprtLGOzURHaxc5YzviSj_2Kx23v=gjr2uFb+tbNfjw@mail.gmail.com>
Subject: Re: [PATCH 02/15] submodule: don't use submodule_from_name
To:     Jens Lehmann <Jens.Lehmann@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 30, 2017 at 6:43 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 26.07.2017 um 23:06 schrieb Junio C Hamano:
>>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Rereading the archives, there was quite some discussion on the design
>>> of these patches, but these lines of code did not get any attention
>>>
>>>      https://public-inbox.org/git/4CDB3063.5010801@web.de/
>>>
>>> I cc'd Jens in the hope of him having a good memory why he
>>> wrote the code that way. :)
>>
>>
>> Thanks for digging.  I wouldn't be surprised if this were a fallback
>> to help a broken entry in .gitmodules that lack .path variable, but
>> we shouldn't be sweeping the problem under the rug like that.
>
>
> Sorry to disappoint you ;-) I added this in 7dce19d374 because
> submodule by path lookup back then only parsed the checked out
> .gitmodules file.

This is still the case AFAICT, as we never ask for a specific .gitmodules
file identified by sha1 of the commit.

> So looking for it by name was a good guess to
> fetch a new submodule that wasn't present in the current HEAD's
> .gitmodules, as the path is used as the default name in "git
> submodule add".

3 things:
a) I think it is not as much a feature ('fallback to still make it work'),
   but rather a bug as when there is no (or wrong) entry in the .gitmodules
   file, reporting it is better than trying something.
b) in the case of moved submodules (2 submodules swapped their path)
   this may be harmful as we'd get a wrong submodule potentially.

c) I wonder if we want to use a different default for submodule names
   as I have seen people get confused by path and name being the same,
   e.g. to move a submodule they would have not just adapted the path,
   but any occurrence of the string that reads like the path.
   (i.e. also change the name, defeating the purpose of name/path
   separation).

   For a new name default, I would wager for some non-legible gibberish
   such as "hash( path/time )", as that sends a clear message to not mess
   with the value of the name.

>
> The refactoring in 851e18c385 could and should have removed that
> because since then we use the .gitmodules path to name mapping
> of the fetched commit.
>
>> I wonder if we should barf loudly if there shouldn't be a submodule
>> at that path, i.e.
>>
>>         if (!submodule)
>>                 die("there is no submodule defined for path '%s'"...);
>>
>> though.
>
>
> Not sure if you want to die() or just issue a warning(), but yes.

Either die() or "warning && return 0" is fine with me.
