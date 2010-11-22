From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] contrib/svn-fe: Fast script to remap svn history
Date: Mon, 22 Nov 2010 11:42:42 -0600
Message-ID: <20101122174242.GD2084@burratino>
References: <20101121051734.GA11856@burratino>
 <15144262.32618.1290434477881.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 18:43:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKaQ7-00050V-GY
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 18:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab0KVRmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 12:42:52 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43928 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab0KVRmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 12:42:49 -0500
Received: by pva4 with SMTP id 4so24758pva.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 09:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZUT5jWK4y8Qi+yVXqs1thlM7T7NLD/9+OmjaGldYQMk=;
        b=jHxqJ3GxJbUT8xm2hvtN600lAOpTsujHsJKIhqsWZ3/sNfIGnsRE5SlYaN4v5qaLeS
         PCYT8XmJPVGvjfD0Uvaubic8+QIGwapfE/6Pj72gMuBVG7ycJimWGUzjye4Xcf5z39Og
         C3vmXDchzWAE3Y4WQpsdN1GBF1JL9v4V9oy98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jiMF05UMXcXfd+iybcb4e18KddyJUhnXxDkNvFIwXN5fvqon7q87kcN72hFL/3Aoep
         E9tqDaL0nblcSEBGK/aBar+u8VBfmw3qAV9mz37swPEycz7TbGrWBrmBXvIFYipVrLa9
         WrX10MSDbt1putjnbC0p2USMip4kR35IqDcgo=
Received: by 10.229.74.147 with SMTP id u19mr5225971qcj.214.1290447768464;
        Mon, 22 Nov 2010 09:42:48 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id s34sm3000314qcp.8.2010.11.22.09.42.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 09:42:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <15144262.32618.1290434477881.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161906>

Stephen Bash wrote:

> This has been discussed (and IMO it is essentially required to achieve high accuracy in the mapping):
> 
> http://thread.gmane.org/gmane.comp.version-control.git/158940/focus=159331

I think the suggestion of that thread was (tweaked a little)
something like this:

 - List of directories with copyfrom information.
   Prune them so no listed directory is an ancestor of another.
   The result would usually be a single directory name.

 - Record that directory's (or those directories') copyfrom
   information in the log message.

In general, I don't like limiting the information accessible to branch
mappers this way.  Maybe a branch mapper would like to look at the
copyfrom information for files instead of directories.  But this does
have the advantages of being simple and of not littering imported
trees with spurious files.

It also leaves open the question of how we would record unhandled node
properties (like svn:ignore and svn:eol) and empty directories, if at
all.

Probably in the end we will have to give up and provide multiple
options to choose between. :)

Jonathan
