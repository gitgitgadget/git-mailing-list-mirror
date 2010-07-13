From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Question about 'branch -d' safety
Date: Tue, 13 Jul 2010 10:30:45 +0200
Message-ID: <4C3C2435.8010500@viscovery.net>
References: <20091230065442.6117@nanako3.lavabit.com>	 <m3lj9jknlr.fsf@localhost.localdomain> <20100711065505.GA19606@localhost>	 <201007110916.29567.jnareb@gmail.com> <20100711133730.GA10338@localhost>	 <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>	 <20100712184754.GA18429@localhost>	 <7v39vo8dkn.fsf@alter.siamese.dyndns.org>	 <20100713071317.GA26348@localhost> <1279008023.2030.11.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 10:30:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYatE-0001nv-N2
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 10:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab0GMIav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 04:30:51 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19941 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751288Ab0GMIau (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 04:30:50 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OYat4-0004UH-F5; Tue, 13 Jul 2010 10:30:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 220E11660F;
	Tue, 13 Jul 2010 10:30:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <1279008023.2030.11.camel@wpalmer.simply-domain>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150888>

Am 7/13/2010 10:00, schrieb Will Palmer:
> On Tue, 2010-07-13 at 09:13 +0200, Clemens Buchacher wrote:
>> Why would we need that? Even now, it is not enough to do "git
>> branch -D frotz; git gc --prune". You need to expire the reflog,
>> since HEAD may still have a reference to it. So instead you would
>> need
>>
>>  git branch -D frotz
>>  git reflog expire --expire=now HEAD frotz
>>  git gc --prune
>>
>> Purging a branch becomes just a special case of purging anything
>> from history.
> 
> With that in mind, would it not be enough to simply remove the ref, but
> not the reflog,

With that in mind, shouldn't it be exactly the other way around, i.e.,
dump the reflog (the objects are still referenced from HEAD's reflog), but
keep the ref around in some attic, just in case the branch is so old that
its reflog was empty and its objects would otherwise be pruned right away?

-- Hannes
