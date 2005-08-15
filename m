From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [ANNOUNCE] qgit-0.9
Date: Mon, 15 Aug 2005 21:41:19 +1200
Message-ID: <46a038f9050815024135d351d0@mail.gmail.com>
References: <20050813121216.15512.qmail@web26305.mail.ukl.yahoo.com>
	 <46a038f905081402049d317e5@mail.gmail.com>
	 <20050814115834.GD6844@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Marco Costalba <mcostalba@yahoo.it>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 11:42:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4bTB-0005xC-1B
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 11:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVHOJlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 05:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVHOJlV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 05:41:21 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:28523 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932386AbVHOJlU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 05:41:20 -0400
Received: by rproxy.gmail.com with SMTP id a36so948551rnf
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 02:41:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rboIaJ1/BvZ6UtZi1ZAY6OHZox3uzU3bb3yH/mlyiZ90bjr9AgfdYp5rpWF4w7L69LKYB7xJBQM5uTHvVHlKqmK8Y69gawSneU99vXRG7UY4907GBM0SBBNlcmhEhAeR2wiMmTdC1DyeIpDkT0a17P6nntVsj0/3xqJcDrAmurM=
Received: by 10.38.75.6 with SMTP id x6mr1903937rna;
        Mon, 15 Aug 2005 02:41:20 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 15 Aug 2005 02:41:19 -0700 (PDT)
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050814115834.GD6844@mythryan2.michonline.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> You just need to add -I/usr/include/qt3/ in the appropriate place in the
> scons control file, IIRC.

I figured out that it wanted qt3-mt, installed it, and fiddled with
the SConfiguration file.  Still no dice, perhaps because I have a qt4
build environment?

$ QTDIR=/usr/ make
scons -Q
Retrieved `src/annotate.o' from cache
/usr//bin/uic -o src/commitbase.h src/commitbase.ui
/usr//bin/uic -impl commitbase.h -o src/uic_commitbase.cc src/commitbase.ui
/usr//bin/moc -o src/moc_commitbase.cc src/commitbase.h
uic: File generated with too old version of Qt Designer
File 'src/commitbase.ui' is not valid
scons: *** [src/commitbase.h] Error 1
make: *** [all] Error 2

this is with qgit 0.91. Hmmm. Removed all traces of qt4. Hmmm, and hmm
some more and it's built. Nice!

I actually like it quite a bit. So, notes for the build instructions:
under debian, you want  to

  apt-get install qt3-dev-tools libqt3-mt-dev

Make sure there's_no_ qt4 build environment, edit SConstruct and have
the env.Append line look like:
 
  env.Append( CPPFLAGS = ['-DQT_THREAD_SUPPORT', '-D_REENTRANT',
'-I/usr/include/qt3'] )

And then make it, saying:

  QTDIR=/usr make

cheers,

martin
