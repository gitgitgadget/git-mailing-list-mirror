From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: textconv not invoked when viewing merge commit
Date: Thu, 14 Apr 2011 21:35:40 +0200
Message-ID: <4DA74C8C.509@drmicha.warpmail.net>
References: <201104111912.47547.kumbayo84@arcor.de> <4DA415AB.9020008@drmicha.warpmail.net> <20110414190901.GA1184@sigill.intra.peff.net> <7vipughbxh.fsf@alter.siamese.dyndns.org> <20110414192839.GA6001@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:35:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QASKU-00027S-Lw
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 21:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758125Ab1DNTfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 15:35:43 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56037 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757039Ab1DNTfn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 15:35:43 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5FEEA20DE8;
	Thu, 14 Apr 2011 15:35:42 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 14 Apr 2011 15:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=qkzgiGjcAmja0bxktFaGo1v5GeA=; b=BTM2jtQShAlcZIut9sNRnja+3MxCgyJYbscs2avEPpjkeOzJaks59M4sGpmVc3mS0+te50xk7Xfz6w6CmOzTZkDZJIiYQg61tJTalGBjASZqLfhP1H3rRFJdpeFpBxsbHAWRUd9AWrsqEFfJrXVDijm8MwpQZpoWTOXUqtmc9XQ=
X-Sasl-enc: pCKgUGPak6OziGg9KmSbbWuNjdoWKmQWq9tvMnUTPhTW 1302809742
Received: from localhost.localdomain (p54859211.dip0.t-ipconnect.de [84.133.146.17])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6F087443A23;
	Thu, 14 Apr 2011 15:35:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110414192839.GA6001@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171540>

Jeff King venit, vidit, dixit 14.04.2011 21:28:
> On Thu, Apr 14, 2011 at 12:26:18PM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> We just dump the binary goo all over the terminal. So I think the whole
>>> combined-diff code path needs to learn how to handle binaries properly.
>>
>> How would you show multi-way diffs for binary files?
> 
> No clue. But anything would be better than pretending it's line oriented
> and dumping binary goo to the terminal.
> 
>> It would probably be sufficient to say "binary files differ" at the
>> beginning of the patch-combining codepath of the combined diff, which
>> would at least keep the --raw -c/--cc output working.
> 
> Yeah, something like "binary files differ" would probably be OK for
> "-c". I think for "--cc", that is probably the best we can do, too. It
> is about condensing uninteresting hunks, but we don't even have the
> concept of hunks.
> 
> -Peff

I have "one half" of a partial fix cooking which applies textconv. Good
to see that I'm not the only who is surprised by the disjointness of
codepaths. That should give me some freedom to go wild in
combine-diff.c... But it's rc-time, we're devoting all git time to
regression fixes and cleanups, right?

Michael
