From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/2] t/lib-http.sh: Enable httpd tests by default.
Date: Fri, 20 Nov 2009 21:11:16 +0100
Message-ID: <20091120201116.GA19131@localhost>
References: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com> <1258680123-28684-2-git-send-email-tarmigan+git@gmail.com> <7vd43d7hdo.fsf@alter.siamese.dyndns.org> <905315640911201103w6d1da86duf41a53537672be8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	peff@peff.net, jaysoffian@gmail.com, spearce@spearce.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:11:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBZpc-0001hu-12
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 21:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbZKTULg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 15:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbZKTULg
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 15:11:36 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:39534 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbZKTULf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 15:11:35 -0500
Received: by bwz27 with SMTP id 27so3733223bwz.21
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 12:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=ZY2dUs4bNJtQcG1ohxvsJyYsjcK+2XDaUxlFYdSuztQ=;
        b=QvJ2aJLHFDVaezbTeIunA2tiOoWnT+27D5nnovP0fARzsdIASa94JEpi0tCK4JeFVS
         DfkUK/A/18rzxuoggBjuhChR4Y0iZ3J1sD785Y+SbKpBm0ahQ9nXPuMq/4ehTKnBHyL9
         Eb9SxLcokahPQ0vf8HuKf1aZ2MJqxEGLXjJgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=s/ZnV0IBhsFIWx8C4N5b22vz2yDljprC5+/3UjH+9s/0wF+HgtCZ1zTjb1fL+gnkON
         cJ6AqGBXiXF7ds1doxoBSrYyOnQduGwbtlAg0hPklxNaJTcxxEntc+mZ///xxQsTR3KB
         IQkz8n8t02Jal2aR20FpMBMc335WKQgbuc084=
Received: by 10.204.25.5 with SMTP id x5mr1796470bkb.166.1258747900687;
        Fri, 20 Nov 2009 12:11:40 -0800 (PST)
Received: from darc.lan (p549A4DE7.dip.t-dialin.net [84.154.77.231])
        by mx.google.com with ESMTPS id 13sm660484fxm.13.2009.11.20.12.11.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 12:11:39 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1NBZp6-00052l-C8; Fri, 20 Nov 2009 21:11:16 +0100
Content-Disposition: inline
In-Reply-To: <905315640911201103w6d1da86duf41a53537672be8e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133373>

On Fri, Nov 20, 2009 at 11:03:13AM -0800, Tarmigan wrote:

> Here's a patch (cut-n-paste so it will probably be munged) for
> discussion of the port-fallback idea.  If httpd cannot bind to 5541,
> it tries 15541 etc.

I would prefer if we skip the test right away. If we really want to try
different ports, we should first check that the port really is the problem.
Otherwise, the test will uselessly retry several times. Apache 2 writes

 (98)Address already in use: make_sock: could not bind to address
 127.0.0.1:5541

to stderr, which we could use to detect that error condition. But other web
servers are bound to behave differently.

Clemens
