From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/3] gitweb: add patches view
Date: Thu, 18 Dec 2008 20:44:31 +0100
Message-ID: <200812182044.32154.jnareb@gmail.com>
References: <1229422290-6213-1-git-send-email-giuseppe.bilotta@gmail.com> <200812181033.57360.jnareb@gmail.com> <7viqphguqu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 20:47:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDOpW-0006Ww-Vd
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 20:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbYLRTop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 14:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbYLRTop
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 14:44:45 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:44214 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbYLRToo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 14:44:44 -0500
Received: by ewy10 with SMTP id 10so683473ewy.13
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lGGgECl3dt28BR+nAb9bY6ohUm+FH/snqNjoM+YzcM0=;
        b=vGzArQMb596wHbMKS4AUE7RC3HneKbQb+L9XFqu4kOvTl9Vn1m2455Im2Q8ccXDnLN
         l//6/PCNC+d7t3W76ZjMO80WP7yXfyCioD+6vwUtuAbNHUQ1D5EJC+IWBs2Dc5YOpttP
         n4DqjiGz0qN0ySFMD9bS0a/8Y8gZoTz71csyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IomsXGILkSS7O063U4m2hIKIjzVbO9iI6bm9U43iczpfN4GYU27iS3C0e6xiVb1Nq4
         9AvR0qXmtKHAbAbkCcbPPVHarZkRdaA7En39Ol+G5bXgIM7x+4RSNBlKsW5IpxmLNksf
         PwJQvbWjK9K6ECXC5wnaPKhJJPZtOWkb54dJ4=
Received: by 10.210.16.10 with SMTP id 10mr1963872ebp.7.1229629482007;
        Thu, 18 Dec 2008 11:44:42 -0800 (PST)
Received: from ?192.168.1.11? (abwk173.neoplus.adsl.tpnet.pl [83.8.234.173])
        by mx.google.com with ESMTPS id 7sm1017461eyg.52.2008.12.18.11.44.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Dec 2008 11:44:40 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7viqphguqu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103483>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Thu, 18 Dec 2008, Junio C Hamano wrote:
>>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>> 
>>>>  sub git_commitdiff {
>>>>  	my $format = shift || 'html';
>>>> +	my %params = @_;
>>>> ...  
>>>> +			if ($params{-single}) {
>>>> +				push @commit_spec, '-1';
>>>> +			} else {
>>>> +				if ($patch_max> 0) {
>>>> ...
>>>> +			}
>>>> @@ -5625,6 +5635,10 @@ sub git_commitdiff_plain {
>>>>  
>>>>  # format-patch-style patches
>>>>  sub git_patch {
>>>> +	git_commitdiff('patch', -single=> 1);
>>>> +}
>>> 
>>> Hmm, if you are changing the interface this way, wouldn't it make more
>>> sense to also do this?
>>> 
>>> 	git_commitdiff(--format => 'patch', --single => 1);
>>> 	git_commitdiff(--format => 'html');
>>
>> The first argument (format) is _required_, second is _optional_;
> 
> My reading of the first line of the sub seems to contradict with your
> statement.  "If the first argument is empty, we use 'html' instead" sounds
> pretty optional to me.
 
Well, for me it is more of required argument, but with default value.
But now we argue semantics... :-)

-- 
Jakub Narebski
Poland
