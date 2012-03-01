From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH-w 101/105] t6300 (for-each-ref): modernize style
Date: Wed, 29 Feb 2012 19:20:53 -0800
Message-ID: <20120301032053.GD2572@tgrennan-laptop>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330566326-26075-7-git-send-email-tmgrennan@gmail.com>
 <7v62epqd9a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 04:21:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2wZn-0001Zr-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 04:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab2CADVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 22:21:00 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59645 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab2CADU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 22:20:59 -0500
Received: by vbbff1 with SMTP id ff1so130136vbb.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 19:20:59 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.93.74 as permitted sender) client-ip=10.52.93.74;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.93.74 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.93.74])
        by 10.52.93.74 with SMTP id cs10mr4581655vdb.42.1330572059105 (num_hops = 1);
        Wed, 29 Feb 2012 19:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sk5vHRZKzVVasBhEzPtpcuv0pc6xKD1l+Nreoo1Sqnk=;
        b=rNjDHoja7E+a5yKfqXUujCGNxor7Cv5mWn0lsxvrKL/qznOR4LH4qy0aJLOycKL3Bf
         VbgtvAphev1ZAYu3T9GZ5EptUCns5K5lUpFekvu3K9UTbrIlhLNw/z+EmRoxHtm18BLE
         K5e0jN3IsqUIunyDp2v1J1r4+fDQqgnJZ//Z8=
Received: by 10.52.93.74 with SMTP id cs10mr3920328vdb.42.1330572059024;
        Wed, 29 Feb 2012 19:20:59 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id ew2sm910368vdc.16.2012.02.29.19.20.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 19:20:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v62epqd9a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191890>

On Wed, Feb 29, 2012 at 06:13:53PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> +if ! test -r test-lib.sh ; then
>> +	(cd ${0%/*} && ./${0##*/} $@)
>> +	exit $?
>> +fi
>
>Not very nice; why is this an improvement?

I liked being able to,
	t/t1234-frotz.sh [-q|-v]
in addition to,
	cd t && sh ./t1234-frotz.sh

>>  . ./test-lib.sh
>>  . "$TEST_DIRECTORY"/lib-gpg.sh
>>  
>> +quiet () { "$@" >/dev/null; }
>> +silent () { "$@" >/dev/null 2>&1; }
>
>Not nice, either.

"Not nice" b/c they're on one line?
I like simple things compressed so I quickly glance pass them.
Sort of forest through the trees.

>>  # Mon Jul 3 15:18:43 2006 +0000
>>  datestamp=1151939923
>>  setdate_and_increment () {
>> @@ -22,9 +30,9 @@ test_expect_success 'Create sample commit with known timestamp' '
>>  	setdate_and_increment &&
>>  	echo "Using $datestamp" > one &&
>>  	git add one &&
>> -	git commit -m "Initial" &&
>> +	git commit -q -m "Initial" &&
>>  	setdate_and_increment &&
>> -	git tag -a -m "Tagging at $datestamp" testtag
>> +	quiet git tag -a -m "Tagging at $datestamp" testtag
>
>Why? Why? Why?
>
>	cd t && sh ./t1234-frotz.sh
>
>would be silent enough and suppressing the output from the commands like
>this patch does makes it _harder_ for people to debug their changes to the
>script with
>
>	sh ./t1234-frotz.sh -v

Hmm, I found the noise distracting.  For example, w/o redirecting
stderr, most of the test_must_fail puke as expected.  If it's expected,
why show it?  BTW since it's a different stream, to get the error near
the exec log one has to:

	sh ./t1234-frotz.sh -v |& less

Otherwise it's challenging to separate the expected vs unexpected failures.

Most of the "quiet's"  are with git-tag and git-branch.  I'd prefer
--quiet and --silent options to these commands like git-init, git-commit, etc.

>Most of the change in this patch does nothing to do with "modernize style".

It's trivial to remove these "quiet" and "silent", but to me that's the
only value added by these patches.  More seriously, the remaining
modernization still seems much larger than its value.

-- 
TomG
