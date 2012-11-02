From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v4 04/14] Add new simplified git-remote-testgit
Date: Fri, 02 Nov 2012 17:03:00 +0100
Message-ID: <5093EEB4.3040402@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com> <1351821738-17526-5-git-send-email-felipe.contreras@gmail.com> <5093D0DD.3050801@gmail.com> <CAMP44s0n_O-7j329WyTxsWgVbCV2mEAnPG-WQeWBFdmHdfOjnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:03:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJiP-00043S-T6
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 17:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759546Ab2KBQDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 12:03:11 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62828 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759490Ab2KBQDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 12:03:08 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1439379bkc.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=EvT+3C/QFV6Pl39+ZOaXEPEN7LRzQwVHHJRb/a2uXTU=;
        b=k6GbVwCtkj6R84n3Yrw9UROdIJeOforWhrtOrpPYaOxbU31lf92XkU9GvEQhBktD1m
         e+wOJc77rcvUSwINO0YYri3D4QcnudR515g2mspmiMqrBenEunFiZRdNrEmnApOTCvnA
         1MiqCOsKLNoxVdBfuqA9fQ4vczJuWauXpx3Uu3ZGg3ufE6NXdEIToLvvDJ2zgY0EZWK1
         gzYS5uw2saH3AOscKm98hzUO7ZjeZ6zb4sWzAKZF/NjB/4ML3LdH28asPQpE0KKPs1r+
         h/rWYg5Vq3ceNABuPtBVGUNP7B+ulLRX3Hf5z7tSAX5KEzF/eisZdUJ7t8O7aFvtF3Sm
         mRxw==
Received: by 10.204.8.194 with SMTP id i2mr511806bki.117.1351872186054;
        Fri, 02 Nov 2012 09:03:06 -0700 (PDT)
Received: from [192.168.178.21] (host247-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.247])
        by mx.google.com with ESMTPS id e3sm6918345bks.7.2012.11.02.09.03.03
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 09:03:05 -0700 (PDT)
In-Reply-To: <CAMP44s0n_O-7j329WyTxsWgVbCV2mEAnPG-WQeWBFdmHdfOjnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208956>

On 11/02/2012 04:42 PM, Felipe Contreras wrote:
> On Fri, Nov 2, 2012 at 2:55 PM, Stefano Lattarini
> <stefano.lattarini@gmail.com> wrote:
> 
>>> +#!/bin/bash
>>>
>> I think git can't assume the existence of bash unconditionally, neither
>> in its scripts, nor in its tests (the exception being the tests on
>> bash completion, of course).  This script probably need to be re-written
>> to be a valid POSIX shell script.
> 
> Well, this is a _reference_ script, and that is used only for testing
> purposes. The test itself can be like the bash completion tests, and
> simply be skipped.
> 
> The reason I chose bash is because associative arrays, which you see
> in a later patch.
> 
>> It almost is, anyway, apart from the nits below ...
>>
>>> +# Copyright (c) 2012 Felipe Contreras
>>> +
>>> +alias="$1"
>>>
>> Just FYI: the double quoting here (and in several variable assignments
>> below) is redundant.  You can portably write it as:
>>
>>     alias=$1
>>
>> and still be safe in the face of spaces and metacharacters in $1.
>> I'm not sure whether the Git coding guidelines suggest the use of
>> quoting in this situation though; if this is the case, feel free
>> to disregard my observation.
> 
> What happens when you call this with:
> 
>  ./script "alias with spaces"
>
'$alias' will correctly expand to "alias with spaces".  Try out:

  $ sh -c 'alias=$1; echo "$alias"' dummy '1   2*3'
  1   2*3

This works consistently with every known shell (even non-POSIX
relics like Solaris /bin/sh).

>>> +url="$2"
>>> +
>>> +# huh?
>>> +url="${url#file://}"
>>> +
>>> +dir="$GIT_DIR/testgit/$alias"
>>> +prefix="refs/testgit/$alias"
>>> +refspec="refs/heads/*:${prefix}/heads/*"
>>> +
>>> +gitmarks="$dir/git.marks"
>>> +testgitmarks="$dir/testgit.marks"
>>> +
>>> +export GIT_DIR="$url/.git"
>>> +
>> I believe this should be rewritten as:
>>
>>   GIT_DIR="$url/.git"; export GIT_DIR
>>
>> in order to be portable to all the POSIX shells targeted by Git.
> 
> _If_ we want this as POSIX, yeah.
>
Why don't we?  Why add an extra requirement for a test that

 1. can be easily written in POSIX shell, and
 2. tests a feature that doesn't require bash to work (unless
    I'm sorely mistaken, that is)?

Honest question.  But of course, if the Git active contributors
deem the extra requirement (which is not an invasive one, given
how often bash is installed even on non-Linux systems) acceptable
in order to have the test case simpler and clearer, feel free to
disregard all my observations in this thread.

>>> +mkdir -p "$dir"
>>> +
>>> +test -e "$gitmarks" || echo -n > "$gitmarks"
>>> +test -e "$testgitmarks" || echo -n > "$testgitmarks"
>>> +
>> The '-n' option to echo is not portable.  To create an empty
>> file, you can just use
>>
>>    : > file
>>
>> or
>>
>>    true > file
> 
> All right, thanks.
> 
>>> +while read line; do
>>> +    case "$line" in
>>>
>> Useless double quoting (my previous observation about Git coding
>> guidelines applies here as well, of course).
> 
> What if line has multiple spaces?
>
Still no problem, as in the case of the 'alias=$1' assignment before:

  $ sh -c 'case $1 in *x"  "x*) echo ok;; *) exit 1;; esac' dummy 'x  x'
  ok

> To me it makes sense to quote it.
>
Surely it doesn't cause any problem to "over-quote" in this case;
it's better than risking to under-quote in other.  I just pointed
out that the quoting it's not really necessary, in case you weren't
aware of that.

>>> +        echo "feature import-marks=$gitmarks"
>>> +        echo "feature export-marks=$gitmarks"
>>> +        git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs | \
>>>
>> Better avoid the tricky {foo,bar} bashism:
>>
>>     git fast-export --use-done-feature \
>>                     --import-marks="$testgitmarks" \
>>                     --export-marks="$testgitmarks" \
>>                     $refs | \
> 
> If that's what we want, yeah.
>
Honestly, I find my longer-and-more-explicit version clearer, even
if you can assume bash for your script.  But that's a matter of
personal preference (sorry for not stating that right away), so
feel free to ignore it if you decide to keep the bash requirement
in the end.

Regards,
  Stefano
