From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http: expand http.cookieFile as a path
Date: Fri, 29 Apr 2016 10:11:48 -0700
Message-ID: <xmqqziscz6ej.fsf@gitster.mtv.corp.google.com>
References: <20160429062357.12647-1-computersforpeace@gmail.com>
	<20160429062357.12647-2-computersforpeace@gmail.com>
	<20160429141212.GB26643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brian Norris <computersforpeace@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:11:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awBxM-0004im-Vb
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbcD2RLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:11:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751980AbcD2RLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:11:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 027BE152B3;
	Fri, 29 Apr 2016 13:11:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3CTSYtZlpCTM/23L/tcIEx4M6wI=; b=H/MBZm
	1rEQO+ABOmrJH4QNFQPeqp61gRB/ABiQfMBB//XQszRbZmTgIFBQQnbYa16qsbTA
	1NJ+q1etXM9BIQWIy6XQn7hes+qO4d1jwbwJeeIvViVZszEf6TKNHAdNdgLSdCPh
	qnCZ6IZ4Hi3SEonhKsKqz13mgcltlP59k8DUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TJgD18BJcT0svvEQqxuewTf2kcbVoq37
	K+KAL09oiwSJQezsPRiIhy2BIGHKTlucIJpIQKDPP0HlRT+usyMMXTCLZ+f6CHO9
	zmR3uHmVzgmMu7B2/blW59ord9TqUEL8PYOb4E0M1GT3m4kFfiFkUxeyL5DbXc57
	0/8UCr9Wq30=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED6A0152B2;
	Fri, 29 Apr 2016 13:11:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58310152B1;
	Fri, 29 Apr 2016 13:11:50 -0400 (EDT)
In-Reply-To: <20160429141212.GB26643@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Apr 2016 10:12:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7660D76A-0E2D-11E6-BA82-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293027>

Jeff King <peff@peff.net> writes:

> I'm not sure if it's a good idea to go into so much detail about
> expand_user_path() here. There are a lot of options that use the same
> rules, and we probably don't want to go into a complete explanation
> inside each option's description. Is there a canonical definition of how
> we do expansion in config.txt that we can just reference (and if not,
> can we add one)?

We have a dedicated section for various value-types used in the
configuration variables already, because we needed to describe how
booleans and scaled integers can be spelled, and the pathname type
would fit there.

 Documentation/config.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 59d7046..1bf42a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -169,6 +169,11 @@ thing on the same output line (e.g. opening parenthesis before the
 list of branch names in `log --decorate` output) is set to be
 painted with `bold` or some other attribute.
 
+pathname::
+	A variable that takes a pathname value can be given a
+	string that begins with "~/" or "~user/", and the usual
+	tilde expansion happens to such a string.
+
 
 Variables
 ~~~~~~~~~
