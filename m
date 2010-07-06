From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 06:56:36 -0400
Message-ID: <DD1E6EE4-1196-4FCA-87DA-EB9EBCA3AC83@mit.edu>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu> <20100705025900.GQ22659@josefsipek.net> <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu> <20100705185238.GS22659@josefsipek.net> <20100705192201.GI25518@thunk.org> <20100706080322.GA2856@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: jeffpc@josefsipek.net, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 12:56:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW5pW-0002Gr-3M
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 12:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756647Ab0GFK4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 06:56:40 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:50864 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756634Ab0GFK4j convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 06:56:39 -0400
X-AuditID: 1209190d-b7c19ae0000009ea-34-4c330be69b4f
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Brightmail Gateway) with SMTP id 80.15.02538.6EB033C4; Tue,  6 Jul 2010 06:56:38 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o66AucWh022162;
	Tue, 6 Jul 2010 06:56:38 -0400
Received: from [10.0.42.106] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o66AuZia004004
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 6 Jul 2010 06:56:37 -0400 (EDT)
In-Reply-To: <20100706080322.GA2856@burratino>
X-Mailer: Apple Mail (2.1081)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150342>


On Jul 6, 2010, at 4:03 AM, Jonathan Nieder wrote:
> At one point rev-list did require monotonic --- i.e., the committer
> date of each commit had to be equal to or later than that of each of
> its parents) with no clock skew but that was considered a bug and
> fixed by v1.5.5-rc1~16 (Make revision limiting more robust against
> occasional bad commit dates, 2008-03-17)

You're right that it's been a while since git has run into problems with 
mild forms of clock skew (even Debian Stable is shipping v1.5.6) but
I think it's better to times in the future if we can at all help it, and it's not
like we're talking about a lot of extra complexity to guilt to test for this.

> By the way, I think your idea to have commit warn about nonmonotonic
> commit dates is a good one.  We should also decide on a rule,
> hopefully one the kernel repo obeys (30 days max skew? *crosses
> fingers*) and make git fsck warn loudly about violations.

Having git commit warn, absolutely.

Unfortunately, there is already ~100 days of skew (see the earlier
discusion on this thread by Jeff King) in the Linux kernel repo
already...

-- Ted
