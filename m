From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git config' access
Date: Thu, 9 Apr 2009 01:13:53 +0200
Message-ID: <200904090113.54272.jnareb@gmail.com>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz> <200904081218.39984.jnareb@gmail.com> <49DC8002.6050503@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Sam Vilain <samv@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Apr 09 01:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrgzU-0008Ax-LM
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 01:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbZDHXN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 19:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbZDHXN5
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 19:13:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:29572 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbZDHXN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 19:13:56 -0400
Received: by fg-out-1718.google.com with SMTP id 16so617328fgg.17
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WZ75FiGToKADDqRIEiIDsVUGMpoN7XzYt5zRW3guDbw=;
        b=GZeOHea0KqP37mkqrUANaAnW4QfldEdzSLmX2ajMPlshU6wzK+gES/5gPXrZ3YVXip
         tFgzh6Ea0I+o72Mn9UsVUlnxqxrqn2G973acS/fGZ+bKKRJf9ZJLOZt4DJihxQlAwljv
         PMrQfhSiWwth9GeOZtU2QYv8NjRmhWFn9Mnk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EJIzyaSwkJXKi3xFMe0JjjBeuYtOj7AQEU8I7L1mDGlQz4geut2U59+bgreuWNJAfV
         A59LUSUaWWjPXTUMxL79OcZqcRZFw4ZAGgKqqVgERsJvvUOuY6FCvwxYF7QtJW8+Mfj2
         WTLdSSl2cXXI6j7Q336jsLT3giBm18yv7/Cuc=
Received: by 10.86.61.13 with SMTP id j13mr1431697fga.68.1239232434684;
        Wed, 08 Apr 2009 16:13:54 -0700 (PDT)
Received: from ?192.168.1.13? (abvo208.neoplus.adsl.tpnet.pl [83.8.212.208])
        by mx.google.com with ESMTPS id e20sm3105484fga.4.2009.04.08.16.13.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 16:13:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <49DC8002.6050503@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116130>

On Wed, 8 Apr 2009, Sam Vilain wrote:
> Jakub Narebski wrote:
>>
>> By the way, did you take a look how cached 'git config' access and
>> typecasting is done in gitweb?  See commit b201927 (gitweb: Read
>> repo config using 'git config -z -l') and following similar commits.
> 
> Right ... sure, looks fairly straightforward.  I guess gitweb could 
> potentially use this tested module instead of including that code 
> itself.  Also various parts of git-svn... anything really.

Well... first, gitweb use of config files is simplified to what, I guess,
you want, because it only considers _reading_ config, and doesn't worry
about writing and (what is I guess most difficult) rewriting config file.

Second, gitweb doesn't even use Git.pm (although "gitweb caching" project
by Lea Wiemann from GSoC 2008 introduced Git::Repo, the alternate OO
interface, and used it in caching gitweb).  This has the advantage of
being slightly easier to install... but we require git anyway, so it
is not much more diffucult requiring perl-Git / Git.pm.

> 
> I actually wrote this code because I wanted something a bit nicer for 
> writing the mirror-sync initial implementations.  And I wanted to have a 
> bit of control over when values get committed, and save work for 
> reading, so I wrote this.

Well, you could have written in C instead ;-)

>>> Any more gremlins? 
>>>     
>> I have nor examined your patch in detail; I'll try to do it soon,
>> but with git config file parsing there lies following traps.
>>
>> 1. In fully qualified variable name section name and variable name
>>    have to be compared case insensitive (or normalized, i.e.
>>    lowercased), while subsection part (if it exists) is case sensitive.
> 
> I noticed that 'git config' hides this by normalising the case of what 
> it outputs with 'git config --list'; do you think anything special is 
> required in light of this?

I'm not sure. I was thinking that get() method should normalize its
arguments before comparing... but I am not sure if it is necessary
(or even if it is a good idea).

>> 2. When coercing type to bool, you need to remember (and test) that
>>    there are values which are truish (no value, 'true', 'yes', non-zero
>>    integer usually 1), values which are falsish (empry, 'false', 'no',
>>    0); other values IIRC are truish too.
> 
> Yep, see the Git::Config::boolean mini-package which has a list of 
> those.  I think I used the documented legal values, which are 'true', 
> 'yes' and '1' for affirmative and 'false', 'no' and '0' for negative.  I 
> guess I could make that include non-zero integers as well.

They are, from what I understand, empty value, 'false', 'no' and '0' for
negative, all else is positive (which includes no value, 'true', 'yes'
and '1').  But you'd better check the C code yourself.

[...]
>> Why not represent it simply as an 'undef'? You can always distinguish 
>> between not defined and not existing by using 'exists'...
>>   
> 
> I don't like 'undef' being a data value.

Why not? It is IMHO the most natural way.

>                                           In this case I was already  
> using setting a value to undef to tell the module to remove the key from 
> the config file.

Why not use 'delete' to remove hash element, and 'exists' to check
whether it exists?


-- 
Jakub Narebski
Poland
