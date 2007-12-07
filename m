From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 16:39:44 -0500
Message-ID: <9e4733910712071339o5b1efd37g8ff471e767c0ae76@mail.gmail.com>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
	 <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
	 <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0kvZ-0003IU-Fw
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbXLGVjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755038AbXLGVjq
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:39:46 -0500
Received: from ro-out-1112.google.com ([72.14.202.183]:39591 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbXLGVjp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:39:45 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7318749roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 13:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=p6joo1QZWnK6s0SQGP8oX0SXfHT4v0kEg+ZCORDai38=;
        b=Sds9b9hLOb3UPJi2lXfFs9J1petkS3NzMSg36zqLz+FV32T1BVwjs8Mj1L8vbrYTSyJ3mSoJxv/GAVqmZdq/79ymdGbJFL1XQhNL+JPyRfJ6e4vFA6XucPQWzdiiFtxIeKjBrrd0apSfgHNfWKsHOG9FQXar3QEJ8K609Y9ASQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i4r1fFsHrjXZxFhrEXYIAibX16N3sxpV1hmw21tjDpKPmZq0L6e8ZoMk2x7lha0Aq+YYoGACp3fvD6FikfT7dsFqxx5L16/rRS+VzOy5/tMLId4Uem+8N0aBVuRP1nlvworMBKb2tvQRTjmhIFjnou7i6WoqAAXZPJrarnhMFDk=
Received: by 10.115.111.1 with SMTP id o1mr4023631wam.1197063584603;
        Fri, 07 Dec 2007 13:39:44 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 13:39:44 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67470>

Here's a big clue.

When I repack the 300MB file the process grows to 4.8GB
When I repack the 2,000MB file the process grows to 3.3GB

In both cases the last 10% of the repack is taking as much time as the
first 90%.

At the end I am packing 60 objects/sec. In the beginning i was packing
1,000s of objects per second.

I'm not swapping

jonsmirl@terra:/video/gcc/.git/objects/pack/foo$ vmstat 1
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 2  0   1416  25668   3904 2756404    0    0    62    45  115  398  6  0 93  1
 3  0   1416  26880   3900 2754852    0    0     0     0  414 2453 26  1 73  0
 2  0   1416  26880   3900 2754852    0    0     0     0  472 3518 26  1 73  0
 4  0   1416  26912   3900 2754768    0    0     0     0  394 1642 26  1 74  0
 2  0   1416  26912   3900 2754768    0    0     0     0  401 1364 25  0 75  0
 2  0   1416  26896   3900 2754768    0    0     0     0  456 1922 25  1 75  0



-- 
Jon Smirl
jonsmirl@gmail.com
