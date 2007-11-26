From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 15:48:13 -0500
Message-ID: <9e4733910711261248o3ece7523s1069490e6c87932f@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org>
	 <2A34D324-48A4-49EF-9D4E-5B9469A0791D@lrde.epita.fr>
	 <20071126185600.GA25784@efreet.light.src>
	 <85prxw253u.fsf@lola.goethe.zz>
	 <20071126193455.GC25784@efreet.light.src>
	 <87ve7ozsz8.fsf@graviton.dyn.troilus.org>
	 <20071126200913.GE25784@efreet.light.src>
	 <87oddgzr3c.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>, "David Kastrup" <dak@gnu.org>,
	"Benoit Sigoure" <tsuna@lrde.epita.fr>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Michael Poole" <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:48:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwksc-0008Ax-Fi
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbXKZUsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbXKZUsP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:48:15 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:20672 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbXKZUsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 15:48:14 -0500
Received: by rv-out-0910.google.com with SMTP id k20so664189rvb
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 12:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MbTT3bmIsWx3kWK2kKrvu3ELwKNYbk04rJdIGvLTGW4=;
        b=gulDITOPpkUx2GoIHt2yqkVbDg8bbMhpGjF8hl5DtwMxcTPRk3JCy/S4/XWHDDnMEyntjAv6HoDGkoZQ32fy5I+BGHHe/zruxvK3kU8ZtFRrBdH1M6MZExvSS2SdaE+BHT9YiglESXLmeAfT4lKhwK++FnBQHVxPkrVTR5S5Svw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SmiVDL50b2PzNHt35ABsNBe/rszT98RGaUIUXSM29AWrmtz0USrauojhF49inw/Oi1/0x5ncAgTyznoXPB63VzlywPNZInzxPyl18iR/95oOXdfxW5mlSG1A1nO5nFtH3DrnOksILdx6bDK0646/CWVwhFmZSQ9jg/2mMV2sOE4=
Received: by 10.140.169.6 with SMTP id r6mr1437254rve.1196110093573;
        Mon, 26 Nov 2007 12:48:13 -0800 (PST)
Received: by 10.140.166.14 with HTTP; Mon, 26 Nov 2007 12:48:13 -0800 (PST)
In-Reply-To: <87oddgzr3c.fsf@graviton.dyn.troilus.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66120>

On 11/26/07, Michael Poole <mdpoole@troilus.org> wrote:
> Jan Hudec writes:
>
> > On Mon, Nov 26, 2007 at 14:50:35 -0500, Michael Poole wrote:
> >> Jan Hudec writes:
> >>
> >> > The basic pull/push actions are:
> >> >
> >> > git pull: Bring the remote ref value here.
> >> > git push: Put the local ref value there.
> >> >
> >> > Are those not oposites?
> >> >
> >> > Than each command has it's different features on top of this -- pull merges
> >> > and push can push multiple refs -- but in the basic operation they are
> >> > oposites.
> >>
> >> I think that is in absolute agreement with David: Ducks swim on the
> >> surface of the water and lobsters swim underneath.  Why consider the
> >> different features on top of where they swim?
> >>
> >> The thing about git-pull that surprises so many users is the merge.
> >> There's a separate command to do that step, and git-pull had a fairly
> >> good excuse to do the merge before git's 1.5.x remote system was in
> >> place, but now the only really defensible reason for its behavior is
> >> history.
> >
> > When I first looked at hg -- and that was long before I looked at git --
> > I was surprised that their pull did NOT merge and you had to do a separate
> > step. Partly because doing those two steps is quite common.
>
> Frequency of use is a good argument for having one command that does
> both.  It is not a good argument that "fetch, then merge" should be
> called "pull" or is the opposite of "push".

I'm starting to think that things oriented around the default names of
master and origin needs rethinking. Everything should use explicitly
named remotes. You could always do something like set a default remote
repository, but that is different than using the magic name 'origin'.

-- 
Jon Smirl
jonsmirl@gmail.com
