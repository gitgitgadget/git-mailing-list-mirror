From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Thu, 24 Jul 2008 18:24:53 +0400
Message-ID: <20080724142453.GV2925@dpotapov.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness> <200807231852.10206.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:26:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM1lZ-0002af-3J
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbYGXOZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbYGXOZA
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:25:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:37432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbYGXOY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 10:24:59 -0400
Received: by ug-out-1314.google.com with SMTP id h2so595998ugf.16
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0Ibw24mcugAaqukhBATezUj36QGHH6WrR4AHlVU0ODc=;
        b=odpCnhC7eMSzQG67Fyj91XKVBevTYvHNZI1kVpQOC8EW8qecF0bZgK/7pky4EpcFE2
         6bx9EnyGKXpUGTM33idtJvtHM9nY1J+eviK1xI4LeSFyUqJ1Mqtyy2VRTZkvAsEvbsY5
         ohbJv07kJWG92V9c+h5e1jQbWr7x2ok9F+QtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L1iP0sjf5+II1HC4fRFi2kOnowb6B4nx0VZ20/4HicHwD+4qoqxyi4B/fgC+eWc2N3
         MGm5tgb1n28bx94WoU9xXwXUysBuF2AAhIgqhNghT6eQyMSvehZRSUsC9y3psA6/P84R
         dMK37mJC9K8VE8MVsISbu3BS4jBLnaxws4Mvk=
Received: by 10.103.204.1 with SMTP id g1mr131081muq.9.1216909496702;
        Thu, 24 Jul 2008 07:24:56 -0700 (PDT)
Received: from localhost ( [85.140.170.251])
        by mx.google.com with ESMTPS id g1sm60535058muf.7.2008.07.24.07.24.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 07:24:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807231852.10206.litvinov2004@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89887>

On Wed, Jul 23, 2008 at 06:52:09PM +0700, Alexander Litvinov wrote:
> > On Wed, 23 Jul 2008, Alexander Litvinov wrote:
> > > In short: I can't clone svn repo into git when crlf convertion is
> > > activated.
> >
> > This is a known issue, but since nobody with that itch seems to care
> > enough to fix it, I doubt it will ever be fixed.
> 
> That is a bad news for me. Anyway I will spend some time at holidays during 
> digging this bug. 

I don't want to discourage from digging into this problem, but there are
two reasons why no one has fixed this issue yet. First, configuration
CRLF conversion in Git and SVN is quite different, so it may not be easy
to have the solution that will work in all cases. Second, in many cases,
you can workaround this issue.

If I understood your situation correctly, you use SVN repo where text
files are marked with svn:eol-style=native. In this case, SVN stores
these files with LF endings internally, and git-svn receives files in
that format (at least, it is so on Debian).  Practically all Windows
editors do not have problems to open and edit files with LF endings, but
some of them will write back using CRLF. You do not want CRLF to get in
your Git repository, so you can do that by setting core.autocrlf=input.
This might work for you...

Dmitry
