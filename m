From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v6] Re: mailinfo: allow e-mail files as input
Date: Sat, 18 Jul 2009 00:04:24 +0200
Message-ID: <20090717220424.GA12968@vidovic>
References: <7v8wip9jjw.fsf@alter.siamese.dyndns.org> <f006bbb9c754c80c133798ff70db5b5291dae060.1247766192.git.nicolas.s.dev@gmx.fr> <20090717190601.6117@nanako3.lavabit.com> <7vtz1b3x26.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 00:04:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRvXj-0003BD-I8
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 00:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757926AbZGQWEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 18:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757913AbZGQWEb
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 18:04:31 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:42655 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757912AbZGQWEa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 18:04:30 -0400
Received: by ewy26 with SMTP id 26so1187737ewy.37
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 15:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=5yiBYMvKJwd35nm5txnNu3nG8EjW495FCm0xYhbRa4o=;
        b=Nq17Kv2sjZHI4enhE2fkZlm8XQcZ9KPdCS1GfzntYRsMdpDeKPYVY9aDdurynr2VqV
         QMJzrbqvpO/+mQTK4RM+02QPg0ZbB14uhf7MP+kIo8epqer29gMP/Y+859PuNz5yL/hx
         t2G/jiNpgSQOjNhsgVDNaRvw5CD0aiWDq4KBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k2O0jSQRuuP9iWkl2AgzyHtwGyPzrotg9MUj7QR2BvUo9H7LJPKIJso3jufkjvAjUA
         4THMWhSpKyX+eBr0pPHoP63fuSZsTSf1II8D+demA+mVCwGPvT9737zG8EEmTuFg/5sf
         S1MaMlcwyb36rc7sv2NzZknKQD1qPo1ofikE8=
Received: by 10.210.139.9 with SMTP id m9mr317875ebd.79.1247868268333;
        Fri, 17 Jul 2009 15:04:28 -0700 (PDT)
Received: from @ (91-164-145-221.rev.libertysurf.net [91.164.145.221])
        by mx.google.com with ESMTPS id 10sm4167389eyz.31.2009.07.17.15.04.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 17 Jul 2009 15:04:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtz1b3x26.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123494>

The 17/07/09, Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
> 
> > Why does this description have ... in it? If I'm reading it correctly, the code in check_patch_format function checks only the first file.

( Please, wrap your lines to something convenient. )

> Good eyes.
> 
> This actually is an issue with the Guiseppe's multi-format support patch
> in that we assume that the command line input are of uniform type, check
> only $1 and assume $2 and subsequent are suitable to be fed to the same
> splitter.
> 
> I do not think it is necessary to allow mixed input.  We certainly could,
> but why bother?  It is not a sensible nor common thing to do.

I agree.

> Also the documentation said we take only one mbox or multiple Maildirs,
> but in reality we can take multiple mboxes just fine, so <mbox> should
> have had "..." at the end (we could lose the ellipses from all of them for
> brevity).  Oh, and it should list the other formats Giuseppe added.
> 
>     <mbox>|<maildir>|<email>::
> 
> 	    One or more of the same type of mail source to read e-mails
>             from.  A directory is taken as a mailbox in the maildir
>             format.  A file is taken as UNIX mbox, StGit patch series
>             file, or a single piece of e-mail in RFC2822 format.

Strictly speacking, this is not what I understand from the code: only
one StGit patch series can be given at the command line.

     <mbox>|<maildir>|<stgit>|<email>::
 
 	    One or more of the same type of mail source to read e-mails
             from.  A directory is taken as a mailbox in the maildir
             format.  A file is taken as UNIX mbox, StGit patch file,
             or a single piece of e-mail in RFC2822 format.  StGit
             patches series are also supported but only one series at
             a time. 


-- 
Nicolas Sebrecht
