From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache (WIP)
Date: Mon, 25 Jan 2010 14:48:26 +0100
Message-ID: <201001251448.27513.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com> <201001251246.40237.jnareb@gmail.com> <20100125130230.GE9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 25 14:48:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZPJ4-0005pD-Cc
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 14:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab0AYNsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 08:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242Ab0AYNsi
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 08:48:38 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:47823 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab0AYNsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 08:48:37 -0500
Received: by fxm7 with SMTP id 7so4065fxm.28
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 05:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=EZ43Gx+tTNCpqqaqg4YztPr/ZXalA/UCuxCszSBX0ks=;
        b=JHperj1NIiPpWadUBR5ENRBTBsIOar7u1TrOvCI2J0QSgM6QYoJMSJ6vEkzKDQkfse
         pR/mKsTqtkdketJ2wxjx6LU3s6ZeIxL4w6Jqk1unzV3NUtKX2Wv9wmePRhjmDPau17rA
         t0jvb7ivl9vu1wtQv6Odz+IqPPPfCu4Tplsbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=T9SwWUs5sCJD/cCd0Yf4t+UnlDZGY8Hv+b59+cLwA5XEdPpIQ1wE+3r9MZilyB8Yrg
         zOVsTZKHqyHR2fVKctMh1kxYEtE92/gIw8kjv4Wt3X1J9zTuiNCU4n10lgKTvMqILJsX
         dkcDCx0ANZOeTt0PSMKfPQbj+jtCdTnEwjpxc=
Received: by 10.223.5.135 with SMTP id 7mr382106fav.81.1264427315767;
        Mon, 25 Jan 2010 05:48:35 -0800 (PST)
Received: from ?192.168.1.13? (abvr10.neoplus.adsl.tpnet.pl [83.8.215.10])
        by mx.google.com with ESMTPS id 12sm6655573fks.9.2010.01.25.05.48.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 05:48:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100125130230.GE9553@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137963>

On Mon, Jan 25, 2010, Petr Baudis wrote:
> On Mon, Jan 25, 2010 at 12:46:39PM +0100, Jakub Narebski wrote:
>> On Sun, 24 Jan 2010, Petr Baudis wrote:

>>>   I have stupid question, common to both the original patch and this
>>> RFC.
>>> 
>>>> [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
>>>> regenerating cache (WIP)
>>> 
>>>   Just why is a "Generating..." page appropriate?
>>> 
>>>   I have to admit I hate it; can you please at least make it
>>> configurable? Why is it needed at all? It [...] confuses
>>> non-interactive HTTP clients [...]

>> Second, gitweb can always check User-Agent header, and serve 
>> "Generating..." page only to web browsers:
>> 
>>   unless (defined $cgi->user_agent() &&
>>           $cgi->user_agent() =~ /\b(Mozilla|Opera)\b/i) {
>>   	return;
>>   }
>> 
>> or something like that.
> 
> I'm not too happy with this. What about Safari? Opera? ELinks? There's a
> lot of web browsers.

The "Mozilla" part would catch all "Mozilla compatibile" web browsers,
including Firefox (and other Gecko-based web browsers), Internet Explorer,
WebKit based browsers including Safari and Chrome and Konqueror.
The "Opera" part would catch Opera.
http://www.nczonline.net/blog/2010/01/12/history-of-the-user-agent-string/

As to other web browsers like Elinks, Lynx, w3m, Dillo, etc.: the issue
is whether they honor '<meta http-equiv="refresh" content="0" />'.  
I think it is better to stay on the safe side; it is not disaster if web
browser is not shown "Generating..." page where it could (but see 
explanation below).
 
> Most of the issues can be worked around, but I'm not sure why to go
> through all the trouble. I just personally don't see the value in having
> the placeholder in there at all, to me it is distracting UI even if all
> the technicalities are put aside.

The issue that "Generating..." page tries to solve is, I think, the 
following.  

Some actions, like 'blame' view or pickaxe search, or grep search,
can take quite a long time to generate, with times counted in
tens of seconds.  It is not that visible for non-caching, because
gitweb streams output so we have at least _some_ output upfront quite
fast.

Now those patches (mine and J.H. both) make gitweb use locking
(it is IIRC configurable in J.H. patch) to make only one process
generate the page if it is missing from cache, or is stale.  Now
if it is missing, we have to wait until it is generated in full
before being able to show it to client.  While it is possible to
"tee" output (using PerlIO::tee, or Capture::Tiny, or tie like
CGI::Cache) writing it simultaneously to browser and to cache for 
the process that is generating data, it is as far as I understand
it impossible for processes which are waiting for data.  Therefore
the need for "Generating..." page, so the user does not think that
web server hung or something, and is not generating output.
 
We can try to reduce occurrences of cache miss stampedes by using
'expires_variance' feature[1] from CHI - Unified caching interface.
We can also turn off locking and tee output to have some output upfront
as an activity indicator instead of this "Generating..." page.

[1]: http://search.cpan.org/~jswartz/CHI-0.33/lib/CHI.pm#set

> But if it will be possible to turn this off eventually, it's all your
> call whether to bother implementing it. :-)

In my implementation it is (or rather would be) as simple as just
not passing 'generating_info' => \&git_generating_data_html in the
GitwebCache::SimpleFileCache constructor.

-- 
Jakub Narebski
Poland
