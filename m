From: Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v3] Documentation fixes in git-config
Date: Thu, 1 Mar 2012 11:54:48 +0100
Message-ID: <20120301105448.GH31079@fm.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz>
 <20110111055922.GD10094@sigill.intra.peff.net>
 <20110119100105.GB8034@fm.suse.cz>
 <20110119141401.GE8034@fm.suse.cz>
 <20110121002716.GC9442@sigill.intra.peff.net>
 <20110121102048.GF19715@fm.suse.cz>
 <20110121102537.GH19715@fm.suse.cz>
 <20120301081941.GA31079@fm.suse.cz>
 <20120301090828.GA16033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 11:55:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S33fl-0002oq-Lh
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 11:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758001Ab2CAKzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 05:55:06 -0500
Received: from cantor2.suse.de ([195.135.220.15]:32971 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754679Ab2CAKyt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 05:54:49 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8ED258FC93;
	Thu,  1 Mar 2012 11:54:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120301090828.GA16033@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191913>

On Thu 01-03-12 04:08:28, Jeff King wrote:
> On Thu, Mar 01, 2012 at 09:19:42AM +0100, Libor Pechacek wrote:
[...]
> Generally it looks OK to me, but I have two comments:
> 
> >  Syntax
> >  ~~~~~~
> > @@ -54,9 +55,10 @@ All the other lines (and the remainder of the line after the section
> >  header) are recognized as setting variables, in the form
> >  'name = value'.  If there is no equal sign on the line, the entire line
> >  is taken as 'name' and the variable is recognized as boolean "true".
> > -The variable names are case-insensitive and only alphanumeric
> > -characters and `-` are allowed.  There can be more than one value
> > -for a given variable; we say then that variable is multivalued.
> > +The variable names are case-insensitive, allow only alphanumeric characters
> > +and `-`, and must start with an alphabetic character.  There can be more
> > +than one value for a given variable; we say then that variable is
> > +multivalued.
> 
> Not an error you introduced, but should it be "...we say then that _the_
> variable is multivalued".

Yes, even my language sense tells me the article is missing.  Fixed.

> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > index aa8303b..a54fee8 100644
> > --- a/Documentation/git-config.txt
> > +++ b/Documentation/git-config.txt
> > @@ -85,8 +85,13 @@ OPTIONS
> >  	is not exactly one.
> >  
> >  --get-regexp::
> > -	Like --get-all, but interprets the name as a regular expression.
> > -	Also outputs the key names.
> > +	Like --get-all, but interprets the name as a regular expression and
> > +	writes out the key names.  Regular expression matching is currently
> > +	case-sensitive and done against a canonicalized version of the key
> > +	in which section and variable names are lowercased, but subsection
> > +	names are not.  Regular expressions are partially lower-cased
> > +	before matching (everything before the first dot and after the last
> > +	dot), which makes things like "Core.*' work.
> 
> I know I ack'ed this last time around, but reading it fresh, I think we
> are probably better off to just not mention the down-casing at all. It's
> just confusing, and people shouldn't depend on it. They should know that
> they are comparing against the canonical name, and should use lowercase
> in their regex. I.e., just cut out the last sentence from there.

I agree, it's just a technical detail, which can be left out in sake of
readability.

Thanks for review, the final patch will follow.

Libor
