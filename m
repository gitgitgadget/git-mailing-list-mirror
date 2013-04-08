From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3700 (add): add failing test for add with submodules
Date: Mon, 8 Apr 2013 18:07:30 -0400
Message-ID: <20130408220730.GA11873@sigill.intra.peff.net>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
 <1365416809-4396-1-git-send-email-artagnon@gmail.com>
 <20130408213006.GD9649@sigill.intra.peff.net>
 <7v8v4svfwi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 00:07:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPKDz-0007Xy-Jw
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936423Ab3DHWHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 18:07:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34394 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934823Ab3DHWHf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 18:07:35 -0400
Received: (qmail 17225 invoked by uid 107); 8 Apr 2013 22:09:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 18:09:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 18:07:30 -0400
Content-Disposition: inline
In-Reply-To: <7v8v4svfwi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220533>

On Mon, Apr 08, 2013 at 03:03:41PM -0700, Junio C Hamano wrote:

> >> +test_expect_failure 'git add should not go past submodule boundaries' '
> >> +	mkdir submodule_dir &&
> >> +	(
> >> +		cd submodule_dir &&
> >> +		git init &&
> >> +		cat >foo <<-\EOF &&
> >> +		Some content
> >> +		EOF
> >> +		git add foo &&
> >> +		git commit -a -m "Add foo"
> >> +	) &&
> >> +	git add submodule_dir/foo
> >> +'
> >
> > That is not actually a submodule, but rather just a repo that happens to
> > be inside our working tree. 
> 
> I think we should treat it as a submodule-to-be, waiting for the
> user to run "git add submodule_dir".
> 
> If it is a file in the working tree of an unrelated and separate
> repository, it still is wrong to allow it to be added to our
> repository, no?

Sorry if I wasn't clear; I absolutely think this test is checking
something reasonable, and we should fix it to pass. I was only referring
to the wording, which is misleading (and hoped that pointing it out
would help whoever works on it in the right direction of where the
problem is).

-Peff
