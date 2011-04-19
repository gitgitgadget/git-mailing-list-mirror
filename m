From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git notes list/show <revision-range>
Date: Tue, 19 Apr 2011 09:17:51 +0200
Message-ID: <4DAD371F.9040003@drmicha.warpmail.net>
References: <4DAC80CF.8020704@lyx.org> <20110418182724.GB11250@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	Git Mailing List <git@vger.kernel.org>, bebarino@gmail.com,
	johan@herland.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 09:18:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC5CC-0003gB-Gz
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 09:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab1DSHR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 03:17:56 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58192 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751943Ab1DSHRy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2011 03:17:54 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E7C112054D;
	Tue, 19 Apr 2011 03:17:53 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 19 Apr 2011 03:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=OkAnfW1NRbS/FtifIt6HU+Ta2Mo=; b=klCUUxsM2ny88Exg44koEwiktoe/dJmejKSB924TQaG2DCkmNn/VD6Hrs4hnrVzreWPf/KDZlNobfHe7zx90EYChWphn6IIds8hkqcI7qKSzysYE8SIs+5aPa3hRN5vkuifFJeh7hx528E05xNV0Ag7pRjpiO5ugpbsmaNmcgjw=
X-Sasl-enc: V6OR/uO7BERUNq6LIGQBZKyAeBrSvbCCHSF51NT0ON2u 1303197473
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 19AFD446C6F;
	Tue, 19 Apr 2011 03:17:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110418182724.GB11250@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171777>

Jeff King venit, vidit, dixit 18.04.2011 20:27:
> On Mon, Apr 18, 2011 at 08:19:59PM +0200, Vincent van Ravesteijn wrote:
> 
>> When a feature/patch is proposed, it will "cook" for a while in "pu"
>> and "next". During this period people can comment on the patch. These
>> comments can be stored in git notes added to the commits on which is
>> commented.
> 
> If you haven't already seen it, you might find the "notes/*" refs here:
> 
>   git://repo.or.cz/git/trast.git
> 
> They reference the messages discussing the patch on the mailing list by
> message-id and gmane link.
> 
>> That's why I want to (try to) implement the feature that 'git notes
>> list' and 'git notes show' accept a revision range and collect all
>> notes for the commits in this range.
> 
> You can do more-or-less what you want with something like:
> 
>   git log --format="%h %s%n%N"

Exactly, the log family does that and more, since it makes the whole
revision walk machinery available.

But since the OP is volunteering to code for notes :-)
We could need a feature which allows to log the history of a note. The alias

`git noteslog' is aliased to `!sh -c 'git log $(git notes get-ref) "$@"' -'

gives you the history of the notes tree (try it with "-p"), but
sometimes I would like the history of the notes to a specific commit, and in

git noteslog -p -- $(commit)

I would have to use for $(commit) all possible breakdowns of the sha1 of
the commit for all possible notes tree structures. It feels as of the
revision walker needs to learn another pathspec, say

":(note):<sha1>"

in line with our magic pathspec discussion.

Michael
