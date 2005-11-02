From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/4] Client side of user-relative paths, take two.
Date: Wed, 02 Nov 2005 09:19:37 +0100
Message-ID: <43687699.8060609@op5.se>
References: <20051101225921.245595BF70@nox.op5.se> <7vpspj6h3n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 09:19:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXDqP-0000o0-2R
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 09:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbVKBITi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 03:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVKBITi
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 03:19:38 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:4846 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932631AbVKBITi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 03:19:38 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 3BD926BD00
	for <git@vger.kernel.org>; Wed,  2 Nov 2005 09:19:37 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vpspj6h3n.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11006>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>+	if (protocol == PROTO_SSH && colon && (!path || colon < path)) {
>>+		*colon = 0;
>>+		path = colon + 1;
>>+	}
> 
> 
> I think "colon < path" is to cover "git://host.xz/foo/bar:baz"
> case (i.e. funny directory name with an embedded colon); I think
> you should reset colon to NULL if you do things differently
> later depending on colon is set or not, like this part:
> 
> 
>>+	/* null-terminate host part and point path to ~ for URL's like this:
>>+	 *    ssh://host.xz/~user/repo
>>+	 */
>>+	if(!colon && *(path + 1) == '~')
>>+		*path++ = '\0';
>>+	else {
>>+		colon = path;
>>+		path = strdup(path);
>>+		*colon = '\0';
> 
> 

True. Should I update this patch or submit a new one fixing only this 
specific issue?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
