From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [regression] Re: git-cat-file --batch reversion; cannot query
 filenames with spaces
Date: Thu, 1 Aug 2013 23:40:03 -0700
Message-ID: <20130802064003.GB3013@elie.Belkin>
References: <20130801201842.GA16809@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Joey Hess <joeyh@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 02 08:40:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5928-00069H-TH
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 08:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab3HBGkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 02:40:10 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:41382 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab3HBGkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 02:40:09 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so328971pad.14
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jroN8yI00ycAB1pVft/xpE2U+XIE716nI1EkpQfIA9c=;
        b=A+eoO5yd7Z3VyYvrvCUSpQmdc3NqfdmWsTitYkEdglEV6o0lF4lhrxXzURb2c/clQd
         W8cBlu7s+bUVd9eIOSA+te83qWNwRlFY6Qpkb9kpcJ4Zq3BzL5wzndQkMAlrK4+65syk
         zh17sAtZDNYviuEmuxQcz07q8zKDQzy/pkgvkiwKICwV33kwzfO0D9uEiuVpDPLVa/9g
         njWqvSXfP7G86Ii4u00VUGIJJVzbi8nR0fVpV8VAey27siUJrAED82Jc66OmGCh9Wjhn
         Tur8U0lCFwZfgKwl65CixLrLGsDHn7IlxQ+tNVf+deA8QeovnyYwdJ2xEN0WrcGKxf+T
         t43Q==
X-Received: by 10.68.163.165 with SMTP id yj5mr5927802pbb.141.1375425608812;
        Thu, 01 Aug 2013 23:40:08 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id zv11sm8590353pab.3.2013.08.01.23.40.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 01 Aug 2013 23:40:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130801201842.GA16809@kitenet.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231518>

Hi Joey,

Joey Hess wrote[1]:

> Commit c334b87b30c1464a1ab563fe1fb8de5eaf0e5bac caused a reversion in
> git-cat-file --batch. 
>
> With an older version:
>
> joey@gnu:~/tmp/rrr>git cat-file --batch
> :file name
> e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 blob 0
>
> With the new version:
>
> joey@wren:~/tmp/r>git cat-file --batch
> :file name
> :file missing
>
> This has broken git-annex's support for operating on files/directories
> containing whitespace. I cannot see a way to query such a filename using
> the new interface.

Oh dear.  Luckily you caught this before the final 1.8.4 release.  I
wonder if we should just revert c334b87b (cat-file: split --batch
input lines on whitespace, 2013-07-11) for now.

Thanks,
Jonathan

[1] http://bugs.debian.org/718517
