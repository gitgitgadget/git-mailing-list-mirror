From: Maaartin-1 <grajcar1@seznam.cz>
Subject: Re: Forcing re-reading files with unchanged stats
Date: Fri, 14 Jan 2011 22:03:02 +0100
Message-ID: <4D30BA06.3090100@seznam.cz>
References: <loom.20110112T150313-103@post.gmane.org> <4D2E6D99.9060907@dbservice.com> <20110113033217.GA32661@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 14 22:03:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdqoE-0000PK-Dv
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 22:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab1ANVDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 16:03:39 -0500
Received: from smtp.seznam.cz ([77.75.72.43]:34183 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050Ab1ANVDj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 16:03:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=X-Seznam-DomainKeys:X-Seznam-SPF:X-Virus-Info:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-QM-Mark;
	b=fSbvpoKcdtAh/dlmSWK/hHnVdVsiRA4aAAmz35Ms/3OvUAmfbo4llKUqW2MGSPwpd
	QB7zTMhXUgAuB6uEjTBWf2LJUBFFM96rnsGpm0nE60kFR2cyRqqFPJKde59Qw6kMPgw
	r0+3I1APSGUH1vMQDMapx4oYNo4dXZWqmGwhKOk=
X-Seznam-DomainKeys: unknown
X-Seznam-SPF: neutral
X-Virus-Info: clean
Received: from [10.0.3.100] (188-120-198-113.luckynet.cz [188.120.198.113])
	by email-relay2.go.seznam.cz (Seznam SMTPD 1.2.14@16206) with ESMTP;
	Fri, 14 Jan 2011 22:03:06 +0100 (CET)  
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110113033217.GA32661@sigill.intra.peff.net>
X-Smtpd: 1.2.14@16206
X-Seznam-User: grajcar1@seznam.cz
X-Session: 2506
X-Country: CZ
X-QM-Mark: email-qm3<459866260>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165122>

On 11-01-13 04:32, Jeff King wrote:
> On Thu, Jan 13, 2011 at 04:12:25AM +0100, Tomas Carnecky wrote:
> 
>>  On 1/12/11 3:07 PM, Maaartin wrote:
>>> There are files in my working tree which changes, but their size and mtime
>>> remains the same (I know it's strange, but it's useful). Can I make git to re-
>>
>> When can this be useful?

Well, not really. I was asked to place a line containing a version
number and a fingerprint in each file (of course the fingerprint must
ignore this line), so I did. This gets done using a script, and I didn't
like always saying "yes" to Emacs complaining about editing a file
changed on the disk, so I reset the mtime. I really don't think it was
the brightest idea ever.

>>> read them all, so it recognizes the change? Ideally, using a configuration
>>> variable. The repo is fairly small, so speed is no issue here.
>>
>> Try git update-index --refresh. I'm not aware of any config option,
>> but you might want to look through man git-config.
> 
> That won't work, as it respects the stat information. So does
> --really-refresh. AFAIK, there isn't a way to tell update-index to
> ignore start information, short of blowing away the index entirely, and
> doing a read-tree to repopulate it.

Blowing away the index could work for me. I had to check if it's clean
(equal to the HEAD or working tree) first, so I loose no work. But this
is a bit too much work for making my mtime hack work.

> I'm curious what this use case is, and whether it would be acceptable to
> update something like ctime on the files to make them stat-dirty to git.

I'd suppose, Emacs does the same checks.
