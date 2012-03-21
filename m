From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 21:04:22 +0100
Message-ID: <201203212104.23192.jnareb@gmail.com>
References: <20120321140429.GA28721@odin.tremily.us> <7vmx7921yz.fsf@alter.siamese.dyndns.org> <20120321195520.GB32535@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 21 21:04:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARll-0004n2-Nv
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 21:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434Ab2CUUEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 16:04:25 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:41385 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756977Ab2CUUEY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 16:04:24 -0400
Received: by wejx9 with SMTP id x9so1254430wej.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Vofbyh80/Zd5Pj+S1GOaPxK1J2lanwPXqUZ4yCKL2BM=;
        b=oKfjM3Yc0s2q4DK48xFwqOzmzWkTXgkJr+WKoC/wdvpLX3yOHxRdP5XKxbhEQ0Mncu
         ikOJlPponCnWhiOnvxpty4n+57ZiIbX7Za+H3X9NwXOYZbJJ85xp+yXE7icQkjfxjmwi
         YLYC8OmWxQyckpXTBi2uMIeVC0eMLH8FtYzkLEv2tv5Z8EmKPinHdHCp1cqe1X66QhEy
         Ar7kvdSRpLotRX7zh2JQHcSpjObtwc+/3sdbvO2nFyYO1MrSNAATrueLHFHl92UtTmGa
         cyqAyV+EWCWz6+SJLKbOWgPY8HNNEym3onOdL0KEp/YlN+akNMsQJ1bJBUVg/gvSJKNb
         fJ9Q==
Received: by 10.180.72.212 with SMTP id f20mr37744022wiv.15.1332360263311;
        Wed, 21 Mar 2012 13:04:23 -0700 (PDT)
Received: from [192.168.1.13] (abvy85.neoplus.adsl.tpnet.pl. [83.8.222.85])
        by mx.google.com with ESMTPS id bx13sm7012054wib.10.2012.03.21.13.04.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 13:04:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120321195520.GB32535@odin.tremily.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193609>

W. Trevor King wrote:
> On Wed, Mar 21, 2012 at 12:22:44PM -0700, Junio C Hamano wrote:
> > "W. Trevor King" <wking@drexel.edu> writes:

> > > > I think it would be better to add initial tests with refactoring, and
> > > > snapshot specific tests with snapshot support, e.g.:
> > > > 
> > > >   1/2: gitweb: Refactor If-Modified-Since handling and add tests
> > > >   2/2: gitweb: Add If-Modified-Since support for snapshots
> > >
> > > But the new tests would be for the new functionality (i.e. snapshot
> > > support), so they wouldn't belong in the general refactoring commit.
> > 
> > Then you are planning to split it in a wrong way.
> > 
> > ... add tests for codepaths that use i-m-s to make sure your
> > refactoring did not break them...
> 
> Ah, I was assuming that some current tests might be checking the
> current behavior, and that my new tests would be testing my new
> snapshot behavior.  If the old i-m-s handling also needs tests, that
> should happen before any of my previously proposed patches:
> 
> 1: tests for i-m-s and git_feed
> 2: refactor i-m-s handling

Those two can be in single commit.  Tests added need only test i-m-s
using git_feed ('atom' or 'rss' action), as it is the only user,
and you touch only i-m-s handling.

> 3: tests for i-m-s and git_snapshot (which fail until 4)
> 4: add i-m-s to git_snapshot

We usually put tests together with feature.  Tests before feature means
that you would need to mark them as test_expect_failure, as they would
not pass before feature is added, isn't it?

-- 
Jakub Narebski
Poland
