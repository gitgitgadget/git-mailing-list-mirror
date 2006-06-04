From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Sun, 4 Jun 2006 04:24:45 +0200
Message-ID: <4fb292fa0606031924v42024765l9f068f6915bfcf96@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
	 <46a038f90606012116t478edacex72a441544f395af4@mail.gmail.com>
	 <200606040116.38036.robin.rosenberg.lists@dewire.com>
	 <Pine.LNX.4.64.0606031631480.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"Keith Packard" <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 04:24:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmiIM-0000GI-Uo
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 04:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWFDCYr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 22:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWFDCYr
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 22:24:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:39900 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751426AbWFDCYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 22:24:47 -0400
Received: by nf-out-0910.google.com with SMTP id c31so1588021nfb
        for <git@vger.kernel.org>; Sat, 03 Jun 2006 19:24:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kcGwxvsEitf6Ai7kQCgstreMOaa+gxq7Epx790ptJLXQZq1ZwTuPvfh0eEdfcmoqjp0GYfc/kBecWyyEc9oE6tX3AHNnxNqzmR+je4s9Vo/NN1O1zfD+yjscdmBNr+ebN1OGZIs8LJglJ4uhedoMnpb9zCVo5B0uSmEYOKRdahw=
Received: by 10.49.58.9 with SMTP id l9mr2036327nfk;
        Sat, 03 Jun 2006 19:24:45 -0700 (PDT)
Received: by 10.49.5.13 with HTTP; Sat, 3 Jun 2006 19:24:45 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606031631480.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21242>

On 6/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Sun, 4 Jun 2006, Robin Rosenberg (list subscriber) wrote:
> >
> > (Yet) Another problem is that many windows tools use CR LF as the line ending.
> > Almost all windows editors default to CRLF and some detect existing line
> > endings. No editing with notepad anymore. Of course that is a problem
> > regardless of whether a git or cvs client is used. You'll get these big
> > everything-changed commits that alter between CRLF and LF.
>
> The only sane approach there (if you want to be at all cross-platform) is
> to just force everybody to _commit_ in UNIX '\n'-only format. Especially
> as most Windows tools probably handle that fine on reading (just have
> trouble writing them).
>
> And that shouldn't actually be that hard to do. The most trivial approach
> is to have just a pre-trigger on commits, but let's face it, that would
> not be a good "full" solution. A better one is to just make the whole
> "git update-index" thing just have a "automatically ignore CR/LF" mode.
>
> Which really shouldn't be that hard. I think it's literally a matter of
> teaching "index_fd()" in sha1_file.c to recognize text-files, and remove
> CR/LF from them. All done (except to add the flag that enables the
> detection, of course - just so that sane systems won't have the overhead
> or the "corrupt binary files" issue).
>
> Something like this is TOTALLY UNTESTED!
>
> (You also need to teach "diff" to ignore differences in cr/lf, and this
> patch is bad because it's unconditional, and probably doesn't work
> anyway, but hey, the idea is possibly sound. Maybe)

Is it also apply for binary files ? It could corrupt files as well.
If end-user application don't understand '\n' but '\r\n', you can have
bad issues (I think to notepad here (yes crappy, but ..)). Couldn't it
be configurable ?

-- 
# Beber : beber@gna.org
# IM : beber@jabber.fr
# http://guybrush.ath.cx, irc://irc.freenode.net/#{e.fr,gentoofr}
