From: Jeff King <peff@peff.net>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Tue, 25 May 2010 02:33:54 -0400
Message-ID: <20100525063354.GC10898@coredump.intra.peff.net>
References: <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <4BF2E168.2020706@puckerupgames.com>
 <20100518191933.GB2383@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005181528550.12758@xanadu.home>
 <20100518194105.GA4723@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005181557250.12758@xanadu.home>
 <4BF9C678.6010108@puckerupgames.com>
 <7vaarq14me.fsf@alter.siamese.dyndns.org>
 <4BFA2451.6090507@puckerupgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: John <john@puckerupgames.com>
X-From: git-owner@vger.kernel.org Tue May 25 08:34:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGniJ-0000Cl-BE
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 08:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281Ab0EYGd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 02:33:58 -0400
Received: from peff.net ([208.65.91.99]:48361 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753723Ab0EYGd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 02:33:58 -0400
Received: (qmail 15957 invoked by uid 107); 25 May 2010 06:34:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 02:34:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 02:33:54 -0400
Content-Disposition: inline
In-Reply-To: <4BFA2451.6090507@puckerupgames.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147667>

On Mon, May 24, 2010 at 03:01:37AM -0400, John wrote:

> Ok, fair enough. It's your project, and you are defining "source
> control" as that which git supports: non-binary, line-by-line text
> only, C, bash .. no images, documents, etc.
>
> I only wish that definition of "source" had been more clear from the get-go.

I think both Junio's and my responses were not "we can't do a better job
with non-text sources" but rather "this is how we ended up with the
current state".

I'll admit I have some reservations about trying to figure out a sane
set of extensions for default .gitattributes, but that doesn't mean you
can't try if you want to. :)

> Perhaps a front and center blurb on the git home page or mission
> statement might clarify things for those of us who have different
> definitions of "source"?  That way, you wouldn't have to be bothered
> by folks trying to version all their project assets with git. For
> example, you could specify that non-text is out of scope for git, (or
> however you wish to define "source").

I don't know that we want to explicitly discourage such use. Obviously
certain workflows don't work as well with randomly-changing binary blobs
(e.g., reading format-patch output is next to useless, though it does
still work as a transport if your project relies on emailed patch
submissions).

In general, I think we are happy to take patches making binary storage
more pleasant (e.g., textconv) as long as they don't somehow make the
"normal" case of text worse. There are some things for which git is
simply not well suited (single files in the gigabytes, for example), and
those aren't likely to change because the some of the issues are
fundamental to how git works (though there are often workarounds, like
putting gigantic files in their own individual packs). But certainly
100M of jpgs does not seem like an unusable workload to me (as I
mentioned, I have a several-gigabyte photo repository that git does just
fine with).

-Peff
