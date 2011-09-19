From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFCv4 1/4] Documentation: Preparation for gitweb manpages
Date: Mon, 19 Sep 2011 18:37:03 -0500
Message-ID: <20110919233703.GF6343@elie>
References: <1316352884-26193-1-git-send-email-jnareb@gmail.com>
 <1316352884-26193-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 01:37:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5nOm-0005s3-F7
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 01:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878Ab1ISXhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 19:37:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64817 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab1ISXhI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 19:37:08 -0400
Received: by iaqq3 with SMTP id q3so5842438iaq.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HQNIGC/fYvvNz9emaivcPkOhgTFg02Ty1yRp4IP4fss=;
        b=L/aOI0JB1SQSFz0T31/s3yEvZs2FtKfvJ/YSrc0JH3C5G8DhkGxzsiR+g1PxcQN5l7
         dEePVwM9V8GL6iW28pUHRfaxt1XNc5MSNZPJQVmWyBym4t8Opb1H89mLFdKq3P6X7Ake
         cfWxslPkDNLX0dHKXhcGVctdfHO+BEeUCHGkY=
Received: by 10.231.83.194 with SMTP id g2mr167155ibl.57.1316475427571;
        Mon, 19 Sep 2011 16:37:07 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id by18sm15968762ibb.1.2011.09.19.16.37.05
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 16:37:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316352884-26193-2-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181719>

Jakub Narebski wrote:

> Gitweb documentation currently consist of gitweb/README, gitweb/INSTALL
> and comments in gitweb source code.  This is harder to find, use and
> browse that manpages ("man gitweb" or "git help gitweb") and HTML
> documentation ("git help --web gitweb").

Language nits: s/consist/consists/; s/that manpages/than manpages/.  I
completely agree.

> The goal is to move documentation out of gitweb/README to gitweb.txt and
> gitweb.conf.txt manpages, reducing its size 10x from around 500 to
> around 50 lines (two pages), and move information not related drectly to
> building and installing gitweb out of gitweb/INSTALL there.

I guess you mean this patch prepares for or is part of a larger
project or series with that goal?  Wording nits: s/and move
information/and to move information/; s/drectly/directly/; s/ there//.
 
> The idea is to have gitweb manpage sources reside in AsciiDoc format
> in Documentation/ directory, like for gitk and git-gui.  Alternate
> solution would be to have gitweb documentation in gitweb/ directory,
> perhaps in POD format (see perlpod(1)).

Language nits: missing "the" before "Documentation/ directory" and
"gitweb manpage sources"; missing "An" before "Alternate solution".
I guess this is the most controversial aspect of the patch; your idea
seems sane enough to me.

> This patch adds infrastructure for easy generating gitweb-related
> manpages.  It adds currently empty 'gitweb-doc' target to
> Documentation/Makefile, and 'doc' proxy target to gitweb's Makefile.

Language nits: s/easy/easily/; missing "a" before "currently empty
'gitweb-doc' target" and "'doc' proxy target".

> This way to build gitweb documentation one can use
>
>   make -C gitweb doc
>
> or
>
>   cd gitweb; make doc

Language nit: a comma after "This way" would disambiguate.

Does "make -CDocumentation man html" build the gitweb documentation,
too (and "make install-doc" install it)?

[...]
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -170,6 +170,9 @@ info: git.info gitman.info
>  
>  pdf: user-manual.pdf
>  
> +GITWEB_DOC = $(filter gitweb.%,$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7))
> +gitweb-doc: $(GITWEB_DOC)

Looks like no, alas.

Except for that detail, this looks good.

Thanks,
Jonathan
