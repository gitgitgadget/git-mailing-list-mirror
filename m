From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: organizing multiple repositories with dependencies
Date: Wed, 18 Apr 2012 14:19:35 +0200
Message-ID: <4F8EB157.5060707@web.de>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com> <m3hawjagw9.fsf@localhost.localdomain> <nng3983phhc.fsf@transit.us.cray.com> <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com> <201204171837.q3HIbbcW013784@no.baka.org> <CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com> <nng1unmnksx.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, greened@obbligato.org
To: dag@cray.com
X-From: git-owner@vger.kernel.org Wed Apr 18 14:19:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKTrS-0003vi-Iv
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 14:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab2DRMTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 08:19:44 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:51290 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab2DRMTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 08:19:44 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate04.web.de (Postfix) with ESMTP id CD30576338E2
	for <git@vger.kernel.org>; Wed, 18 Apr 2012 14:19:37 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.175.87]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LlnMG-1Rl96d3DYe-00ZMbk; Wed, 18 Apr 2012 14:19:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <nng1unmnksx.fsf@transit.us.cray.com>
X-Provags-ID: V02:K0:qG6MCYQJHjg3k6SeF6fbZGwU2tvMgbG+o80mZVxkTxy
 Tu6DC+9tODTDI9hCoaSTo66gRdjDcT/iQUwPvcW/J13B3QYerv
 U48/T3odu2mLAn/QjpovuAsfLmX8vI+gyqLYQ2b2Gk9wsS08+b
 j/E/hM6FMicAHTfnx+u6hGQJvity66zKRkjisKHqfdGemMQMKi
 o6e1LS1sKBZAwhHpanYtA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195862>

Am 17.04.2012 22:51, schrieb dag@cray.com:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
> 
>> If you work on a subproject (in its own repo) then a subsequent pull
>> in the umbrella project should bring this new code into the umbrella
>> project (assuming that would make sense given the branches involved).
> 
> I don't necessarily think this is always what should happen.

I agree, the reason that we have three different implementations of
subproject support is that there is no model that fits all work flows.

>  I can't
> comment on git-submodule since I haven't used it in its more recent
> incarnation, but one thing I like about git-subtree is that it's
> explicit.  I have to do a "git subtree pull" on the umbrella project to
> pull in the new changes from a subproject.  That gives me some degree of
> control over when to update sources.  I suspect one can do the same by
> using "git pull" in submodule directories.

It's explicit too when using submodules, you can update each submodule
to the commit you want, review and test that and then decide if you want
to commit that (or e.g. it's parent) in the superproject or just rewind
the submodule because the new changes don't work for you. For a lot of
use cases an automatic pull of changes you haven't even seen yet and
then automatically promote them to the superproject (which is how I
understand "git subtree pull", but I might be wrong) is undesirable, for
others it might very well work.

> Perhaps a good way to go would be to provide the basic operations (I
> think we have most of that) and some hooks in contrib/ or elsewere to
> implement various models.  Just like git imposes no particular workflow
> model I don't think git should impose one particular aggregation model.
> What we do need is better documentation of what the various models and
> tools are.  For example, I would find a subtree/submodule comparison
> highly valuable.  It would help people decide which model is best for
> them.

I agree and am willing to provide information about submodule use cases,
advantages and problems, but I'm not a user of subtree so I can't really
comment on it. Now that subtree is in git core, what about putting such
a comparison under Documentation/subproject-support.txt?
