From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] cache_tree_find(): remove redundant checks
Date: Wed, 05 Mar 2014 05:38:39 +0100
Message-ID: <87eh2hi7jk.fsf@fencepost.gnu.org>
References: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq8uspk72g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 05:40:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL3dF-0000yS-TB
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 05:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbaCEEke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 23:40:34 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:38954 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaCEEkd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 23:40:33 -0500
Received: from localhost ([127.0.0.1]:37995 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WL3dA-0004c2-Bj; Tue, 04 Mar 2014 23:40:32 -0500
Received: by lola (Postfix, from userid 1000)
	id 0AB60DF406; Wed,  5 Mar 2014 05:38:39 +0100 (CET)
In-Reply-To: <xmqq8uspk72g.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 04 Mar 2014 13:05:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243418>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>>  	while (*path) {
>> -		const char *slash;
>>  		struct cache_tree_sub *sub;
>> +		const char *slash = strchr(path, '/');
>>  
>> -		slash = strchr(path, '/');
>>  		if (!slash)
>>  			slash = path + strlen(path);
>
> Isn't the above a strchrnul()?

Yes.  I realized that previously, but since it's a GNU extension rather
than part of the C standards, I discarded that idea.  Calling

    git grep strchrnul

shows, however, that it _is_ used plentifully already.

That would, indeed, favor the current proposal but with strchnul.

Still worth thinking about whether there is no better name than slash
for something that indicated the end of the current path name segment.

-- 
David Kastrup
