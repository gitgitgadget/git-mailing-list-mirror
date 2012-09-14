From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH RFC 0/2] Mixing English and a local language
Date: Fri, 14 Sep 2012 12:41:48 +0200
Message-ID: <505309EC.8040400@drmicha.warpmail.net>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com> <CACsJy8CG72PzvndV7C4a9hspxhprKn2tcb49HxeZ14pmEDycGQ@mail.gmail.com> <7vligfcdgh.fsf@alter.siamese.dyndns.org> <20120913132847.GD4287@sigill.intra.peff.net> <7v4nn1akz7.fsf@alter.siamese.dyndns.org> <20120913180056.GA1696@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 12:42:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCTLU-0004ks-W4
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 12:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404Ab2INKlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 06:41:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47561 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751275Ab2INKlu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 06:41:50 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 232AD20645;
	Fri, 14 Sep 2012 06:41:50 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 14 Sep 2012 06:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=pg+my2xs2nxXxGSxQp77yh
	IOi50=; b=VqnAp9ma+7MatN5kpfycv+2mf/FIvlt9bBOXcWh6riEaa33TpNapkt
	wdwAvLbM1k94RhvNSKEmHn4fERciqZZ73SzgYvQJLc6FNBL3cwzhwbW42gyaktvg
	9Jhi8th1smOKuSPjA0tfQ2emL1iOqoS5klGOEXS3nzZREpg4IJPXs=
X-Sasl-enc: yBaLEhmAw61OVAd88/7kuGdUMRMJDdMMJkPBmxVX2fKP 1347619309
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 612A28E03D5;
	Fri, 14 Sep 2012 06:41:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <20120913180056.GA1696@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205479>

Jeff King venit, vidit, dixit 13.09.2012 20:00:
> On Thu, Sep 13, 2012 at 10:30:52AM -0700, Junio C Hamano wrote:
> 
>>>      But it should not be per-command, but per-message, and
>>>      should include all output that is not diagnostic and is not
>>>      machine-parseable (e.g., what I mentioned above, request-pull
>>>      output, etc). If it is the project's language, then the team
>>>      members will need to know it anyway, so it should not be too big a
>>>      burden to have a potentially different language there than in the
>>>      diagnostic messages.
>>
>> No matter what the project languages is, machine parseable part will
>> not be localized but fixed to "C" anyway, so I do not think it comes
>> into the picture.
> 
> But there are parts that are neither machine-parseable nor diagnostics.
> The diffstat is one, but I mentioned others. Are those going to be
> forever fixed to LANG=C?
> 
> That does not bother me, but for a project whose team works entirely in
> Japanese (both individually, and when sharing code), they will still be
> stuck with these English-language snippets, and no way to localize them.
> Even though they may not speak a word of it.
> 
> I have no idea if such a team is a strawman or not; that is why I
> separated points 1 and 2. We can wait on point 2 until such a team shows
> up and complains (of course, they would have to come here and complain
> in English, so...).
> 
>> My take on this is, if there is the project language, it should
>> apply to _everything_.  Please do not introduce any per-command,
>> per-message, per-anything mess.  Just set LANG/LC_ALL up and be done
>> with it.
> 
> But isn't that arguing for localizing diffstat? It is not
> machine-parseable, so an all-Japanese team would want to localize it
> along with their diagnostics.
> 
> -Peff
> 

The basic assumption is that we have people who are proficient in at
least 2 languages. In fact, the initial i18n efforts were targeted at
people who are much more comfortable in their $LANG than with LANG=C.
For this category, being able to localize everything(*) is important.
They will mostly work with $LANG projects. I don't think they're strawmen.

For those proficient in 2 languages it's desirable to switch per project
because it's likely they participate in projects with different $LANG
preferences. Again, that means localizing everything(*). Additionally,
setting core.i18n in global config is probably the better choice
(compared to NO_GETTEXT=y) for those who are frustrated by git's
translation in their usual $LANG.

[git svn should pass that LANG to svn also etc.]

The question is whether we have people who prefer to work with git in
their $LANG even though project interaction requires a different
language. They would probably run log/gitk/commit... in their $LANG but
need format-patch and the like in project-lang.

I do think we have people in this category here on the list, so they
should speak up ;) Could they alias their format-patch to use "-c
core.i18n=C" or such? Or have <command>.i18n on top? per-command config
again ;)

Michael
