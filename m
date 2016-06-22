Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C266120189
	for <e@80x24.org>; Wed, 22 Jun 2016 16:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbcFVQiZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:38:25 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45467 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751524AbcFVQiZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:38:25 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 91142204D5
	for <git@vger.kernel.org>; Wed, 22 Jun 2016 12:38:24 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 22 Jun 2016 12:38:24 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=O2shRLCL4ZJ8bl0
	JStG0DFnTDGA=; b=XqjoWnMLpGxdv5WOj/xibvER6cksediMkrD6of5x2zADS6V
	p+7C9euh+A1HsRCo109cEwc0y85ZjVpg0vBQHivyJwVVSKOsrwlkhw6hZST9HjTq
	LijdiGkmtsWQsjzI8xtIaXGwGoh9/FES2lPax29uagkJrisPgVo9Hk2uVmhU=
X-Sasl-enc: DFXGzUfZ+3g4dlCDUctdVJCwYJ0h1nJv4pNPaMlDhZiI 1466613504
Received: from ebox.rath.org (ebox.rath.org [45.79.69.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id 48F96F2022
	for <git@vger.kernel.org>; Wed, 22 Jun 2016 12:38:24 -0400 (EDT)
Received: from thinkpad.rath.org (thinkpad [192.168.12.2])
	by ebox.rath.org (Postfix) with ESMTPS id 8991D3047D4
	for <git@vger.kernel.org>; Wed, 22 Jun 2016 16:38:22 +0000 (UTC)
Received: by thinkpad.rath.org (Postfix, from userid 1000)
	id 54311C01DC; Wed, 22 Jun 2016 09:38:23 -0700 (PDT)
From:	Nikolaus Rath <Nikolaus@rath.org>
To:	git@vger.kernel.org
Subject: Re: How to find commits unique to a branch
References: <878txz8ubq.fsf@thinkpad.rath.org>
	<xmqqtwgnsdr3.fsf@gitster.mtv.corp.google.com>
	<87lh1z78fr.fsf@thinkpad.rath.org>
	<8a97003e-fa74-2d9b-f2a8-946614be649c@drmicha.warpmail.net>
Mail-Copies-To:	never
Mail-Followup-To: git@vger.kernel.org
Date:	Wed, 22 Jun 2016 09:38:23 -0700
In-Reply-To: <8a97003e-fa74-2d9b-f2a8-946614be649c@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 21 Jun 2016 10:28:53 +0200")
Message-ID: <87k2hhgow0.fsf@thinkpad.rath.org>
User-Agent: Gnus/5.130014 (Ma Gnus v0.14) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Jun 21 2016, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Nikolaus Rath venit, vidit, dixit 21.06.2016 01:21:
>> On Jun 20 2016, Junio C Hamano <gitster@pobox.com> wrote:
>>> Nikolaus Rath <Nikolaus@rath.org> writes:
>>>
>>>> What's the best way to find all commits in a branch A that have not been
>>>> cherry-picked from (or to) another branch B?
>>>>
>>>> I think I could format-patch all commits in every branch into separate
>>>> files, hash the Author and Date of each files, and then compare the two
>>>> lists. But I'm hoping there's a way to instead have git do the
>>>> heavy-lifting?
>>>
>>> "git cherry" perhaps?
>> 
>> That seems to work only the "wrong way around". I have a tag
>> fuse_3_0_start, which is the common ancestor to "master" and
>> "fuse_2_9_bugfix". I'd like to find all the commits from fuse_3_0_start
>> to master that have not been cherry-picked into fuse_2_9_bugfix.
>> 
>> However:
>> 
>> * "git cherry fuse_3_0_start master release2.9" tells me nothing has
>>   been cherry-picked at all (only lines with +)
>> 
>> * "git cherry fuse_3_0_start release2.9 master" also tells me nothing
>>   has been cherry picked, but somehow shows a smaller total number of
>>   commits.
>> 
>> * "git cherry master release2.9 fuse_3_0_start" gives me the commits
>>   from fuse_2_9_bugfix that have not been cherry-picked into master
>>   (which seems to be in contradiction to the two earlier commands).
>> 
>> 
>> Am I missing something obvious?
>
> There is always
>
> git log --left-right --cherry-mark A...B
>
> to give you a good overview of the situation.

This worked nicely too, thanks!

Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             »Time flies like an arrow, fruit flies like a Banana.«
