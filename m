From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL
	interfere with the test
Date: Tue, 14 Oct 2008 19:45:12 -0400
Message-ID: <20081014234512.GC14994@riemann.deskinm.fdns.net>
References: <1224022020.2699.4.camel@mattlaptop2.local> <1224022216.2699.5.camel@mattlaptop2.local> <7vzll66c5u.fsf@gitster.siamese.dyndns.org> <1224025227.2699.13.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 01:49:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kptdp-000740-P9
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 01:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYJNXsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 19:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYJNXsR
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 19:48:17 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:42767 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbYJNXsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 19:48:17 -0400
Received: by gxk9 with SMTP id 9so6088378gxk.13
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 16:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=9HIK1Ti3sBzgfiaeROQC9LgJ+FztkeBbf2C6Af35AfA=;
        b=Thq+tXCJ69W8EpGoiYYiylKZDphNJscqluPZK/XTQVnKlvzPzhCTgsxelHYegEapOo
         754sZ2MkVI0JyZsETReThScDWj/X1XstjxzM4LDqyGdwI7/2yix6ukBY2YGX9MMqIJFV
         vNllWHZS2z891TchOY7C2o6+VYz/CouW3ddRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=IyTuLahttN4Gfff8IJ3KQ3rfYiSenKW/Lg0bAPtyp4+m6wbFlPj2lPW4NiYc72VuQz
         eq79GTLc/HdI+uuAdp0w3r1EVwXeNtLuKPbm+waGpdOqnKqkMeIJTUkOTgbGGfumHNiC
         DNODpArzWEiXyp92O9V6YiNQDk5GmZJxcLPRQ=
Received: by 10.150.149.19 with SMTP id w19mr723746ybd.50.1224028095601;
        Tue, 14 Oct 2008 16:48:15 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id e27sm14924404elf.12.2008.10.14.16.48.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Oct 2008 16:48:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1224025227.2699.13.camel@mattlaptop2.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98226>

On Tue, Oct 14, 2008 at 07:00:27PM -0400, Matt McCutchen wrote:
> On Tue, 2008-10-14 at 15:32 -0700, Junio C Hamano wrote:
> > Makes me wonder why this is _not_ inside test-lib.sh where it creates the
> > test (trash) directory.  That way, you would cover future tests that wants
> > to see a saner/simpler POSIX permission behaviour, wouldn't you?
> 
> Yes.  However, I don't anticipate there being any tests specifically
> about file permissions other than t1301-shared-repo.sh, and if the user
> has set a default ACL on the git source tree, we might want to let trash
> directories obey that setting except in the one case where it breaks the
> test.  What do you think?

I'll add a shameless plug for my patch: Fix testcase failure when extended
attributes are in use, available from Gmane at

http://thread.gmane.org/gmane.comp.version-control.git/98170

It's orthogonal to this patch, I think: this patch deals with ACLs overriding
the umask testing we're doing, while my patch deals with parsing the
permissions that ls returns, and applies to instances where extended attributes
are in use which we can't get rid of, like SELinux.

Deskin Miller
