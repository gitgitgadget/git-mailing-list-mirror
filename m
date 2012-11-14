From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Thu, 15 Nov 2012 00:43:45 +0100
Message-ID: <CAB9Jk9CoCAnWtWGPXBq_rNKrdUBgxEcdu3ySzaG-XDnkJn=BvA@mail.gmail.com>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
	<7v4nktdwtp.fsf@alter.siamese.dyndns.org>
	<CAEUsAPYvrR6WsVWCvwoEWA21gzL6Sib0sTyx-c_2tH=8ni69yQ@mail.gmail.com>
	<CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com>
	<7v390ccoak.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9DAwaLw2bTqj5x_zxRcFqn7s=nmGi=Jc_SD38vFoszBZg@mail.gmail.com>
	<7vmwykay4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Rorvick <chris@rorvick.com>, git <git@vger.kernel.org>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 00:44:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYmci-0000Yq-9N
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 00:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab2KNXnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 18:43:46 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58508 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab2KNXnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 18:43:45 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so659134pad.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 15:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PPBg89/+T1aa4nqQQ4ot97raN6JW+mwgsOuhspuvqvo=;
        b=JEZbAB5oB+g2WxegIpaMaGHtmSArcBQ0r6oGFj9CKhhmKgr7qU/UI9u2OYxNW3KO9E
         A5+OMgMoMhDYIiNP37yNSPzjf41H1eGluY/UfiSfbGY6sWSer7UxyHRtu6b5ER3c/5JD
         AfTSMuGB8U+mMplHxlU4LMeyx18KMdOQByTv/LcQPGe0MZz7UGXm7TsOnJwBDLCTfVsa
         4P17WRmO1CxpeApIXMHc7A2aCP97Hc+gjN2Je5JHmJnfC1aAeUapGRUe2fMvy0y/2h1B
         5HbJRCbHPa6yYeUa+KSLgarqYBHXm0R6G/hlHUSXLVKZvqh5Ky8Pfkfxqrg57Ru933bQ
         HWRA==
Received: by 10.68.131.8 with SMTP id oi8mr82690595pbb.29.1352936625214; Wed,
 14 Nov 2012 15:43:45 -0800 (PST)
Received: by 10.67.3.101 with HTTP; Wed, 14 Nov 2012 15:43:45 -0800 (PST)
In-Reply-To: <7vmwykay4n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209759>

Hi Junio,

> That is an independent issue of deciding to accept or reject
> receiving a push from outside, no?

Yes, it is. Actually I thought some means to let the owner do decide
what to accept were already present (the pushNonFastForward config
key), and going along this avenue I thought it could be appropriate to
extent this a bit.

-Angelo

On 14 November 2012 18:32, Junio C Hamano <gitster@pobox.com> wrote:
> Angelo Borsotti <angelo.borsotti@gmail.com> writes:
>
>> actually, I proposed to add a key in config files, e.g.
>> pushTagsNoChange to be set in the remote repo do disallow changes to
>> tags, similar to pushNonFastForward that disallows non-fastforward
>> changes to branches. I still have the impression that this is simple
>> and clear, and allows the owner of the remote repository to enforce
>> the policy s/he wants on her/his repository.
>
> That is an independent issue of deciding to accept or reject
> receiving a push from outside, no?  You can implement any such
> policy in the pre-receive hook on the receiving end with a simple
> and clear manner, instead of adding specific logic to enforce a
> single hardcoded policy to the code that is flipped on with a
> configuration variable.
>
> In any case, I thought this series was about users who run "push"
> voluntarily stopping themselves from pushing updates to tags that
> may happen to fast-forward, so if we were to go with the
> configuration route, the suggestion would be more like
>
>     [push]
>         updateNeedsForce = refs/tags/:refs/frotz/
>
> or perhaps
>
>     [remote "origin"]
>         updateNeedsForce = refs/tags/:refs/frotz/
>
> if we want to configure it per-remote, to specify that you would
> need to say "--force" to update the refs in the listed hierarchies.
>
> Then your patch series could become just the matter of declaring
> that the value of push.updateNeedsForce, when unspecified, defaults
> to "refs/tags/".
>
