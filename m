Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA5E1FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 23:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbcFTXVx (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 19:21:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48514 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752049AbcFTXVw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 19:21:52 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 76B9E20C01;
	Mon, 20 Jun 2016 19:21:47 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 20 Jun 2016 19:21:47 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=AyTiOZN6muuffW0
	prkqJZwvq7yo=; b=otIjWxuADUEGISprXt3a9hBYN5jsxgQoTCFEaU1wYL26YmR
	OBJKFKVwapypMi9LzB88/sxzZMjtXulkrqG3G+hHcwcV8VGmdd9io7ukHj+3mSCo
	G+yJEUPUNhN/zrQ2yU5XTTfVBlS/3qAKLC4LQbf/5askrDzp/S0RvfAbkNzQ=
X-Sasl-enc: ntq0k5U0TidRwzhdjNSBPnP31UwifQK3YyGNuZpjJ/YQ 1466464907
Received: from ebox.rath.org (ebox.rath.org [45.79.69.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id 19BB1F29FC;
	Mon, 20 Jun 2016 19:21:47 -0400 (EDT)
Received: from thinkpad.rath.org (thinkpad [192.168.12.2])
	by ebox.rath.org (Postfix) with ESMTPS id 572D13005F1;
	Mon, 20 Jun 2016 23:21:45 +0000 (UTC)
Received: by thinkpad.rath.org (Postfix, from userid 1000)
	id DAAAAC0257; Mon, 20 Jun 2016 16:21:45 -0700 (PDT)
From:	Nikolaus Rath <Nikolaus@rath.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: How to find commits unique to a branch
References: <878txz8ubq.fsf@thinkpad.rath.org>
	<xmqqtwgnsdr3.fsf@gitster.mtv.corp.google.com>
Mail-Copies-To:	never
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:	Mon, 20 Jun 2016 16:21:44 -0700
In-Reply-To: <xmqqtwgnsdr3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 20 Jun 2016 15:21:20 -0700")
Message-ID: <87lh1z78fr.fsf@thinkpad.rath.org>
User-Agent: Gnus/5.130014 (Ma Gnus v0.14) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Jun 20 2016, Junio C Hamano <gitster@pobox.com> wrote:
> Nikolaus Rath <Nikolaus@rath.org> writes:
>
>> What's the best way to find all commits in a branch A that have not been
>> cherry-picked from (or to) another branch B?
>>
>> I think I could format-patch all commits in every branch into separate
>> files, hash the Author and Date of each files, and then compare the two
>> lists. But I'm hoping there's a way to instead have git do the
>> heavy-lifting?
>
> "git cherry" perhaps?

That seems to work only the "wrong way around". I have a tag
fuse_3_0_start, which is the common ancestor to "master" and
"fuse_2_9_bugfix". I'd like to find all the commits from fuse_3_0_start
to master that have not been cherry-picked into fuse_2_9_bugfix.

However:

* "git cherry fuse_3_0_start master release2.9" tells me nothing has
  been cherry-picked at all (only lines with +)

* "git cherry fuse_3_0_start release2.9 master" also tells me nothing
  has been cherry picked, but somehow shows a smaller total number of
  commits.

* "git cherry master release2.9 fuse_3_0_start" gives me the commits
  from fuse_2_9_bugfix that have not been cherry-picked into master
  (which seems to be in contradiction to the two earlier commands).


Am I missing something obvious?

Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             »Time flies like an arrow, fruit flies like a Banana.«
