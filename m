From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Thu, 6 Mar 2008 08:16:28 +0600
Message-ID: <7bfdc29a0803051816r752d3027yff83a78e1769216a@mail.gmail.com>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
	 <7vd4q8kbey.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803051754o4b45222es524a62a7cac50b94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 03:17:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX5fc-0007kR-5H
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 03:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbYCFCQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 21:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbYCFCQe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 21:16:34 -0500
Received: from hu-out-0506.google.com ([72.14.214.226]:33975 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbYCFCQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 21:16:33 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1171991hue.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 18:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ooODxcBUyqtlCSLNdr6RrxNEc5pCPNaXUfIjbw042UE=;
        b=L2LNSO70NedjO5zBwwVklTVWdYQgslNWwTQbIC1OndyhX9Voc7nUwu5F7y0ulxWd22DSfNcuEdVF+krwE5An1bfoDwimRTcqYUseEqFoVSYyl+ATZ/SRBv9oEux4Hc41eVMC7njDfir/q5pSufPpAxI7e+uyVoMTmRqE03Ffj6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pTfjUe+1YfbCmqP8Dqr1uKmzxHAknyD62ZDdkDNhe9XJG0lo/9jiL9KYmHnbWTZOtu4u+Vsa8Ec2O2ZTJpgLpkv1BNVhx3WUZrsEM+nkoPJOteHh9Hu5i+cJ1uyklV52/DM6XfN7vvyRMQKB9M8eG1I3hxGyv/qexParnVLbAYc=
Received: by 10.78.139.14 with SMTP id m14mr8718321hud.76.1204769788645;
        Wed, 05 Mar 2008 18:16:28 -0800 (PST)
Received: by 10.78.75.8 with HTTP; Wed, 5 Mar 2008 18:16:28 -0800 (PST)
In-Reply-To: <46dff0320803051754o4b45222es524a62a7cac50b94@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76309>

On Thu, Mar 6, 2008 at 7:54 AM, Ping Yin <pkufranky@gmail.com> wrote:
>
> On Thu, Mar 6, 2008 at 7:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  > Ping Yin <pkufranky@gmail.com> writes:
>  >
>  >  > This patch allows multi-level module definition in .gitmodules as
>  >  > Linus and Sven Verdoolaege etc. have suggested in mails
>  >  > "Let .git/config specify the url for submodules"
>  >  > (http://article.gmane.org/gmane.comp.version-control.git/48939).
>  >  >
>  >  > Following shows an example of such a .gitmodules.
>  >  >
>  >  > .gitmodules with with multiple level of indirection
>  >  > ------------------------------------------------------
>  >  > [submodule "service"]
>  >  >    submodule = crawler
>  >  >    submodule = search
>  >  > ...
>  >
>  > > [submodule "util"]
>  >  >    url = git://xyzzy/util.git
>  >  > [submodule "imsearch"]
>  >  >    path = search/imsearch
>  >  >    url = git://xyzzy/imsearch.git
>  >  > [submodule "imcrawler"]
>  >  >    path = crawler/imcrawter
>  >  >    url = git://xyzzy/imcrawter.git
>  >  > ------------------------------------------------------
>  >
>  >  I would agree that allowing the user to use a short-hand to name a group
>  >  of modules the user is interested in would be a good idea, but I think
>  >  .gitmodules is a wrong place to do so.  The grouping is a user preference,
>  >  isn't it?
>  >
>  >  The place the owner of the repository (not the project) expresses which
>  >  modules are of interest, what transports she wants to use to access it,
>  >  etc. is $GIT_DIR/config, and .gitmodules is a vehicle to supply hints to
>  >  be used when the user populates that information.
>  >
>  Not always the case. In my company environment, we have many
>  submodules and have a unified hierachy of modules, and we use the same
>  transports ssh. So after top maintainer give the basic module hierachy
>  config in .gitmodules, other people needn't and even shouldn't
>  consider changing these common config. If other people have special
>  needs, they can of course edit .git/config to add new hierachy or
>  override existing ones in .gitmodules. However, it's better to put the
>  common config in .gitmodules to pass to every one.
>

I am a bit confused about why we need it as from discussion earlier we
see that there isn't much difference with the currently available
mechanism. I still do not see any advantage over the currently
available system other than having an alternate way to do a thing
already can be done.

>  I think this may not be a special requirement for my company, so
>  letting .gitmodule record the common module hierachy should be a
>  common requirement in a company environment.
>

Actually our company has a high modular structure, using maven makes
it easier to main and link modules. I would find an in place submodule
much more handy for such requirement.

>
>  --
>  Ping Yin
>
>
> --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
