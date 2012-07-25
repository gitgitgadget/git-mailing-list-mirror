From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 3/3] The Makefile.PL will now find .pm files itself.
Date: Wed, 25 Jul 2012 14:49:29 -0700
Message-ID: <501069E9.2000009@pobox.com>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <1343186471-1024-4-git-send-email-schwern@pobox.com>
 <20120725211143.GA5455@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:49:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su9Sb-0008Bp-Nk
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 23:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab2GYVtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 17:49:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab2GYVtc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 17:49:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A315A7967;
	Wed, 25 Jul 2012 17:49:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=CfTEtj9/y+nh
	uwQhVYW6dWnBoEQ=; b=nR+bLUNLUSBoQgIihYX3Fd72WIBY6FgpqHTzG5DJZxgy
	nWnkQLt2hO/+OoOyk6g+p3N+opD9bIxXdXGP9L/07FtSJZ6ysvyFZXlXHal5k4Og
	Lo0gDiqd3qqqhEd5FxbE6At1LazBBB4QIGTQsNV76/jaOlXGUcyWY3VtrbsH/HU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d8G+8X
	5nVxvfnlrPuvPGmqLpzAQqaWx8F8wwvi2rJ2bdwwTMZjlobQzc2nxI0YOivbYQjZ
	8I3U5Uja9JKf6Fo5/p6MS7PfvsG0texECk2oBaNzzFKt+DJcyXULqNKBSI9UhCHY
	Lg+N2M4dZlZezGz0N3XrBe8sie1XraR01iziQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FA537966;
	Wed, 25 Jul 2012 17:49:31 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B11DC7965; Wed, 25 Jul
 2012 17:49:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120725211143.GA5455@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 9D74FB22-D6A2-11E1-9F89-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202202>

On 2012.7.25 2:11 PM, Jonathan Nieder wrote:
>> --- a/perl/Makefile.PL
>> +++ b/perl/Makefile.PL
>> @@ -2,6 +2,10 @@ use strict;
>>  use warnings;
>>  use ExtUtils::MakeMaker;
>>  use Getopt::Long;
>> +use File::Find;
>> +
>> +# Don't forget to update the perl/Makefile, too.
>> +# Don't forget to test with NO_PERL_MAKEMAKER=YesPlease
> 
> In a previous apartment I lived in, there was a note taped to the
> lightswitch reminding us to turn off the heat, take keys with us, and
> lock the door.  The note was useful because by force of habit we would
> be turning off the light, and as a result see the note, on the way
> out.
> 
> Who are these comments in perl/Makefile.PL addressed to?

Somebody adding, renaming or deleting a .pm file.

> Why would such a person be looking at perl/Makefile.PL?

Because sometimes they do wacky things, especially in non-Perl projects, its
good to check.

> Sorry to sound like a broken record, but I don't think these questions
> were answered yet.

The instructions are still necessary and I don't know where to put them so
they have a better chance to be seen.  At least somebody adding a .pm file
might glance inside the Makefile.PL.


> How about this patch for squashing in, which would avoid the question
> and save me from having to worry that my words are going to stay in
> this file after the no-makemaker option no longer exists because
> nobody looks at them here?

If somebody eliminates NO_PERL_MAKEMAKER they'd grep the tree for all its
occurrences.  I'd rather keep the instructions in there, because having two
build systems is downright wacky.  In fact, I'd go on to say that an
explanation should be added to the Makefile as well.

This is out of scope for what I wanted this patch to do, and I really don't
have a horse in this race.  For my purposes, I just preserved the comment.  If
it goes away that's ok, too.

Later on I can help getting rid of the second build system.


> diff --git i/perl/Makefile.PL w/perl/Makefile.PL
> index 3d88a6b9..377fd042 100644
> --- i/perl/Makefile.PL
> +++ w/perl/Makefile.PL
> @@ -4,9 +4,6 @@ use ExtUtils::MakeMaker;
>  use Getopt::Long;
>  use File::Find;
>  
> -# Don't forget to update the perl/Makefile, too.
> -# Don't forget to test with NO_PERL_MAKEMAKER=YesPlease
> -
>  # Sanity: die at first unknown option
>  Getopt::Long::Configure qw/ pass_through /;



-- 
31. Not allowed to let sock puppets take responsibility for any of my
    actions.
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
