From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb giving me some warnings in Apache's error_log
Date: Mon, 10 Aug 2009 16:57:11 +0200
Message-ID: <200908101657.13301.jnareb@gmail.com>
References: <533D6DDF-4DAC-4A86-A6F7-95B54B77E48B@gmail.com> <m3my6bpv6v.fsf@localhost.localdomain> <88f4c4ee0908071056g5d9da83ft77d56ec2e5e84bac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Rada <markrada26@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 16:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWJW-0001tA-Vf
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 16:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbZHJO5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 10:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbZHJO5S
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 10:57:18 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:61317 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZHJO5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 10:57:18 -0400
Received: by bwz19 with SMTP id 19so2621319bwz.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lTPFp8VdOokZ6DkTDQiru4QtlMIbCI5mKARlWfY7/so=;
        b=aPFGGHF5cex2wPe1jAPerNbXm3wdB9ThdHch+4lvudBnbQtwheLSLA67xt3k5bKLa7
         cHG2B0usCCQiCSC0H5SbxLHIfitiQbZ71lvPjLm6IGKg0/FpOl6emy1SpHkv/N+onwQP
         wuHOgTdxs71igTMfJ4glUMtHBsAzqK+69hzns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ON8ex5gnhBx8ce0CKUzulRJoG0T78MKd/FtUAaGwlf37VOHGaa/vJlMErIS0t9+/Gd
         PbjsGxExXLxJhcEiTFncmU52iDFRdT2R6IdWxmy3mc1Mtim9xxUQ3Hl12F5uLDoUvwgB
         2NKtWkMC5sqnQQ2SFnUS8JqnC45XVKLnNnN1o=
Received: by 10.103.12.19 with SMTP id p19mr1944141mui.110.1249916237849;
        Mon, 10 Aug 2009 07:57:17 -0700 (PDT)
Received: from ?192.168.1.13? (abwq118.neoplus.adsl.tpnet.pl [83.8.240.118])
        by mx.google.com with ESMTPS id j10sm20353480muh.59.2009.08.10.07.57.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 07:57:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <88f4c4ee0908071056g5d9da83ft77d56ec2e5e84bac@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125453>

On Fri, 7 Aug 2009, Mark Rada wrote:
> On Fri, Aug 7, 2009 at 10:14 AM, Jakub Narebski<jnareb@gmail.com> wrote:
>> Mark A Rada <markrada26@gmail.com> writes:
>>
>>> It doesn't seem to cause any other problems, but I don't know if it is
>>> significant or not.
>>>
>>> [Fri Aug  7 08:51:13 2009] gitweb.cgi: Variable "$project_maxdepth"
>>> may be unavailable at /var/www/private/gitweb/cgi-bin/gitweb.cgi line
>>> 2296.
>>> [Fri Aug  7 08:51:13 2009] gitweb.cgi: Variable "$projectroot" may be
>>> unavailable at /var/www/private/gitweb/cgi-bin/gitweb.cgi line 2304.
>>>
>>>
>>> Apache 2.2.12/ mod_perl 2.04/ perl 5.8.8
>>
>> From perldiag(1) manpage:
>>
>>  Variable "%s" may be unavailable
>>
>>    (W closure) An inner (nested) anonymous subroutine is inside a
>>    named subroutine, and outside that is another subroutine; and the
>>    anonymous (innermost) subroutine is referencing a lexical variable
>>    defined in the outermost subroutine.
[...]

>> The warning is about 'wanted' anonymous subroutine passed to
>> File::Find::find.  The "middle" subroutine is git_get_projects_list,
>> and the "outermost" is mod_perl / ModPerl::Registry request loop.
>>
>> We can't make git_get_projects_list anonymous, but anonymous
>> subroutine is not called or referenced outside git_get_projects_list,
>> nor it is called or referenced outside mod_perl request/event loop.
>>
>> This warning is harmless... but I do not know how to silence it.

> Let me double check my understanding.
> 
> The warnings will not occur if Gitweb is run as a regular CGI script
> because then it won't be nested inside a call from ModPerl::Registry?

Yes, it is true that this happens only when running gitweb as mod_perl
legacy script using ModPerl::Registry.  Otherwise it would be caught
when running t/t9500-gitweb-standalone-no-errors.sh test.

> 
> Will it also not complain if I provided my own $projects_list in the
> first place?

Yes, it would not, because the code is run only when $projects_list is
a directory to search for git repositories.  If $projects_list is
a file you wouldn't get this warning (and it might be slightly faster,
if less flexible, as you would need to regenerate this file when adding
or removing, or renaming, or changing owner of repositories).

-- 
Jakub Narebski
Poland
