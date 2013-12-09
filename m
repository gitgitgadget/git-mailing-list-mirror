From: Chris Packham <judge.packham@gmail.com>
Subject: Re: A couple of rebase --autosquash proposals
Date: Mon, 09 Dec 2013 22:26:19 +1300
Message-ID: <52A58CBB.6040809@gmail.com>
References: <CALeEUB4mTpd9tHJCC9Ffrfe6L=m0+gaDsXYSFGaO_tMcxCX_nA@mail.gmail.com> <52A56887.4070909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Johannes Sixt <j.sixt@viscovery.net>,
	Brett Randall <javabrett@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 10:26:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpx6n-0005nA-EE
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 10:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709Ab3LIJ01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 04:26:27 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:35363 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932707Ab3LIJ0X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 04:26:23 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so5066734pbc.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 01:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=omv/GnH0cNZvW/eKYnn2CeKBN07okXiHzegs+MBy0g4=;
        b=KupTsK0p6rOyrz6B08i3TAagY7F9T9oQFqirlmzUAtqK7nFIDhcX2uQpKVmsYpY+BM
         TZQJe03mUZ32N7Pknj3NI5Lc7k5Zrr7yOx3WS7HL5ZYiyIOZN5A2fSmaenjs9SKCfDdf
         koYMuWVwu0sdXPkSL6yPKcGejcCvomsHj2NfidHM0tinnxX3gNnLdQzzwLFFXOJJtHot
         5rTSaLbCqPj/PNunoAPYrnmTH8P4gTM5ZkRxVYgxN1xqHcJ9uNhoff/vDseu4P1MAKaI
         3V3CIbO5LiKVzuvPAYGKde/oNxIMhQhojzrdqMrv2qDVxX56Y2GEj2kNOV4clwdp8lJL
         BX8g==
X-Received: by 10.66.147.9 with SMTP id tg9mr19411690pab.5.1386581183346;
        Mon, 09 Dec 2013 01:26:23 -0800 (PST)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id jk16sm16532736pbb.34.2013.12.09.01.26.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 01:26:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52A56887.4070909@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239062>

On 09/12/13 19:51, Johannes Sixt wrote:
> Am 12/9/2013 3:23, schrieb Brett Randall:
>> * fixup! or squash! on it's own would default to fixing-up the
>> previous commit (or result of previous step of rebase if that was a
>> squash/fixup).
> 
> Why would you want that? To fixup the previous commit, just use 'git
> commit --amend'. What am I missing?

In the past I've used this kind of approach when doing merging/porting
work with 3rd party code (or just large integrations). The first (and
eventually final) commit introduces the new code. The subsequent fixups
address build issues which are either errors in the 3rd party code
(which I will want to submit bug reports for later and carry in my tree
as real commits) or errors in my merging (which I want to squash into
the merge commit). When faced with a screen full of compilation errors
I'm not sure which of these 2 categories are applicable at the time so I
tend to have lots of little fixups that I need to juggle around with git
rebase once I've got the code compiling and passing some tests.

All that being said I think allowing multiple "fixup!\n" stack up on
each other might be a bit dangerous. There are cases where
fixup!-fixup!-real might be useful but those would be hard to
distinguish those from cases where someone absent mindedly forgot to put
something after "fixup!".
