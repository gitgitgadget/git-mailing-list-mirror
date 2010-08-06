From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC] struct *_struct
Date: Fri, 06 Aug 2010 11:28:23 +0900
Message-ID: <87y6ckiiew.fsf@catnip.gol.com>
References: <20100804150843.GA2762@localhost.localdomain>
	<7vaap2fafm.fsf@alter.siamese.dyndns.org>
	<AANLkTin_6gaYF++N2GBgDsedfo7mY7yG5H99=-DxCa5E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 04:28:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhCfr-00047d-BL
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 04:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935331Ab0HFC2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 22:28:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:44015 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935327Ab0HFC2f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 22:28:35 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OhCfg-00044z-U5
	for git@vger.kernel.org; Fri, 06 Aug 2010 04:28:32 +0200
Received: from 218.231.154.125.eo.eaccess.ne.jp ([218.231.154.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 04:28:32 +0200
Received: from miles by 218.231.154.125.eo.eaccess.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 04:28:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 218.231.154.125.eo.eaccess.ne.jp
System-Type: x86_64-unknown-linux-gnu
Cancel-Lock: sha1:CCU9KkQtyAjQvo97LFfvDR+KmrE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152744>

Michael Witten <mfwitten@gmail.com> writes:
> On Wed, Aug 4, 2010 at 14:24, Junio C Hamano <gitster@pobox.com> wrote:
>> I hate... "typedef foo struct foo"
>
> How come?

There is a practical issue in that "struct foo *" can be used with just
a forward declaration (or no declaration at all), whereas "foo *"
requires the declaration of foo be visible.  This is especially handy
given C's use of #include, because in cases where there are circular
type references, it can be very annoying to get things #included in the
right order; being able to use a forward declaration instead of #include
makes it easy to break such loops.  One can still use "struct foo *"
even if there are typedefs, of course, but that breaks the illusion that
"foo" is an abstract type, and I gather that illusion is one reason
people like the typedefs in the first place.

But I think mainly it's an issue of style/culture:

Some codebases use "typedef style" (obviously those in C++, since the
typedefs are automatically), and in those codebases programmers will
naturally choose typenames that are more distinct (e.g., the common
convention of using StudlyCaps for types).  Some codebases use "struct
style" (in C programs I think this is more common, as C-programming
culture tends to value explicitness and simplicity).

One should use follow whatever style is common in the codebase one is
working on.  If git uses "struct foo" generally, new code should use
"struct bar".

-miles

-- 
Arrest, v. Formally to detain one accused of unusualness.
