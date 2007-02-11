From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible BUG in 'git config'
Date: Sun, 11 Feb 2007 18:21:08 +0100
Message-ID: <e5bfff550702110921l710d62cr6c82baed1b678ab2@mail.gmail.com>
References: <e5bfff550702110613q315e1f7es4ca1a88b92e4c3e9@mail.gmail.com>
	 <Pine.LNX.4.63.0702111720260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "GIT list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 11 18:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGIO2-00069b-Q6
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 18:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbXBKRVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 12:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbXBKRVL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 12:21:11 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:57815 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbXBKRVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 12:21:09 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1380445wri
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 09:21:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jSP1gG7fYLgfD6E8F9VdP4eYS8ymRwnhgkG0LLDfuKcBOPcljuK+68R3I16cVn7ZRK3Ry54idck0DM+SfbPfXTjY5DF1M2roZ0+wuWS+A+4jRz0uR6tGcrSNkOYyeOwHJEA0/vdClcGwQjVt8+noBG5Y9NgsyQWZ/MfzVm6S67I=
Received: by 10.114.133.1 with SMTP id g1mr6559252wad.1171214468997;
        Sun, 11 Feb 2007 09:21:08 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sun, 11 Feb 2007 09:21:08 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702111720260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39297>

On 2/11/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

>
> So I am certain that you made a mistake when you need to ignore the
> settings in $HOME/.gitconfig.
>

Please do the following:

$ cd <git tree repo>
$ git repo-config --global --unset user.name
$ git repo-config --unset user.name
$ git gui

Then go to Edit->options, you will see empty both 'git repository' and
'Global (All repositories)'

Then exit 'git gui' and type:

$ git repo-config --global user.name dummy
$ git gui

Then go to Edit->options and.... surprise! dummy has been added to
both panes instead of only in 'Global' one.

The bug is not in 'git gui' but in 'git repo-config' that when queried
for user.name if doesn't find it in local config, silently falls back
in global config. This is not documented and probably a bug because
documentation of --global option says:

--global::
       Use global ~/.gitconfig file *rather than* the repository .git/config.


Thanks
Marco
