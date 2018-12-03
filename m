Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B613211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 22:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeLCWbA (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 17:31:00 -0500
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:46218 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbeLCWbA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Dec 2018 17:31:00 -0500
Received: from resomta-po-01v.sys.comcast.net ([96.114.154.225])
        by resqmta-po-12v.sys.comcast.net with ESMTP
        id Tu6fgaXb9ow0hTwjzgCCge; Mon, 03 Dec 2018 22:30:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1543876259;
        bh=+/r0iysiLHA/wcWzllYKnRnWUVfESRey+Bq4tvN3y8s=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=eHpIkxbRyVG5xnXp0tsLWBKv8eL2cAGrSZq7ZEo1whoveCAYdysIckI3k7a6/MqUw
         euSK8/NcTu26CRjklCsahLfCNqdnV7MdMHyp89V4j2NdANjZW4L1IXkNwuYgPkzd6e
         I9MM990ZBD43vRTA/zBdzZZpZlmffNguxy/5UfpZpQ0v9MZYAiPIR+n3/KA+XgcPrV
         +iagLIcmmJXHs2uM2tWWmEYg6RHNFyT/K0FIiGqtnLMkb8qlgRYKLnYpj9Sc3Q1R5L
         qdW/MA13JhjZrt5bL3qTR3Sf/AVxpiPImWmZ3WMUTsYavhG3YbXIIVxU4z3hbSPyaf
         2+Cy8xB5JUIcw==
Received: from maqtu.svl.corp.google.com ([IPv6:2620:0:100e:913:aa8d:64ee:3bb6:179])
        by resomta-po-01v.sys.comcast.net with ESMTPSA
        id TwjkgMIw99nOcTwjpg3W2Y; Mon, 03 Dec 2018 22:30:57 +0000
Subject: Re: easy way to demonstrate length of colliding SHA-1 prefixes?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1812020647440.32023@localhost.localdomain>
 <87y398uknn.fsf@evledraar.gmail.com>
From:   Matthew DeVore <matvore@comcast.net>
Message-ID: <5d63905a-4a52-0724-90f6-a2b0a7ab0f62@comcast.net>
Date:   Mon, 3 Dec 2018 14:30:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87y398uknn.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfILvCZjSwfPrutBrhUXH1eEojG6mfgflXABSSqCoz/LualN1jmpL5XzJ0P1dw6qlm2tsnHKABVIB/hsB6eu0Mhz61IVUT9pBqxpebgySN8UvLyP60c74
 g/IQ7HbTdyQ/4zevWxdV8XOC0O9YHnmXbwxBrxTdy7g3cf7LV8pcopq1S7YCBwAGtTR4sFWSxk50qWKJgzjdPCdnNhbte/4jyrbKhLDXv07cACrE7ur0pe4i
 FlSRUMEYUDml7R91hURGa/QBSrkyRsCXQ3Qf4JBKbfNp04g6AapNIVC5XrfvPDYNANQQsA20mc+hjVLfhrZA1g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/02/2018 05:23 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Dec 02 2018, Robert P. J. Day wrote:
> 
>>    as part of an upcoming git class i'm delivering, i thought it would
>> be amusing to demonstrate the maximum length of colliding SHA-1
>> prefixes in a repository (in my case, i use the linux kernel git repo
>> for most of my examples).
>>
>>    is there a way to display the objects in the object database that
>> clash in the longest object name SHA-1 prefix; i mean, short of
>> manually listing all object names, running that through cut and sort
>> and uniq and ... you get the idea.
>>
>>    is there a cute way to do that? thanks.
> 

Here is a one-liner to do it. It is Perl line noise, so it's not very 
cute, thought that is subjective. The output shown below is for the Git 
project (not Linux) repository as I've currently synced it:

$ git rev-list --objects HEAD | sort | perl -anE 'BEGIN { $prev = ""; 
$long = "" } $n = $F[0]; for my $i (reverse 1..40) {last if $i < 
length($long); if (substr($prev, 0, $i) eq substr($n, 0, $i)) {$long = 
substr($prev, 0, $i); last} } $prev = $n; END {say $long}'

c68038ef

$ git cat-file -t c68038ef

error: short SHA1 c68038ef is ambiguous
hint: The candidates are:
hint:   c68038effe commit 2012-06-01 - vcs-svn: suppress a 
signed/unsigned comparison warning
hint:   c68038ef00 blob
fatal: Not a valid object name c68038ef


> You'll always need to list them all. It's inherently an operation where
> for each SHA-1 you need to search for other ones with that prefix up to
> a given length.
> 
> Perhaps you've missed that you can use --abbrev=N for this, and just
> grep for things that are loger than that N, e.g. for linux.git:
> 
>      git log --oneline --abbrev=10 --pretty=format:%h |
>      grep -E -v '^.{10}$' |
>      perl -pe 's/^(.{10}).*/$1/'

I think the goal was to search all object hashes, not just commits. And 
git rev-list --objects will do that.
