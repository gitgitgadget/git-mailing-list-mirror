From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [RFC] Mirroring svn
Date: Thu, 06 Dec 2007 04:18:51 -0800
Message-ID: <1196943531.13311.0.camel@brick>
References: <1196922153.10408.101.camel@brick>
	 <20071206064317.GC18698@coredump.intra.peff.net>
	 <1196923525.10408.103.camel@brick>
	 <Pine.LNX.4.64.0712061214340.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 06 13:19:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Fh2-0001sP-CX
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 13:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbXLFMSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 07:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbXLFMSo
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 07:18:44 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:21404 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbXLFMSn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 07:18:43 -0500
Received: by rv-out-0910.google.com with SMTP id k20so231257rvb
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 04:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=uhIYctaTuPZLyDMZbJ27/vOKuI0CsG7lB6nVnWnwDmE=;
        b=ZUE5jWx4bRPwbFYihDJYALk0xaaSOKCNodd5FpvSNSJCuaecpjqwjhVQFG4YwauOCEhnzYPgCmqefnx3yv1tCt0MazXW9Nt8v/UeZGzW7yjyFE8xM24yHO1et+t3rRPnJC93euMoYS9XJ1jYXGfSKl+N3zfnSHEVWEy3wqJhWkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=hcKPuOq2jPbt3ItlKV24s00CNmj+ZPSQ/tidAaz/cwonwBrpAQ5koZ0ffMh9shc0Z7SdZMSKKo/ChOUqBK1S5OH1DBLgsf/HQlpYYev1VfqglXj2cXZOCW3njZ07vus/Q6rNGdfsY0+P3JxJhXHkPNP9z8KzQIwMq3303FUd8xI=
Received: by 10.141.163.12 with SMTP id q12mr950935rvo.1196943522740;
        Thu, 06 Dec 2007 04:18:42 -0800 (PST)
Received: from ?192.168.1.101? ( [216.19.190.48])
        by mx.google.com with ESMTPS id l38sm86278rvb.2007.12.06.04.18.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Dec 2007 04:18:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712061214340.27959@racer.site>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67279>

On Thu, 2007-12-06 at 12:15 +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 5 Dec 2007, Harvey Harrison wrote:
> 
> > On Thu, 2007-12-06 at 01:43 -0500, Jeff King wrote:
> > > On Wed, Dec 05, 2007 at 10:22:33PM -0800, Harvey Harrison wrote:
> > > 
> > > > // fetching someone else's remote branches is not a standard thing to do
> > > > // so we'll need to edit our .git/config file
> > > > // you should have a section that looks like:
> > > > [remote "gcc.gnu.org"]
> > > > 	url = git://git.infradead.org/gcc.git
> > > > 	fetch = +refs/heads/*:refs/remotes/gcc.gnu.org/*
> > > > // infradead's mirror puts the gcc svn branches in its own namespace
> > > > // refs/remotes/gcc.gnu.org/*
> > > > // change our fetch line accordingly
> > > > [remote "gcc.gnu.org"]
> > > > 	url = git://git.infradead.org/gcc.git
> > > > 	fetch = +refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*
> > > 
> > > FWIW, if you are writing a shell recipe for other people to cut and
> > > paste, you can say this as:
> > > 
> > >   git config remote.gcc.gnu.org.fetch \
> > >     '+refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*'
> > 
> > I thought about that, but I like to encourage people to actually look at 
> > the config file, it's pretty easy to understand.
> 
> I agree that people should be encouraged to edit their .git/config.  But a 
> recipe is something easy-to-follow IMHO, so I would write this as a shell 
> script (with #-comments, not //-comments).

I'll probably turn it into such eventually, this was more of a
hand-holding exercise for people who would like to try git in gcc-land.

Harvey
