From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git sideband hook output
Date: Tue, 8 Jun 2010 14:46:32 -0700
Message-ID: <20100608214632.GN14847@spearce.org>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 23:47:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM6dW-0001qR-Ek
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 23:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189Ab0FHVql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 17:46:41 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:65474 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932171Ab0FHVqi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 17:46:38 -0400
Received: by ewy23 with SMTP id 23so213231ewy.1
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 14:46:36 -0700 (PDT)
Received: by 10.213.31.203 with SMTP id z11mr781627ebc.88.1276033596789;
        Tue, 08 Jun 2010 14:46:36 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 14sm3677503ewy.2.2010.06.08.14.46.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 14:46:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148723>

Scott Chacon <schacon@gmail.com> wrote:
> Prior to 6d525d where Shawn made the receive-pack process send hook
> output over side band #2, how did the hook output get sent to the
> client?

It was sent over stderr, which was proxied down to the client by
the SSH daemon.

> On older clients (before this commit) and on older servers,
> the hook output just shows up without the 'remote:' prefix.

Because its echoed to the tty by the SSH client, without Git ever
seeing it.

> After
> this commit I get the 'remote:' prefix,

Now its being parsed out of the stream by the git client, using
the same code that displays the progress messages during clone/fetch.

> which is kind of annoying.

Depends on your perspective.  Its nice to know that the messages
came from the server, rather than from your client.  :-)

> Is
> there a way to suppress this to get the old output format?

No.  Other than to have the hook not output anything at all.

-- 
Shawn.
