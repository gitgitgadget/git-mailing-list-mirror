From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Feeding an annotated but unsigned tag to "git merge"
Date: Wed, 6 Jun 2012 09:42:07 -0400
Message-ID: <20120606134207.GB2597@sigill.intra.peff.net>
References: <1338926312-4239-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 15:42:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScGV5-0002pV-I2
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248Ab2FFNmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 09:42:11 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:44974
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898Ab2FFNmK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:42:10 -0400
Received: (qmail 2084 invoked by uid 107); 6 Jun 2012 13:42:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jun 2012 09:42:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jun 2012 09:42:07 -0400
Content-Disposition: inline
In-Reply-To: <1338926312-4239-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199330>

On Tue, Jun 05, 2012 at 12:58:30PM -0700, Junio C Hamano wrote:

> This two-patch series further loosens the definition by considering
> that an annotated but unsigned tag can be fast-forwarded as long as
> it points at a commit that can be fast-forwarded to.  So
> 
>         $ git merge anno
>         $ git merge --ff anno
> 
> will now fast-forward (note that this will *not* happen for signed
> tags).
> 
> I find this change somewhat iffy myself, as we are encouraging
> people to lose information (i.e. the contents of the annotated tag
> is no longer recorded in the history) and some may see it as a
> regression in the post 1.7.10 world because of that.
> 
> But since I've written it already, I thought it might be worth
> showing it to the list for discussion, if only to publicly reject
> the idea ;-).

It has been nearly a day, and nobody has publicly rejected it. So I will
do so. :)

This just doesn't make sense to me. Why would we treat annotated but
unsigned tags differently from signed tags? In both cases, the new
behavior is keeping more information about what happened, which is
generally a good thing.

I haven't seen any good argument against creating these merges[1]. But
even if there was one, I don't think "signed versus unsigned" is
necessarily the right distinguishing feature. It is probably more about
per-project or per-user preferences (e.g., "my project does not want too
many merges, because it makes our history less pretty"). And in that
case, something like a config flag would be a better option (not that I
am not saying that such a flag is a good idea, only that it might be
less bad than this).

-Peff

[1] From the tone of your message, I think you are not the right person
    to be arguing that side, anyway. It sounds as though you are not all
    that invested in this series. :)
