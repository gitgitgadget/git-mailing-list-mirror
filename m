From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: BUG: "git add --interactive" does not work with UTF-8 filenames
Date: Tue, 01 Apr 2008 13:08:07 -0700 (PDT)
Message-ID: <m3y77xtk32.fsf@localhost.localdomain>
References: <200804012232.03559.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 01 22:08:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgmmt-0002ht-C4
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 22:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbYDAUIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 16:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755754AbYDAUIM
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 16:08:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:2784 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537AbYDAUIL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 16:08:11 -0400
Received: by nf-out-0910.google.com with SMTP id g13so960385nfb.21
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=WfUFjyEgTYid1uWGy8qq/dVdmDbRP5ICiLS9NxwYtio=;
        b=jgpqXPKxdS5DnRnqcOSI8m/CV7p7R/A2IxgcfYNIRPm3YTHIQWyYreCvSyvLNN5emHhWJBKNOkZT5PEBKNQCWQaHymrT7D4Cg115VDFMioKl91QTwfHTBQBK3o3OxbxiHs1A8Nt7jWtB3ZD/emDllFXr5W/psdswmh5BmYQbaj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=XGtrqHMljfwVkLfSJz1yKnSsLTUMjEFAd/0jsEVkVsO4qVEjAYVPcNRhtboggE5YHIjzpMhxMrGdN+If/bjZrPLDT/IZP7vnRVwxWWvrahFgKuSmq5VAVj9zQdUwwdq3CdBrK+JiR6BYJRnjZYdhByuT4i9NCyzncFmHlSH+WxY=
Received: by 10.78.81.2 with SMTP id e2mr24788106hub.13.1207080488916;
        Tue, 01 Apr 2008 13:08:08 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.226.198])
        by mx.google.com with ESMTPS id t10sm647310muh.13.2008.04.01.13.08.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Apr 2008 13:08:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m31K83d2028998;
	Tue, 1 Apr 2008 22:08:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m31K7krO028991;
	Tue, 1 Apr 2008 22:07:46 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200804012232.03559.tlikonen@iki.fi>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78662>

Teemu Likonen <tlikonen@iki.fi> writes:

> As a side note/rant: Git tends to show non-Ascii characters in filenames 
> as \xxx escape sequences. It's not a big problem but surely it's not 
> very nice to read if (say) half of the word's letters are escaped like 
> this. I believe Git is mostly used for tracking source codes where 
> Ascii-only filenames are a common practice. I'm using Git to develop 
> Finnish spell-checking system (called Voikko) and we have some 
> non-Ascii filenames in the repo.

git-config(1):

  core.quotepath::
	The commands that output paths (e.g. `ls-files`,
	`diff`), when not given the `-z` option, will quote
	"unusual" characters in the pathname by enclosing the
	pathname in a double-quote pair and with backslashes the
	same way strings in C source code are quoted.  If this
	variable is set to false, the bytes higher than 0x80 are
	not quoted but output as verbatim.  Note that double
	quote, backslash and control characters are always
	quoted without `-z` regardless of the setting of this
	variable.

Since 1.5.2.2 (I think), or at least 1.5.3, so you have new enough
version of git (git is now at 1.5.5-rc2).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
