From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GSoC - Designing a faster index format
Date: Mon, 26 Mar 2012 16:28:20 +0200
Message-ID: <87iphrjv23.fsf@thomas.inf.ethz.ch>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
	<87aa3aw5z8.fsf@thomas.inf.ethz.ch>
	<CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
	<CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
	<CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
	<CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
	<CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
	<CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
	<CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
	<CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
	<CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
	<CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 16:29:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCAvM-0005EB-KE
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 16:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554Ab2CZO3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 10:29:21 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:18458 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932636Ab2CZO2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 10:28:24 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 26 Mar
 2012 16:28:20 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 26 Mar
 2012 16:28:20 +0200
In-Reply-To: <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
	(elton sky's message of "Mon, 26 Mar 2012 23:36:59 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193914>

elton sky <eltonsky9404@gmail.com> writes:

> On Mon, Mar 26, 2012 at 12:06 PM, Nguyen Thai Ngoc Duy
> <pclouds@gmail.com> wrote:
>> (I think this should be on git@vger as there are many experienced devs there)
>>
>> On Sun, Mar 25, 2012 at 11:13 AM, elton sky <eltonsky9404@gmail.com> wrote:
>>> About the new format:
>>>
>>> The index is a single file. Entries in the index still stored
>>> sequentially as old format. The difference is they are grouped into
>>> blocks. A block contains many entries and they are ordered by names.
>>> Blocks are also ordered by the name of the first entry. Each block
>>> contains a sha1 for entries in it.
>>
>> If I remove an entry in the first block, because blocks are of fixed
>> size, you would need to shift all entries up by one, thus update all
>> blocks?
>
> We need some GC here. I am not moving all blocks. Rather I would
> consider merge or recycle the block. In a simple case if a block
> becomes empty, I ll change the offset of new block in the header point
> to this block, and make this block points to the original offset of
> new block. In this way, I keep the list of empty blocks I can reuse.
[...]

Doesn't that venture into database land?

If we go that far, wouldn't it be better to use a proper database
library?  All other things being equal, writing such complex code from
scratch is probably not a good idea.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
