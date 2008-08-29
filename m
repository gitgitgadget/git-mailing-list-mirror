From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3] Expand ~ and ~user in core.excludesfile, commit.template
Date: Fri, 29 Aug 2008 09:00:45 +0200
Message-ID: <48B79E9D.9000308@viscovery.net>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>	<7vsksw92nh.fsf@gitster.siamese.dyndns.org>	<quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>	<7vprnyqo59.fsf@gitster.siamese.dyndns.org>	<20080824220854.GA27299@coredump.intra.peff.net>	<7vzln2j9y2.fsf@gitster.siamese.dyndns.org>	<20080824231343.GC27619@coredump.intra.peff.net>	<7vhc9aj82i.fsf@gitster.siamese.dyndns.org>	<quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>	<20080827002506.GB7347@coredump.intra.peff.net>	<quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu>	<7vy72jrr00.fsf@gitster.siamese.dyndns.org> <quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Aug 29 09:02:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYxzW-000860-KZ
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 09:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbYH2HAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 03:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbYH2HAu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 03:00:50 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:32084 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYH2HAt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 03:00:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KYxyP-0005Wr-Qz; Fri, 29 Aug 2008 09:00:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8AE1E6EF; Fri, 29 Aug 2008 09:00:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karl Chen schrieb:
> +		const char *after_username = strchr_or_end(path+1, '/');

Use strchrnul() instead of a home-grown strchr_or_end().

> +		struct passwd *pw = getpw_strspan(path+1, after_username);
> +		if (!pw) return NULL;
> +		return concatstr(buf, pw->pw_dir, after_username, sz);

You really should use the strbuf API here. Look for strbuf_detach() in the
existing code.

-- Hannes
