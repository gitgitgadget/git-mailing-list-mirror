From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] don't append 'opaquelocktoken:' in PUT and MOVE
Date: Sun, 8 Feb 2009 01:52:27 +0800
Message-ID: <be6fef0d0902070952l5818e4b7x3048c667661ce31@mail.gmail.com>
References: <498DA4F9.20104@gmail.com>
	 <alpine.DEB.1.00.0902071801570.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 07 18:54:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVrNL-0007Yb-H7
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 18:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbZBGRw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 12:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbZBGRw2
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 12:52:28 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:7075 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbZBGRw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 12:52:27 -0500
Received: by wa-out-1112.google.com with SMTP id v33so620284wah.21
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4rfWxsYGDQwQxC+yNV9FtBJI/zIcBLGb0ue5Pt8iEkg=;
        b=F/c+pkYyrSa9lo8uZ2ZpNLdOmV9upSVUdrOOR/Tcso4XE1Ag4IhXj3CY4OCw4n8vqV
         3+UfGZvETru7sD9Lw9aGh3AF9qNjGZm7dvU1q9xHMxsZyaMIXyUUSmCVK1wlctDkZuQI
         0C01ug+MKK701QMnqeKf9ezVxopDcCwK/O/rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tpT+n4YuKtnGjy8HBD7L1Ozk9FkEGSxey2n6R6Srgfnkt4HeANt4vIUG5LDxBqxeK5
         3+C/QtEvD4Daajbgyn6cCZzfqnGXPf9D3qXPZZFjL2bq3AVL4fHKMnuAXs8BNoyXhsOo
         1bdYPjqbCpaxzNxTn6J0kE5koeqAXG3CuODCw=
Received: by 10.114.26.18 with SMTP id 18mr2172936waz.159.1234029147208; Sat, 
	07 Feb 2009 09:52:27 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902071801570.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108869>

Hi,

On Sun, Feb 8, 2009 at 1:03 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Umm.  This "16" is a little bit too hardcoded for my liking.  I mean, it
> is not even obvious from _this_ hunk why "16" should be correct.

Any solutions for this? Would a comment like "skip 'opaquelocktoken:'
prefix of length 16" be sufficient? Or maybe in the commit message?

I considered a set of strbuf functions, like for the remote object url
(get_remote_object_url and append_remote_object_url), but I thought it
was a little overkill, since this is one of the only instances that I
can think of where including 'opaquelocktoken:' is unwanted.

> Besides, I have to wonder where request->lock->token is set, and if that
> would not be the better place to fix the issue?

Are you suggesting perhaps that we revert commit 753bc91? Or perhaps
create another way to access lock tokens, say, get_lock_token(int
prepend_scheme)?

-- 
Cheers,
Ray Chuan
