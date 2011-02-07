From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Mon, 7 Feb 2011 19:29:33 +0700
Message-ID: <AANLkTim-nbVsp8z0Cw+p67JU0B9yAE3hkaZ1ay9cmsjm@mail.gmail.com>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com> <20110207091740.GA5391@elie>
 <20110207095713.GA19653@do> <20110207121855.GA7298@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Feb 07 13:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmQEQ-0002lq-Mo
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 13:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645Ab1BGMaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 07:30:05 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42239 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab1BGMaE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 07:30:04 -0500
Received: by wyb28 with SMTP id 28so4476540wyb.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 04:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=DeMbhz2WMhifMTbUFPhDQwBnOYoQYQr+lFSV1Pqp1PI=;
        b=YHzoPz5pKiD9r7xDQN6E9lTI8sZZ4YyiUCfSsNfSjw3hVDib2XCEc/edrPFwD56o7v
         CEt2oQrlZnW9SAMHZOFgu3h3OxUIDF9RY6YCMUhGMrA8Ya0Mn5YhYesUhXpdYLZGgp8P
         b4/GUdZ3TBAn2/Od60bMlOFG0+H56a045jAt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CFFaQYuBusu8uamnC3HwGaAtUN6LSxJv8FyiMoF69MQEEoqq7rKO6HZnRIIowC64OU
         6MY7Ghpz9kRK5H4zWB24xqW54atZbs6JVEzmNTPJhFZxdwRhvDUw5PRP/Pj/SCs3o3w/
         x1lz2yrD7ZZ0zmo7CMY1jOOLAnOkeaQ8O6N0Q=
Received: by 10.216.89.71 with SMTP id b49mr14067574wef.28.1297081803281; Mon,
 07 Feb 2011 04:30:03 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Mon, 7 Feb 2011 04:29:33 -0800 (PST)
In-Reply-To: <20110207121855.GA7298@LK-Perkele-VI.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166259>

On Mon, Feb 7, 2011 at 7:18 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Mon, Feb 07, 2011 at 04:57:13PM +0700, Nguyen Thai Ngoc Duy wrote:
>>
>> Perhaps it's not a good approach after all. What I wanted was to make
>> pre-1.8.0 tolerate empty trees created by 1.8.0. Perhaps it's better
>> to just let pre-1.8.0 refuse to work with empty trees, forcing users
>> to upgrade to 1.8.0?
>>
>> The (untested) patch below would make git refuse to create an index
>> from a tree that contains empty trees. Hmm?
>
> Remember, many distros ship with old versions of Git. Debian stable
> is now at 1.7.2.3 (Squeeze became Debian 6.0) and it'll take years
> before next release. What about these?

Waiting a few years is my best bet :P Really I don't figure out any
other way for migration. New empty trees would end up in repository
and affect all connected clients regardless version.

> Making previous versions refuse to work with empty trees isn't exactly
> trivial, as the tree parser seems to be written to be extremely
> liberal on what it accepts.

The repository _can_ contain empty trees. The main problem is index
not supporting empty trees. I only prevent index being used. If users
create new commits (including empty trees) with mktree and
commit-tree, they can also checkout without index using ls-tree and
cat-file.
-- 
Duy
