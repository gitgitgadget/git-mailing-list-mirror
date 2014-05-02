From: Keith Derrick <keith.derrick@lge.com>
Subject: Re: BUG or FEATURE? Use of '/' in branch names
Date: Fri, 2 May 2014 18:36:59 -0400
Message-ID: <53641E0B.5000706@lge.com>
References: <5363D1B4.1000503@lge.com>
 <AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>
 <20140502221617.GO9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"simon.busch@lge.com" <simon.busch@lge.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:39:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgM7H-0003hc-Fc
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbaEBWjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:39:36 -0400
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:49739 "EHLO
	lgemrelse6q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbaEBWjf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 18:39:35 -0400
Received: from unknown (HELO aicexhub01.lge.net) (204.79.148.69)
	by 156.147.1.121 with ESMTP; 3 May 2014 07:39:32 +0900
X-Original-SENDERIP: 204.79.148.69
X-Original-MAILFROM: keith.derrick@lge.com
Received: from AICEXMBXCL02.LGE.NET ([136.166.10.230]) by AICEXHUB01
 ([204.79.148.67]) with mapi; Fri, 2 May 2014 18:38:02 -0400
Thread-Topic: BUG or FEATURE? Use of '/' in branch names
Thread-Index: Ac9mVyzLZ1O7UBh+QDaKvZcQ4jr8Ig==
In-Reply-To: <20140502221617.GO9218@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101
 Thunderbird/24.4.0
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248001>

Yes, I've since found some discussion on this, and had already changed 
to use '-' to append the classifier.

But the other problem is that I can't easily find this restriction 
documented anywhere - which means it comes as a suprise to people.

As it stands, the documentation implies that what I tried should work. 
In which case, how it's been *implemented* seems to be breaking the 
promise of the functional specification (if you view the documentation 
as such).

Keith

On 05/02/2014 03:16 PM, Jonathan Nieder wrote:
> Hi Keith,
>
> Keith Derrick wrote:
>
>>      $ git checkout -b hotfix
>>      Switched to a new branch 'hotfix'
>>      $ git checkout -b hotfix/b2
>>      error: unable to resolve reference refs/heads/hotfix/b2: Not a directory
>>      fatal: Failed to lock ref for update: Not a directory
>>      $
> That's an ugly message.  I think we can do better. (hint hint)
>
> Longer term, I think people would like to make it possible for a
> 'hotfix' and 'hotfix/b2' branch to coexist, but that will take some
> work, and until then, git tries to be careful about enforcing the
> constraint that they cannot coexist.
>
> Fixing it would be complicated by the need to avoid breaking people
> with older versions of git when they fetch from you (what happens to
> the origin/hotfix and origin/hotfix/b2 remote-tracking refs on the
> client side?).
>
> Thanks and hope that helps,
> Jonathan
