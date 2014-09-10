From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] Makefile: add check-headers target
Date: Tue, 9 Sep 2014 17:03:29 -0700
Message-ID: <20140910000328.GB12644@gmail.com>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com>
 <xmqqiokylz46.fsf@gitster.dls.corp.google.com>
 <vpqsik13o84.fsf@anie.imag.fr>
 <xmqqa969nav9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 02:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRVNx-0004Vn-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 02:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbaIJADf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 20:03:35 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:45850 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbaIJADd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 20:03:33 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so9062142pad.35
        for <git@vger.kernel.org>; Tue, 09 Sep 2014 17:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5/jEcvYPIW73rrSGeIMK/aRy3SLRMg1kve5zIQnOa30=;
        b=g0t43wYJvDH+rz2U+mmj9O+QOrxngD2vobka86D7RA7LaH7KFjKPJGOtTR36mMsVzP
         d+EzoiGW8R5ZWu1dM9Vi3VgimOHuFtmsWJ/5BYVGMDvqfV4s1EDzCgePA6aXLWsPunEh
         XEmzG4omriqLyILXkRTdPw0flt1tJF98YLix9GK1XTCluZVT12G6FYHkC4Ly0FkNiCzG
         bufUZTHSMHXLUgQrf+8OHyZRhQ1rDdcodUg/FHiY8gfTUvf41ueZNJR4vUQehgBAzMGN
         4chmrhjgQNmsnI8WNHpQx1+6uJUmRNB2NIHoJTfsmKZ8b/x4ikmwyY5e1kt0s7EcKPFW
         gNog==
X-Received: by 10.66.155.2 with SMTP id vs2mr60372570pab.60.1410307412980;
        Tue, 09 Sep 2014 17:03:32 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id p3sm5407724pde.35.2014.09.09.17.03.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Sep 2014 17:03:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqa969nav9.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256725>

On Mon, Sep 08, 2014 at 12:57:46PM -0700, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> David Aguilar <davvid@gmail.com> writes:
> >>
> >>> +IFS='
> >>> +'
> >>> +git ls-files *.h ewah/*.h vcs-svn/*.h xdiff/*.h |
> >>
> >> Hmm.  This is only for true developers (not one who merely compiles
> >> after expanding a tarball), so "git ls-files" may probably be OK.
> >>
> >> But "/bin/ls" would be equally fine for that, no?
> >
> > Actually, since this is "| while read header", I have to wonder why this
> > is not written as
> >
> > for header in .h ewah/*.h vcs-svn/*.h xdiff/*.h
> > do
> > 	...
> > done
> 
> Yes, that would be even better.  Then you wouldn't even have to
> worry about $IFS dance.

The original motivation was to avoid picking up the generated
common-cmds.h header file.

It was the N_() function that was messing it up.

Would it make sense to split out a separate patch that makes common-cmds.h
check-headers clean?
-- 
David
