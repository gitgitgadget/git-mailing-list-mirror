From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Teach Makefile.PL to find .pm files on its own
Date: Wed, 25 Jul 2012 14:12:22 -0700
Message-ID: <50106136.5000404@pobox.com>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <7vhasvdbk9.fsf@alter.siamese.dyndns.org> <5010567B.1060907@pobox.com>
 <7vehnzbmyt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su8sh-0004GN-BC
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 23:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab2GYVM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 17:12:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394Ab2GYVMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 17:12:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13B5E6F09;
	Wed, 25 Jul 2012 17:12:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=kiKGEp+Mwyuv
	KRB3dSUPdCjcuvk=; b=NMai+6SclB86tgWsWcnuZTmJA3Zj383F/WS7prJfDvxI
	pQEtC1NK2LH+3V/MjtVazrxzYV0zqplVeqh2cR38QrxMndcfOyWjv+oNN7XMFTBv
	z7TL0vWPe4/+UTHLwZLUXEkqzYAnPHfjZuYw2qve6i+0jjUC+RTI4Z3IzCuOTMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r7k5qo
	jv1p67TNPsk3OaUanbxeqYYxw31mFMYYj2tl0M6mRdzu2iNtsQ0w0AdJIDeUtlER
	8BANaAVLf2zcZleozsvX3KBuXvM4TWxAwrLyWIKCrxKVVZ2YSZoVTMRwIjl2rSLG
	DDEcX4aayeSIsfeAQ0tNAdravKXmN39fFLqFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0055E6F07;
	Wed, 25 Jul 2012 17:12:25 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B6706F06; Wed, 25 Jul
 2012 17:12:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vehnzbmyt.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 6E3637C2-D69D-11E1-823C-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202198>

On 2012.7.25 1:32 PM, Junio C Hamano wrote:
> Michael G Schwern <schwern@pobox.com> writes:
> 
>> What's the lag time on it showing up in the repo, and which branch will it
>> appear in?
> 
> There is nothing special in this topic, so it is likely to start on
> 'pu', and unlikely to come to 'master' before 1.7.12 ships sometime
> next month.

Ok.


>> Also I just realized I've been basing my work on master.  Should I move to maint?
> 
> I don't think so.  It is not fixing any urgent breakage (iow, by
> being told about .pm explicitly, it knows about them just fine
> without being taught how to find them).

How about the git-svn SVN 1.7 fix in general?  All of these patch sets I'm
sending build on one another, is that going to be a problem?  It's going to
come in about six parts.

1) Makefile.PL .pm auto-find
2) Extract Git::SVN from git-svn
3) Extract the other modules from git-svn
4) Create and use accessors for paths and urls
5) Make the accessors canonicalize
6) Fix misc canonicalization issues

This is #1.  #2 was submitted last night.  #3 will be coming today.  #4 should
probably wait until #3 is at least in pu and I stop moving around large chunks
of code.

#1 to #4 are all refactorings with no functional changes.  #5 and #6 will be
tricky to provide as small commits while keeping all tests passing in SVN 1.6.
 We'll see when I get there after doing the rebasing necessary to separate #4,
#5 and #6.


-- 
10. Not allowed to purchase anyone's soul on government time.
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
