From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Thu, 15 Jun 2006 14:49:12 +0200
Message-ID: <8aa486160606150549n4b55912ap@mail.gmail.com>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
	 <8aa486160606150426q19b0a661s@mail.gmail.com>
	 <f36b08ee0606150440l544455c7r5c52609b360d0f74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 14:49:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqrHh-0000Y3-1a
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 14:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWFOMtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 08:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWFOMtO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 08:49:14 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:30599 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030358AbWFOMtN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 08:49:13 -0400
Received: by wx-out-0102.google.com with SMTP id h28so265247wxd
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 05:49:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UcuhwCPUt0BvGaqDOJxsjI8Zks6CWrTCOud2Xu+7hyioTMzpPVNMkMyAOsGT6SGm9YRl55WYrKEf2if7i2jK0u9B0Hr8plbxsJGylN4X59b+YnXplNhN24OU6mvSQJYHtEjPCQ4dYZDP98Fg6+s9gRrU+usIlaym7wjSUwVpeOc=
Received: by 10.70.83.20 with SMTP id g20mr2186855wxb;
        Thu, 15 Jun 2006 05:49:13 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Thu, 15 Jun 2006 05:49:12 -0700 (PDT)
To: "Yakov Lerner" <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0606150440l544455c7r5c52609b360d0f74@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21891>

2006/6/15, Yakov Lerner <iler.ml@gmail.com>:
> On 6/15/06, Santi <sbejar@gmail.com> wrote:
> > Wed, 14 Jun 2006 22:26 +0300, Yakov Lerner <iler.ml@gmail.com>:
> > > Many times, I mistakenly used 'make prefix=... install' where prefix value
> > > was different from prefix value during build. This resulted in broken
> > > install. This patch adds auto-detection of $prefix change to the Makefile.
> > > This results in correct install whenever prefix is changed.
> >
> > I do this each time I install packages from source. I keep them with
> > "stow" and the usual sequence is:
> >
> > make prefix=/home/santi/usr
> > make install prefix=/home/santi/usr/stow/git
> > cd /home/santi/usr/stow/
> > stow -v git
> >
> > so with this auto-detection I'll compile some programs twice.
>
> I'm not familiar with stow. Does stow create some kind of symlinks from
> /home/santi/usr/stow/git to home/santi/usr ?
It makes links from .../usr/ to .../usr/stow/git/, for expample:

$ls -l ~/usr/bin/git
lrwxrwxrwx 1 santi santi 19 2006-06-01 09:42 /home/santi/usr/bin/git
-> ../stow/git/bin/git*


> If so, why can't you
> use prefix=/home/santi/usr/stow/git both in 'make' and in 'make install' ?
> Would this work ?

For the few tests I've made it does works, but it is not the
recommended method from the stow developers, and I suppose they know
better than me.

>
> BTW, is it possible to have git use argv[0] to automatically determine
> the executable_dir without compiled-in paths ?
>
> Yakov
>
