From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-receive
Date: Thu, 29 Nov 2007 23:06:31 -0500
Message-ID: <7F81126E-5A76-40CA-94BF-82B46C57AFF6@mit.edu>
References: <1195809174-28142-1-git-send-email-mfwitten@mit.edu> <7v3aup291c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 05:13:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxxFL-0007Ay-GJ
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 05:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762607AbXK3EMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 23:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762768AbXK3EMa
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 23:12:30 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:50301 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762418AbXK3EM3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 23:12:29 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2007 23:12:29 EST
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id lAU46XiB015363;
	Thu, 29 Nov 2007 23:06:33 -0500 (EST)
Received: from [18.239.5.240] (MACGREGOR-TWO-FORTY.MIT.EDU [18.239.5.240])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id lAU46VKV028198
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 29 Nov 2007 23:06:32 -0500 (EST)
In-Reply-To: <7v3aup291c.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66612>


On 28 Nov 2007, at 7:24:31 PM, Junio C Hamano wrote:

> Michael Witten <mfwitten@mit.edu> writes:
>
>> git-cvsserver just did the following:
>>     (1) run hooks/update
>>     (2) commit if hooks/update passed
>>
>> This commit simply adds:
>>     (3) run hooks/post-receive
>>
>> Also, there are a few grammar cleanups and
>> consistency improvements.
>
> I gave only a very cursory look; looks Ok to me.  This makes me wonder
> if post-update wants to run as well.

Seems like post-receive is supposed to supersede post-update anyhow,
so might as well leave post-update out at this point?

In any case, I haven't taken a thorough look at how git-cvsserver works,
but it seems to duplicate a lot of git-receive-pack.

How about turning git-cvsserver into a true middleman, so that it  
constructs
a 'temporary git working tree' and then does a real git-push into the  
final
git repository.

Because git-cvsserver would be using git-send-pack to do the pushing,  
it could
push to yet another server. How cool is that!
