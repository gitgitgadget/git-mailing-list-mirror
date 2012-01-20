From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH] t/Makefile: Use $(sort ...) explicitly where needed
Date: Fri, 20 Jan 2012 11:19:36 +0400
Organization: St.Petersburg State University
Message-ID: <20120120071936.GA22112@mini.zxlink>
References: <1327004244-18892-1-git-send-email-kirr@navytux.spb.ru>
 <7v8vl3ic6o.fsf@alter.siamese.dyndns.org>
 <20120120063450.GA15371@mini.zxlink>
 <7vbopyhmlx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@navytux.spb.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 08:18:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro8kG-0000t2-3R
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab2ATHSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 02:18:39 -0500
Received: from forward4.mail.yandex.net ([77.88.46.9]:49971 "EHLO
	forward4.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab2ATHSi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 02:18:38 -0500
Received: from smtp2.mail.yandex.net (smtp2.mail.yandex.net [77.88.46.102])
	by forward4.mail.yandex.net (Yandex) with ESMTP id 0C3DB50267B;
	Fri, 20 Jan 2012 11:18:36 +0400 (MSK)
Received: from smtp2.mail.yandex.net (localhost [127.0.0.1])
	by smtp2.mail.yandex.net (Yandex) with ESMTP id E107FE203A2;
	Fri, 20 Jan 2012 11:18:35 +0400 (MSK)
Received: from unknown (unknown [83.171.93.225])
	by smtp2.mail.yandex.net (nwsmtp/Yandex) with ESMTP id IZQGcYul-IZQSTfE3;
	Fri, 20 Jan 2012 11:18:35 +0400
X-Yandex-Spam: 1
Received: from kirr by mini.zxlink with local (Exim 4.77)
	(envelope-from <kirr@mini.zxlink>)
	id 1Ro8l6-0005rl-JA; Fri, 20 Jan 2012 11:19:36 +0400
Content-Disposition: inline
In-Reply-To: <7vbopyhmlx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188860>

On Thu, Jan 19, 2012 at 11:14:18PM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
> 
> >> I do not necessarily buy your "so we HAVE TO, OR ELSE".
> >> 
> >> Even though I can understand "We can sort the list of tests _if_ we do not
> >> want them executed in seemingly random order when running 'make -j1'", I
> >> tend to think that *if* is a big one.  Aren't these tests designed not to
> >> depend on each other anyway?
> >
> > Yes, they don't depend on each other, but what's the point in not
> > sorting them? I usually watch test progress visually, and if tests are
> > sorted, even with make -j4 they go more or less incrementally by their t
> > number.
> >
> > On my netbook, adding $(sort ...) adds approximately 0.008s to make
> > startup, so imho there is no performance penalty to adding that sort.
> 
> Heh, who said anything about performance?
> 
> I was pointing out that your justification "we HAVE TO" was wrong.
> 
> If you are doing this for perceived prettyness and not as a fix for any
> correctness issue, I want to see the patch honestly described as such;
> that's all.

I agree about rewording.


> By the way, if I recall correctly, $(sort) in GNU make not just sorts but
> as a nice side effect removes duplicates. So if we used a(n fictional)
> construct in our Makefile like this:
> 
>     T = $(wildcard *.sh a.*)
> 
> that might produce duplicates (i.e. "a.sh" might appear twice), which
> might leave us two identical pathnames in $T and cause us trouble.  Even
> if we do not have such a use currently, rewriting $(wildcard) like your
> patch does using $(sort $(wildcard ...)) may be a good way to future-proof
> our Makefile, and if you justify your patch that way, it would be a
> possible correctness hardening, not just cosmetics, and phrasing it with
> "HAVE TO" may be justifiable.
> 
> Care to try if $(wildcard *.sh a.*) give you duplicated output with newer
> GNU make? I am lazy but am a bit curious ;-)

Sure. Please give me time untill evening (GMT+0400), or maybe till the
weekend.


Kirill
