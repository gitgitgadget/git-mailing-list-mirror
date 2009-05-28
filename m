From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 2/2] diff: generate prettier filenames when using
	GIT_EXTERNAL_DIFF
Date: Thu, 28 May 2009 14:30:49 -0700
Message-ID: <20090528213049.GA55167@gmail.com>
References: <1243491077-27738-1-git-send-email-davvid@gmail.com> <1243491077-27738-2-git-send-email-davvid@gmail.com> <20090528174436.GA12723@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 23:31:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9nC7-0005Vg-IL
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 23:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760852AbZE1Vaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 17:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759187AbZE1Vay
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 17:30:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:53378 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994AbZE1Vay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 17:30:54 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1747140rvb.1
        for <git@vger.kernel.org>; Thu, 28 May 2009 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ywS4RNNZ/+puqj6gf7HeuRoiRaT24jkXuUKZWCj5EJ4=;
        b=nlWo2KEwiZRW8iZYY9vJjfUSGYseDRV0wsTIkJ/zBckUhGtOq3wkkjISggBX0lLwgn
         3VEL9qhJ1M7TymK/eP2QgyWPktxGwGzyArApL1QzFR7PAnLQloN4/bITPB5gWPPthII5
         o8p3K94rZqdqcExFDn8SnKF9lhf8xRPc4JPsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JyYkVFWI9kGUbTltqJzjB3FNXxbO64VWChyn3Ix4S/x1rX4WaMPN1ESiSg7nrd9yXH
         7UGSviXSpXfJxC6YGvEEyuLE4Hn+Tastpkzls1Npqc17Ems1Sp5i5CBiJdYRQQUAgYE7
         TMq0dDWYqdRjiLmgfsAQtwHf+A5nIh0yyEbBs=
Received: by 10.141.41.3 with SMTP id t3mr910044rvj.149.1243546255356;
        Thu, 28 May 2009 14:30:55 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id g22sm1498860rvb.36.2009.05.28.14.30.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 14:30:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090528174436.GA12723@coredump.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120237>

On Thu, May 28, 2009 at 01:44:36PM -0400, Jeff King wrote:
> On Wed, May 27, 2009 at 11:11:17PM -0700, David Aguilar wrote:
> 
> > +int git_mkstemps(char *path, size_t n, const char *template, int suffix_len);
> 
> FWIW, I find this name not very descriptive. From the name, I would
> expect it to do the exact same thing as mkstemps, but be our own
> personal implementation. But it is actually a wrapper that behaves
> somewhat differently. So I wonder if "mkstemps_tmpdir" or something
> would be a better name.

It does exactly what git_mkstemp() does, plus the extra
suffix_len parameter.  If we rename this function we have to
rename both.


> Is there a reason _not_ to always just use the pretty filename? It looks
> like you turn it on for external diff, but off for textconv. I don't
> think there is a reason not to use it for textconv.

I was not aware of the other code paths and only wanted to
affect the one that I knew about.  I agree that making that the
default behavior would be great, meaning we could drop the
pretty_filename flag altogether.

If you and others agree that the user-friendly names are a good
thing to have by default then I can rework patch 2/2.

> However, I suspect that all callers should use pretty filenames, and
> then this bit would just go away.

I fully agree.


-- 
		David
