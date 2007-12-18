From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Tue, 18 Dec 2007 10:14:38 +0100
Message-ID: <200712181014.38986.jnareb@gmail.com>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu> <200712180920.39633.jnareb@gmail.com> <20071218093819.0b1caf16@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Andy Dougherty <doughera@lafayette.edu>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:15:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4YXj-0004Ad-VM
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbXLRJOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 04:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbXLRJOw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:14:52 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:6108 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbXLRJOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 04:14:50 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1948168fkz.5
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 01:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=NwommJ+mCr7gn3LSPIFuK5NewnRUdHeGRG63mYjW75U=;
        b=wah3HwRVLWdMi1pUj/PubC/w3WNZrl9d6vw7pLj+IqtSEnSlcJpZTBjtMGqLmIxyYk3fnZX2asw714nOv7LcY02tFDC5w8zd+YcUtaX3c4tFXBWu324B3RmhgpneDYyUAi6QtjhsgOCg9Egjpg1PoREc7AoSR48+kg620BY4l/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JdmBozW8GvTIcs2c5bljAaCCeJEgBJNBsj+Fv4ezaygKpK/GpxS3WWr2D7GEjVClQDVVEGT6v6BjVaG9e5yRTUk6UrEqzxSaJUCoVEflNcdGRhvSNPtg5KXkIiVeriMasOM9s/9YyFH90KzQpkeE0M4UmSnxU1mf4y4s19mpeq4=
Received: by 10.82.152.16 with SMTP id z16mr17872546bud.17.1197969285473;
        Tue, 18 Dec 2007 01:14:45 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.201])
        by mx.google.com with ESMTPS id y34sm17049873iky.2007.12.18.01.14.42
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 01:14:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071218093819.0b1caf16@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68713>

On Tue, 18 Dec 2007, H.Merijn Brand wrote:
> On Tue, 18 Dec 2007 09:20:38 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Tue, 18 Dec 2007, H.Merijn Brand wrote:
>>> On Mon, 17 Dec 2007 17:21:08 -0800 (PST), Jakub Narebski wrote:
>>>>
>>>> Second, the default autoconf macro AC_PROG_INSTALL *requires* that
>>>> there is BSD-compatible `install' program (as 'install-sh' or
>>>> 'install.sh') in the sources.  Adding such script is (I think) not a
>>>> problem; finding minimal portable[*1*] script is.  
>>>> So if you know one... 
>> 
>> [...]. There is need for BSD-compatibile
>> `install` program as 'install-sh', not 'make-install' script. The idea
>> is to use system-provided 'install' if it exists and is compatibile,
> 
> There lies the problem. HP-UX does have an 'install', but it is not
> compatible, and chances are (very) small that people have installed
> the GNU or any other BSD compliant install.
> 
>> because it should be faster than script version, and fallback to 
>> provided install-sh only if system install is not found.
> 
> The problem again. It *does* find install, but it turns out to be
> unusable.

Could you check if ./configure correctly uses install-sh in your case?
Copy install-sh from for example autotools[*1*] (e.g. libtool has one)
to the git sources, uncomment line with AC_PROG_INSTALL in configure.ac,
generate configure script using "make configure" and check what
./configure chooses.

In my case it is:

  $ cp /usr/share/libtool/install-sh .
  $ make configure
  GIT_VERSION = 1.5.4.rc0.56.g6fbe-dirty
      GEN configure
  $ ./configure
  configure: CHECKS for programs
  [...]
  checking for a BSD-compatible install... /usr/bin/install -c

What is ./configure output in your case?

Footnotes:
----------
[*1*] Or for example http://svn.scheffers.net/zlib/tclconfig/install-sh
which is smaller (2189 bytes vs. 9233 autotools one, or 10970 from
kapptemplate (kdesdk 3.5.3)).

-- 
Jakub Narebski
Poland
