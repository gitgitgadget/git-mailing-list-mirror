From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Fri, 1 Aug 2008 02:23:20 +0400
Message-ID: <37fcd2780807311523l2d5a3708xeb09403c0a063898@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
	 <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
	 <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com>
	 <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, git@vger.kernel.org
To: cte <cestreich@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 00:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOgZJ-0005gs-RF
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 00:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759607AbYGaWXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 18:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759666AbYGaWXV
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 18:23:21 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:58604 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759112AbYGaWXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 18:23:20 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1014435wfd.4
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 15:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WKjb5MEuO7fM7OwVMsMwf8tEnCuJ0WjEXThbxFCYbUs=;
        b=A87HzmLO8JBH9nheXaBjSs8TaoDJt7V7Z2iVUu0WCDKtgqPlfykpDiXcz+6QWfLm+N
         IbEbn3GS4LdXNb9qDXic3riYg5ry65Ro/O10dSUq33Z//NvXGCXrsNBnkjFDBOOZd8gd
         r5HZ9nlrCBQaofWYtO87JSFmbZOkS1Vs/Ln7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iqu9eJTzIQAF8EUsoMhodotqWT/DqOYCzo9QYSUbyveEyb7sngg05yfZUCVwFlq3NI
         aJAW0giGhhwOlscES9KRUXQ6Gjx0Lwd2aiChrC7P6UaBhiTmvFfU1twDwSMfqGZbEI4t
         7c1qqw7nd1qPyPUoAUaSC6JQfKG4n7oeY/E8o=
Received: by 10.142.12.14 with SMTP id 14mr3447195wfl.308.1217543000139;
        Thu, 31 Jul 2008 15:23:20 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Thu, 31 Jul 2008 15:23:20 -0700 (PDT)
In-Reply-To: <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91007>

On Fri, Aug 1, 2008 at 1:44 AM, cte <cestreich@gmail.com> wrote:
>
> Using output from the command line utilities as an API has its own set
> of problems. For instance, check out some of the difficulties that
> gitk and qgit have had to deal with:
> http://kerneltrap.org/mailarchive/git/2007/11/2/379067.

There is no problem with parsing. If you want to receive the output
in the specific order, Git has to read everything first, and that
is *slow*. So, --topo-order is convenient but slow, and it is slow
not because it is piping data, but because it takes some time to
read the whole history.

> Digging into
> the git internals and reusing its core functions will always be more
> powerful and flexible than parsing command line output.

"Flexible" is not a synonym of the word "useful". For instance, using
core functions will not help you to overcome the aforementioned problem.
Drawing a graph is NOT what git core functions about. You have to do
that in your GUI, and to do that when revisions are given to you in
arbitrary order is not easy. Yet, it is something what good GUI should
be capable to handle, because otherwise the response time will be bad.


Dmitry
