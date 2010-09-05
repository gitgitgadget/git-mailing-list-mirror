From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [demo/patch 0/3] Re: [PATCH] Documentation: document the
 string-list macros.
Date: Sun, 5 Sep 2010 15:03:23 -0500
Message-ID: <20100905200323.GA14497@burratino>
References: <1283709077-5438-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 22:05:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsLSx-0003Yc-Iu
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 22:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab0IEUFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 16:05:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64880 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab0IEUFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 16:05:21 -0400
Received: by gyd8 with SMTP id 8so1417232gyd.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 13:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fRqhCBkd+Ud4xc8+adkRXivdWUQ3kk9dBGJ/D+TQz3w=;
        b=hPPIIDqgKqKp9LomF8o6GTB4mFmlV5uciB8DdJhnThxgmRG3XR1P4UxXSOERVHSu/F
         BDGeFQZXhcduWITIWi8eSpcGxEDLvRsOs4H6Onntub3WwDHJzJPjfzaEHt0AOnrdqdtf
         ooEzN+A31DooBdm/+k9X5e4VDKarJHJh7tLY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cimqlqqI/wRZV9OD3cqN11I+TYSN4LCG3I3oJhZZKN4Jn4Ru4BaQZ/HPpjDmQNdOjl
         o1+KXesBaU/4rbua7TmThhFkX0i36pkTrtXJbeEO0BJfNh6GLzCUVlzcbtyGI27ewYfQ
         LTKugm4MR5QnnHX7n1t+RRV/x4LIMpOKoYq8k=
Received: by 10.101.171.20 with SMTP id y20mr2743502ano.150.1283717121272;
        Sun, 05 Sep 2010 13:05:21 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i30sm7606479anh.9.2010.09.05.13.05.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 13:05:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283709077-5438-1-git-send-email-tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155479>

Thiago Farina wrote:

> --- a/Documentation/technical/api-string-list.txt
> +++ b/Documentation/technical/api-string-list.txt
> @@ -52,6 +52,18 @@ However, if you use the list to check if a certain string was added
>  already, you should not do that (using unsorted_string_list_has_string()),
>  because the complexity would be quadratic again (but with a worse factor).
>  
> +Macros
> +------
> +
> +`STRING_LIST_INIT_NODUP`::
> +
> +	Initialize the members and set the `strdup_strings` member to 0.
> +
> +`STRING_LIST_INIT_DUP`::
> +
> +	Initialize the members and set the `strdup_strings` member to 1.

After reading that, one might be tempted to write

	struct string_list x;
	STRING_LIST_INIT_NODUP(x);

, no?  In other words, I don't find the text very clear.

If you like working by example (like I do) then api-strbuf.txt might
give a good indication of how this sort of thing can be helpfully
documented.

Maybe something in this direction?

Patch #3 in particular is very rough and ought to be split up for
easier review.  This is not meant for application, just to give an
idea.

Jonathan Nieder (3):
  string-list: introduce string_list_init()
  string-list: document ...
  Make initialization of string_lists more consistent

 Documentation/technical/api-string-list.txt |   18 +++++++++------
 builtin/apply.c                             |    8 +++---
 builtin/blame.c                             |    4 +-
 builtin/clean.c                             |    2 +-
 builtin/commit.c                            |    4 +-
 builtin/fetch.c                             |   13 ++++-------
 builtin/fmt-merge-msg.c                     |   13 ++++++-----
 builtin/log.c                               |    9 ++-----
 builtin/mailsplit.c                         |    1 +
 builtin/notes.c                             |    4 +-
 builtin/remote.c                            |   30 +++++++++++++-------------
 builtin/shortlog.c                          |   25 ++++++++++++---------
 diff-no-index.c                             |    1 +
 mailmap.c                                   |   17 +++++++++-----
 mailmap.h                                   |    2 +-
 merge-recursive.c                           |   16 ++++++++------
 notes.c                                     |    4 +-
 pretty.c                                    |    5 ++-
 reflog-walk.c                               |    1 +
 resolve-undo.c                              |    8 +++---
 revision.c                                  |    7 ++++-
 string-list.c                               |   28 +++++++++++++++++++++---
 string-list.h                               |    4 +++
 submodule.c                                 |    4 +-
 wt-status.c                                 |    6 ++--
 25 files changed, 137 insertions(+), 97 deletions(-)

-- 
1.7.2.3
