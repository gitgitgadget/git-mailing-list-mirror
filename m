From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with textconv
 filter
Date: Mon, 03 Jun 2013 19:25:06 +0200
Message-ID: <51ACD172.4070608@arcor.de>
References: <508C29E4.5000801@arcor.de> <20121028120104.GE11434@sigill.intra.peff.net> <508D8DF7.7040007@arcor.de> <20121029060524.GB4457@sigill.intra.peff.net> <508EE4E4.1080407@arcor.de> <20121029223521.GJ20513@sigill.intra.peff.net> <509ACE63.9070007@arcor.de> <20121107211339.GA29184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:25:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYVv-0003aP-EH
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759064Ab3FCRZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:25:44 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:36549 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753430Ab3FCRZm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jun 2013 13:25:42 -0400
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id 6FAEE2D704C;
	Mon,  3 Jun 2013 19:25:41 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id 6B8933F83C5;
	Mon,  3 Jun 2013 19:25:41 +0200 (CEST)
Received: from [10.0.0.5] (62-47-252-102.adsl.highway.telekom.at [62.47.252.102])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTPA id 0BFA65AFE0;
	Mon,  3 Jun 2013 19:25:40 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-01.arcor-online.net 0BFA65AFE0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1370280341; bh=2LdnE5zH0/JMoGa/e97veAELnIPnZxlZ7w3sEnMrK48=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=OTFNJPLB5hy+oTLsoYtlhRqO3N0K2xucP753muJafkMaZ7GJtH/OBcQgnz5/q7dPj
	 qxNDanXii9f88eMOTQ6Jds30+6znG5WWM/jrNBRTmsjxOy1qXbrrBfwMrj/2FS3V0/
	 LxsBUSGSQ7Jjq5uj3NhBhHi8iGDLX/WWbgyj0XNs=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20121107211339.GA29184@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226243>

On 2012-11-07 22:13, Jeff King wrote:
> On Wed, Nov 07, 2012 at 10:10:59PM +0100, Peter Oberndorfer wrote:
>
>>>> For me the key to reproduce the problem was to have 2 commits.
>>>> Adding the file in the root commit it did not work. [1]
>>> You probably would need to pass "--root" for it to do the diff of the
>>> initial commit.
>>>
>>> The patch below fixes it, but it's terribly inefficient (it just detects
>>> the situation and reallocates). It would be much better to disable the
>>> reuse_worktree_file mmap when we populate the filespec, but it is too
>>> late to pass an option; we may have already populated from an earlier
>>> diffcore stage.
>> Hi,
>> I tested your patch, and i can confirm it fixes the problem for me.
>> (also on my real world test in msysgit)
> Thanks for the report. I'd still like to pursue using a regex library
> that does not require NUL-termination, but I've been distracted by other
> things. I'm going to hold back my copy-to-a-NUL-buffer patch for now and
> see if I can get to the regex thing this week.
>
Hi,

are there any news regarding this problem?
The crash seems to still exist in the current version 1.8.3 and master.

Thanks,
Greetings Peter
