From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-new-workdir for filesystems without links (e.g. FAT32)?
Date: Sun, 6 Feb 2011 13:14:59 -0600
Message-ID: <20110206191459.GA17939@elie>
References: <loom.20110206T151206-851@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 20:15:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmA4p-0002HW-0k
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 20:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab1BFTPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 14:15:07 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58144 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab1BFTPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 14:15:06 -0500
Received: by ywo7 with SMTP id 7so1223221ywo.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 11:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2PPPfz0+fL/Z1cY7ivtl4+1qee4qZ3/E0djnUSvCUN8=;
        b=IAnl8rFoHYKLFEEgw/SFGhUMFFBQm2sEywISsHuMKBJNmKv5QQnisKDjveZZAG8K4+
         xyBr2CCCJ7A6dPGRe3KzgohnZARwANcfy7cDOJoDQtwEiw2tqqpdaIciNPNWChw4mQGg
         nX6B5Hr9B6Hg22Z9ygBM8P2pOygDwMXDwZcrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YdYl9wHSZuwQ+h5erMx9LpD+8vuVx7n3dHqbB38g2bnr8N8rFRV3dogf6wMwOtk4Ab
         Fyz/nv8R07BlkJXAsnAKWfpDHpNhsIMVBfvUA9KPWoeakLua6Tr7aA2dfa5t3Hy4sHee
         6lOWXzdQib9vUE4VPSRbfWaYetQD++Pn4kXZU=
Received: by 10.147.171.3 with SMTP id y3mr3454275yao.34.1297019704610;
        Sun, 06 Feb 2011 11:15:04 -0800 (PST)
Received: from elie ([76.206.235.233])
        by mx.google.com with ESMTPS id 50sm2217721yhl.29.2011.02.06.11.15.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 11:15:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20110206T151206-851@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166194>

Hi Piotr,

Piotr Krukowiecki wrote:

> git-new-workdir requires soft links to work, so obviously it will fail if file 
> system does not support them. Is there any other way for having multiple working 
> dirs with one repository?

I assume you mean a way to share refs between repositories without
using symlinks?  Then alas, that is not implemented, though there
is some interest.  See [1] for details.

It should not be impossible, I think --- something for refs analagous
to the ".git file" mechanism might make perfect sense (see
v1.5.6-rc0~93^2~3, Add platform-independent .git "symlink", 2008-02-20
and "git log --grep='git file'" to see development since then).  The
main distinction here is that the target of a refs "symlink" should
also be aware of it, to avoid garbage collecting the shared objects.

If on the other hand you just want to share objects (not refs) between
repositories, the GIT_OBJECT_DIRECTORY environment variable might
help.

Good luck,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/150559/focus=150693
