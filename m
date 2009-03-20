From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for
 doing  custom path transformations
Date: Fri, 20 Mar 2009 23:27:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903202321150.6865@intel-tinevez-2-302>
References: <49B7DFA1.4030409@viscovery.net>  <1236852820-12980-1-git-send-email-johan@johansorensen.com>  <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de>  <9e0f31700903121206m3adbabacra655c5d340365f43@mail.gmail.com>  <7vvdqcd1zh.fsf@gitster.siamese.dyndns.org>
  <9e0f31700903140739g26be7981lb0fa411cdd8029e6@mail.gmail.com>  <7vprgkarq5.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0903190107001.10279@pacific.mpi-cbg.de> <9e0f31700903190602h569a3d18y30477c7a136d875e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-167191864-1237588064=:6865"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LknDK-0006FZ-Fa
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 23:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbZCTW1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 18:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbZCTW1t
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 18:27:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:53582 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751435AbZCTW1s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 18:27:48 -0400
Received: (qmail invoked by alias); 20 Mar 2009 22:27:45 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 20 Mar 2009 23:27:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tWy0/dKDtN9waIjqG8gO8gP2UeJh5yTx1kg6I5g
	Yn5IT90EQj+UTu
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <9e0f31700903190602h569a3d18y30477c7a136d875e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114011>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-167191864-1237588064=:6865
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 19 Mar 2009, Johan Sørensen wrote:

> 2009/3/19 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >> I actually was hoping (especially we have Dscho on Cc: list) that 
> >> somebody like you would start suggesting a "plug in" approach to load 
> >> .so files, which would lead to a easy-to-port dso support with the 
> >> help from msysgit folks we can use later in other parts of the system 
> >> (e.g. customizable filters used for diff textconv, clean/smudge, 
> >> etc.)
> >
> > I do not like that at all.  Dynamic libraries -- especially on Windows 
> > -- are a major hassle.
> >
> > However, I cannot think of anything Johan might want to do that would 
> > not be possible using a bunch of regular expressions together with 
> > substitions.
> 
> Let me reiterate my use-case then: I need to dynamically substitute one 
> path with another. Perhaps "map" paints a better picture than 
> "substitute" here. Please refer to my second mail in this thread for 
> more details.
> 
> The only way I can see regexps work, is that if they're read, on a 
> per-request basis (reloading git-daemon every time they change is just 
> silly), from somewhere outside the git-daemon. Then, you might as well 
> take the full-on approach this patch provides.
>
> > FWIW I have experimental code in my personal tree that sports 
> > strbuf_regsub(), a function to replace matches of a regular expression 
> > (possibly with groups) by a given string (which may contain \0 .. \9, 
> > being replaced with the respective group's contents).

Do not get me wrong, I can see your use case.

But I have been cautioning against other possibly regrettably things, and 
it gave me _no_ pleasure at all to be proven correct in hindsight.

I'd rather be called grumpy old Git, be ridiculed and insulted, but at the 
same time have precautions in git.git that prevent having to admit 
mournfully that some change was not so brilliant after all.

So if some rules consisting of regular expressions with appropriate 
substitutions, even if they will have to be updated from time to time, 
solve your case, I'd rather have that than allow a server to run external 
programs that are not exactly well audited against all kinds of attacks.

Ciao,
Dscho

--8323329-167191864-1237588064=:6865--
