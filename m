From: "Bryan O'Sullivan" <bryano@fb.com>
Subject: Re: logging disjoint sets of commits in a single command
Date: Wed, 1 Feb 2012 01:02:57 +0000
Message-ID: <CB4DCD5C.747%bryano@fb.com>
References: <20120201005332.GC30969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 02:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsOcR-0006sj-Qp
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 02:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab2BABEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 20:04:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59313 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754182Ab2BABEJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 20:04:09 -0500
Received: from pps.filterd (m0004346 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id q11142kK006687;
	Tue, 31 Jan 2012 17:04:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Vsh22XFRs2A6vZ6rc1iOgmNr1K8/pzEzkDIjpSRxTSE=;
 b=l9SjA7zwU4vpzP0DEpzlU8o2AwaU+Lvzt+e+vuv6qM4DQWkE7eDRS2KtFvKLusqm0W9Y
 UyrJZgb2oXobK3pEeZgSnhqXUZFbwQ78CvqDgLZyNnDuGIpdRbJWlT36i+jWYkuTR+KE
 NyF5hp1EV3lgavI7uS9Tzwf3XXS0Dv3IptQ= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0a-00082601.pphosted.com with ESMTP id 12pt8qr2k8-4
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 31 Jan 2012 17:04:02 -0800
Received: from SC-MBX02-4.TheFacebook.com ([fe80::e1f0:42de:c867:1385]) by
 sc-hub04.TheFacebook.com ([192.168.18.212]) with mapi id 14.01.0355.002; Tue,
 31 Jan 2012 17:02:57 -0800
Thread-Topic: logging disjoint sets of commits in a single command
Thread-Index: AQHM4Hal0o4/+qLyk0uC5cG4lN8eDZYnLqsAgACKbYCAAAPugP//fISA
In-Reply-To: <20120201005332.GC30969@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.18.252]
Content-ID: <5A8BD53D81A71746BD92131C4E063EF0@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.211,0.0.0000
 definitions=2012-01-31_09:2012-01-31,2012-01-31,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189490>

On 2012-01-31, "Jeff King" <peff@peff.net> wrote:

>This topic came up
>recently, and I think the general consensus is that it would be cool to
>be able to do totally independent ranges, but that would be backwards
>incompatible with the current behavior.

That's totally sensible. I hadn't been able to tell from inspection
whether the behaviour was deliberate or not.

>which is of course slightly more annoying to type. If you're just
>interested in _single_ commits, though, you can just give the commits
>and turn off walking:
>
>  git log --no-walk 373af0c 590dfe2

Oh, nice! I hadn't seen that option.

By the way, the reason I'm even interested in this in the first place is
that the performance of commands like "git blame" and "git log" on files
and subtrees has become a problem for us (> 10 seconds per invocation,
forecast to get much worse), and I wanted to see whether I could feed "git
log" a specific list of revisions, and if so, whether that could yield
good performance.

I have it in mind to build a secondary index (maintained externally) so
that I can supply these git commands with precise lists of revisions for
much faster response times.

Thanks, guys!
