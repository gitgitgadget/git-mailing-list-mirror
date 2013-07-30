From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] config: --get-urlmatch
Date: Tue, 30 Jul 2013 01:14:13 -0700
Message-ID: <20130730081413.GC16693@sigill.intra.peff.net>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
 <1375138150-19520-1-git-send-email-gitster@pobox.com>
 <1375138150-19520-4-git-send-email-gitster@pobox.com>
 <20130730003716.GA13114@sigill.intra.peff.net>
 <7vbo5kzv9k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 10:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V454c-0007qm-90
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 10:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017Ab3G3IOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 04:14:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:36210 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450Ab3G3IOR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 04:14:17 -0400
Received: (qmail 18758 invoked by uid 102); 30 Jul 2013 08:14:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Jul 2013 03:14:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jul 2013 01:14:13 -0700
Content-Disposition: inline
In-Reply-To: <7vbo5kzv9k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231351>

On Mon, Jul 29, 2013 at 06:33:43PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> +struct urlmatch_item {
> >> +	size_t max_matched_len;
> >> +	char user_matched;
> >> +	char value_is_null;
> >> +	struct strbuf value;
> >> +};
> >
> > I think you ultimately want such a string_list for matching arbitrary
> > numbers of keys, but do you need it for the git-config case?
> 
> "git config" does not know the semantics of each key, nor available
> set of keys, no?  The string-list is only to support
> 
>     git config --get-urlmatch http http://www.google.com/
> 
> i.e. "list everything under http.* hierarchy".

Ah, I missed that you could leave "key" empty. I had expected
collect->key to be filled in, at which point you only ever have one such
key (and you do not need to know the semantics, only which one is the
"winner").

-Peff
