From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: howto handle name clashes
Date: Sat, 24 Mar 2012 01:19:59 +0100
Message-ID: <4F6D132F.6020504@tu-clausthal.de>
References: <4F6C7539.3080607@tu-clausthal.de> <20120323171219.GB12881@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 01:20:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBEiA-0003li-Vi
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 01:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab2CXAT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 20:19:57 -0400
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:32008 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932167Ab2CXAT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2012 20:19:56 -0400
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id B0DEA27B0A8;
	Sat, 24 Mar 2012 01:19:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=j8TanBy8o/SLSZCCCSxii4Orsd8=; b=X6aq5iUMiy4UilKqhXXRkJF09E+H
	GmA+JTtfz+NEa1yOcECAC4yLnMhAFXPh9OYs7Ahj/rTpszad36GhN8EV4eJRFx1R
	OHOe0P0ENBfXyLDy4+2jfZl5+Qegbz2JsytESfKeJ8fgv/t19QPaGtwMxsIwct67
	zt7RFLocfjeJo2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=7gKDFKTSo5wrAcg416SlNimw0/2C039zxcNI/LFgn7Pv4RBXiB/QLF4
	FL+LDQso+FHpnDuLEMR/LmCmeSSPKeYlnxFkvk8Gzls4pvgTghrOzvlVqy1QqMJ7
	FBiV2KSmy/BNFMCg/gLD5kCCc8KnajVyRzMP9Yr0tD7QdKK9tNP4=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 7C80D27B0A7;
	Sat, 24 Mar 2012 01:19:53 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 29795338; Sat, 24 Mar 2012 01:19:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <20120323171219.GB12881@sigill.intra.peff.net>
X-Enigmail-Version: 1.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, BODY_SIZE_700_799 0, CT_TEXT_PLAIN_UTF8_CAPS 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193814>

Am 23.03.2012 18:12 schrieb Jeff King:
>> - how to drop a remote tag/branch ("git push origin :test" does not
>> work)
>
> Does "git push origin :heads/foo" (or :tags/foo) not work?

well, ":heads/foo" does not work. Imagine I want to drop a remote branch
which is ambiguous (e.g. a tag with same name exists) on the repository:

"git push origin :food"

gives me: "error: dst refspec food matches more than one."

However, deleting the remote tag (:tags/foo) works with your suggestion.

"git push origin :refs/remotes/origin/foo" showed success (and warning
"remote: warning: Allowing deletion of corrupt ref."), but did not work.

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
