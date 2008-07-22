From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did not change
Date: Tue, 22 Jul 2008 18:22:34 -0400
Message-ID: <32541b130807221522r2a43c49cl6400f00dbe7451a0@mail.gmail.com>
References: <alpine.DEB.1.00.0807222235520.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 00:23:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLQGf-0006nw-F3
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 00:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbYGVWWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 18:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbYGVWWh
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 18:22:37 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:21034 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbYGVWWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 18:22:36 -0400
Received: by yw-out-2324.google.com with SMTP id 9so902376ywe.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=x3cy1FpN7+bwUY/CaLYg88zvYVmwNl1V5dsOK4aT9S4=;
        b=bJKXA8pa/ErtS93d+hLxGJAKddVj4N6wAvyM8hucx/dUDryk3ssEgrR9s5FP41cpTT
         ihkl2rzlLwWRYX4eCehA+gGRsCPNMyxfVomkXXBqkXmCYEC9sYyv4CP63sqHC82IJhZE
         Uv+MjdaGwuaW49QTDe16qKIHCX0oYX9S9LS5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tlTv4UHJ8iOSJdxG/h9jM4y0I9coUwpPjGZmbKOeTaCj0m7y3sec7mubys9N7twHSo
         mvj+6xp0bYrqrfARvZ7FXIQlqiNUm7Yk4hcgK3AOrJtOmIVlA8Uv9t+zznwKMscianxs
         9Iylic6TwpsCfT1C0dEkQhyBgKugl3q+loCiQ=
Received: by 10.150.202.8 with SMTP id z8mr6131874ybf.223.1216765354316;
        Tue, 22 Jul 2008 15:22:34 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Tue, 22 Jul 2008 15:22:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807222235520.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89552>

On 7/22/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  If the user called "rebase -i", marked a commit as "edit", "rebase
>  --continue" would automatically amend the commit when there were
>  staged changes.
>
>  However, this is actively wrong when the current commit is not the
>  one marked with "edit".  So guard against this.

This patch is perhaps a symptom of something I've been meaning to ask
about for a while.

Why doesn't "edit" just stage the commit and not auto-commit it at
all?  That way an amend would *never* be necessary, and rebase
--continue would always do a commit -a (if there was anything left to
commit).  The special case fixed by this patch would thus not be
needed.

It would also make it more obvious how to remove files from a commit,
for example, without having to learn about "git reset".  For that
matter, you wouldn't have to learn about "git commit --amend" either,
and it would save typing.

It would also be a little more consistent with "squash", which already
lets you edit the commit message by default.

Just a thought.  Presumably it was implemented the way it is for some
reason, but I haven't seen any discussion about it.

Have fun,

Avery
