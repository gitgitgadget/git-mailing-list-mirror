From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv3] Documentation: describe --thin more accurately
Date: Thu, 18 Feb 2010 00:33:16 -0800
Message-ID: <4B7CFB4C.2020507@gmail.com>
References: <1265961646-28585-1-git-send-email-bebarino@gmail.com> <1266262395-11864-1-git-send-email-bebarino@gmail.com> <7vfx52xm8d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 09:40:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni1vd-0004jF-Mg
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 09:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab0BRIjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 03:39:49 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60505 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab0BRIjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 03:39:48 -0500
Received: by pwj8 with SMTP id 8so1419695pwj.19
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 00:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=h0nJU0Bghn6Kjc6p1Sunz8G6kzsleCe6AxhqI8Ufp54=;
        b=UR6bkowzuy1CTkoNww1VHbcKWagXWyUgrpHt+kCu2BtZSRIBXNbvdcoe3GM1g139gm
         t50RoYr5oiw9tVr0vna2RbnlIgGX654Id/sxckolNmpvSe5zRj3aZgRG6m1ZDSpsQ1+E
         qvX/9X9Trv6FqBkznV20hFQrd6O0mwZ5PMKos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Yw6n/ms0mlBcy4o0SfR4JkFLvJ7n0zBPI11RZwSdMydhelx7LPvG/JjVu+klxWIzLU
         d9hCWSN863XOvcNBDk8+nE0a9SE2CedXitvpKgKzsbOE8VPC8Lmxt+0wluxDPi0xPYqt
         bCI5d7lVT7KXuiUiQvEZSaYz/vxRvcK44iTBc=
Received: by 10.114.187.40 with SMTP id k40mr3674078waf.10.1266481999291;
        Thu, 18 Feb 2010 00:33:19 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm9538984pzk.13.2010.02.18.00.33.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 00:33:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <7vfx52xm8d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140302>

On 02/15/2010 12:44 PM, Junio C Hamano wrote:
> I however think the first two points might be better covered by the
> description of `--thin` of `pack-objects` and we should simply refer to it
> from here, like this:
>
>     --fix-thin::
>             Make a "thin" pack produced by `git pack-objects --thin` (see
>             linkgit:git-pack-objects[1] for details) directly usable by
>             git, by adding objects that the objects stored in the
>             deltified form are based on to the packfile.
>

This looks good. I'd like to avoid introducing the term packfile though
and just use pack throughout.

>     --thin::
>             Create a "thin" pack in order to reduce network transfer.
>     +
>     For a packfile to be usable directly by git, any object in the pack
>     that is represented in the deltified form must be based on an object
>     that exists in the same pack.  Such a pack is called "self-contained".
>     +
>     If the sender sends an object in the deltified form based on an object
>     both the sender and the receiver have, but excludes the common object
>     itself from the datastream, it can often reduce the network traffic
>     dramatically.  Such a datastream is called a "thin" pack.
>     +
>     Note that a thin pack violates the self-containedness requirement and
>     is not directly usable by git on the receiving end without making it a
>     self-contained pack by running `git index-pack --fix-thin` (see
>     linkgit:git-index-pack[1]).

This looks long winded. Perhaps we can do without explaining what
self-containedness is? If you read the second paragraph in the
description section of git-pack-objects.txt it tries to explain
self-contained:

    The packed archive format (.pack) is designed to be 
    self-contained so that it can be unpacked without
    any further information


If all I know is a pack contains objects and deltas based on other
objects I might be able to figure out that all the objects must be
present in the pack for it to be self-contained. This description
section might need some work but I don't think repeating ourselves in
--thin is good.

Updated patch to follow.
