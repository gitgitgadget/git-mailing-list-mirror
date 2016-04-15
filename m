From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 15 Apr 2016 16:21:35 -0400
Organization: Twitter
Message-ID: <1460751695.5540.94.camel@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
	 <CACsJy8DE40dMiiqkTb=Pz8uidPk-q1-kuX514s7mO55ChFLXhg@mail.gmail.com>
	 <1460573236.5540.83.camel@twopensource.com>
	 <CACsJy8AyZKLC4Fsa8+BKqvRSAJOQSPBramjLC0ubrhW+fWQtxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:21:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arAFL-0000nT-W5
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 22:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbcDOUVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 16:21:39 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34554 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcDOUVi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 16:21:38 -0400
Received: by mail-qg0-f47.google.com with SMTP id c6so87907299qga.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=PaBJqyMDCEvzLWGyD6fZg1BqKGgD03PNixOC6867MUE=;
        b=iHYvDvF6D/yJVTDGfADU8v1D/ORob3c1AL/9OvOB2aGnI5hej5vm99Y3mlvCM/AFJW
         /evzWRkfN+ze1qzUk9UgwQe8NYWvSouI7N2OIfoDrQNOb/dr0i5HSP/rihqO62F4jtc3
         B+frD+eIuULO5w7NW88IBodfZRM5naSb2H0SrLfsLrT6RFXkYZemMtnpwutibN4nADbL
         uqqjHfXxHSmn21rATOtCwYz6yeV+t2aY7lDLHZ+yhM+kOUulcnekQlfoFienKIcmdzvJ
         P0a/uwFgYveDGuo06xNqyZdEZ1x+c5tIr/7xKW84XVjSgerY2I9Kmd5mHnIa9Dsb+u4l
         77gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PaBJqyMDCEvzLWGyD6fZg1BqKGgD03PNixOC6867MUE=;
        b=lpwAM0NsNFRiWZPNATR/ui+l4vR7P2d1tTy4/AxzM0H5YD8B9L1SPDeJBGN+rzKBz1
         C78LZuCP+cdtdpDo16gL1ndkU/8JEXQ6uRX0Xo3UzP55IHPa4NreMd90oL180DBd0eRM
         ZCHWETF2l0RK7Ht0cPPCCANCHxQ7VyzG36hxNx5vbSBerIXUmKo4Zd9pjWYs+Rk98SxY
         jpr3B1uG1bSFhAMXkP1KH6K89r/xsRPcUOOWwZNcLJVA6nm3NIg/vd/vl/YhFcsL/EN2
         KYN6AfXTG27/cVuNHgnEDQWEbcUdlFXwXqrUT3e17Q2LApqKCyrWlE1phgHy4Jayg+RJ
         uM7A==
X-Gm-Message-State: AOPr4FVoJPs5l/mf/smbZuCMe2JEPiUEuZcAwqsuoO/BYWZ8/AFe/qcGAqfCjMy4iEbs5Q==
X-Received: by 10.140.101.145 with SMTP id u17mr27233349qge.59.1460751697518;
        Fri, 15 Apr 2016 13:21:37 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b6sm21274295qkh.12.2016.04.15.13.21.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2016 13:21:36 -0700 (PDT)
In-Reply-To: <CACsJy8AyZKLC4Fsa8+BKqvRSAJOQSPBramjLC0ubrhW+fWQtxA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291655>

On Fri, 2016-04-15 at 18:25 +0700, Duy Nguyen wrote:
> On Thu, Apr 14, 2016 at 1:47 AM, David Turner <
> dturner@twopensource.com> wrote:
> > > > +       fd = unix_stream_connect(socket_path);
> > > > +       if (refresh_cache) {
> > > > +               ret = write_in_full(fd, "refresh", 8) != 8;
> > > 
> > > Since we've moved to unix socket and had bidirectional
> > > communication,
> > > it's probably a good idea to read an "ok" back, giving index
> > > -helper
> > > time to prepare the cache. As I recall the last discussion with
> > > Johannes, missing a cache here when the index is around 300MB
> > > could
> > > hurt more than wait patiently once and have it ready next time.
> > 
> > It is somewhat slower to wait for the daemon (which requires a disk
> > load + a memcpy) than it is to just load it ourselves (which is
> > just a
> > disk load).
> 
> You forgot the most costly part, SHA-1 verification. For very large
> index, I assume the index-helper is already in the middle of hashing
> the index content. If you ignore index-helper, you need to go hash
> the
> whole thing again. The index-helper can hand it to you if you wait
> just a bit more. This wait time should be shorter because index
> -helper
> is already in the middle of hashing (and in optimistic case, very
> close to finishing it).

You're right -- I did forget that part.

In "index-helper: use watchman to avoid refreshing index with lstat()",
we switch from just poking to poking and waiting for a reply.  Then in
"read-cache: config for waiting for index-helper", we make that waiting
optional.  So what if I just remove that patch?  Does that solve it?
