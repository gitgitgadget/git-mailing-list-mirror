From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WRONG/PATCH 1/3] revisions: clarify handling of --no-walk and
 --do-walk
Date: Sun, 24 Apr 2011 13:28:01 +0200
Message-ID: <4DB40941.5030903@drmicha.warpmail.net>
References: <20110421102241.GA16185@elie> <20110421103926.GA16260@elie> <4DB02B24.4030503@drmicha.warpmail.net> <20110421213014.GB18418@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 13:28:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDxU5-000726-3O
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 13:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756953Ab1DXL2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 07:28:08 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50255 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756597Ab1DXL2G (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2011 07:28:06 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7CDCC20785;
	Sun, 24 Apr 2011 07:28:04 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sun, 24 Apr 2011 07:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=s1SrGaloJiVV98KvbIF1y6dr4eg=; b=U+H46YtBqSDJpV97YUwlBnBspTyaA1pLIMjwb8f68sou84nCXfvigd8n6BHkonGUugdsEdEXRUodj7YyvW41eos/MMEg2SYXHx7iB1MZVu7diPBhgDrMvAViHa7rpPuddVg3FGC932j8TdsF8Sl39s6p/73uj7OXHn4IJW3dVkU=
X-Sasl-enc: agOgb2S3glSu+uCkG5EZNG5pc+6bzW8Q9fi4jQCH/JsC 1303644484
Received: from localhost.localdomain (p5485971C.dip0.t-ipconnect.de [84.133.151.28])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5ABFE4088EC;
	Sun, 24 Apr 2011 07:28:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110421213014.GB18418@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171992>

Jonathan Nieder venit, vidit, dixit 21.04.2011 23:30:
> Michael J Gruber wrote:
> 
>> This is not unrelated to the tip of gitster/mg/show-without-prune, i.e.
>>
>> 0c738b6 (builtin/show: do not prune by pathspec, 2011-04-01)
> 
> True.
> 
>> We should rethink the ui balance between deviating from the usual log
>> option processing and the usefulness here.
> 
> Could you expand on that?  I think --no-walk being a positional
> argument is just an ugly consequence of the code that permits
> 

Sorry for being fuzzy. What I meant was: There is the systematic
approach which gives the user exactly what he asks for, i.e.: log,
rev-list default to walking, show to not walking (and rev-parse of
course), and when a user feeds a range it may or may may not make sense.
Similarly, "git show commit -- path" returns nothing at all if path is
not touched by commit because the commit gets pruned.

We don't do the systematic approach now. In some situations, some
commands switch on the walker automatically (I think "show A..B") to
make things more useful (to most users) but less systematic, even less
predictable if you don't know these deviations/exceptions. I've
suggested such a "usefulness exception" myself (don't prune commits by
path for "show").

The strict, systematic approach produces some command/argument
combinations which are not useful or rarely useful.

The "helpful" approach produces special casing which may make things
confusing if there's too much of it.

Finding the right balance is probably more difficult than being
radically systematic...

Michael
