From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Extract Git classes from git-svn (2/10) (was Re: Fix git-svn
 tests for SVN 1.7.5.)
Date: Wed, 18 Jul 2012 17:11:22 -0700
Message-ID: <500750AA.3060802@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
 <5005F164.3060300@pobox.com> <20120718105835.GA32215@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 02:11:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SreL2-0007ru-4v
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 02:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab2GSALX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 20:11:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163Ab2GSALW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 20:11:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DA648377;
	Wed, 18 Jul 2012 20:11:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=M7K60OkyT6/u
	v4NNOsHzdCIGdh4=; b=p6At0nGbLLyVcP+q2Gf3MxCPcLBoqnPoW5z17tesDl86
	KFAa11PCEe4hVYSJ0B0/TmgJBhyd0imSFcZgQbphO3qJ/x2piaxBCny5GeeDI7QX
	s95MrhGvGpGdMBFyhrzBoTUzkSUiBekLImVIGS2dbLECpKJRi9i4oMUCVsTpR/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PKWR/h
	njRICkqdG8hfZRDPg3ix/KxIyR4wljfHIBhmZQYBUJ0KhzReMDxOrNcIfF4aMruR
	sPDFD2Bi+4TFVJdtueLHUWA+sbOAEjIj2lCn+eS7F2JTFZVsMuN7Ty3+IqU6uQV6
	WUcwyYgE/tcp8Yq4xqNIRhMG5TWNcSCagmQ30=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29D158376;
	Wed, 18 Jul 2012 20:11:21 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 586F28375; Wed, 18 Jul
 2012 20:11:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120718105835.GA32215@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 44AD0604-D136-11E1-9E38-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201707>

On 2012.7.18 3:58 AM, Eric Wong wrote:
> I agree with everything Jonathan said (and thank him for taking
> the time to point you in the right direction).

Thanks, you guys have been very nice to my flailing and failing.  I'm going to
back off and send out a sort of overview email so we can figure out how best
to chunk this up.


>> +++ b/t/Git-SVN/00compile.t
> 
>> +use Test::More tests => 2;
> 
> I prefer not declaring test counts and using done_testing() instead.
> done_testing() is favorable to me in at least 2 ways:
> 
> * done_testing() closely matches the behavior of the existing
>   sh-based test suite in git (which calls test_done)
> 
> * maintaining test counts leads to unnecessary merge conflicts

Yes, I concur 100%.  So much that I went back in my time machine and added
done_testing() to Test::More!  Also I killed Hitler, so now WWII ends in 1945.
 Things seem to have turned out for the better.

I love it when people advocate my features back to me. :)  I didn't use
done_testing because I didn't know your stance on using non-5.8 core versions
of modules.


> Skipping the tests on old versions of Test::More (< 0.88) is acceptable
> to me (especially since integration tests provide the real coverage
> already).

It is very easy to bundle an uninstalled copy of Test::More, probably easier
than putting in the code necessary to check for it and skip it.  A lot of Perl
modules do it.  The usual thing is to put it into t/lib/ and add "use lib
't/lib'" to the tests.  I don't see any reason why that basic technique
wouldn't work here, with some minor changes to match the Git test suite.

I can help you with that, but I'd like to get through this SVN 1.7 fix first.


-- 
Being faith-based doesn't trump reality.
	-- Bruce Sterling
