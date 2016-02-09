From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Merging branches with smudge filter
Date: Tue, 9 Feb 2016 10:15:12 +0100
Message-ID: <56B9AE20.70905@drmicha.warpmail.net>
References: <CACqLfMk_qDhbXUjWLtBLP4o=CeKEgaWAm881h03fneuiRO-v2w@mail.gmail.com>
 <xmqqbn7r9kfz.fsf@gitster.mtv.corp.google.com>
 <CACqLfM=G-=kD+wnDG-oWz4-eKW1ET_vnsenEXdCDwRsv0YXcSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Leonardo <leobasilio@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 10:15:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aT4Oc-0003yf-Px
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 10:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbcBIJPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 04:15:37 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33211 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754580AbcBIJPO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2016 04:15:14 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A037820B6A
	for <git@vger.kernel.org>; Tue,  9 Feb 2016 04:15:13 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 09 Feb 2016 04:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=IhA7MOLPkY9yIbIHDWEpcATlxNQ=; b=WB21/C
	DV2zDEiGttp11olvM3o7Pix7L2Sth8Qm9hxGq3S6lAPPy3rrwNJcaAwX1tCQEBDb
	K/lr3iVfCAUeUeQSvsPRo8Ml/HjMi1m6TVOADb0xZrK6D43rpE+E+fgNu70J2IUr
	AeJYhrah3rQJ0gJdeYln4A1Vtg7w+eAddPyS0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=IhA7MOLPkY9yIbI
	HDWEpcATlxNQ=; b=c800RDxMy4mkMLjA692kHXGFCyUIz88asMYQjsH2VujaJ6L
	KcWsya7gEmXJOferkBmGsXpPsJ3PHBEFNWNEaWmwVHLPtW80h671CSd2ospKsMQp
	wH0/wzigeTg2egRiM79kttybW0udJu5G/s/iNtdYj6LFRyaegFNs0eaQFTrA=
X-Sasl-enc: x2H4neLt/LRzKvcXQ0w0m+twabIXP1CLJBRI92GJi9K/ 1455009313
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 15274C00018;
	Tue,  9 Feb 2016 04:15:12 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CACqLfM=G-=kD+wnDG-oWz4-eKW1ET_vnsenEXdCDwRsv0YXcSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285832>

[Please bottom-reply on this list]
Leonardo venit, vidit, dixit 08.02.2016 18:52:
> Hi. I understand what you mean, but if that's the case, I don't get
> how every file was merged successfully despite the encryption, except
> two of them. I thought the smudge filter was supposed to be applied to
> every blob before any git operation, thus exposing the clean source
> code. Well, in the end I've merged these two files manually. I think I
> might have done something wrong while branching. I'm still learning.
> Next time I'll be more attentive.

Simple rule with filters:
"cleaned" is what is stored in the repo (as blobs)
"smudged" is what you see in your files in the working tree

Now, if Git is asked to merge two revisions and some blobs were not
changed at all, or only by one side of the merge, these parts of the
merge can be resolved trivially.

The others can't. You may want to try merge tools, or even a custom
merge driver (see git-merge man page).

Michael

> 2016-02-08 15:32 GMT-02:00 Junio C Hamano <gitster@pobox.com>:
>> Leonardo <leobasilio@gmail.com> writes:
>>
>>> Hi, everybody. I'm new to git and I'd like to keep track of some codes
>>> we have here in our company. They have some sensitive information I
>>> would like to keep private. After some googling, I found some
>>> solutions that encrypt/decrypt the files using filters as they're
>>> committed/checked out. I've been using this approach and it suits my
>>> needs. Now I need to merge two branches, but the process is failing
>>> for two files in particular. First of all, here's my config file:
>>>
>>> [filter "openssl"]
>>>     clean = openssl enc -aes-256-cbc -a -nosalt -pass pass:password
>>>     smudge = openssl enc -d -aes-256-cbc -a -nosalt -pass pass:password
>>>     required
>>
>> Git works on the "clean" representation of the data, i.e. the
>> representation of the blob object stored in the object database and
>> in the index, when manipulating the contents, e.g. diffing two
>> variants, patching (think "add -p"), merging, etc.
>>
>> As you are making the "clean" version an encrypted opaque sequence
>> of bytes, it is expected that you wouldn't be able to run 3-way
>> merges.
