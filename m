From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http: expand http.cookieFile as a path
Date: Fri, 29 Apr 2016 10:52:17 -0700
Message-ID: <xmqqbn4sz4j2.fsf@gitster.mtv.corp.google.com>
References: <20160429062357.12647-1-computersforpeace@gmail.com>
	<20160429062357.12647-2-computersforpeace@gmail.com>
	<20160429141212.GB26643@sigill.intra.peff.net>
	<20160429155532.GA57118@google.com>
	<xmqqfuu4z4pr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:52:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awCaX-0000e9-2O
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbcD2RwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:52:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751153AbcD2RwU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:52:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3BFC15893;
	Fri, 29 Apr 2016 13:52:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WZizBTR1KbGjMyK6as5ZWtpwixw=; b=ewUVQI
	/+ZK3JIEpWCHf0abd+vu67zLOYVdR/3cVdanAM6IDXsgUiGnLQwQ6Is/k68m0fUY
	U0AuxLtIz0EH48KycYU40g99Ob9Rd8Am0i63hqjgSr/CXVyEBh5GBk2BeKcqimJ2
	O5Mu8kMOo95VRUIkWYZInM1dHxwSfvwnGL5K4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jx+LiH67sb59fcdz+tIP5yfl2Wk1iFG0
	ZkOk8LJSNRK67zbfqCEly3mJ9KEixtgxF1pfSLySNu79BB8K/lanuJr+Qs81nU5h
	3gFAkLjalbGOagqcrtsZUcwXoKU5D6Z5aDVlualB2JztTK4fwZitjR5IMH3GP+Hu
	xfN6C/1Kthw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BD1715892;
	Fri, 29 Apr 2016 13:52:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F217C15890;
	Fri, 29 Apr 2016 13:52:18 -0400 (EDT)
In-Reply-To: <xmqqfuu4z4pr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 Apr 2016 10:48:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DF4376A-0E33-11E6-A7F4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293035>

Junio C Hamano <gitster@pobox.com> writes:

> Brian Norris <computersforpeace@gmail.com> writes:
>
>> I mostly just copied from boilerplate on another option. IIRC, there
>> were at least two other options that were documented similarly.
>
> My quick grep didn't find 'another option' other than include.path,
> but how about this as a preparatory step?
>
> -- >8 --
> Subject: [PATCH] config: describe 'pathname' value type

And then, after applying this either before or after your 1/2, we can
squash this into your 2/2.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 39867f5..b7d3e69 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1665,13 +1665,11 @@ http.emptyAuth::
 	authentication.
 
 http.cookieFile::
-	File containing previously stored cookie lines which should be used
+	The pathname of a file containing previously stored cookie lines,
+	which should be used
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
 	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
-	The value of `http.cookieFile` is subject to tilde expansion: `~/` is
-	expanded to the value of `$HOME`, and `~user/` to the specified user's
-	home directory.
 	NOTE that the file specified with http.cookieFile is used only as
 	input unless http.saveCookies is set.
 
