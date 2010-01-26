From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache (WIP)
Date: Tue, 26 Jan 2010 03:30:25 +0100
Message-ID: <201001260330.26365.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com> <201001251448.27513.jnareb@gmail.com> <4B5E01F5.20402@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 03:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZbCK-0007aw-Sp
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 03:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab0AZCa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 21:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653Ab0AZCa2
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 21:30:28 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:59304 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab0AZCa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 21:30:27 -0500
Received: by fxm7 with SMTP id 7so799999fxm.28
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 18:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1DcUkChvSVCqyVqj3htV0WvO1YRWhF8hwlb+4hDkEAk=;
        b=XHCykZ2Q5lVQaf4kz0EHdd0hguac9bCm7anfiCJJD6fgoEZxgCD9bE8jkLXfJ0lT51
         hpFEqxlnoWkvLoadyymN0oFJ3Gk4DPAFtVo5lAv8Q2IqTknaTxLrMIfX7UqoZnVlJ2FU
         ltT0MMElDsU81LI9eVEqGrR4iAHxczRxhLhe4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JoZZxIOnv1A5h/a8jjI/hK97AeMDWfommA2ZJQJXD3xZ5tWj/KXmU9gIvr2XTzReTz
         K0lp9Fyzc8H1UfneXEaPLYU4a24jkbxYGSJ4P+Sbh9lSI4i8yugh41GoBtJHr8U92R5y
         V+3hgzS0YjT/Mz9Ky3usmhH+77HZpvLH6XnOY=
Received: by 10.223.60.138 with SMTP id p10mr7739139fah.32.1264473025837;
        Mon, 25 Jan 2010 18:30:25 -0800 (PST)
Received: from ?192.168.1.13? (abvr10.neoplus.adsl.tpnet.pl [83.8.215.10])
        by mx.google.com with ESMTPS id 31sm7399133fkt.1.2010.01.25.18.30.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 18:30:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B5E01F5.20402@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138023>

On Mon, 25 Jan 2010, J.H. wrote:
> On 01/25/2010 05:48 AM, Jakub Narebski wrote:
>> On Mon, Jan 25, 2010, Petr Baudis wrote:
>>> On Mon, Jan 25, 2010 at 12:46:39PM +0100, Jakub Narebski wrote:
>>>> On Sun, 24 Jan 2010, Petr Baudis wrote:
>> 
>>>>>   I have stupid question, common to both the original patch and this
>>>>> RFC.
>>>>>
>>>>>> [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
>>>>>> regenerating cache (WIP)
>>>>>
>>>>>   Just why is a "Generating..." page appropriate?
>>>>>
>>>>>   I have to admit I hate it; can you please at least make it
>>>>> configurable? Why is it needed at all? It [...] confuses
>>>>> non-interactive HTTP clients [...]
>> 
>>>> Second, gitweb can always check User-Agent header, and serve 
>>>> "Generating..." page only to web browsers:
>>>>
>>>>   unless (defined $cgi->user_agent() &&
>>>>           $cgi->user_agent() =~ /\b(Mozilla|Opera)\b/i) {
>>>>   	return;
>>>>   }
>>>>
>>>> or something like that.
>>>
>>> I'm not too happy with this. What about Safari? Opera? ELinks? There's a
>>> lot of web browsers.
>> 
>> The "Mozilla" part would catch all "Mozilla compatibile" web browsers,
>> including Firefox (and other Gecko-based web browsers), Internet Explorer,
>> WebKit based browsers including Safari and Chrome and Konqueror.
>> The "Opera" part would catch Opera.
>> http://www.nczonline.net/blog/2010/01/12/history-of-the-user-agent-string/
>> 
>> As to other web browsers like Elinks, Lynx, w3m, Dillo, etc.: the issue
>> is whether they honor '<meta http-equiv="refresh" content="0" />'.  
>> I think it is better to stay on the safe side; it is not disaster if web
>> browser is not shown "Generating..." page where it could (but see 
>> explanation below).
> 
> Most of them do, that particular tag has been around for a long time and
> since it doesn't require Javascript to do the page refresh it's pretty
> much universal.

For this method to work there is additional assumption about web browser,
namely that it would follow refresh only after it gets page in full (only
when connection closes).  But perhaps that is true for all web browsers
following http-equiv refresh.

> 
> The problem is going to be with things like wget when someone wants to
> snag a binary file.  This works fine if the file is already cached, but
> the user doesn't get what they are expecting if they get a blob that
> isn't the final file, but the html contents of the page.  I don't know
> of any hint that things like wget would send to the server that you
> could switch based on, but it would be more or less the non-background
> caching state.

Well, the above solution would work as long as you don't run wget with
--user-agent.

[...]
>>> But if it will be possible to turn this off eventually, it's all your
>>> call whether to bother implementing it. :-)
>> 
>> In my implementation it is (or rather would be) as simple as just
>> not passing 'generating_info' => \&git_generating_data_html in the
>> GitwebCache::SimpleFileCache constructor.
> 
> At least in mine it was don't allow background caching.  It would force
> everyone to wait on the one process that was actually generating
> content.  But it means a few blank pages with a spinning working icon
> until the cache releases it's exclusive lock.

Theoretically at least having "Generating..." page is orthogonal to using
locking, to background serving and to serving stale data.  In current 
implementation those features are dependent, serving stale data on locking,
and "Generating..." also on locking.

I think that serving stale data should depend on background caching, as
otherwise we introduce inequality in treating process which regenerates
cache (and must wait without background caching) and rest of processes
(which are served stale data).

Certainly in final version of patch all this should be made configurable.

 
P.S. With background caching there is a question whether parent should
generate and child display stale or "Generating...", or whether parent
should display stale/activity and child (re)generate cache entry.  Also
there is an issue whether parent should waitpid for child, would fiddling
with SIGCHLD handler be enough, or is it not needed.

-- 
Jakub Narebski
Poland
