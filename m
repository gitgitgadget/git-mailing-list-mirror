From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Sun, 4 Mar 2007 01:49:44 +0100
Message-ID: <200703040149.45713.jnareb@gmail.com>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net> <200703030458.58616.jnareb@gmail.com> <alpine.LRH.0.82.0703022328460.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: James Cloos <cloos+vger-git@jhcloos.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Oleg Verych <olecom@flower.upol.cz>,
	Junio C Hamano <junkio@cox.net>,
	Li Yang-r58472 <LeoLi@freescale.com>, rea-git@codelabs.ru,
	Raimund Bauer <ray@softwarelandschaft.com>,
	Alp Toker <alp@atoker.com>
To: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 01:47:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNess-0007ra-69
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 01:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbXCDAr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 19:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbXCDAr1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 19:47:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:58067 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbXCDAr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 19:47:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so997080uga
        for <git@vger.kernel.org>; Sat, 03 Mar 2007 16:47:25 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TSoSL0RM172wy7dpAJE72HOUDj4tcGUMptrFzpLlELkmUKKL27DFRVZyQDB9oo326G1/hvTHgcdOwBiM0hYAf+SpwRWWMAT9DNdE1rtMZiwPaSn6XOUrrMr7M2jtyaB4v4MyxXrjltVlyNZN5jyiMISUQ9MjnUTNI0KhR41UA4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Qo/RZa1Pj9v/ygKlOfvf7LDgNaFQHQW+FdnzYKLoFmjHIXWFBUzVvFhpow9p304GcrLkzmusFZYXX508H++PFk0kVHwuervUXsVNrGZ9rggu0fzgB3Tvzw7RE5CDm+EGOccey/ZHJoMW0GiTeZLtPQwnJgZgXTQgVsWrWEsEHVY=
Received: by 10.66.221.6 with SMTP id t6mr6695189ugg.1172969244876;
        Sat, 03 Mar 2007 16:47:24 -0800 (PST)
Received: from host-81-190-25-43.torun.mm.pl ( [81.190.25.43])
        by mx.google.com with ESMTP id y2sm10931850mug.2007.03.03.16.47.21;
        Sat, 03 Mar 2007 16:47:22 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LRH.0.82.0703022328460.29426@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41341>

Nicolas Pitre wrote:
> On Sat, 3 Mar 2007, Jakub Narebski wrote:
> 
>> Could you check if "application/xhtml+xml" is in "Accept:"
>> HTTP Request Header sent by _your_ lynx, e.g. as seen via
>>   http://web-sniffer.net/?url=http://www.kernel.org/git
> 
> Accept: text/html, text/plain, application/pdf, application/msword,
>   audio/mod, image/*, application/postscript, text/sgml, */*;q=0.01
>   [CRLF]    
> User-Agent: Lynx/2.8.5rel.1 libwww-FM/2.14 SSL-MM/1.4.1 OpenSSL/0.9.8b 

I'm adding back everybody which participated in this thread...

There are two complications: first, sometimes http://www.kernel.org/git
works with lynx (and links2, and w3m), and sometimes do not. I have
reported lynx working with it, but when I tried to repeat this I got
not understood (by lynx) "application/xhtml+xml" instead of correct
"text/html".

Second, the code responsible for setting correct content type is:

	my $content_type;
	# require explicit support from the UA if we are to send the page as
	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
	# we have to do this because MSIE sometimes globs '*/*', pretending to
	# support xhtml+xml but choking when it gets what it asked for.
	if (defined $cgi->http('HTTP_ACCEPT') &&
	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
	    $cgi->Accept('application/xhtml+xml') != 0) {
		$content_type = 'application/xhtml+xml';
	} else {
		$content_type = 'text/html';
	}

As you can see lynx _does not_ include 'application/xhtml+xml' among
accepted content types, and gitweb requires to have it set explicitely
(i.e. having */* is not enough).


BUT I have an idea: this might be caused by the gitweb _used by
kernel.org_. http://www.kernel.org/git says that it use "git web interface
version 1.4.5-rc0.GIT" while using "git core binaries version 1.5.0.1"
which is a bit suspicious... and right so, because IIRC kernel.org uses
caching version of gitweb by John 'Warthog9'
  http://www.kernel.org/git/?p=git/warthog9/gitweb.git;a=summary
(I think it should use different identification, perhaps "caching git web
interface", or "git web interface (caching)"). I guess that it caches
too aggresively, caching also HTTP response (including content type).
 
That of course might not be true, but check if for example
http://repo.or.cz (which also does not run vanilla gitweb, by the way)
also gives the same problems to lynx or w3m.


Oleg Verych wrote:
> On Sat, Mar 03, 2007 at 05:29:22AM -0800, Junio C Hamano wrote:
>>
>> I think the real question is if gitweb output need to be XHTML.
>> If everybody's browser is happier with text/html and we do not
>> have to use things only in xhtml, sending text/html out (both as
>> content-type and the actual contents) feels like the right thing
>> to do from compatibility point of view.
>
> Right XML (XHTML) isn't a tags soup as HTML is, so it's better. But
> "application/xml+xml+xml" is very silly, unless site's content uses
> dynamics, DOM, etc. As far as i can see, gitweb is not going to have
> javascript and such yet (because of compatibility/usability).

It would be nice to AJAX-ize blame view in gitweb (if it is enabled).

> Thus, fixing of http content negotiation is needed, or whatever is
> used in Perl for this.

By the way, the change to use 'application/xhtml+xml' is by Alp Toker,
made in commit f6801d669 with the following explanation:

    "The 'text/html' media type [RFC2854] is primarily for HTML, not for
    XHTML. In general, this media type is NOT suitable for XHTML."
    
    This patch makes gitweb use content negotiation to conservatively send
    pages as Content-Type 'application/xhtml+xml' when the user agent
    explicitly claims to support it.

Please discuss it with Alp, if is available.
-- 
Jakub Narebski
Poland
