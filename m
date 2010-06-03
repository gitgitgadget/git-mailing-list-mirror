From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] documentation: git-mergetool updated to warn against
 builtin tools invocations
Date: Thu, 03 Jun 2010 09:45:04 +0200
Message-ID: <4C075D80.70304@drmicha.warpmail.net>
References: <1275501453-13081-1-git-send-email-srabot@steek.com> <7vbpbt9f9j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sylvain Rabot <srabot@steek.com>, git@vger.kernel.org,
	sylvain@abstraction.fr, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 09:45:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK57M-0003nV-9I
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 09:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271Ab0FCHp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 03:45:27 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51125 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753808Ab0FCHp0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 03:45:26 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 86EF0F834E;
	Thu,  3 Jun 2010 03:45:25 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 03 Jun 2010 03:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=v8cXwGa12c2jP4flzGFyLPWZduI=; b=edL/5GI+y2dDWOoyFSfPzjLLtmBwwJjS9wa2KZnbKB7mGdsEmG6xASUtgSlnHSYgscNL2mEat4JFXkRP9N4LhGXZGIIJ2ucuaaDGbDpsKRyBG+LKP6csP05z7inH5OGYQPtQSkpHetucYlJ7l1QwoxmUq+Fg3fZXaNMhuMZlLPI=
X-Sasl-enc: M9tP7rR6AgfTEsBzrl5J71FL4Vl4CSg0TxpKWYdJOUYd 1275551125
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A221C4A91A;
	Thu,  3 Jun 2010 03:45:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <7vbpbt9f9j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148296>

Junio C Hamano venit, vidit, dixit 03.06.2010 01:38:
> Sylvain Rabot <srabot@steek.com> writes:
> 
>> +Be aware that 'git mergetool' has some predefined invocation commands builtin
>> +for known diff tools like meld, diffuse, p4merge ... etc. It means that if
>> +you set the merge.tool configuration to one of these tools, the
>> +mergetool.<tool>.* configurations will not be taken care of. If you
>> +really want to customize the invocation of one of these tools,
>> +set `merge.tool` to "custom" or whatever you want and `mergetool.custom.cmd`
>> +to "/usr/bin/<tool> $LOCAL $MERGED $REMOTE"
> 
> Two half-points and three points (that makes them four in total ;-):
> 
>  o If I read the above without "It means that", it still makes sense;
> 
>  o "If you really" can go without "really";
> 
>  * I had to read "will not be taken care of" twice; "are ignored" is
>    probably easier to understand;
> 
>  * The description and the example makes it sound as if the command line
>    has to have these three tokens in the given order, but the whole point
>    of this mechanism is that you can launch whatever external command with
>    a custom command line, so "and `mergetool.custom.cmd` to a command line
>    to invoke the command.  $LOCAL $MERGED and $REMOTE on this command line
>    are substituted by ...." may be more reader-friendly.
> 
>  * As a documentation update it is perfectly fine to describe this glitch,
>    but I wonder if we might want to lift this restriction (read: consider
>    this as a bug and fix it).

Definitely. The current behaviour even means that when you have set up
fancytool, and then a new git-mergetool version suddenly starts to
support fancytool, possibly with different options, your existing
configuration breaks. I.e., even for currently unsupported tools you
have to use the procedure Silvain describes in order to protect against
updates!

Michael
