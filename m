From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] tests: set temp variables using 'env' in test
 function instead of subshell
Date: Tue, 18 Mar 2014 19:06:58 -0400
Message-ID: <20140318230658.GA10679@sigill.intra.peff.net>
References: <244284@gmane.comp.version-control.git>
 <1395144518-2489-1-git-send-email-unsignedzero@gmail.com>
 <xmqqd2hj6y5o.fsf@gitster.dls.corp.google.com>
 <20140318214536.GA10076@sigill.intra.peff.net>
 <xmqqy5075f0k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 00:07:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ36v-00005B-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 00:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758271AbaCRXHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 19:07:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:42204 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757315AbaCRXHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 19:07:00 -0400
Received: (qmail 16202 invoked by uid 102); 18 Mar 2014 23:07:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Mar 2014 18:07:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Mar 2014 19:06:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy5075f0k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244393>

On Tue, Mar 18, 2014 at 03:16:27PM -0700, Junio C Hamano wrote:

> > Isn't GIT_CONFIG here another way of saying:
> >
> >   test_must_fail git config -f doesnotexist --list
> >
> > Perhaps that is shorter and more readable still (and there are a few
> > similar cases in this patch.
> 
> Surely, but are we assuming that "git config" correctly honors the
> equivalence between GIT_CONFIG=file and -f file, or is that also
> something we are testing in these tests?

I think we can assume that they are equivalent, and it is not worth
testing (and they are equivalent in code since 270a344 (config: stop
using config_exclusive_filename, 2012-02-16).

My recollection is that GIT_CONFIG mostly exists as a historical
footnote. Recall that at one time it affected all commands, but that had
many problems and was done away with in dc87183 (Only use GIT_CONFIG in
"git config", not other programs, 2008-06-30). I think we left it in
place for git-config mostly for backward compatibility, but I didn't see
that point explicitly addressed in the list discussion (the main issue
was that setting it for things besides "git config" is a bad idea, as it
suppresses ~/.gitconfig).

-Peff
