From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Thu, 10 Sep 2009 22:32:09 +0200
Message-ID: <20090910203209.GA27391@localhost>
References: <20090902081917.GA5447@coredump.intra.peff.net> <20090904070216.GA3996@darc.dnsalias.org> <20090905061804.GB29863@coredump.intra.peff.net> <7v8wgt98ms.fsf@alter.siamese.dyndns.org> <20090905072017.GA5152@coredump.intra.peff.net> <7v3a717rgl.fsf@alter.siamese.dyndns.org> <20090905080249.GA8801@coredump.intra.peff.net> <7vy6ot4x61.fsf@alter.siamese.dyndns.org> <20090910084653.6117@nanako3.lavabit.com> <7vmy527f0b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, Jeff King <peff@peff.net>,
	SZEDER Gbor <szeder@ira.uka.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlqJj-00049C-5w
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 22:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbZIJUcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 16:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbZIJUcV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 16:32:21 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50834 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZIJUcV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 16:32:21 -0400
Received: by bwz19 with SMTP id 19so382483bwz.37
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=RN9E/D0QD22DuFEBfxWIpD/ypy1O5HhRz3zRiOawhLE=;
        b=Y6w+TYbxZDrL6jEsX/9NySdFx4g/IUWFVO8Yyi+16jdzwdJsVNYHzYGusENCTtglNX
         oo/PjfzFuchHEA3hdutkYwIW4hmCPNcNcrxdm9ggr+71FlD02PqN+JeANPyKbJsvTHg8
         orEy9pAaBwuKqE31H5hCxeZQ0yO6wp44qEUO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=mfx+8fEPQ/7/K+q9DAj5NjpDUUXuq/nghq0tlR08hrjk9O3yvBKusJXqOhZZmO75sH
         zOXUHrGwl6tqL/ManExXbYDYJWeVnQOqIPT2wg8Ja4I6Mc7+WBtq8SbM4FeHKkxk5BwL
         BxKMo3VhC+YYYkMnjtoUfxiLn98m2JOGJiKbY=
Received: by 10.204.34.205 with SMTP id m13mr1318826bkd.80.1252614742963;
        Thu, 10 Sep 2009 13:32:22 -0700 (PDT)
Received: from darc.lan (p549A414D.dip.t-dialin.net [84.154.65.77])
        by mx.google.com with ESMTPS id 6sm503102bwz.26.2009.09.10.13.32.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 13:32:20 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MlqJO-0007QI-1j; Thu, 10 Sep 2009 22:32:10 +0200
Content-Disposition: inline
In-Reply-To: <7vmy527f0b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128147>

On Thu, Sep 10, 2009 at 12:53:40PM -0700, Junio C Hamano wrote:

> If this were going to happen as a list concensus, I am very tempted to
> suggest that we at least _consider_ applying the same rule even to
> ls-files and ls-tree.  That would impact scripts, so we need to be extra
> careful, though.

I originally thought those commands should be consistent with plain "ls",
simply because of their name. However, ls-files is already inconsistent
because "ls-files <subdir>" lists files relative to the current directory,
as opposed to "ls <subdir>", which does so relative to <subdir>. And ls-tree
is even more different from "ls".

So I don't think users are tempted to associate those commands with the
behavior they are used from "ls". From that perspective it would therefore
be ok to traverse the entire tree by default. To me that seems perfectly
natural, especially for ls-tree.

In case of ls-files, I don't know. Its current behavior certainly did not
bother me so far. But the same arguments as for "add -u" apply if you think
of doing something like "git ls-files -u | cut -f2 | xargs git add", for
example.

I can't really speak for the impact on scripts. But that is certainly an
issue, more so than with "add -u" or "grep", which are more typically used
interactively.

> If we try to give a sensible default to make it easier for the user,
> perhaps we should also default to HEAD when the user did not specify which
> tree-ish to archive from.  This is a topic in a separate thread.

I don't see why not.

> *3* Command line pathspec of course should honor cwd as before.

No argument there.

Clemens
