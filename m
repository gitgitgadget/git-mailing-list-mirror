From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] Add '--fixed-strings' option to "git log --grep" and friends
Date: Wed, 27 Feb 2008 02:37:16 +0100
Message-ID: <200802270237.18044.jnareb@gmail.com>
References: <1204028528-18941-1-git-send-email-jnareb@gmail.com> <1204028528-18941-2-git-send-email-jnareb@gmail.com> <7vfxvf2osk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 02:38:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUBFD-0001HY-FP
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 02:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759312AbYB0Bh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 20:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758520AbYB0Bh1
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 20:37:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:15623 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214AbYB0Bh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 20:37:26 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1305805nfb.21
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 17:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=D7GLubW7Ie2SMKOp6dm5UwW55PtWlG61WBz0Uy/8PaI=;
        b=B0Ws4+kWrwXk+EuYG4ypbHBUuwAkkZGmu6EPBNtZ2KFyfpUYrvvVrvayxoEXxeQwMGPgC+RWm6z9Rcwo8lV0sllKAUulHQcEHq6djgbiDZSHWTANXpHp+3clUHCDMlIF7fxi6gbIg3+vxQ88QRw0SB/M108/pExYWRuZbMUvby8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HUI42ytjZxjKV07yDobh7EBR5ZKFU17KgeQKOJNlELBimUECFmObQuPPFu0ekMVxiNuiPprS8Ij1a7Z76UNNy+TmJVfVjG5RmrpXDZEtp+ipXOMtwF0RoQkKj/GVbuIkn0QoktQQoyybqvvXaYPbHU6qMNkRmIlxHxDasoiwd44=
Received: by 10.78.168.1 with SMTP id q1mr4562333hue.2.1204076244657;
        Tue, 26 Feb 2008 17:37:24 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.204.229])
        by mx.google.com with ESMTPS id g17sm12550261nfd.10.2008.02.26.17.37.22
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Feb 2008 17:37:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfxvf2osk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75199>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Add support for -F | --fixed-strings option to "git log --grep"
> > and friends: "git log --author", "git log --committer=<pattern>".
> > Code is based on implementation of this option in "git grep".
> >
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > This would simplify ignore-case searching for a fixed string from
> > within gitweb, as gitweb wouldn't then have to deal with differences
> > in quoting and unquoting (if you quote character which doesn't need
> > quoting, would git (grep) unquote it?) between searched phrase,
> > basic/extended regular expression as understood by git/by grep,
> > and regular expressions in Perl (when showing matched info).
> >
> > [I am not sure if the above paragraph should be added to commit
> > message, so it is in patch comments. Feel free to add it.] 
> 
> I do not understand the issue from reading that paragraph, so it
> probably means that (1) it does not help even if it is in the
> commit log message, and/or (2) more readable explanation may
> help in the commit log message ;-).

What I meant here that gitweb using --fixed-strings option for
commit message search is example usage of this new feature. 

Otherwise we would have to have in gitweb original $searchtext
(for links, description, page title, etc.), $search_grep_regexp
(for grep, or rather for "git log --grep" and friends, basic/extended 
regexp meta quoted), and finally $search_regexp to be used in gitweb, 
i.e. in Perl to show match.

> The rule for grep input should be known by anybody who writes
> scripts around grep, so I do not think this patch is absolutely
> necessary if this is only for gitweb.

I have written it this way not only because it is simpler than correct 
escaping, but also because git-grep has this option (consistency).
Besides it was very easy to add.

> But for command line 
> end-user usage, fixed string search _might be_ useful, although
> I've personally never felt need for that.  So I am reluctant to
> see it grab a short-and-sweet -F option letter that might have
> better uses, but I do not have major objection against a more
> explicit --fixed-strings.

Feel free to drop support for '-F' short option then, both in code
and in documentation.

I have checked that git-log doesn't support '-F' short option; 
additionally '-F' is used in git commands as '--file', i.e. "-F <file>" 
to get contents (commit message, tag comment/message). Therefore it was 
unlikely that "git log" and friends would acquire "-F <file>" option.

> By the way, do you allow the default regexp search in gitweb?
> If so, how do you handle a malformed regexp that a user gives
> you?  For example,
> 
> 	$ git log --grep="don\('t" -1
> 
> barfs, and I suspect that you can catch the exit status 128 from
> die() and say something other than "nothing found" if you really
> wanted to.

Errr... to be sure I don't know. From what I have checked it shows
"nothing found", but I guess it could be more explicit.

-- 
Jakub Narebski
Poland
