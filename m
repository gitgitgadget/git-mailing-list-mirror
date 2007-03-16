From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 19:38:08 +0100
Message-ID: <e5bfff550703161138x5ab1fe3anf7b2aaab81bb77e4@mail.gmail.com>
References: <20070316042406.7e750ed0@home.brethil>
	 <20070316045928.GB31606@spearce.org>
	 <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	 <20070316060033.GD31606@spearce.org>
	 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
	 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550703161120o4571769eq18c13ae29ac79957@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rocco Rutte" <pdmef@gmx.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 16 19:38:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSHJq-0008BF-Aa
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 19:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbXCPSiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 14:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753581AbXCPSiM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 14:38:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:4568 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbXCPSiK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 14:38:10 -0400
Received: by wr-out-0506.google.com with SMTP id 41so636571wry
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 11:38:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FGM0JP/icSFo76KzGFGxXewKq1rcgvIXHFkMdTV1wMkf3VuoDDAylrFea4hqHjxBayuTkvKXCiuvIusfRaVXFXBCRB2qyoB7Ul9BB3vb1TJiwB6/OeWH6n14WtYMmBB1UM8Uk0uqGY8wOckSIX7Qmb8+OkHVi/jaEFGOt3QmiQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TKcZmwjD40iiO5FMdxhAeN4/SIBhFtI8VP/heAg4QV6773XGEiV8uaQ5NJNE2KIv20kMgNO39kOVOSnMZ0jHHd5g46KvUBaVcc/N/SS5TM8bowoLU9ezBIDTzBGBEy5fUA9wLz1sp6r4+aN2KBBSivDaCS/4KR/FTA5mCiYQhyk=
Received: by 10.115.76.1 with SMTP id d1mr837896wal.1174070289011;
        Fri, 16 Mar 2007 11:38:09 -0700 (PDT)
Received: by 10.114.60.16 with HTTP; Fri, 16 Mar 2007 11:38:08 -0700 (PDT)
In-Reply-To: <e5bfff550703161120o4571769eq18c13ae29ac79957@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42391>

On 3/16/07, Marco Costalba <mcostalba@gmail.com> wrote:
>
> *The most important thing for a libgit to be used by qgit is reentrancy*
>

Another crtitical feature is that this call to git-rev-list-like
function MUST be non-blocking.

Reading a big repo could take many seconds, also more then 10 seconds
in cold cache case for Linux tree, as example. Getting the history of
a file ('git rev-list -- /path/to/file) it's also very slow.

There is no way that a GUI tool is allowed to *freeze* for that amount
of time. Currently, because an external process is forked when running
'git rev-list' all the problem is happly handled by the kernel
scheduler and the QProcess callback mechanism (based on select()). In
case of a libified git-rev-list this could be an issue.

   Marco
