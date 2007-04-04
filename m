From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: Few doublequoted strings cleanups
Date: Wed, 4 Apr 2007 11:10:33 +0200
Message-ID: <200704041110.33921.jnareb@gmail.com>
References: <200704012221.01676.jnareb@gmail.com> <200704012223.00087.jnareb@gmail.com> <7vlkh9w6pa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 14:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ4Li-0004pi-Sg
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 14:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992877AbXDDMMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 08:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992879AbXDDMMZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 08:12:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:50872 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992877AbXDDMMY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 08:12:24 -0400
Received: by ug-out-1314.google.com with SMTP id 44so637860uga
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 05:12:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=J44oP8xeAEDS9Ov71ZaGQPYmwijkhDyf7iIxaPugxW/W7S3pht+f37FXG+9QEpTRk3WFTDT0Z1X5aQo39DO2vON9bfmSc45JU6EiWPT/snHG6cTgaHNwSeoQ3PTC6yTlP+RYY1ddehDEvszTh54dmXJ/ctopMq4kmyjt0ZJVeyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lMKDzXQ9QFQT5MW7m9TnASmH1djtR6YzGge6mNmoLCk/AV1jgQ3hOZZRHwsMz3sBTgrxX9Dz+DhHmf3ERc+I+IpVnpf5s5c5jlG0Y1hOsEgyUkq2KGVdTTKtAD2lVlKhGi8jYFkkU8Ei1QJPCbPAHLBTJTklFieaZrpd4fS6aXI=
Received: by 10.82.167.5 with SMTP id p5mr603804bue.1175688742463;
        Wed, 04 Apr 2007 05:12:22 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w5sm51452mue.2007.04.04.05.12.20;
        Wed, 04 Apr 2007 05:12:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vlkh9w6pa.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43731>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Replace a few doublequoted strings by theirs singlequoted equivalent,
>> lose doublequotes around variable in string containing only
>> of a variable name, use '' consistently as an empty string (and not
>> sometimes as "").
> 
> Why?  I do not in particular like a micro-cleanup like this (it
> seems more of personal taste than cleanup).

IMVHO consistency (always use '' to denote empty string... or always
use "") is a cleanup.

But I'm not that attached to this patch. It could stay or it could
go... One of the reasons for this patch was (most probably wrong)
idea from dealing with PHP that using single quotes makes program
a tiny bit faster.

>> -	} elsif ($char eq "\\") {
>> +	} elsif ($char eq '\\') {
>>  		$diff_class = " incomplete";
>>  	}
> 
> Especially this makes a shell scripter think twice before
> realizing that this is Perl and a backslash expands inside
> single quotes.  In other words, I find that the former is easier
> to read.

O.K. Although you can always escape singlequote inside single
quotes, so escape character also has to be escaped.

>> @@ -1052,7 +1052,7 @@ sub git_get_projects_list {
>>  		my $dir = $projects_list . ($filter ? "/$filter" : '');
>>  		# remove the trailing "/"
>>  		$dir =~ s!/+$!!;
>> -		my $pfxlen = length("$dir");
>> +		my $pfxlen = length($dir);
> 
> On the other hand, I think this makes the code easier to read.

There are only two such chunks. Feel free to pick them...
 
>> @@ -3616,7 +3616,7 @@ sub git_snapshot {
>>  
>>  	print $cgi->header(
>>  		-type => "application/$ctype",
>> -		-content_disposition => 'inline; filename="' . "$filename" . '"',
>> +		-content_disposition => 'inline; filename="' . $filename . '"',
>>  		-status => '200 OK');
>>  
> 
> Wouldn't it be easier to read if we did
> 
> 	"inline; filename=\"$filename\""
> 
> instead?

It would. Right.

-- 
Jakub Narebski
Poland
