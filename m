From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH/RFC] Add global and system-wide gitattributes
Date: Wed, 11 Aug 2010 11:20:39 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1008111059281.1471@shipon.roxen.com>
References: <1281488646-7108-1-git-send-email-gsvick@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-15952070-1281518439=:1471"
Cc: git@vger.kernel.org
To: Petr Onderka <gsvick@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 11:50:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj7wf-00005d-Pr
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 11:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785Ab0HKJt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 05:49:56 -0400
Received: from mail.roxen.com ([212.247.29.220]:40928 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932675Ab0HKJt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 05:49:56 -0400
X-Greylist: delayed 1754 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Aug 2010 05:49:55 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 0BA0F6281CE;
	Wed, 11 Aug 2010 11:20:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TMEwuMUdBZHD; Wed, 11 Aug 2010 11:20:39 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 1F91B6281B3;
	Wed, 11 Aug 2010 11:20:39 +0200 (CEST)
In-Reply-To: <1281488646-7108-1-git-send-email-gsvick@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153221>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-15952070-1281518439=:1471
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

Hi.

On Wed, 11 Aug 2010, Petr Onderka wrote:

> Allow gitattributes to be set globally and system wide in ~/.giattributes
                                                                ^^
I assume you mean "~/.gitattributes" (ie missing a 't').

> and $(prefix)/etc/gitattributes files, respectively. This way, settings
> for particular file types can be set in one place and apply for all user's
> repositories.
[...]
> Hi,
>
> I thought this feature would be useful for me, so I coded it up.
> What do you think? Is it ready to be included to the official 
> repository as is?

The feature as such seems reasonable.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 564586b..351b014 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
[...]
> When deciding what attributes are assigned to a path, git
> -consults `$GIT_DIR/info/attributes` file (which has the highest
> +consults `$GIT_DIR/info/attributes`, `~/.gitattributes`
> +and `$(prefix)/etc/gitconfig` files (in order of decreasing
> precedence), `.gitattributes` file in the same directory as the
> path in question, and its parent directories up to the toplevel of the
> work tree (the further the directory that contains `.gitattributes`

I'm not sure if the above priority order is the most desireable order, 
since the user may want to set a default attribute, and have it to be 
overridden by the .gitattributes in the repositories.

> diff --git a/configure.ac b/configure.ac
> index 5601e8b..773b835 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -285,6 +285,13 @@ GIT_PARSE_WITH_SET_MAKE_VAR(gitconfig, ETC_GITCONFIG,
> 			If VALUE is not fully qualified it will be interpretted
                                                                            ^^
Spello (not your fault): "interpreted".

> 			as a path relative to the computed prefix at runtime.)
>
> +# Allow user to set ETC_GITATTRIBUTS variable
> +GIT_PARSE_WITH_SET_MAKE_VAR(gitattributes, ETC_GITATTRIBUTES,
> +			Use VALUE instead of /etc/gitattributes as the
> +			global git attributes file.
> +			If VALUE is not fully qualified it will be interpretted
                                                                            ^^
Same.

> +			as a path relative to the computed prefix at runtime.)
> +

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-15952070-1281518439=:1471--
