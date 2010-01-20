From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 22:02:20 +0100
Message-ID: <4B576F5C.2050102@drmicha.warpmail.net>
References: <20100120050343.GA12860@gnu.kitenet.net> <201001201148.11701.johan@herland.net> <20100120182438.GB31507@gnu.kitenet.net> <7vhbqg376b.fsf@alter.siamese.dyndns.org> <20100120195626.GA6641@gnu.kitenet.net> <7vska01qrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:02:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhgw-0006XF-OJ
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab0ATVCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509Ab0ATVCO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:02:14 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54023 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751729Ab0ATVCO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 16:02:14 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5A7C2CDA26;
	Wed, 20 Jan 2010 16:02:13 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 20 Jan 2010 16:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=gLbtu+/+2JXcDY/TL8HScQVNMMQ=; b=oA6Ckb/p00x+2iD5gBortNonhE1QwpUblBe97hRyqofEsf1cvU/iSaWa523xmqHdfDdrSpJH2IXibla/v23uYgFxtsYQctUIVtPRyV4Ku8UTyiwMXV7vi6ee+SGoOLU3TPqDbaYWAFPKCZgnW+wSvEeeFp56VUEvGCY38EkdaXY=
X-Sasl-enc: uBtx2Zv8GO6Hmu8sPqu2LhzKd4+4XdAUp/QL6xSdKXQH 1264021332
Received: from localhost.localdomain (p5DCC04F9.dip0.t-ipconnect.de [93.204.4.249])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 795B3BAFB;
	Wed, 20 Jan 2010 16:02:12 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <7vska01qrt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137580>

Junio C Hamano venit, vidit, dixit 20.01.2010 21:10:
> Joey Hess <joey@kitenet.net> writes:
> 
>> Do you think it makes sense for even git log --format=format:%s to be
>> porcelain and potentially change when new features are used?
> 
> If the series changed the meaning of "%s" format to mean "the subject of
> the commit and notes information", with or without documenting it, then it
> is just a bug we would like to fix.

No, but outputting the note as part of the log is the standard. So for
example, when you do a format-patch | apply cycle, format-patch will
insert the note as part of the commit message, and apply will *store*
the note text (including Note:\n) as part of the commit message of the
new commit.

So, I would say the notes feature is not that well integrated right now,
and either log has to learn --no-notes (and format-patch has to use it,
or rather the corresponding internal flag), or apply has to learn to
parse "Note:" headers. Or, depending on how you use notes, it may be
better if format-patch puts the note after the "--"; that way you can
store the usual "after-the-message" patch comments in a note.

Similarly, I don't think rebasing and cherry-picking adjust the notes
tree for commits with notes whose sha1 changes - which may or may not be
the appropriate behaviour.

In both cases, the "right" way depends on how you use notes, and there
should be an easy way to specify your choice.

I'm not complaining, I actually have this on a maybe-to-do list, but the
way the series went kept me from investing time.

Cheers,
Michael
