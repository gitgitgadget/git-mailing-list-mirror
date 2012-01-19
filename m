From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Unexpected "clean -Xd" behavior
Date: Thu, 19 Jan 2012 04:03:42 -0600
Message-ID: <20120119100317.GA15386@burratino>
References: <4F1384AE.1050209@pcharlan.com>
 <20120119002904.GA14107@burratino>
 <CACsJy8AE+rwmOVUZez5GRXRHJsTy+W8ekzr59NTd7_C+gB0Byw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Harlan <pgit@pcharlan.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 11:04:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnor1-0000CZ-ST
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 11:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768Ab2ASKD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 05:03:56 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59536 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab2ASKDz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 05:03:55 -0500
Received: by ggnb1 with SMTP id b1so748326ggn.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 02:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EUOYHxSgsMLMuIFCOeH6qWOyIOTPn2KQ6ZFG3SZLdx8=;
        b=ABK5Lx33yo53TryA+CCMTklh9SCUcQLpyULsURO3t6rXVFZsuGTDrg0w+Vu+SNrYXQ
         y8S2e+JK8x63v6m5KIYxYI+uPurIZCbaAUtafNVOkR3RMZ2A5V8G+5TY31MSRlj+VTeq
         IMeh87UM56wvS+rOY923rVO9RlNOaXTVlY7y4=
Received: by 10.50.157.131 with SMTP id wm3mr26712017igb.13.1326967435129;
        Thu, 19 Jan 2012 02:03:55 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id cv10sm41560353igc.0.2012.01.19.02.03.54
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Jan 2012 02:03:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8AE+rwmOVUZez5GRXRHJsTy+W8ekzr59NTd7_C+gB0Byw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188805>

Nguyen Thai Ngoc Duy wrote:

> -X is to remove ignored files _only_ (DIR_SHOW_IGNORED flag). And
> "foo" is not ignored according to .gitignore, so it cuts short there
> and never gets to "foo/a". -x works.

Makes sense.

I guess the internal logic is that "git clean -fdX" cleans up files
that "git clean -fd" would miss, and this is not such a file ("git
clean -fd" removes it).  But as Pete mentioned, in this edge case the
behavior renders "git clean -fdX" less effective than expected at its
primary task as poor man's "make clean".

I'd be happy to see a patch that moves to a different set of semantics
or an addition to t/t7300-clean.sh and BUGS section in
Documentation/git-clean.txt explaining the current limitations, if
someone wants to work on that.

Thanks, both.
Jonathan
