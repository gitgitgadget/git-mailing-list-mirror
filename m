From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Mon, 1 Dec 2008 21:41:53 -0500
Message-ID: <ee2a733e0812011841l73fc046dra6434340702fc282@mail.gmail.com>
References: <20081107220730.GA15942@coredump.intra.peff.net>
	 <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
	 <20081108142756.GC17100@coredump.intra.peff.net>
	 <ee2a733e0812011822r4cef6a44ra68d6e84f9e30a90@mail.gmail.com>
	 <7vtz9npawn.fsf@gitster.siamese.dyndns.org>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Sam Vilain" <sam@vilain.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:43:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7LEH-000789-0D
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbYLBCl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbYLBCl4
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:41:56 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:41773 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbYLBClz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:41:55 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1989567fgg.17
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 18:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NOlHt2Hw8wp6zdyDGBv0IFlIJ8g7OlusvULmTNLNg30=;
        b=WTtnvnmh5ra6a55uP3lSR2c8O+INBkXTsmFEU6n5OZpDZ5hfRslVUphnCvdkrria+G
         sOyMzCpSTmidAr6EXIiAAkZLyhKw9QfykEeIBbZknnZFTzIxMychfHIGv+2holcYpoyQ
         9d1meVLHMkByN03f7h/C2xW/3SAF85/frgfMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=p0MEcorW4DAlP0cbqUmGZXiLcH8CzW38cqXl3MmRLVBa2TE7MbBcF4GQwgXi0y7vuw
         B+0r4teGtJYpXlU2eEPehwNH17hRUiGPyRNABlhvB6a/xG8xWjY0OL4AaqzB0JDVPDO4
         aw3BmVjG8aiefss8pQfW1bv+3ZXCStiXodLdk=
Received: by 10.181.221.15 with SMTP id y15mr4114767bkq.121.1228185713555;
        Mon, 01 Dec 2008 18:41:53 -0800 (PST)
Received: by 10.181.7.8 with HTTP; Mon, 1 Dec 2008 18:41:53 -0800 (PST)
In-Reply-To: <7vtz9npawn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102111>

On 12/1/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Leo Razoumov" <slonik.az@gmail.com> writes:
>
>  > On 11/8/08, Jeff King <peff@peff.net> wrote:
>  >> On Fri, Nov 07, 2008 at 03:16:53PM -0800, Junio C Hamano wrote:
>  >>
>  >>  > > The FAQ even says "don't do this until you know what you are doing." So
>  >>  > > the safety valve is configurable, so that those who know what they are
>  >>  > > doing can switch it off.
>  >>  >
>  >>  > "We are breaking your existing working setup but you can add a new
>  >>  > configuration to unbreak it" should not be done lightly.  I think as the
>  >>  > end result it is a reasonable thing to aim for for this particular
>  >>  > feature, but we do need a transition plan patch in between that introduces
>  >>  > a step that warns but not forbids.  We can ship 1.6.1 with it and then
>  >>  > switch the default to forbid in 1.6.3, for example.
>  >>
>  >>
>  >> Yeah, I was kind of hoping we could assume that anybody relying on this
>  >>  behavior was somewhat insane, and wouldn't be too upset when it broke.
>  >
>  > I do not think that having a work-flow different from yours deserves a
>  > "somewhat insane" label. But let us consider the consequences of
>  > banning push into a (current branch) non-bare repo. To propagate
>  > changes to such a non-bare repo there are two remaining alternatives
>  > neither of which is fully satisfactory:
>  >
>  > (1) Switch target's current branch to something else (prevent a
>  > conflict) before pushing and then restore it back after the push
>  >
>  > (2) Use git-fetch from the target.
>
>
> (3) set the config in the target repository to allow such a push
>     regardless of the git version.
>
>  Remember, I am in the third camp in this topic myself.

Junio,
thanks for supporting the "third way". I am not sure whether I
interpret it correctly but in the same thread several message earlier
you wrote "We can ship 1.6.1 with it and then switch the default to
forbid in 1.6.3, for example". With the default set to "deny" it would
be useful if the git-push error message will indicate what config
variable to set in order to reverse the denial.

--Leo--
