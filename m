From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Configuring (future) committags support in gitweb, especially bug linking
Date: Wed, 18 Feb 2009 04:38:53 +0100
Message-ID: <200902180438.55081.jnareb@gmail.com>
References: <200811082007.55045.jnareb@gmail.com> <200811082335.49505.jnareb@gmail.com> <499AD871.8000808@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Francis Galiegue <fg@one2team.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 04:40:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZdIW-0005S7-Gy
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 04:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbZBRDjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 22:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbZBRDjF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 22:39:05 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:25039 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbZBRDjC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 22:39:02 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1590260fkf.5
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 19:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kJP2fCHbgA5E7wbtVcIh1EWa+bc8SDL7CxpPBPd/14U=;
        b=UHaifygg2cFnNudiGq81EWR80cJpdHGRVHhknlTd1XN5qZ2EdoQHoJICE6kRHe7xCV
         VPT56fGSTIsccuWFMKzmzFdX+Hbsy2ooCxHMh/Zf7M/BNMtwlpe+GHltkOMU5jAVy0YE
         EkAaJCEZ5qbXPk5Gi8CI22D9789Y2uBnb/xPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ddZEjEzpJ5/zlRG91Y75m5a8zneycMkPnAWTk3xC4lzw0f3pWm4KJrUlxKX99WUZcr
         J54w7fG1aFUCByvKMBiPDCiFvb19xvc5K1Q7J3BAKYgq2Y6iivPTX7FoLrp/JL4pHhme
         /Fc+A1MUGwZuLm7QWAj4biqzPvcv2flKiJ168=
Received: by 10.103.226.10 with SMTP id d10mr1053088mur.105.1234928340171;
        Tue, 17 Feb 2009 19:39:00 -0800 (PST)
Received: from ?192.168.1.13? (abvn202.neoplus.adsl.tpnet.pl [83.8.211.202])
        by mx.google.com with ESMTPS id 12sm1084865muq.35.2009.02.17.19.38.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 19:38:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <499AD871.8000808@oak.homeunix.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110502>

On Tue, 17 Feb 2009, Marcel M. Cary wrote:

> I'm interested in cross-linking bug references in commit messages to a
> bug tracking system.  I started tinkering a couple weeks ago and am
> finally understanding that committags encompass this functionality.
> (From the subject line I first understood "tags" to mean git tags rather
> than commit message munging.)

What would you name this feature, then?

> 
> Is the committags idea still under active development?

Well, it is in my todo list, rather further on...

[...]
> Two regexes would make it easier to configure a driver without needing
> look-ahead and look-behind assertions.  For example, if you want to
> match non-negative integers but only in the context of a Resolves-bug
> header:
> 
>     Resolves-bug: 1234, 1235

[...]
> I got the two-regex idea from a spec I ran across while evaluating
> Subversion:
> 
> http://guest:@tortoisesvn.tigris.org/svn/tortoisesvn/trunk/doc/issuetrackers.txt

You don't need multiple regexps for that, and in above example it is
used _single_ regexp; only with more than one catching group.

> I like the idea of allowing a regex writer -- a gitweb admin or a
> repository owner -- to ignore issues regarding HTML escaping.  For
> example, I'd rather not have &nbsp; in the regex.  And I don't want the
> replacement to have to escape "&" in a query string.  That's a strength
> of not having to write the whole link replacement rule.  And I think
> hyperlinking will be one of the most common uses of this committag
> feature, so it's worth special support.

[...]
> I'm concerned about the composition of these committag drivers.  In
> other words, will it be hard for the configurer to manage interactions
> between committag drivers?  To choose a sane order, will I have to
> understand the implementation details of each committag driver?

In current proposal the order of running committags drivers is
specified in configuration...

> 
> Perhaps a simpler alternative would be to let at most one driver process
> a given snippet of text, forbidding nesting of replacements.  (If I
> understand Junio's suggestion to use a list of strings and refs,
> non-nesting overlaps are already not supported.)  If all replacements
> were hyperlinks -- and I expect that to be the common case -- they
> wouldn't be nestable anyway.  I wouldn't see it as a huge loss for the
> nesting examples I can think of:  Separate rules for span around S-o-b
> and linking or obfuscation of email could be combined into one...  A
> rule to shade text quoted email-style with leading angle brackets could
> just clobber any further processing of that text.  And it might simplify
> the code and testing of it quite a bit.

... but I guess that at first attempt we could support non-overlapping
committags only, i.e. replacement is always as whole not passed to
later committags.

Still there is a problem how to specify which parts of replacement for
committags have to be HTML escaped, and which are HTML and should not
be (and which are attributes, and have to be escaped too).

[...]
> A few ideas for drivers that I don't think have been mentioned yet:
> 
> * Wiki page names, like to [[Feature Documentation]].  These are notable
> because they tend to contain punctuation that get HTML-escaped, like
> quotes and ampersands.

Well, I think if it would be supported, it would be a very special
case, so I don't think generic support for this is needed nor required.

> 
> * Links to gitweb itself, such as 123abc:file.txt and HEAD:file.txt.  I
> guess the current hash linking sort of does the first case except that
> you have to get the hash of the blob instead of using the commit hash,
> and the current hash linking wouldn't reveal the filename until after
> you click, nor when viewing textual log messages.  I'm not sure whether
> special support for linking to multi-commit diffs or other object types
> would be as helpful.

Also 'v1.5.4' etc linking to tag; both would be a good idea. At this
point I think we have already list of all references (for ref markers)
so it wouldn't require additional call to git command.


P.S. I understand that this post is an exception (send after long, long
time), but please do not toppost in replies. It goes against natural
reading order.

-- 
Jakub Narebski
Poland
