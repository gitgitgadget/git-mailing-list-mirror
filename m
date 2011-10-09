From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Re: Recovering Committed Changes in a Detached Head?
Date: Sat, 08 Oct 2011 23:32:00 -0400
Message-ID: <4E9115B0.3030701@gmail.com>
References: <1318107488.5865.46.camel@R0b0ty> <20111008213741.GA24409@goldbirke> <ab706826-75df-4410-941e-6b40ec92713c@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: mfick@codeaurora.org, szeder@ira.uka.de, daly.gutierrez@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 05:32:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCk7X-000584-0M
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 05:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814Ab1JIDcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 23:32:06 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58873 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab1JIDcE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 23:32:04 -0400
Received: by qadb15 with SMTP id b15so3391074qad.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 20:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        bh=14z0zo8QClyIAsAft94hckBmqpyK9zbcUYmq3T2NQL0=;
        b=gV5uAZUgk47M8yBFEdSVHOBkRK2+48CykypfygCTMPQlebTdmYHCS3v/uuTNdmCNFF
         DaDDCFhoPzsRbzHpubEm+VxuuDDqu+4xHw/ANnYVSu06IpCclx3TqNoWVC6gjTya9VhU
         U46sWPeAmcdTeuE3Jh4EvOShoW87duIvdzgl0=
Received: by 10.224.181.202 with SMTP id bz10mr2665405qab.59.1318131122705;
        Sat, 08 Oct 2011 20:32:02 -0700 (PDT)
Received: from [192.168.1.44] (pool-173-77-12-230.nycmny.east.verizon.net. [173.77.12.230])
        by mx.google.com with ESMTPS id du8sm17250756qab.11.2011.10.08.20.32.00
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 20:32:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110923 Thunderbird/7.0
In-Reply-To: <ab706826-75df-4410-941e-6b40ec92713c@email.android.com>
X-Enigmail-Version: 1.4a1pre
OpenPGP: url=hkp://pool.sks-keyservers.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183183>

On 10/08/2011 06:00 PM, Martin Fick wrote:
>> git reflog to the rescue.
<snip>
>> There you see the first line of the commit message from your "lost"
>> commit, and you can do
>>
>>  git checkout -b lost_detached_head 92aa5381
>>
>> and you get a branch pointing to that commit you made while on
>> detached head, and you can work with it as usual.
> 
> While rflog is cool, I can't help but think that git could be even more helpful for these scenarios.
> 
> First, maybe git could create refs for these automatically, perhaps with a name like orphans/1?  Maybe these refs would only be visible via git branch --orphans.

Creating these "orphan" refs would require the equivalent of (part of)
git-fsck; I can't imagine that could be imposed without significant
overhead on too many operations.  I think you'd be better off wrapping
git-fsck in a script that can create these branches.

--Joel
