From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Announcing a new (prototype) git-remote-hg tool
Date: Fri, 5 Dec 2014 15:13:30 -0800
Message-ID: <20141205231330.GL16345@google.com>
References: <20141205205335.GA28935@glandium.org>
 <20141205221319.GK16345@google.com>
 <20141205225930.GA29256@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 06 00:13:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx24I-0006CT-Kn
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 00:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbaLEXNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 18:13:36 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:49549 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbaLEXNd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 18:13:33 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so1575118igb.4
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 15:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MTtzRmU7A27tVEG50I4RMCoDLdybl1ldlfNtqw5smNM=;
        b=zMvSmSz3AYkZGflkPi5/OZw9M74Nrk/8+A42iON986C1Z++hRz3BWxVzQ7BzNDun64
         gDIX1ty0hkg0nZTwde4UC+SSp4iRuTHUWlADi3Au7FTzGdWNrOtG87xVsayzzKALdcg1
         dkwbYb/OmahTE/jD7TzuRY3fJhjomia/byQDExlpefWO83Ag7rn8oWLBtxueThK/5Ukq
         SrsbDKgE3TTmq6AlUhquwy3jfR92suKgd5EtolWnbR1aTklt2SEaJR3IXbTkcsGX3B+j
         vGILBhRyRJoAsc3cmpoyOCx9/g65DNXlTmrqWBl6IgnQRDbknTzh4qjzl1vJ8+oXCbLC
         4DrA==
X-Received: by 10.107.138.5 with SMTP id m5mr978477iod.85.1417821212807;
        Fri, 05 Dec 2014 15:13:32 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d425:9c48:1673:7021])
        by mx.google.com with ESMTPSA id l5sm1513721igu.10.2014.12.05.15.13.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 15:13:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141205225930.GA29256@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260911>

Jeff King wrote:

> One of the nice things about spinning remote-hg out of the core repo is
> that it means we do not have to endorse a particular implementation, and
> they can compete with each other on their merits.

True.

[...]
> It's a shame that both squat on the name "remote-hg", because it makes
> it difficult to tell the two apart. But of course that is the only way
> to make "git clone hg::..." work. Maybe we need a layer of indirection?
> :)

If the helpers are roughly interchangeable (that is, if you can switch
between fetching using each one into the same on-disk git repository),
then picking one to symlink as git-remote-hg in your $PATH should be
enough.

If they don't have that level of interoperability, then there's an
argument to be made that the URLs shouldn't be the same.
Unfortunately url.*.insteadof rules are resolved at fetch time instead
of being resolved once and the result recorded in .git/config.  So
yes, it seems like a way to have abbreviations for URLs (e.g., hg::
meaning hg+mh:: or hg+fc::) that get resolved at clone time would be
useful.  It's a layer of indirection we don't provide. :/

Thanks,
Jonathan
