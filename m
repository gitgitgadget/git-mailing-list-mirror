From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: add 'ls' command
Date: Thu, 2 Dec 2010 11:37:22 -0600
Message-ID: <20101202173722.GE3962@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <1291286420-13591-2-git-send-email-david.barr@cordelta.com>
 <AANLkTi=HuPK+q_+hdkg4yK45UcoOA5PAGi4OmsojCsFa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 18:37:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POD6M-0000qQ-Do
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 18:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757895Ab0LBRhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 12:37:35 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57400 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757871Ab0LBRhd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 12:37:33 -0500
Received: by vws16 with SMTP id 16so1180084vws.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=h+Tsq/jSM2iexuYEXkxvIygSwxFId0goAA1ikH5PyUc=;
        b=Pil/Sp751mZplHv6kKjOKRLjE3iOQQBReu9qFV+134VGY7SRJG0Bgi7RO4jqgKwy2H
         HP0O7cYcCOspwrMxWKyAD7UVc7Ea9163uzF50nbQQVW+GcwC/5ny7JvskLIG4wTWoHDL
         Jfol/seJSE7EZdJxBXurGLgfMu/709vnAWPik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L+960tXQ/YPPXpM69t4rIjP1/VhIiYXbSXcYVxpx5Db1DmF3pJF8P3TgBvcWyQtWYz
         g7gUKsijzI5JRQnbeQPHUs12P/eqfAuly9NqTa7RzSsxhwrTOhOFxmdqbKuxOTQ9dqku
         d3HdWV/MHST3PgO76+wAAUqQfnsZDn3tKuXRs=
Received: by 10.220.188.135 with SMTP id da7mr100298vcb.214.1291311453055;
        Thu, 02 Dec 2010 09:37:33 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id fs21sm259588vbb.0.2010.12.02.09.37.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 09:37:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=HuPK+q_+hdkg4yK45UcoOA5PAGi4OmsojCsFa@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162714>

Sverre Rabbelier wrote:
> On Thu, Dec 2, 2010 at 11:40, David Barr <david.barr@cordelta.com> wrote:

>> There are two forms of the 'ls' command, one that takes a tree-ish and
>> one relative to the index. Allow the tree-ish variant to be used anywhere
>> a comment is allowed. Allow the index variant to be used within a commit
>> where file change commands would be used.
>
> The commit message doesn't explain why the index variant isn't allowed
> anywhere a comment is allowed. I assume that's because there's a
> half-constructed index if you're in the middle of a modify operation
> or such?

I somewhat agree.  Actually I would go further: the word "index" brings
to mind .git/index and its in-core counterpart, so at the same time as
documenting it better, we might look into making it more self-
explanatory.  Maybe a syntax like

	ls current "path/to/entry"

would make it clearer that this is about directory entries in
fast-import's active commit and not necessarily the usual index file?

I am not sure what syntax other vcs-es use for tree-ishes.  To avoid
name clashes (what if 'current' is the low-level name of a tree-ish?),
an alternative might be

	ls-tree :11 "path/to/historical/entry"
	ls "path/to/current/entry"

Hm (just musing).
Jonathan
