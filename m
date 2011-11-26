From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb ignores git-daemon-export-ok and displays all repositories
Date: Sat, 26 Nov 2011 15:37:51 +0100
Message-ID: <201111261537.52613.jnareb@gmail.com>
References: <20111113001730.3945.75979.reportbug@gpl.code.de> <D765D350-947E-4DB2-8A91-4B9653064F80@code.de> <20111116224706.GA17851@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Erik Wenzel <erik@code.de>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Matthias Lederhofer <matled@gmx.net>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 26 15:41:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUJRW-0002my-EM
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 15:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab1KZOiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 09:38:00 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53530 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1KZOh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 09:37:59 -0500
Received: by bke11 with SMTP id 11so5747516bke.19
        for <git@vger.kernel.org>; Sat, 26 Nov 2011 06:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=g2h+RXT7tjzrOr4EBgxbvvp0nWtRBn5QNTiVhJAQyic=;
        b=qg2PT5ltyPOHsXkWgnql+tAMAL8uS30DOHJH+Lh5I61THcBJc/wHLCtvKsx12uvsah
         J1k1imU/zhX0DNrhV/nf2OXFMH3pk9+2ve4gDr6Sw81pdtol4AKpXBWaZVMFGumYlOiE
         MyNVhYq+7bkwJ3JMBW2HnUs5p3j8zP12Or3/A=
Received: by 10.204.12.68 with SMTP id w4mr37643990bkw.31.1322318278173;
        Sat, 26 Nov 2011 06:37:58 -0800 (PST)
Received: from [192.168.1.13] (abwd237.neoplus.adsl.tpnet.pl. [83.8.227.237])
        by mx.google.com with ESMTPS id z1sm2328478fab.22.2011.11.26.06.37.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Nov 2011 06:37:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20111116224706.GA17851@elie.hsd1.il.comcast.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185953>

I'm sorry for the delay in responding.

On Wed, 16 Nov 2011, Jonathan Nieder wrote:
> Erik Wenzel wrote (http://bugs.debian.org/648561):
>> Am 13.11.2011 um 02.19 schrieb Jonathan Nieder:
>> 
>>> The git-daemon(1) manpage describes git daemon, not gitweb, so I guess
>>> you mean that
>>>
>>>	# Do not list projects without git-daemon-export-ok in the
>>>	# projects list.
>>>	our $export_ok = "git-daemon-export-ok";
>>>
>>>	# Do not allow access to projects not listed in the projects
>>>	# list.
>>>	our $strict_export = 1;
>>>
>>> should be the default.
>> [...]
>> Because I think this is the way a user is expecting the behavior of gitweb.
>> As I do. Don't let gitweb overwrite the meaning of "git-daemon-export-ok".
>> Just act like git-daemon. Keep it simple and stupid.
> 
> My first thought was that if we could turn back time, it would
> probably be best for both git-daemon and gitweb to look for a file
> named git-export-ok.  In the present world, maybe git-daemon-export-ok
> is a good substitute for that.
> 
> What do you think?  Should the default in the makefile be changed?  If
> so, how could we go about it to avoid disturbing existing
> installations?  (For example, in a system where no repositories have
> the export-ok files and "git daemon" is configured to run with
> --export-all, the effect would be to make repos suddenly disappear
> from the projects list in gitweb.  Unpleasant.)

I think the best solution would be to leave it up to the tool that
manages both git-daemon and git (manages access to git repositories),
like e.g. gitolite.  It would be this tool that is to be responsible
for synchronizing git-daemon and gitweb behavior, i.e. make either
both use 'git-daemon-export-ok', or both export all.

-- 
Jakub Narebski
Poland
