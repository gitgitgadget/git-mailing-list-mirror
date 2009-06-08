From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 7/8] Makefile: introduce SANE_TOOL_PATH for prepending
 required elements to PATH
Date: Mon, 08 Jun 2009 08:39:50 -0500
Message-ID: <nwND53LJ3yJOus0fY2Tjm-DbTAR8lJKtmBZRYJ4EcvNx7qWStwbs9w@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE26gwuGblUI8bcWLxyoPZhmfzJAibRVMtix-zkRUKYe5Y8R8-GRcIkUI@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2-yxscBzIn8DiQogVPM7EAgcGyYg61V8vYLxFiW6A4ovZp6SOuP0pDM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2_PLKo8HHFSCQIZrHM
 fucFNo_Bdy4p79XNP-MU8gnsUflWndiCqfhFM@cipher.nrlssc.navy.mil> <20090608114351.GA13775@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 15:40:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDf5E-0000Bf-DV
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 15:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbZFHNj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 09:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773AbZFHNj4
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 09:39:56 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55883 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623AbZFHNj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 09:39:56 -0400
Received: by mail.nrlssc.navy.mil id n58DdpZb027052; Mon, 8 Jun 2009 08:39:51 -0500
In-Reply-To: <20090608114351.GA13775@coredump.intra.peff.net>
X-OriginalArrivalTime: 08 Jun 2009 13:39:51.0290 (UTC) FILETIME=[9936EDA0:01C9E83E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121072>

Jeff King wrote:
> On Fri, Jun 05, 2009 at 06:36:15PM -0500, Brandon Casey wrote:
> 
>> From: Junio C Hamano <gitster@pobox.com>
>>
>> Some platforms (like SunOS and family) have kept their common binaries at
>> some historical moment in time, and introduced new binaries with modern
>> features in a special location like /usr/xpg4/bin or /usr/ucb.  Some of the
>> features provided by these modern binaries are expected and required by git.
>> If the featureful binaries are not in the users path, then git could end up
>> using the less featureful binary and fail.
>>
>> So provide a mechanism to prepend elements to the users PATH at runtime so
>> the modern binaries will be found.
> 
> So this bit me already, and it's only been in next for a day. :) I
> _already_ have /usr/xpg4/bin in my PATH before /usr/bin, but with this
> patch, I get it stuck at the _beginning_ of my PATH automagically. Which
> overrides, against my wishes, the "even more sane than /usr/xpg4/bin"
> part of my PATH that comes at the beginning.
> 
> Specifically, I have "~peff/local/bin" at the beginning of my PATH which
> contains a 'vi' that points to vim. Running "git rebase -i" now puts
> /usr/xpg4/bin at the beginning of the PATH (before ~peff/local/bin),
> which means I end up running the crappy system vi instead. For bonus
> fun, "git commit" still runs the correct 'vi' because it doesn't happen
> to be implemented as a shell script.
> 
> Am I crazy for not having EDITOR=vim instead of EDITOR=vi? Perhaps. But
> I wanted to point out that tweaking the PATH behind the user's back does
> cause surprises in the real world.

Good points.  I'm fine with dropping this patch, especially when it causes
problems for a real Solaris user, which I'm not.

I don't like that git has a dependency on the user's PATH being set
correctly though.  That's why I liked the patch.  I guess I could modify
all the uses of sed and friends to look like $SED and then set SED to
/usr/xpg4/bin/sed on Solaris.  It doesn't sound like that is necessary
in practice though.

btw, this patch does help the test suite when the test suite is run using
make.  The patch added SANE_TOOL_PATH to PATH in the Makefile.

-brandon
