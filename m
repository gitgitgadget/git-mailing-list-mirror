From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Mon, 17 Dec 2012 14:43:59 +0100
Message-ID: <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
	<7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
	<20121212094432.6e1e48c8@chalon.bertin.fr>
	<7v38zb3ux0.fsf@alter.siamese.dyndns.org>
	<877goht6eu.fsf@pctrast.inf.ethz.ch>
	<20121217114058.449cbc3c@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Dec 17 14:44:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkazU-000468-78
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 14:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab2LQNoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 08:44:01 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:43247 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab2LQNoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 08:44:00 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so2723683wey.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 05:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z2YEEsMEeWHpi1OHhBcpydDDWins7m1QQjXtCA+5xSU=;
        b=gAiXbo0dmTMtaFp4fMPp97UWnO2/mj4JvI4XWYEP8/a9KLbDVs3Lm1J1YMoBLN19Aa
         VHvBGmyIqVp8h8ry4+1N0sb0XysyX0onrgnhwxBwmjDLOKuGDR625tXf2Y90yr6JRPYh
         nPV28jayh7GAh1pOzz23DR8KSEYtj3/qPWiG5hXgiyNEWyhwKxCasn8sigsTqrDSA4Zb
         1EgbBTqZ8iVDEmfr4btOnJ64jwNHN9QpkNMbmwnMDs7lZ7ntYubfCRFXjSzzpafkdFhf
         eJoj0/bw+O66bXrr8jclzH9LSXo4VfpLmmn+BVTjddpdmTP3rii0ONixZQ5SxbOGlpId
         HcUg==
Received: by 10.194.9.162 with SMTP id a2mr17117785wjb.33.1355751839347; Mon,
 17 Dec 2012 05:43:59 -0800 (PST)
Received: by 10.194.42.8 with HTTP; Mon, 17 Dec 2012 05:43:59 -0800 (PST)
In-Reply-To: <20121217114058.449cbc3c@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211684>

Hi Yann,

On Mon, Dec 17, 2012 at 11:40 AM, Yann Dirson <dirson@bertin.fr> wrote:
> On Mon, 17 Dec 2012 09:43:53 +0100
> Thomas Rast <trast@student.ethz.ch> wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>
>> I suppose there's the additional issue that grafts are much easier to
>> use than replacements if you really only want to replace some parent
>> lists.  With replace you need to handcraft the replacement commits, and
>> git-replace(1) unhelpfully does not say this, much less gives an example
>> how to do it.
>>
>
> Right, replace refs can surely be made easier to use.  The requirement to craft a
> new commit manually is a major step back in ease of use.

Yeah, at one point I wanted to have a command that created to craft a
new commit based on an existing one.
Perhaps it could be useful when using filter-branch or perhaps it
could reuse some filter-branch code.

> Maybe something like "git replace -p <orig-commit> <parent>..." to just provide a simple
> API to the exact graft functionnality would be good.  But it would be commit-specific, whereas
> replace refs are indeed more generic, and, one could want to rewrite any other part of the commit,
> so we could prefer a more general mechanism.

Yeah I wondered at one point if something like the following would do:

git replace --parent <parent1> --parent <parent2> --author <author>
--commiter <commiter> ... <orig-commit>

> Something that could be useful in this respect, would be an --amend like option to git-commit, like
> "git commit --replace".  But unfortunately it does not allow to change parents, and it has the
> drawback of requiring that HEAD points to the commit to be replaced.
>
> So maybe, if there are no other idea, a simple "git graft" command that would wrap "git replace",
> would fill the gap.

It would not be straightforward to call it "graft" if it uses git replace.

Best,
Christian.
