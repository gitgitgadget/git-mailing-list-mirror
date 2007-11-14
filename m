From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Git and Scmbug integration
Date: Wed, 14 Nov 2007 11:02:04 +1100
Message-ID: <ee77f5c20711131602m5b9042fx72689af53e24ddd2@mail.gmail.com>
References: <1194980792.4106.6.camel@localhost>
	 <ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
	 <1194998142.4106.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: "Kristis Makris" <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:03:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5j7-0001mz-4R
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760933AbXKNACL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760984AbXKNACJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:02:09 -0500
Received: from el-out-1112.google.com ([209.85.162.183]:9668 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760933AbXKNACH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:02:07 -0500
Received: by el-out-1112.google.com with SMTP id j27so569514elf
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 16:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kc5+6qATD9ZoprZn6FlZ+G10M2xOE6efUnx7xXjQ+jg=;
        b=YM6zNW4nQ2JeAumGw2QsXSUHZbTFvYUovADExaCXtSWRkesnDG31zgkZXtFU2nz4lf6M6X5LAhXBzHMLPaM4E82Vt0D8ACVEpDUy7QmbfR9AuBjZb8VGnX1ZVMVDEwZCIyN/Ne5U4g6tmL+TYj3wmkGzndYgFhUlMa7kdO8Tl0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r+JYg6VPW8Px6H06gsoSe+lMvq8U8AWJWVXVabYqcgmH2qodL7oVHJH1EIjtxY1La3PO0ItHsucIacq1+diBeVhVZ+TbH9P7tOiUc2Aw6ofPAp8mB3Y9wd/Th2/+rDvNqaBwmA9il0mAtysGezAvZvAv3G0XxLVU+RI+sxTCwQg=
Received: by 10.142.131.18 with SMTP id e18mr58722wfd.1194998524846;
        Tue, 13 Nov 2007 16:02:04 -0800 (PST)
Received: by 10.142.142.12 with HTTP; Tue, 13 Nov 2007 16:02:04 -0800 (PST)
In-Reply-To: <1194998142.4106.24.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64920>

On Nov 14, 2007 10:55 AM, Kristis Makris <kristis.makris@asu.edu> wrote:
> On Wed, 2007-11-14 at 10:00 +1100, David Symonds wrote:
> > > http://bugzilla.mkgnu.net/show_bug.cgi?id=991
> > >
> > > There's no hook that will trigger when a tag is applied.
> >
> > I believe the 'update' hook is run when the tag is pushed.
>
> Even if that is true, there no hook that will trigger when a local tag
> is applied.

Unannotated tags don't make a proper new object, only a ref. If you
stick to annotated tags, you'll get new objects added which, I think,
should trigger the post-commit hook.

> I'd like the commit hook to provide enough information to be able to
> tell which files were modified and their respective old/new version (or
> perhaps their old/new SHA-1 hash). If the new SHA-1 hash can be used to
> extract all that, that's ok with me. But right now there's nothing.

If you have the new commit's SHA-1, it's very simple to get the parent
commit's SHA-1 and do whatever you want. A complexity would be with
handling merges, where a commit has multiple parents. If you have a
commit SHA-1 hash, you can just "git diff --name-only <hash>^ <hash>"
to get a list of the files changed by <hash>.


Dave.
