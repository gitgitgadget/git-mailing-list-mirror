From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Fri, 11 Oct 2013 21:25:15 -0400
Message-ID: <20131012012515.GA1778@sigill.intra.peff.net>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
 <1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
 <522E3C6A.3070409@bbn.com>
 <CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
 <20130910022152.GA17154@sigill.intra.peff.net>
 <CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com>
 <vpqmwnljdmn.fsf@anie.imag.fr>
 <52589027a4851_5dc4c2be742754f@nysa.mail>
 <20131012005035.GA27939@sigill.intra.peff.net>
 <CAMP44s2y0UZ9uS8xtG2WDD=k5pHSG+K+_WM2dj-DVaUDy4djdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 03:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUnxS-0004JH-92
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 03:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab3JLBZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 21:25:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:47836 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751742Ab3JLBZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 21:25:21 -0400
Received: (qmail 4467 invoked by uid 102); 12 Oct 2013 01:25:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Oct 2013 20:25:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Oct 2013 21:25:15 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2y0UZ9uS8xtG2WDD=k5pHSG+K+_WM2dj-DVaUDy4djdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235936>

On Fri, Oct 11, 2013 at 08:15:46PM -0500, Felipe Contreras wrote:

> >> You are free to go ahead and implement 'warning ()' in git-sh-setup.sh, in the
> >> meantime no shell script does that, and that's no reason to reject this patch
> >> series.
> >
> > You are completely missing Matthieu's point that we attempt to be
> > consistent in the format of messages, as well as where they are output,
> > and from a user's perspective it does not matter what language the tool
> > is implemented in.
> 
> If we truly did that, there should be a warning () function, like in C.

Or people could hand-code them to look similar, which is exactly what
has happened.

If you want to factor out a warning function to clean up the code, be my
guest. But the lack of one does not provide an argument that you should
break consistency.

> > -               echo "The configurations pull.rebase and branch.<name>.rebase are deprecated."
> > -               echo "Please use pull.mode and branch.<name>.pullmode instead."
> > +               echo >&2 "warning: The configurations pull.rebase and branch.<name>.rebase are deprecated."
> > +               echo >&2 "Please use pull.mode and branch.<name>.pullmode instead."
> [...]
> 
> Are you sure you want me to squash that in? Because the warnings
> wouldn't be consistent. Some would be "WARNING: " and others would be
> "warning: ". Personally I don't care, but if your argument is
> consistency, you should. If we had a warning () function, we could
> truly be consistent.

It is significant in the most important ways, which are labeling it at
all, and sending it to stderr. Capitalization is less important, in my
opinion.

Using a lowercase version is much more consistent with the warnings
produced by C code, which is why I chose it over the capitalized
version. Again, if you want to change the existing WARNING cases in the
shell scripts to be consistent with C output, be my guest.

Do you actually have some reason for wanting to output to go to stdout?

-Peff
