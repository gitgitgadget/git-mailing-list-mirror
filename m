From: Ori Avtalion <ori@avtalion.name>
Subject: Re: git-apply that handles rejects like merge conflicts
Date: Tue, 08 Nov 2011 22:50:51 +0200
Message-ID: <4EB9962B.8060809@avtalion.name>
References: <4EB85768.1060508@avtalion.name> <20111107225508.GB28188@sigill.intra.peff.net> <7v4nyf1opf.fsf@alter.siamese.dyndns.org> <20111108054643.GC29643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 21:51:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNsdP-0005KF-Pa
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 21:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396Ab1KHUvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 15:51:03 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47345 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab1KHUvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 15:51:01 -0500
Received: by faan17 with SMTP id n17so950305faa.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 12:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WtzCJpn2SMRyz19aOoPPm48IUZ1RMAVUV0lgzcdooI4=;
        b=bOjItNpXDwwUhZyHRz4cR10jae4YiZKGXHVLUkXVUsH3XW/2Z7Ek269Z9nGHYcO2lE
         ro+L1gWMPJZJo3gcFd0H/adsSsNj6Sa1tWZZtfcY25+ZBpNohrmkepODftl2IuZBiK7g
         CptuBCyYGg/TVdt8PVQN09ReIzMy09KTKMhxg=
Received: by 10.223.77.71 with SMTP id f7mr57015945fak.33.1320785460086;
        Tue, 08 Nov 2011 12:51:00 -0800 (PST)
Received: from [192.168.1.55] (bzq-79-183-1-248.red.bezeqint.net. [79.183.1.248])
        by mx.google.com with ESMTPS id l18sm3670817fab.9.2011.11.08.12.50.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Nov 2011 12:50:59 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111108054643.GC29643@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185109>

On 11/08/2011 07:46 AM, Jeff King wrote:
> On Mon, Nov 07, 2011 at 03:45:48PM -0800, Junio C Hamano wrote:
> But I think there are two questions:
> 
[ snip ]
> 
> I'm actually not sure which one Ori was asking about.
> 

I'm actually interested in both :)

Here's a copy of the description of my problem from another reply:

> I'm dealing with two codebases that have branched in the past, before
> any VCS was used, and now I'm tracking both separately with git. I'm
> trying to  apply changes from one to the other with format-patch and
> git-am/apply.

In answer to your first question
>   1. Should am's 3-way fallback be made more easily available to users
>      of regular "apply"?

git-am is never part of this workflow as I'm trying to move patches
between separate repositories with no shared root.

<rant>
And, personally, I don't think git-am is named correctly as the only
use-case I have for it is applying+committing single patches produced by
format-patch and sent as individual files over some medium which isn't
mboxes (I'm not that old-school). I never understood why git-apply can't
do the commit and I have to instead use a tool with 'mail' in its name
(Let's ignore the historical reasons) -- Shouldn't git-am be an
mbox-reading wrapper around some more basic patch-applying tool?
</rant>

>>   2. Short of doing a 3-way merge, are there better ways to represent
>>      failed hunks in the patch target itself, rather than saving ".rej"
>>      files?

I really want this as .rej files feel very un-git-like. However, after
understanding the problems raised in this thread, I'm a bit more
realistic :)

-Ori
