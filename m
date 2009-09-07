From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Mon, 7 Sep 2009 09:50:58 +0200
Message-ID: <20090907075058.GA10797@localhost>
References: <20090902080305.GA11549@neumann> <20090902081917.GA5447@coredump.intra.peff.net> <20090904070216.GA3996@darc.dnsalias.org> <20090905061804.GB29863@coredump.intra.peff.net> <7v8wgt98ms.fsf@alter.siamese.dyndns.org> <20090905084641.GA24865@darc.dnsalias.org> <20090907090713.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER Gbor <szeder@ira.uka.de>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 09:51:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZ0d-0002Lv-MO
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 09:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbZIGHvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 03:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbZIGHvW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 03:51:22 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44083 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbZIGHvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 03:51:21 -0400
Received: by bwz19 with SMTP id 19so1402395bwz.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=W74fYvmGKiiLNjDPeexww/qzgGJ+f9Va8CbltdpLHCI=;
        b=sMQ9Hn+zNUILN+HxPjh0osnU8Spgg0Q+ojwehNurKqtJ2jtnHywv6JdBCQBB8pAZHf
         TS95hR6Pqtkc8y4AJEc3eAK+0sUN3PL+l8w9IeaLniYaX5OGiwcehMjRi9nO2WzMuxYR
         p0LeYYvziIzYFj7jyFal7HGVEpJGEpNAvFWsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=IJBAl7ER3YnopP73b9T17vfzHTUNUl3f9JvwnUCZqbqTPGxDKymocxH/ePYkrE91q9
         2OhKWhlvWB7IVW8E16xlKOyN1Ee89p/TIP5hX0/5xh/03O0mii7EW1/5EOcWj5em7gIS
         jvI1fhzsu1h8eMaFmhk5soQ/uqw38EpaDevBo=
Received: by 10.204.162.137 with SMTP id v9mr11759146bkx.60.1252309882822;
        Mon, 07 Sep 2009 00:51:22 -0700 (PDT)
Received: from darc.lan (p549A55B4.dip.t-dialin.net [84.154.85.180])
        by mx.google.com with ESMTPS id 2sm583939bwz.117.2009.09.07.00.51.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Sep 2009 00:51:22 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MkZ06-0003Kt-83; Mon, 07 Sep 2009 09:50:58 +0200
Content-Disposition: inline
In-Reply-To: <20090907090713.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127895>

On Mon, Sep 07, 2009 at 09:07:13AM +0900, Nanako Shiraishi wrote:

> The default behavior for 'git-grep' has already been discussed in length,
> and I don't think it is likely to change. See 
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/111519/focus=111717

Actually, most responded with the request for a command or config option,
and did not refuse the idea outright. One was not even aware that this is
how "git grep" behaves. And neither was I until a few days ago.

And that is kind of dangerous with this command. You expect it to behave
analogously to other git commands, but it doesn't. And because grep simply
does not search superdirectories, you may think that there are in fact no
matches so you don't even notice that behavior!

> I think it is a good idea to fix this as an old regression in the maint
> branch. You don't have to introduce "git add -a". In fact the -a option
> was explicitly rejected when "git add -A" option was added with this
> commit. 
> 
>   3ba1f11 "git-add --all: add all files"
> 
> because "git commit -a" will never include new files and it will be inconsistent if "git add -a" did so.

I certainly don't mind fixing "git add -u". But I was not suggesting "git
add -a" instead of "git add -A". The idea was to introduce it instead of
"git add -u" (which can be deprecated later), so that the following are
exactly the same.

	"git add -a; git commit"
	"git commit -a"

That way, scripts are not silently broken.

OTOH, "git add --all" is already inconsistent with "git commit --all". And
we would still need a new command for 'global' "add -A". *sigh*

Clemens
