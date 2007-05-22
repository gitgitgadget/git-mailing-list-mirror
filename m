From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb - encoding problems
Date: Tue, 22 May 2007 09:50:34 +0200
Message-ID: <200705220950.35493.jnareb@gmail.com>
References: <20070521205721.GA21771@auto.tuwien.ac.at> <1179794012.2771.112.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: David Woodhouse <dwmw2@infradead.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue May 22 12:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqS3b-0003EB-1b
	for gcvg-git@gmane.org; Tue, 22 May 2007 12:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758624AbXEVK5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 06:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757659AbXEVK5R
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 06:57:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:35600 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812AbXEVK5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 06:57:15 -0400
Received: by ug-out-1314.google.com with SMTP id 44so238165uga
        for <git@vger.kernel.org>; Tue, 22 May 2007 03:57:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hCs4XDGUWMt4mtnVfD2JjTYHjTKmZ0KweEAMoVgAzxhT8FDBr7pgz/FymaEx4quVzbKRIPvpBpM2IepnGXnU/VbT9KXeWkJvx3Wv23TIs7GTSarJ0IyFST+hir1sofag15yRlTIIdPJ2JdUjNuQMmUTh4svAkxRF6jRF8byEo9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EVGrVQY+130BuhpYOnVPjFtFslbjE0YSubv3lWlGPF4SShNRznrbhNl/kF1BopMBImr50CUGOqPYlbYSJDiplib76ihDX6f69S9q8OZ8dxctDaQHkC5Gz52ptTsVP+6Hw1sMJt+QjsXpwvrErXiAHppaFyEd+9c8r7fML9lzW10=
Received: by 10.67.20.3 with SMTP id x3mr493551ugi.1179831434310;
        Tue, 22 May 2007 03:57:14 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id s7sm1373233uge.2007.05.22.03.57.11;
        Tue, 22 May 2007 03:57:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1179794012.2771.112.camel@shinybook.infradead.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48090>

On Thu, 22 May 2007, David Woodhouse wrote:
> On Mon, 2007-05-21 at 22:57 +0200, Martin Koegler wrote:

>> I use ISO-8859-1 as my locale, so my blobs, commits and tags are in
>> this encoding. 
> 
> That's a very strange thing for anyone to do in the 21st century.
> Did you configure this archaic thing correctly in .git/config?
> 
> Otherwise, gitweb will assume that you're using utf-8 like any normal
> person would, and of course you'll have problems when it tries to deal
> with your legacy character set as if it were something sensible.

Actually gitweb does not respect i18n.* configuration variables and
happily assumes that everything is in utf-8, with the exception of 
*_plain views, which are send :raw.

If you decide to implement supporting encodings other that utf-8 in 
gitweb, please remember that some (like git-show, git-log) but not all 
parts (like git-rev-list or --pretty=raw) do the decoding/encoding. And 
that git can be compiled without iconv support. And that comits might 
be in different encodings, which should be given by 'encoding' header, 
but there is no way to guess encoding for a blob, or for a file names.


git-commit(1):
 i18n.commitEncoding::
     Character encoding the commit messages are stored in; git itself
     does not care per se, but this information is necessary e.g. when
     importing commits from emails or in the gitk graphical history
     browser (and possibly at other places in the future or in other
     porcelains). See e.g. gitlink:git-mailinfo[1]. Defaults to 'utf-8'.

 i18n.logOutputEncoding::
     Character encoding the commit messages are converted to when
     running `git-log` and friends.

-- 
Jakub Narebski
Poland
