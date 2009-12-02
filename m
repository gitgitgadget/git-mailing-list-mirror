From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-pull.sh: Fix call to git-merge for new command  
 format
Date: Wed, 02 Dec 2009 11:02:49 +0100
Message-ID: <4B163B49.4070606@drmicha.warpmail.net>
References: <1259707451-20661-1-git-send-email-vonbrand@inf.utfsm.cl> <7vmy22qmgp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 11:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFm4D-00042O-Rv
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 11:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbZLBKD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 05:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbZLBKD7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 05:03:59 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52579 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753087AbZLBKD5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 05:03:57 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AD8CBC521D;
	Wed,  2 Dec 2009 05:04:03 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 02 Dec 2009 05:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mL74OzXfdeF9CsK3FLamsPCYcgc=; b=Z7gzKJ3Vmso2dgVDsJbSrJ1YoimZnyLaNFBVDgVqOzwFm8FudWLJ7jcKyGNp27Y4IKTkbHZ0wVds2V+idUZ/8z4G7MJEZuxHsS37JimIaY3Rhzj1ZkwOjjVny4zHM32LO6suGQ9gxvICqLG2o79IUEFfOWYu1/b07/mQBXTq4+c=
X-Sasl-enc: gH1NFcZDHn185jl+Wiax87PAREHWpZEuiT3xUYPJjaGJ 1259748243
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 62F431B253;
	Wed,  2 Dec 2009 05:04:02 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <7vmy22qmgp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134320>

Junio C Hamano venit, vidit, dixit 02.12.2009 00:54:
> "Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:
> 
>> Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
>> ---
>>  git-pull.sh |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index bfeb4a0..a875809 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -218,5 +218,5 @@ merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
>>  test true = "$rebase" &&
>>  	exec git-rebase $diffstat $strategy_args --onto $merge_head \
>>  	${oldremoteref:-$merge_head}
>> -exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
>> -	"$merge_name" HEAD $merge_head $verbosity
>> +exec git-merge  $verbosity -m $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
>> +	"$merge_name" $merge_head
>> -- 
>> 1.6.6.rc0.114.gc8648
> 
> Heh, embarrasing.
> 
> But I think you wanted to have -m immediately before "$merge_name", no?

This made me wonder a bit: Do we have a policy regarding the use of
"git-command" vs. "git command" in git shell scripts such as this one?
Of course, having been called through git, the dashed versions are in
the PATH. But I see a mix here ("git fmt-merge-msg" vs. "git-merge") and
in other scripts, which may potentially (in broken setups) lead to parts
of git from different installs being called. I would think the dashed
form is even more efficient (fewer lookups)?

Michael
