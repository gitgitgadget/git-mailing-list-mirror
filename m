From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Wed, 11 Jul 2007 17:55:49 +0200
Message-ID: <200707111755.50018.jnareb@gmail.com>
References: <1183053733.6108.0.camel@mattlaptop2> <7vir8w6inf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matt McCutchen <hashproduct@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Luben Tuikov <ltuikov@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 18:18:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ete-0005do-60
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 18:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293AbXGKQSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 12:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818AbXGKQSY
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 12:18:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:29549 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbXGKQSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 12:18:23 -0400
Received: by ug-out-1314.google.com with SMTP id j3so148781ugf
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 09:18:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JSimxXW3uqwqvb47seuPxsK1JP1W4LB48v8vlCODzlPoNbqT/BVgd5uywe0wdSU0Me73FprqxslbsBnDWwtRpUl+yznmYtNwpy6dol1FKZtlYwUXY50QKm+NUBgj5c7o+ATXks6JzlwaqpelqDs4GFGGj8nuvu8pfUNwVPGN9xM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eHbejmQPIWMLQ0DoJKsrtnUbyRG45BoN0D0qhYjwYskH7cs76hND1FMasksvEYAWm+ROyzGDpknFW433GBNzu/YxUn021ugQAb3MLnhRM7ZDKaDFF1x28yw3Wb7wlBJm0z8QSC6ZefjQ+kaO0t3AQHVxjka/K6k0V3wndmNcZ6E=
Received: by 10.86.3.2 with SMTP id 2mr1364464fgc.1184170702227;
        Wed, 11 Jul 2007 09:18:22 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTP id 22sm36705599fkr.2007.07.11.09.18.19
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jul 2007 09:18:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vir8w6inf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52173>

On Sat, 7 Jul 2007, Junio C Hamano wrote:
> Matt McCutchen <hashproduct@gmail.com> writes:

>> +# information about snapshot formats that gitweb is capable of serving
>> +# name => [mime type, filename suffix, --format for git-archive,
>> +#          compressor command suffix]
>> +our %known_snapshot_formats = (
>> +	'tgz'  => ['application/x-gzip' , '.tar.gz' , 'tar', '| gzip' ],
>> +	'tbz2' => ['application/x-bzip2', '.tar.bz2', 'tar', '| bzip2'],
>> +	'zip'  => ['application/zip'    , '.zip'    , 'zip', ''       ],
>> +);

> This is a very nice clean-up, and I agree we should go this
> route in the longer term.

I agree that is a nice cleanup.

I'm not sure if we want to store whole 'application/x-gzip' or only
'x-gzip' part of mime type, and if we want to store compressor as
'| gzip' or simply as 'gzip'.
 
> This however will break people's existing gitweb configuration,
> so if we were to do this it should be post 1.5.3, I would say.

This would break not only existing _gitweb_ configuration (when
gitweb admin installs new gitweb it isn't that hard to correct
gitweb config), but also git _repositories_ config: gitweb.snapshot
no longer work as it worked before, for example neither 'gzip'
nor 'bzip2' values work anymore ('zip' doesn't stop working).

-- 
Jakub Narebski
Poland
