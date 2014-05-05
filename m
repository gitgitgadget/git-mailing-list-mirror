From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Watchman support for git
Date: Mon, 05 May 2014 13:14:38 -0500
Message-ID: <5367d50e333f_25278db2eccf@nysa.notmuch>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <536428224adfb_200c12912f010@nysa.notmuch>
 <1399083897.5310.0.camel@stross>
 <5364654088dc4_4d2010fb2ec7d@nysa.notmuch>
 <1399313294.5310.59.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:28:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi6c-0006KZ-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbaEESZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 14:25:25 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:54032 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbaEESZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 14:25:21 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so8862314obc.6
        for <git@vger.kernel.org>; Mon, 05 May 2014 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=sqck3gsR2lUIuc8KKkdnouOk9Vb8GAw7+GmpEf4j4Hs=;
        b=Y5MydXeUsJZjdsEQGN4YM6357n2bgd+U8L8bd/HrSpjgWpvVJENdBSooyq541Qk0x6
         K598yoRSl5y0hl6noVaC8BL3lRB6Z6JrJIcQTbBagzFVxwf1+efmdd6kJnoMheMAnnI7
         Emj4pXaOfo2c/i6VuHY8lCe3jWc60jhEQV61xWOxpopuSGbglVXDFaLaQOOi2TIL7mRf
         myRRGLqbnQi9cTm89808drmzzzgGirBfc1RcxeTlXv8X87vk8ZxIRWHLGLcvJkEApW19
         J85YZmyQ8vIbn6v6csVOmnFqqm1wxQg629zRxqgmsChpvbuCOqjsH2GL0mNmoPohSZey
         SPLg==
X-Received: by 10.60.40.198 with SMTP id z6mr3717405oek.85.1399314321414;
        Mon, 05 May 2014 11:25:21 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id sm4sm20913431obc.3.2014.05.05.11.25.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 11:25:20 -0700 (PDT)
In-Reply-To: <1399313294.5310.59.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248138>

David Turner wrote:
> On Fri, 2014-05-02 at 22:40 -0500, Felipe Contreras wrote:
> > David Turner wrote:
> > > On Fri, 2014-05-02 at 18:20 -0500, Felipe Contreras wrote:
> > > > dturner@ wrote:
> > > > > Test repository 1: Linux
> > > > > 
> > > > > Linux is about 45k files in 3k directories.  The average length of a
> > > > > filename is about 32 bytes.
> > > > > 
> > > > > Git status timing:
> > > > > no watchman: 125ms
> > > > > watchman: 90ms
> > > > 
> > > > That's very interesting. Do you get similar improvements when doing
> > > > something similar in Merurial (watchman vs . no watchman).
> > > 
> > > I have not tried it.  My understanding is that this is why Facebook
> > > wrote Watchman and added support for it to Mercurial, so I would assume
> > > that the improvements are at least this good.
> > 
> > Yeah, my bet is that they are actually much better (because Mercurial
> > can't be so optimized as Git).
> >
> > I'm interested in this number because if watchman in Git is improving it
> > by 30%, but in Mercurial it's improving it by 100% (made up number),
> > therefore it makes sens that you might want it more if you are using hg,
> > but not so much if you are using git.
> > 
> > Also, if similar repositories with Mercurial+watchman are actually
> > faster than Git+watchman, that means that there's room for improvement
> > in your implementation. This is not a big issue at this point of the
> > process, just something nice to know.
> 
> Converting git repos to hg seems to be incredibly slow.  (I have not yet
> tried doing it with git-remote-hg).

I haven't profiled the git->hg conversion, only the other way around,
but I don't see why it would be slow in git-remote-hg.

The only restriction is that octopus merges are not supported, so you
would probably need to find another repository.

> But I did find a hg repository for
> linux: https://bitbucket.org/orzel/linux-kernel-stable
> 
> On this repo, I get:
> hg without watchman: 620ms
> hg with watchman: 264ms
> (compared to 125ms/90ms for git).
> 
> The number of syscalls is, perhaps also interesting:
> no watchman / with watchman
> hg  77773   /  5421
> git 59180   /  599 
> 
> (About 1/3 of hg's syscalls with watchman seem to be loading Python
> stuff)

Exactly what I thought :) 28% improvement for Git, 76% improvement for
Mercurial. Still, the improvement would be welcome by big companies I
bet.

Cheers.

-- 
Felipe Contreras
