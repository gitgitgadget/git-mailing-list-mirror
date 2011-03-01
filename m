From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitk: cannot handle tags with a % in them
Date: Mon, 28 Feb 2011 19:38:41 -0600
Message-ID: <20110301013841.GC5597@elie>
References: <20110227224024.3751.96676.reportbug@pcfelipe.sateler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Felipe Sateler <fsateler@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 02:39:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuEYG-0007ox-Ah
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 02:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab1CABiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 20:38:46 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47253 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab1CABip (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 20:38:45 -0500
Received: by vxi39 with SMTP id 39so3763448vxi.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 17:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XOPnwJ5GXsshIRxEsG0NrKnYTlQ0R+dgZLD1KIxrvU0=;
        b=rrxhxy/Bluy7FFM6rCZn2pQardB8GsbC4zj6VwdGmJWJTigda8yfoLDGHIDKp+jVU6
         NhGrYb1Km8H1HC0yCa4osM9+dLJPAalmzyzRJtPORqaPXnvIy9ajENsTO8tGr/PXsCbz
         ftX/5s6NtqX/9Olhwpfcc91PEKZI8/Kag9rAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pcChw+Z0Hp25SpcYOK/mjST+fzjZtWkJpHE2FJgD53i6vtv24d2xGVCmqutOIYzNOl
         7W5MFpoMn2YR6fePS52OM0rsuLTYNCk58xghTKZO7COwTPmnl0Zmvn1JrwluIThtmpJw
         PTQA/v3mG++rs0bpyY1/LiBA5f8NyZxSzIOwo=
Received: by 10.52.176.72 with SMTP id cg8mr4632154vdc.182.1298943524982;
        Mon, 28 Feb 2011 17:38:44 -0800 (PST)
Received: from elie ([76.206.235.173])
        by mx.google.com with ESMTPS id m10sm1967175vcs.32.2011.02.28.17.38.43
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 17:38:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110227224024.3751.96676.reportbug@pcfelipe.sateler>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168177>

Hi,

Felipe Sateler wrote[1]:

> Gitk chokes on tags containing a % character.

Reproduced as follows:

	git tag a%b
	gitk

and then clicking on the "| a%b >" symbol.

Result:

	can't read "tagids(foo1ar)": no such element in array
	can't read "tagids(foo1ar)": no such element in array
	    while executing
	"set text "[mc "Tag"]: $tag\n[mc "Id"]:  $tagids($tag)""
	    (procedure "showtag" line 19)
	    invoked from within
	"showtag foo1ar 1"
	    (command bound to event)

It seems that a tag containing a percent sign works okay in
an expression like $tagids($tag), but not in a quoted expression
like "$tagids($tag)".

Hints?

Thanks for gitk, of course. :)
Jonathan

[1] http://bugs.debian.org/615645
