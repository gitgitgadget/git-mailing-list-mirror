From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Mon, 19 May 2014 16:21:36 -0500
Message-ID: <537a75e0a53b7_afee5d300f3@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <20140516225228.GA3988@sigill.intra.peff.net>
 <5376f2ca5c90d_65b915db2f877@nysa.notmuch>
 <20140517062413.GA13003@sigill.intra.peff.net>
 <xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
 <53795ef8e4023_10da88d30825@nysa.notmuch>
 <xmqqppja2t8a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 23:32:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmVAy-0000Ug-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 23:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbaESVct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 17:32:49 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:49507 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbaESVcr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 17:32:47 -0400
Received: by mail-ob0-f172.google.com with SMTP id wp18so6858630obc.17
        for <git@vger.kernel.org>; Mon, 19 May 2014 14:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=R8bOdVkY840ygVMRBYTyTUKzi43ZLKzsBsGd9upprEo=;
        b=pE8o06hj0Op//JhZHJa+nxNl/rGTRltYSKfypVNfosYQUmF3EZvvN2+y2DpwOHvIP+
         C2i9oAd8wKKIJHFTJt6GJutLvMPygjW/KDmPaifPh3xpFi6NjKVDVD2++vBOFlfRMTZG
         msRIS16+9mHgR3ia1Ug0vgoBXDwBS6LObvIHod6KksT9e2EmyMwWZbneiiiTgoTod3cG
         S2oRLor0toGQONaAu2CAA1iSLhYC9vNOx2OE3ZicMCgVB+/kwmkWrrnqbpOmMu7p4IRe
         J7T02arZAWdLlsavJ+9HfzTRIklvN9o/f2qjuzs5KZt8p8mxtibi4z7/US2pdpBuB8/p
         LH+w==
X-Received: by 10.60.47.111 with SMTP id c15mr6038300oen.80.1400535166887;
        Mon, 19 May 2014 14:32:46 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id fm8sm41263222oeb.10.2014.05.19.14.32.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2014 14:32:46 -0700 (PDT)
In-Reply-To: <xmqqppja2t8a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249625>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >
> >>  - The "always warn" does not force update at the point of use, but
> >>    it still does not help them to notice well before they try to use
> >>    it for the first time after update;
> >
> > I don't understand this sentence. They will see a big fat warning every
> > time they run the tool, of course they'll notice.
> 
> Let me ask one question first, in order to avoid miscommunication,
> as I really want to get the first step for v2.0-rc4 in a concrete
> shape tomorrow.  Do you think gradual transition worth pursuing or
> do you think it is a waste of time?

If by "gradual transition" you mean place the contrib/remote-helpers in
another directory before removing the code, I do think it's a waste of
time, but I don't really care, as long as eventually stubs are put in
place.

> I do not think it matters that much, but since you said you do not
> understand...
> 
> What I meant was that when they update their Git (perhaps at the
> beginning of the week), the won't know they will now be running
> stale code.  The warning comes only when they first run it (perhaps
> at the end of the week) to do some real work with a remote hg
> repository, which may not be a convenient time to do their sysadmin
> task.  And the next time when they update their Git, they may have
> already forgotten about the warning.  The ideal transition would be
> to somehow let them notice when they are in sysadmin mode.

You can add such change in the release notes. Other than that I don't
see what we could do.

> >>  - "Break the build" attempts to help them notice when they try to
> >>    update, not when they need to use the updated one right at this
> >>    moment.
> >
> > This cannot be done.
> 
> Renaming the directory will not "break at the build time" for those
> who have already did "ln -s" these scripts, of course, but it will
> "break at the build time" for others (i.e. those who "cp"), no?

How many people copy the scripts every time they update Git? Not many
I'd gather.

> > They click that URL, and the are immediately greated with this:
> >
> >   To enable this, simply add the git-remote-hg script anywhere in your $PATH:
> >
> >     wget https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg -O ~/bin/git-remote-hg
> >     chmod +x ~/bin/git-remote-hg
> 
> Perfect.  I did check the page when double-checking the URL while
> writing the README thing, and I did skim the page, but I must have
> missed it.
> 
> We could add these two to the warning, then, to discourage people
> who see "please visit this URL" and say "Yuck, I have no time for
> that" without actually visiting.

We could. Personally I don't see the point of making the warning any
more annoying. The instructiosn are just one click away, and if they
have no time for that, they can just ignore the warning.

> >> So to summarize, the following timeline is a full possibility:
> >> ...
> >>   2. add warning that is given every time the scripts are run and
> >>      give the same instruction as in README.
> >> 
> >>   3. (optional) cripple the script to make them always fail after
> >>      showing the same warning as above.
> >
> > This is what I want, and I already sent the patches for; the scripts
> > will be stubs. At this point you would have effectively removed the
> > code, which what I want.
> 
> I think explained why the step 3 would not help very much compared
> to the "there is no script, only README remains" endgame (and that
> is why it is marked as "optional").  Actually, you reminded me that
> a very short and easy-to-follow instruction is on the page referred
> to from README and the warnings, which means that this step would
> make even less difference compared to the endgame.
> 
> I don't think I saw you explain why that is not the case and why we
> do want this step (and I cannot quite tell if you are aiming for
> more gradual transition that wants this step, or an expedited one
> that does not).  I am fine with either way.

To me the endgame is that the code is removed, and only stubs remain.
What you do after that is up to you.

> In any case, I'd ask another question to avoid wasting time on
> miscommunication.  By "This is what I want", do you mean you want
> this step 3 also in v2.0, or do you mean you want 2 alone in v2.0
> then step 3 some time later?

I meant I want 3. eventually, hopefully for v2.1.

> You said your "wish" wasn't "respected" in another message, when I
> explained that I thought you did not want to disrupt v2.0 by
> insisting on removing these scripts and that was why I listed
> options that did not involve removal of the scripts.  Are you saying
> that you wish you want to see them removed or crippled at v2.0?
> Changing your mind after discussion is perfectly fine, by the way.

You did not specify those were only for v2.0.

No, I don't want them crippled for v2.0. A warning should suffice.

-- 
Felipe Contreras
