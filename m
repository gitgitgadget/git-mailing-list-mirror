From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] tag,verify-tag: do not trip over rfc1991 signatures
Date: Tue, 05 Oct 2010 22:47:33 +0200
Message-ID: <4CAB8EE5.5020405@drmicha.warpmail.net>
References: <4CAB46C0.9000807@drmicha.warpmail.net> <5cea498f34522d603a1561bfe69e2f92caa39ced.1286293083.git.git@drmicha.warpmail.net> <20101005204201.GF7629@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:47:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3EQ3-00084H-0n
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab0JEUrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:47:22 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:36044 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751591Ab0JEUrV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 16:47:21 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1C3786A42;
	Tue,  5 Oct 2010 16:47:21 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 05 Oct 2010 16:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=7Y7bvv3eYrNhGITZN0lk6KQgFcM=; b=j8HmZQtPCYl8poVA+ydoIIgwQ6kHzyzacMLpANhdH04Kd0o3c/Xz5IvaFbHdPIy4YU8GbxmYXPT5gOFqTia5/gk9qruq/krrs06W/FkPUgTImxxs1xrCemzZmRKlyaKxfgQ/G7ozQJiGeNYbWs9/vSheDN6/9CsxmkPTI4+Dr98=
X-Sasl-enc: Nsua32rt1lK1aRHuOBG4mOU+zfcRdZ4yZHa7M1Zulv3l 1286311640
Received: from localhost.localdomain (p54858F63.dip0.t-ipconnect.de [84.133.143.99])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 337315E0C35;
	Tue,  5 Oct 2010 16:47:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <20101005204201.GF7629@inocybe.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158243>

Todd Zullinger venit, vidit, dixit 05.10.2010 22:42:
> Michael J Gruber wrote:
>> Currently, git expects "-----BEGIN PGP SIGNATURE-----" at the beginning of a
>> signature. But gpg uses "MESSAGE" instead of "SIGNATURE" when used with
>> the "rfc1991" option. This leads to git's faling to verify it's own
>> signed tags.
>>
>> Be more lenient and take "-----BEGIN PGP " as the indicator.
> 
> Another way to go might be to add --gnupg (or --openpgp) to the gpg
> options used for tagging.  That overrides an option like rfc1991 in
> the gnupg config file.
> 
> Whether that's preferable to accepting these older-style messages is
> debatable.  Using rfc1991 implies pgp-2.x compatibility, which means
> using md5 as the algorithm.  It could be seen as a weakness to accept
> such signatures.

The problem is that we never did this, i.e. we always allowed people to
create such signatures. They never verified, though, even though they
were valid. If that's reason enough to discount the usual compatibility
argument then adding --gnupg would be best.

> (Oh, and you probably saw this already, but s/faling/failing. ;)

:|

Michael
