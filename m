From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v2] gitweb: standarize HTTP status codes
Date: Thu, 19 Jun 2008 21:08:41 +0200
Message-ID: <485AAEB9.2080100@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com>	<1213748115-4038-1-git-send-email-LeWiemann@gmail.com> <m3y752melj.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 21:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9PVP-0001QJ-VO
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 21:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYFSTIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 15:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbYFSTIO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 15:08:14 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:11381 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbYFSTIM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 15:08:12 -0400
Received: by fk-out-0910.google.com with SMTP id 18so896509fkq.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=QzVfOZmQSTgFPGvUMDTVhUz94ykAortaAS1B+ujVoE0=;
        b=FDN1NV+InJWAgsfeAxfA3uwj9KK66Tav5QOBZlXIH6w2/PLfhScT8JBRrmVoe7co/8
         LkJLfOIi78zQlz9jKzoe0p8wue3lQEnEAC2dCek2iBX7roKAYNrWuGmgjyI6jLp7ybCS
         QCRmpxh2D1+O6Tc6rgzBPUx/DO8PwplmHuUt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=g+4p3ynRo3FpcpTF4NEzN3Og2pUJixAarspLG0XbENsTu/XGqLlewrTqB1opkOiwCt
         XfH15AkRTLa04puDkKS9T/z66yv4x7fRlQ7zwtGNzSLyKRuln93kyaOK5S0+9R8C+fK9
         bZYj32J0ANfRB8bAln5GnzVNyU18dP7TYzYiI=
Received: by 10.78.134.7 with SMTP id h7mr1211258hud.76.1213902490853;
        Thu, 19 Jun 2008 12:08:10 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.204.94])
        by mx.google.com with ESMTPS id o38sm714137hub.43.2008.06.19.12.08.09
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 12:08:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <m3y752melj.fsf_-_@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85513>

Jakub Narebski wrote:
> Lea Wiemann <lewiemann@gmail.com> writes:
>> For convenience the die_error function now only takes the status code
>> without reason as first parameter (e.g. 404 instead of "404 Not Found")
> 
> _Whose_ convenience?

The developer's convenience of course.  It's plain redundant.

>  * I don't think that RFC 2616 allows blanket replacing reason phrase
>    by generic "Error",
>  * Test::WWW::Mechanize displays both HTTP error status code and
>    reason phrase when get_ok(...) fails:
>  * From the point of view of someone examinimg gitweb.perl code, 400,
>    403, 404, 500 are _magic numbers_;

I think we're really arguing about the color of the bikeshed here.  IMO 
we're not stretching RFC 2616 too much by putting "Error" there (since 
reason codes don't matter on a technical level), and the status codes 
make enough sense to me (and I'm not even a web developer) that I'm not 
concerned about readability.

I don't think your constants a la HTTP_INVALID are a good idea (I 
remember the status codes in a year, but maybe not the constants); 
die_error could figure out the right reason code using a hash.  Either 
way will be fine with me though.

Look, I really don't care about this and I think it's plain irrelevant 
-- do you mind fixing the patch with whatever solution you prefer and 
resend it?  I'd rather spend my time on getting caching implemented, but 
if you insist on me changing this myself, please let me know.

>> Also documented status code conventions in die_error.
> 
> Putting copy of those status code conventions in the commit message,
> and not only in the comment section, would be also good idea.

*shrugs*  I'd rather not duplicate, and it's in the code anyway.

>> -		die_error(undef, "No such project");
>> +		die_error(404, "No such project");
> 
> Here is one thing worth considering: if project exists, but is
> excluded due to either $export_ok or $strict_export being set,
> should we use '404 Not Found' or '403 Forbidden'?

No, because (a) we'd have add code to check this (so it should be in a 
separate patch), and (b) I don't think we even want to return 403, since 
(as you say) it would reveal the existence of a project on the server. 
Project names can contain sensitive/confidential information though.

>> -		die_error(undef, "At least two characters are required for search parameter");
>> +		die_error(403, "At least two characters are required for search parameter");
> 
> Should gitweb use there '403 Forbidden', or '400 Bad Request'?
> This is failing static validation of CGI parameters, not a matter of
> some permissions...

I used 403 in the sense of "sorry, we don't have shorter search strings 
activated for performance reasons".  The '2' could even become 
configurable.  400 is fine too, though, I don't care.

> *All* "open ... or die_error" constructs should use '500 Internal
> Server Error', as the only errors that can be detected on open are
> very serious, server related ones:

Right, thanks for pointing this out.

>> -	my ($have_blame) = gitweb_check_feature('blame');
>> -	if (!$have_blame) {
>> -		die_error('403 Permission denied', "Permission denied");
>> -	}
>> +	gitweb_check_feature('blame')
>> +	    or die_error(403, "Blame not allowed");
> 
> That is a bit separate change, i.e. better explanation of an error
> (although I'd say rather "Blame view not allowed").
> 
> But what about security reasons?

Separate change: I don't think this has to be a separate patch. ;-)
"Blame view not allowed": Fine with me.
Security concerns: I don't see any, and anyway you can probably infer 
from getting 403 on a=blame that it's disabled.

>> -	die_error(undef, "Couldn't find base commit") unless ($hash_base);
>> +	die_error(400, "Couldn't find base commit") unless ($hash_base);
> 
> Wound't it be '404 Not Found', as the explanation suggests?

Yup, right.

>> -	close $fd or die_error(undef, "Reading tree failed");
>> +	close $fd or die_error(500, "Reading tree failed");
> 
> Not O.K.  Barring errors in gitweb code this might happen when
> [X Y Z].  All those are clearly 4xx _client_ errors,

I haven't verified that, so until we have better error handling I prefer 
500, but I really won't bother objecting to 404.  (Same goes for all 
other occurrences of 500 you quoted, which I've snipped.)  FWIW I'm 
assuming that once gitweb uses the new API, that error handling code 
will go away anyway.

> One should examine URL for mistakes, not contact server admin here...

I don't think that'll be a practical concern. ;-)

>> -		die_error('404 Not Found', "Not enough information to find object");
>> +		die_error(400, "Not enough information to find object");
> 
> I'm not sure if it should be '400 Bad Request' or '404 Not Found' here.

It's about missing CGI parameters, so 400 should be fine.

>>  			@difftree
>> -				or die_error('404 Not Found', "Blob diff not found");
>> +				or die_error(404, "Blob diff not found");
> 
> This, if I am not mistaken, can happen only if path limiters doesn'
> catch anything.

Your sentence doesn't quite parse -- why is 404 wrong?

>> -			die_error('404 Not Found', "Ambiguous blob diff specification");
>> +			die_error(400, "Ambiguous blob diff specification");
> 
> Or perhaps '404 Not Dound' here?

Either way is fine.

>> -		die_error('404 Not Found', "Missing one of the blob diff parameters")
>> +		die_error(400, "Missing one of the blob diff parameters")
>>  			unless %diffinfo;
> 
> The "unless %diffinfo" makes it look more like '404 Not Found'...

Looking at the preceding code (the if statement) I believe diffinfo 
being false doesn't indicate 404 but actually a missing CGI parameter 
(as the error message states).

>>  	if (!defined $ftype) {
>> -		die_error(undef, "Unknown type of object");
>> +		die_error(500, "Unknown type of object");
> 
> Errr... shouldn't be '400 Bad Request' here, per convention?

Nope, we didn't get *anything* back, so something weird happened.  500.

-- Lea
