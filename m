From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 13:13:36 -0500
Message-ID: <20101018181336.GB6877@burratino>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
 <20101018051702.GD22376@kytes>
 <20101018073102.GA3979@burratino>
 <20101018163836.GI22376@kytes>
 <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
 <20101018165631.GA6718@burratino>
 <AANLkTimZU_q3KJYpq7zQU7o5H-M8=efDUDL9Zoy7LuZg@mail.gmail.com>
 <20101018172810.GA6877@burratino>
 <AANLkTinYpa61a=68ACSALtxuFnhGh5nGxmeD41J3e51i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 20:17:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7uGw-0001UX-W6
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 20:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab0JRSRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 14:17:15 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37177 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab0JRSRP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 14:17:15 -0400
Received: by vws2 with SMTP id 2so733642vws.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zs2Ru7V9BrN7+ql2P+YHUcO5Q4vSbL71pDam6HopoJ4=;
        b=oRA+sZLND1xxjcFMpDfLCW1tzCM3QDVZZPPZ2AooIuEaTptm8qAZILl7dM93fazzp3
         2sTbAPX7YhAdXTPeMhvH1tGJLhu8sfIugPBM5/Hezd4+Mi+4Wc8pdZKFNOWMZUvV6LAH
         w6lOup1wBVtgZK2mtSy7h2CTbWCfs/hzW61kE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=F1p1QZ4l5FwXcd6Vp52jz2u/hCi1EPv0f3Hwn21pi5f9oBmLABWsVRp6/kgeo8fTL5
         XZ96lbRJlbWJ4gCUVg04YnwmR0CCg5cknpiDs9TaHM929hEWxQwPyKBNIjxD5jAAdYzl
         5bwLJbp56id7ndDQTsvKoPNR9iBttBEzE2cUo=
Received: by 10.220.200.199 with SMTP id ex7mr1285864vcb.263.1287425834110;
        Mon, 18 Oct 2010 11:17:14 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id s12sm6317601vbp.4.2010.10.18.11.17.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 11:17:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinYpa61a=68ACSALtxuFnhGh5nGxmeD41J3e51i@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159276>

Sverre Rabbelier wrote:
> On Mon, Oct 18, 2010 at 12:28, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> I mean that rejecting a fetch because upstream has weird history
>> would make no one happy.
>
> Agreed. What about when the remote's history is rewritten, do we want
> to just transplant the new history, or do we do a forced update of the
> remote?

I think treating it as a usual non-fast-forward update makes sense.

Log messages could be an annoying special case, though, since people
edit those a lot.  Does svn store the original log message somewhere?
(Please forgive my ignorance).  If not, I suppose downstream can
publish refs produced by "git replace" to cope.
