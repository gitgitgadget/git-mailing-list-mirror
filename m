From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] notes: avoid recommitting identical trees
Date: Tue, 31 Aug 2010 20:26:34 +0200
Message-ID: <4C7D495A.1080806@drmicha.warpmail.net>
References: <4C7CD65F.10509@atlas-elektronik.com> <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net> <20100831160145.GC11014@sigill.intra.peff.net> <4C7D2AAE.9000701@drmicha.warpmail.net> <7vfwxud94w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	stefan.naewe@atlas-elektronik.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:26:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVXe-0002UK-59
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab0HaS0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:26:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59708 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754672Ab0HaS0e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 14:26:34 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 83D73479;
	Tue, 31 Aug 2010 14:26:33 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 31 Aug 2010 14:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=RfB/DRJJML5SSWweGKeFjxKws1E=; b=egDhscZBbz2YjBv+tclENb4ZxeRErVR473QMPBOSk2a9OcNQUVAy/rVBTIXbxNPV4x6TBr3vapOQeG9Hi/J4tFs9FdzuqHylIkT/TFpyWc6Bt1LJyWwaSe1cjz9Xn4SRPS7SgfI7NdP24JMS0ZnzdWLKd5vgUq39eA2Tw0rExgw=
X-Sasl-enc: TxltvY3QPON8cYSXZ/WR59vxlFCd9Js4YlgNelRj2+qc 1283279193
Received: from localhost.localdomain (p54859079.dip0.t-ipconnect.de [84.133.144.121])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6A5465E573D;
	Tue, 31 Aug 2010 14:26:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <7vfwxud94w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154958>

Junio C Hamano venit, vidit, dixit 31.08.2010 18:44:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>>> +	if (!parent || parse_commit(parent->item) || parse_tree(parent->item->tree) ||
>>>> +		hashcmp(parent->item->tree->object.sha1, tree_sha1)) {
>>>
>>> I didn't check, but I can imagine you can drop the parse_tree here. We
>>> should know the object sha1 once the commit is parsed.
>>
>> parse_commit() does a lookup_tree() but I don't think that it parses the
>> tree, i.e. I don't hink it fills in tree->object.sha1.
> 
> Huh?  parse_tree(tree) calls read_sha1_file(tree->object.sha1) to parse
> the tree.  How can it do without filling tree->object.sha1?
> 

Sure parse_tree() does that. That's why I call it. I never claimed it
doesn't.

Michael
