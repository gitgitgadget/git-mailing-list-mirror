From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 3/6] Teach clone to set remote.default.
Date: Fri, 06 Jul 2012 10:37:05 -0400
Message-ID: <4FF6F811.7000808@xiplink.com>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com> <1341526277-17055-4-git-send-email-marcnarc@xiplink.com> <7vzk7dq0qk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 16:37:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn9ea-0001za-EP
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 16:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab2GFOg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 10:36:58 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:52496 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273Ab2GFOg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 10:36:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 806331C80D9;
	Fri,  6 Jul 2012 10:36:57 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp23.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 175EB1C807E;
	Fri,  6 Jul 2012 10:36:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7vzk7dq0qk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201113>

On 12-07-05 06:52 PM, Junio C Hamano wrote:
> marcnarc@xiplink.com writes:
> 
>> From: Marc Branchaud <marcnarc@xiplink.com>
>>
>> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
>> ---
>>  builtin/clone.c          |  2 ++
>>  t/t5601-clone.sh         | 10 ++++++++++
>>  t/t5702-clone-options.sh |  7 +++++--
>>  3 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index a4d8d25..b198456 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -770,6 +770,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>  	git_config_set(key.buf, repo);
>>  	strbuf_reset(&key);
>>  
>> +	git_config_set("remote.default", option_origin);
>> +
> 
> Is this something we would want to do unconditionally?  If so why?

I think so, yes.

> Or is this what we want to do only when the "--origin name" option
> is used?

If remote.default isn't set, then if someone does
		git remote rename origin foo
the default remote will still be "origin" (modulo the currently-checked-out
branch stuff).

		M.
