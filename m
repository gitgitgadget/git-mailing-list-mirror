From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parseopt: do not translate empty help string
Date: Mon, 20 Aug 2012 15:08:23 -0700
Message-ID: <7vvcgdi5d4.fsf@alter.siamese.dyndns.org>
References: <bcb1f4437760452f967737fddf26dff019d0f0b2.1345487066.git.trast@student.ethz.ch> <7vboi5jrn1.fsf@alter.siamese.dyndns.org> <87obm5jpdy.fsf@thomas.inf.ethz.ch> <7vzk5pi5jn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 21 00:08:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3a9B-0002DP-3G
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 00:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab2HTWI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 18:08:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755799Ab2HTWI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 18:08:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9611A8B51;
	Mon, 20 Aug 2012 18:08:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G61oaRXKH8LdZ6WH4wLpnWBB0Fc=; b=ui4T6r
	ZEebJuN02QUtrQ8vYU+6HSnlfXGWYF9fiqCq6MBQfbmvu7lvpSdMnwKFRVbb8e2d
	PWixVZGU+SMgFt4tCmLeSLuX+IFBd4y/iwqbRZvbUtE0iMNcle0FcOwdU42N9mii
	EgCqOBLBHnIrqbpwITDYQcw6ks6Um/nGd4s4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cRXEJpvsIsKt59lUz4adcUPoJdF5evYJ
	+GJk8e7379ZeSU81OYw7VDVqzlRwjqm7LF1px1wiBDO2hFb1dT3Z4283Jy+6B7/+
	h++nCSTDncFEEdC2l8tTo/2D9MJ5k5tYD+j7tr2A8VesToGnqqETv5mXv65uIh1G
	ZImbHffirhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81D218B50;
	Mon, 20 Aug 2012 18:08:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDF708B4F; Mon, 20 Aug 2012
 18:08:24 -0400 (EDT)
In-Reply-To: <7vzk5pi5jn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 20 Aug 2012 15:04:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FE96D00-EB13-11E1-AD0A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203900>

Junio C Hamano <gitster@pobox.com> writes:

>> Oh, I forgot that we actually had a wrapper instead of the usual _.
>> Yes, I think that would be the better solution to guard against this.
>
> OK, then let's replace the patch text of your commit ;-).

He, we need to update the log message a bit, too.

-- >8 --
From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] gettext: do not translate empty string

The gettext .po files have a header, but it looks like the translation
specification for an empty string.  This results in _("") actually
returning that header.

Prevent us from passing empty strings to gettext.  In some places,
we run _(opts->help) where opts->help may be an empty string.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gettext.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gettext.h b/gettext.h
index 57ba8bb..376297b 100644
--- a/gettext.h
+++ b/gettext.h
@@ -44,6 +44,8 @@ extern int use_gettext_poison(void);
 
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
+	if (!*msgid)
+		return "";
 	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
 }
 
-- 
1.7.12.124.ga484625
