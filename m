From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Problem signing a tag
Date: Fri, 06 Nov 2009 10:54:03 +0100
Message-ID: <4AF3F23B.8080203@drmicha.warpmail.net>
References: <200911021558.17550.joshua@eeinternet.com> <200911030911.47030.joshua@eeinternet.com> <4AF18F7A.2000904@drmicha.warpmail.net> <200911040947.50226.joshua@eeinternet.com> <4AF28CE4.5000906@drmicha.warpmail.net> <7vy6mk91ig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Joshua J. Kugler" <joshua@eeinternet.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 10:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6LWO-00087g-Nk
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 10:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206AbZKFJyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 04:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756180AbZKFJyI
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 04:54:08 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51294 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755692AbZKFJyH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 04:54:07 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8629DBE95B;
	Fri,  6 Nov 2009 04:54:12 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 06 Nov 2009 04:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Cmp6ocm3O+aU+kgpHwJPj8o3xf0=; b=tZsQH/cgzkW8PldiCM/N30Pyqiq23D22zdw5cHSk2SLvvUx06Qpv/ZM0lX+Ur4ff8HP36vIuuedDcycDUL3jx4BYj5wOmL8cCgzLjT/6nEyxu+ca+HQXuyDtqzfI/PnAUCK0iPqhlTehwEhwTIS3ggxWwcNcKN6cyzPc0y+OX9U=
X-Sasl-enc: uUB6S/4MCUYAW1qwZwTiNJOo/ZXRnoggABCp7CNy4x2G 1257501252
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 966EE4A7215;
	Fri,  6 Nov 2009 04:54:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091104 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <7vy6mk91ig.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132292>

Junio C Hamano venit, vidit, dixit 05.11.2009 21:09:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Dig dig dig... gpg exits with 2 in a lot of cases, one would need to
>> parse fd-error to find out more. But it also looks as if gpg exits
>> normally with a good passphrase. So I tried, and at least with gpg 1.4.9
>> and git 1.6.5.2 I can sign tags with "use-agent" and without a running
>> agent: I get asked for the passphrase (after reporting the agent MIA),
>> and everything's fine.
>>
>> My gpg returns 0 in this case; it returns 2 only if I don't enter the
>> passphrase. So, this seems to depend on the version of gpg. Or on
>> entering the correct passphrase ;)
> 
> If the problematic gpg that gives 2 is older than yours, the situation
> looks to me that "exiting 2 when failed to contact agent but got a good
> passphrase some other way and successfully signed" was diagnosed as a bug
> and then fixed in gpg.  If that is the case can we find out which version
> that fix is in, and add an entry to FAQ to help next person who will be
> hit by this when using "tag -s"?

Both of us seem to be using gpg 1.4.9, which is weird. I even checked
Fedora's srpm, they don't apply any patches for this. For the record,
I'm doing

unset GPG_AGENT_INFO
echo a |gpg -bsa

with "use-agent" and a default key signing specified in my gpg conf.
This returns "0" if I enter the correct passphrase (after being warned
about the missing agent) and "2" if I enter a wrong one repeatedly.
Joshua, your reports seem to confirm that you get 2 in both cases from
your gpg 1.4.9, right?

Michael
