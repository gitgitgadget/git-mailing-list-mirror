From: Martin Fick <mfick@codeaurora.org>
Subject: Re: git help prune accuracy?
Date: Thu, 15 Dec 2011 16:01:52 -0700
Organization: CAF
Message-ID: <201112151601.52968.mfick@codeaurora.org>
References: <201112151432.09252.mfick@codeaurora.org> <201112151453.52157.mfick@codeaurora.org> <7v1us5mqc4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 00:02:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbKJP-0003cK-2l
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 00:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759727Ab1LOXBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 18:01:55 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:57241 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759722Ab1LOXBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 18:01:54 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6561"; a="144912620"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 15 Dec 2011 15:01:53 -0800
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 8648310004C4;
	Thu, 15 Dec 2011 15:01:53 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7v1us5mqc4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187253>

On Thursday, December 15, 2011 03:18:19 pm Junio C Hamano 
wrote:
> Martin Fick <mfick@codeaurora.org> writes:
> >>   objects from the object database. In addition, it
> >> 
> >> prunes the unpacked objects that are also found in
> >> packs by running git prune-packed.
> >> 
> >> The last sentence seems like it should maybe have the
> >> following fix:
> >> 
> >> s/it prunes the unpacked/it prunes the unreferenced/
> > 
> > Ack, I meant:
> > 
> > s/it prunes the unpacked/it prunes the unreachable/
> 
> "In addition" part is about objects that exist in loose
> format that are also found in packs and has nothing to
> do with reachability.
> 
> Running "git pack-objects" to collect loose objects into
> a new pack will not remove these loose objects that are
> copied into that new pack. Because we try to access
> objects from an already open packfile before trying a
> loose object file, removing these now-redundant loose
> ones after they are packed makes sense. And that is what
> "git prune-packed" does.

Thanks Junio, that makes a lot of sense.  I don't know why I 
was not getting that from the description even though that 
was exactly what I was looking for.  Maybe it was because of 
the intro/summary line?  Now that I think I understand what 
it is doing, it seems like this command is more about 
"pruning loose objects" (whether unreachable or already 
packed) than it is about "pruning unreachable objects" 
(which could be loose or packed)?  The summary line reads:

  git-prune - Prune all unreachable objects from the object 
database

Maybe I am not familiar enough with git terminology, but 
does "object database" imply loose objects only?  Because 
the word "all" in that summary makes it sound like it will 
prune all unreachable objects (loose and packed).

I don't quite have an alternative suggestion for a better 
summary, the best I could do (but don't like) is:

  git-prune - Prune loose objects (unreachable or packed)


-Martin


-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
