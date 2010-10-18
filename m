From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 11:56:31 -0500
Message-ID: <20101018165631.GA6718@burratino>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
 <20101018051702.GD22376@kytes>
 <20101018073102.GA3979@burratino>
 <20101018163836.GI22376@kytes>
 <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 19:00:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7t4R-0001aH-RG
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 19:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106Ab0JRRAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 13:00:15 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48888 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab0JRRAO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 13:00:14 -0400
Received: by gxk21 with SMTP id 21so128294gxk.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8qfdZy65C05t7BKRuIJ7kc4Mg8kqpWzNomF+UTNfyYA=;
        b=kd9ifQMdXVnQ7LdWlwmX+gDNimv7Kjh8pBdZmcUO1U7pxmiwUfNmS/a3ZUOQxporKL
         GQcgI+uAJZfqAv/pHjUQXF3IeC/2BNm33vsgQ9n8nqkn9XYtRTtv828annq+tpvRYeyt
         YwHDr9EOQED+RJObXegCoK3H7qAITHk83bkII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vpzJWozMEsVqAgJ8f/fNbyOt9DDOd/OIrVf6Ch2OHXf/N1ABDfvpE8tds0viXs11nW
         bvB9YMWRT/yQCqQYYVqFiKrnwtPMGtsUb0qD+BCFUh4znxhXCp0EJVxu5vNLYQlt/0oH
         V1trU5inxni1sfza6EG7ejEUHuFkpd1Jdxqbg=
Received: by 10.103.169.18 with SMTP id w18mr2753000muo.6.1287421212787;
        Mon, 18 Oct 2010 10:00:12 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id a16sm3847822fak.19.2010.10.18.10.00.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 10:00:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159265>

Sverre Rabbelier wrote:

> I'm thinking we can just refuse to let through a commit that is
> non-linear, as if there's a hook on the server side that rejects such
> a history. Since we're representing the svn remote as a regular
> remote, the user can just do 'git rebase @{u}" themselves if they end
> up with a non-linear history.

Sounds good to me!

FWIW I just wanted to make sure people don't forget about the
incompatible object models.  The pretend-upstream-has-a-vicious-update-hook
approach sounds like a sane way to deal with this for pushing from
git to svn (like (III) but making the user do more of the work).

Pulling from svn is a harder problem but luckily the single-upstream
case is the usual case (so object model mismatches are easier to cope
with as long as one can find the corresponding svn rev number for a
given git object easily).
