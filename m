From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Doc format-patch: clarify --notes use case
Date: Thu, 25 Oct 2012 06:25:27 -0400
Message-ID: <20121025102527.GO8390@sigill.intra.peff.net>
References: <1350855250-2844-1-git-send-email-philipoakley@iee.org>
 <1350855250-2844-4-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Blake <eblake@redhat.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:25:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRKdD-0003pZ-AO
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 12:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab2JYKZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 06:25:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56103 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab2JYKZa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 06:25:30 -0400
Received: (qmail 7632 invoked by uid 107); 25 Oct 2012 10:26:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 06:26:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 06:25:27 -0400
Content-Disposition: inline
In-Reply-To: <1350855250-2844-4-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208383>

On Sun, Oct 21, 2012 at 10:34:10PM +0100, Philip Oakley wrote:

>  The expected use case of this is to write supporting explanation for
> -the commit that does not belong to the commit log message proper
> -when (or after) you create the commit, and include it in your patch
> -submission.  But if you can plan ahead and write it down, there may
> -not be a good reason not to write it in your commit message, and if
> -you can't, you can always edit the output of format-patch before
> -sending it out, so the practical value of this option is somewhat
> -dubious, unless your workflow is broken.
> +the commit, that does not belong to the commit log message proper,
> +and include it with the patch submission. The notes can be maintained
> +between versions of the patch series. You can also edit the output of
> +format-patch before sending.

I found the "you can also" slightly awkward here, as it was not clear
why it was mentioned. I think the intent is "this is an alternative that
does not involve the notes workflow", but it is not clear from the text
why you would prefer the notes workflow. Here is what I queued instead,
which tires to clarify that, and also mentions that this workflow needs
additional setup to track rewritten commits:

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 066dc8b..750b3fa 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -196,13 +196,12 @@ The expected use case of this is to write supporting explanation for
 	after the three-dash line.
 +
 The expected use case of this is to write supporting explanation for
-the commit that does not belong to the commit log message proper
-when (or after) you create the commit, and include it in your patch
-submission.  But if you can plan ahead and write it down, there may
-not be a good reason not to write it in your commit message, and if
-you can't, you can always edit the output of format-patch before
-sending it out, so the practical value of this option is somewhat
-dubious, unless your workflow is broken.
+the commit that does not belong to the commit log message proper,
+and include it with the patch submission. While one can simply write
+these explanations after `format-patch` has run but before sending,
+keeping them as git notes allows them to be maintained between versions
+of the patch series (but see the discussion of the `notes.rewrite.*`
+configuration in linkgit:git-notes[1] to use this workflow).
 
 --[no]-signature=<signature>::
 	Add a signature to each message produced. Per RFC 3676 the signature


I've queued that and your other patches on top of jc/prettier-pretty-note.

-Peff
