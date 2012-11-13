From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3] replace: parse revision argument for -d
Date: Tue, 13 Nov 2012 11:25:42 +0100
Message-ID: <50A22026.60506@drmicha.warpmail.net>
References: <50A0B896.8050700@drmicha.warpmail.net> <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net> <20121112204254.GH4623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 11:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYDgt-0004Xh-Ju
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 11:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470Ab2KMKZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 05:25:45 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46504 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754716Ab2KMKZo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 05:25:44 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B5E94204F0;
	Tue, 13 Nov 2012 05:25:43 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 13 Nov 2012 05:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=d3KhISG4P6aUAak49zWWgl
	qGzDI=; b=njODz0TB113pn3qzCoJGlPxDEJOUZfwtOLJqOIHVi3VBqoZ+OxTAGV
	VGePYO0RzRz1Ji9CEtTogUblJ/VEL64EHQhY51neV0OsDO+n7p+ujNwHunGn245W
	MEUB21C4m5immzMmZwP1OjUbCFJdBjK6sreykp430E4567ndSxvRo=
X-Sasl-enc: 09NiZovoh2vPWT+LqsJoJdlw3D8+CHxw6c7FPQxs/7/w 1352802343
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 271504827D4;
	Tue, 13 Nov 2012 05:25:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <20121112204254.GH4623@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209593>

Jeff King venit, vidit, dixit 12.11.2012 21:42:
> On Mon, Nov 12, 2012 at 03:18:02PM +0100, Michael J Gruber wrote:
> 
>> 'git replace' parses the revision arguments when it creates replacements
>> (so that a sha1 can be abbreviated, e.g.) but not when deleting
>> replacements.
>>
>> Make it parse the argument to 'replace -d' in the same way.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>
>> Notes:
>>     v3 safeguards the hex buffer against reuse
> 
> Thanks, I don't see any other functional problems.
> 
>> diff --git a/builtin/replace.c b/builtin/replace.c
>> index e3aaf70..33e6ec3 100644
>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
>> @@ -46,24 +46,28 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
>>  
>>  static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
>>  {
>> -	const char **p;
>> +	const char **p, *q;
> 
> I find this readable today, but I wonder if in six months we will wonder
> what in the world "q" means. Maybe "short_refname" or something would be
> appropriate?

That would be sooo inappropriate! ;)

Maybe "full_hex"?

I should also do away with the first replacement which really made sense
in v1 only.

v4 to follow.

Michael
