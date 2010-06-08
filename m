From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
Date: Wed, 9 Jun 2010 01:38:50 +0200
Message-ID: <201006090138.52125.jnareb@gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com> <20100608141321.GP20775@machine.or.cz> <AANLkTiksOpUqxGc7Lo4clrLwOF6GvkT7CZH5CVeirtBr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 01:39:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM8Nu-00040Z-M7
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 01:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab0FHXjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 19:39:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34647 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab0FHXi7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 19:38:59 -0400
Received: by fxm8 with SMTP id 8so3287092fxm.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 16:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GX1DesZz04uxR+TFQtcRmOBcSI6iO2ZoE1gL5q9FWdI=;
        b=YNPF+lOYjF9kwKEZlKnmNZyiYxYDc2g2I7AZPsyETNL/M5verU9fym+k2EPONA93E4
         zF9ngjPd6iHfnzrnYRVco8SQh/+NUQnDym99Y3vjaFVog7kukEUbFZ2uSFZAQYhIC95U
         xz+RSahPzXqq7VYAYz3HZV+hXry2p2cPqXjIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XqqOJKhTaD+I7RRiNtxyPF9FwMH5kmoaohY5BRd4x5+K/1WlVVXZXMtjuj3VJppv9H
         i/ZOkdzWlAn3oLpSskQVMyvFn3Y3cGVU2sgur6qREoULZ4Fecb5i9PUHn1Y99m3vq9Lb
         GQcWBMvgsneS7LOxACg58vdkLRDTYyScIzOt8=
Received: by 10.223.68.131 with SMTP id v3mr284233fai.82.1276040337451;
        Tue, 08 Jun 2010 16:38:57 -0700 (PDT)
Received: from [192.168.1.15] (abvo94.neoplus.adsl.tpnet.pl [83.8.212.94])
        by mx.google.com with ESMTPS id 7sm595799far.18.2010.06.08.16.38.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 16:38:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTiksOpUqxGc7Lo4clrLwOF6GvkT7CZH5CVeirtBr@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148735>

On Tue, 8 Jun 2010, Petr Baudis wrote:
> On Tue, Jun 08, 2010 at 02:46:20PM +0200, Jakub Narebski wrote:
> >
> > Third, and I think most important, is that the whole splitting gitweb into
> > modules series seems to alck direction, some underlying architecture
> > design.  For example Gitweb::HTML, Gitweb::HTML::Link, Gitweb::HTML::String
> > seems to me too detailed, too fine-grained modules.
> 
>   I agree!
> 
> > It was not visible at first, because Gitweb::Config, Gitweb::Request and to
> > a bit lesser extent Gitweb::Git fell out naturally.  But should there be
> > for example Gitweb::Escape module, or should its functionality be a part of
> > Gitweb::Util?  Those issues needs to be addressed.  Perhaps they were
> > discussed with this GSoC project mentors (via IRC, private email, IM), but
> > we don't know what is the intended architecture design of gitweb.
> 
>   I would expect Gitweb::Escape functionality to live in Gitweb::HTML
> (HTML escaping) and/or Gitweb::Request (URL escaping).

I agree... well, partially, depending if we allow Gitweb::Request to be
only about request i.e. inbound links, or also with generating outbound
links.  Thos two are tied together, e.g. with %cgi_param_mapping.

>From what Pavan says, it seems that the problem with splitting gitweb is
interdependency of various commands, and overdepenency on global variables.
That was caused by the fact that gitweb was (well, is currently) big large
monolithic script, and there were no mechanism protecting against adding
(inter)dependencies.

Perhaps instead of fine-splitting gitweb into tiny modules to avoid
circular dependencies (module A needs module B because of variable a,
module B needs module A because of variable b) we should fix overdependence
on global variables by passing more as parameters - at least where it makes
sense.

> > Should we try for Model-Viewer-Controller pattern without backing MVC
> > (micro)framework?  (One of design decisions for gitweb was have it working
> > out of the box if Perl and git are installed, without requiring to install
> > extra modules; but now we can install extra Perl modules e.g. from CPAN
> > under lib/...).  How should we organize gitweb code into packages
> > (modules)?
> 
>   I thought we already discussed MVC and sort of agreed that it's an
> overkill at this point. At least that is still my opinion on it; I'm not
> opposed to MVC per se, but to me, this modularization is a good
> intermediate step even if we go the MVC way later, and doing MVC properly
> would mean much huger large-scale refactoring than just naming a module
> Gitweb::View instead of Gitweb::HTML. Let's do it not at all, or
> properly sometime later. I think it's well out-of-scope for GSoC.

Well, let's not forget that the whole reason behind including splitting
gitweb into project that is about adding write capabilities to gitweb,
making a web interface equivalent to git-gui.  Splitting gitweb was meant
to make it easier to add new functionality without having gitweb become too
large, and maintenance nightmare.

So it would be enough to have Gitweb with core of gitweb, gitweb.perl
top-level script, Gitweb::Write or something like that for new write
functionality and Gitweb::Util containing things that are needed by Gitweb
and by Gitweb::Write(r).

> 
> > Perhaps having gitweb.perl, Gitweb::Git, Gitweb::Config, Gitweb::Request,
> > Gitweb::Util and Gitweb would be enough?
> 
>   I'm not sure what would fall into Gitweb::Util. I think Gitweb::HTML
> makes a lot of sense to have, but I don't see the advantage of finer
> graining than that - I dislike the Gitweb::HTML::* submodules as well.

Gitweb does its work in the following way: first it parses path_info,
query parameters etc. and saves them in global variables.  This is in
Gitweb::Request.  But to parse-out project name from pathinfo it needs
$projectsroot from Gitweb::Config.  Then it runs appropriate git commands
using subroutines from Gitweb::Cmd / Gitweb::Git, setting $git_dir first.
Then it parses output of git commands (probably Gitweb::Git too).
Finally it composes a response, usually HTML, but also feed (OPML, RSS,
Atom), plain text, and other output (blob_plain, snapshot); probably
Gitweb::Response, or Gitweb::Output, or Gitweb::View.

There are of course some problems.

To properly extract project from path_info in Gitweb::Request one needs
$projectroot from Gitweb::Config.  Also generated gitweb links,
i.e. href() and esc_param() etc., are tied with parsing request URL, at
least via %cgi_param_mapping.

Gitweb::Config isn't that simple either.  There is git configuration, e.g
$GIT, there is gitweb configuration, e.g. $projectroot, and there is
per-project configuration or configuration override.

Gitweb::Git / Gitweb::Cmd / Gitweb::Git::Cmd needs $GIT, but also
$git_dir, which is set using $projectroot and $project from
Gitweb::Request.  Should it include parsing output of git commands, and
auxiliary commands dealing directly with files in git repository?

Then there is dispatch and generating response.  It uses many utility
functions, like chop_str, or die_error.  Then there aresubroutines
responsible for actions / views.


Fnally there is a question which parts of those the futture write support
would need...

-- 
Jakub Narebski
Poland
