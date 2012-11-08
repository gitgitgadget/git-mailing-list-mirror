From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] launch_editor: ignore SIGINT while the editor has
 control
Date: Thu, 8 Nov 2012 10:33:31 -0500
Message-ID: <20121108153331.GC15560@sigill.intra.peff.net>
References: <20121107191652.842C52E8089@grass.foxharp.boston.ma.us>
 <20121107220027.GA17463@shrek.podlesie.net>
 <20121107233515.107ED2E8089@grass.foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>,
	gitster@pobox.com
To: Paul Fox <pgf@foxharp.boston.ma.us>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:33:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWU73-0000Qj-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 16:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab2KHPdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 10:33:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36354 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752194Ab2KHPdf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 10:33:35 -0500
Received: (qmail 30169 invoked by uid 107); 8 Nov 2012 15:34:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 10:34:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 10:33:31 -0500
Content-Disposition: inline
In-Reply-To: <20121107233515.107ED2E8089@grass.foxharp.boston.ma.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209165>

On Wed, Nov 07, 2012 at 06:35:15PM -0500, Paul Fox wrote:

> the user's editor likely catches SIGINT (ctrl-C).  but if the user
> spawns a command from the editor and uses ctrl-C to kill that command,
> the SIGINT will likely also kill git itself.  (depending on the
> editor, this can leave the terminal in an unusable state.)
> 
> Signed-off-by: Paul Fox <pgf@foxharp.boston.ma.us>

Thanks, I think this makes sense.

> krzysztof wrote:
> ...
>  > editor.c: In function 'launch_editor':
>  > editor.c:42:3: warning: implicit declaration of function 'sigchain_push' [-Wimplicit-function-declaration]
>  > editor.c:44:3: warning: implicit declaration of function 'sigchain_pop' [-Wimplicit-function-declaration]
> 
> sigh.  i had that initially, lost the patch, and then recreated
> without it.  but i'm surprised my build (i did rebuild! :-) doesn't
> emit those errors.  in any case, here's the fixed patch.

gcc will not warn about implicit declarations by default; try compiling
with "-Wall".

-Peff
