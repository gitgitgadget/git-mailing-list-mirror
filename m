From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: RE: Question re. git remote repository
Date: Thu, 17 Jan 2013 01:09:00 +0000
Message-ID: <A0DB01D693D8EF439496BC8B037A0AEF32209A54@xmb-rcd-x15.cisco.com>
References: <A0DB01D693D8EF439496BC8B037A0AEF322098A4@xmb-rcd-x15.cisco.com>
 <alpine.DEB.2.02.1301161617240.21503@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"ishchis2@gmail.com" <ishchis2@gmail.com>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:09:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvdyv-0003YG-Nt
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 02:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323Ab3AQBJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 20:09:03 -0500
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:13546 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652Ab3AQBJC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 20:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1452; q=dns/txt; s=iport;
  t=1358384942; x=1359594542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ixQ3vhvtSwtGjfYP7BlIUz/S6puKBmivocj1wgxuzw=;
  b=f71NLDyGr2FoGcxGa4yy2NGoexocMGLJP2YAdBm0lR9IBWvYtX8FPsF/
   RTCDH8rRU6d2pW5Dzi0hys2QnMRSPlOyFDavkpskd5nYZmIQ4ORBj0xm+
   jZc/zQCtcPhBDBVl9zPjtm8Sc+o5mgsIef4XhhZ4Uks3afddXbB8CAXtK
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EADNO91CtJXG//2dsb2JhbABEvgEWc4IeAQEBAwE6PwULAgEIFQMKFAkHMhQRAQEEDgUIiAsFAQy5GJBXYQOXKI8tgnWCJA
X-IronPort-AV: E=Sophos;i="4.84,483,1355097600"; 
   d="scan'208";a="163307223"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by rcdn-iport-1.cisco.com with ESMTP; 17 Jan 2013 01:09:00 +0000
Received: from xhc-aln-x08.cisco.com (xhc-aln-x08.cisco.com [173.36.12.82])
	by rcdn-core2-4.cisco.com (8.14.5/8.14.5) with ESMTP id r0H190Wr003914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 17 Jan 2013 01:09:00 GMT
Received: from xmb-rcd-x15.cisco.com ([169.254.5.248]) by
 xhc-aln-x08.cisco.com ([173.36.12.82]) with mapi id 14.02.0318.004; Wed, 16
 Jan 2013 19:09:00 -0600
Thread-Topic: Question re. git remote repository
Thread-Index: Ac30QapFxgO7vxkcSpqZYTWiS/u7TwAOT+SAAAxmn8A=
In-Reply-To: <alpine.DEB.2.02.1301161617240.21503@nftneq.ynat.uz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.71.137.42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213832>

> From: David Lang [mailto:david@lang.hm]
> 
> On Wed, 16 Jan 2013, Matt Seitz (matseitz) wrote:
> 
> > Linus seemed to think it should work:
> >
> > http://permalink.gmane.org/gmane.comp.version-control.git/122670
> 
> In the link you point at, he says that you can have problems with some
> types of
> actions. He points out things like git prune, 

Linus wrote:

You do need to be a bit careful if you do maintenance operations 
concurrently (I would suggest avoiding doing concurrent "git gc --prune", 
for example), but any normal git workflow should be fine.

> but I would also say that there
> are probably race conditions if you have two git processes that try to
> change the HEAD to different things at the same time.

What makes you think there are race conditions?

Linus wrote:

And git doesn't have "proper locking", because it doesn't need it for 
database ops: git objects are stable. For refs, git should be using the 
proper NFS-safe "create and atomic rename" ops.

> > And "git init" specifically has a "shared" option:
> >
> > --shared[=(false|true|umask|group|all|world|everybody|0xxx)]
> 
> I think this is dealing with multiple users _reading_ a repository, not
> making
> updates to it at the same time.

The description of "shared" says "This allows users belonging to the same group to push into that repository."  The "push" command is about making updates.
