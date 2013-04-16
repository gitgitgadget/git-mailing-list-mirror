From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 14:48:46 -0500
Message-ID: <CAMP44s38M7P0T1Wjhfv=XryoUevuxGwrik4pXwfkUfdpPNrXTQ@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<7va9oyl1wb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USBs5-0002k7-72
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935704Ab3DPTst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 15:48:49 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:52587 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935589Ab3DPTss (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 15:48:48 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so790018lab.41
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qfo96l6xj6YgId4IAXT86Y8VeKRCNVhF5Npyq4rq5XA=;
        b=b4kVOhHxD2Me+NAW+O/mRc4CIrYwM6VqXWb7ND/sFMX91zWxe4oHZmZdkCxqb0QI7l
         RCwN7GjeTIuVsJn7AceQ8tRjQgYl1u8ev9DXmRwZK8K6dUwd3yrY6pREag/7v6TeuS7T
         rOjy5CjkJnIe5hdHsCrqaPFu/mrEEYT5cW72ejDDBjOXpd/2YONWZ5hnfYPiXRsRfb+r
         DiwNbbwBodmryWUzmSbDQwroe4L9+xgwU6FcPWemk1IaK/P5dyCK1b7JZ2mEAbBsKpum
         Cv7c9pdIVXAH+GLpAhqyKOFnmgWHaTCEl+mCtDbcpzzCMwIAfTBxZMBOsNBvsZx5QnVh
         CjOg==
X-Received: by 10.152.120.6 with SMTP id ky6mr1948512lab.19.1366141727028;
 Tue, 16 Apr 2013 12:48:47 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Tue, 16 Apr 2013 12:48:46 -0700 (PDT)
In-Reply-To: <7va9oyl1wb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221459>

On Tue, Apr 16, 2013 at 2:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Sure, and where is the thinking not clear? The remote helper ref is
>> not updated, so we do update it. How is that not clear?
>
> Sure, between "leaving it untouched, keeping the stale value" and
> "updating it to match what was pushed", everybody would know you
> mean the latter when you say "correctly update".  There is no third
> option "updating it to match a random commit that is related to but
> is not exactly the same as what was pushed" to be correct.
>
> What I felt unclear was _why_ both of these two (remote and testgit)
> have to get updated.  In other words, "correctly update it" because
> "without doing so, these bad things X, Y and Z will happen".

The bad thing that would happen is that it won't be up-to-date.

If you don't know what an outdated ref causes, then you don't know
what transport-helper does with it, and if you don't know that, why
are you bothering trying to review this patch? Is the purpose of a
patch to educate people?

Here it goes. The remote helper ref is going to be used to tell
fast-export which refs to negate (e.g. ^refs/testgit/origin/master),
so that extra commits are not generated, which the remote helper
should ignore anyway, because it should already have marks for those.
So doing two consecutive pushes, would push the commits twice.

It's worth noting this is the first time anybody asks what is the
negative effect of this not getting fixed.

Cheers.

-- 
Felipe Contreras
