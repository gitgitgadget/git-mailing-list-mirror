From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git abbref-ref: new porcelain for abbreviate_ref()
Date: Mon, 22 Sep 2008 08:55:20 -0700
Message-ID: <7vtzc8xjiv.fsf@gitster.siamese.dyndns.org>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
 <1222074591-26548-2-git-send-email-bert.wesarg@googlemail.com>
 <1222074591-26548-3-git-send-email-bert.wesarg@googlemail.com>
 <20080922153222.GD3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	szeder@ira.uka.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 22 17:56:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhnmJ-0002Rt-5W
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 17:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbYIVPzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 11:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYIVPzh
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 11:55:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbYIVPzh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 11:55:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B8AD964CDD;
	Mon, 22 Sep 2008 11:55:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EAC8D64CD4; Mon, 22 Sep 2008 11:55:28 -0400 (EDT)
In-Reply-To: <20080922153222.GD3669@spearce.org> (Shawn O. Pearce's message
 of "Mon, 22 Sep 2008 08:32:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E45CE94A-88BE-11DD-A5AF-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96485>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> This gives direct access to the abbreviate_ref() function. The operation
>> mode defaults to the core.warnambiguousrefs value, like the refname:short
>> format, but can be explicitly changed with the --{,no}-strict option.
>> 
>> The bash completion script utilizes this new command.
>
> And it slows down too, doesn't it?  Now we are doing a fork per
> branch during completion.  Yikes.  Didn't you just post a series
> about making completion faster?
>  
>> Junio, if this is not a porcelain, tell me.
>
> IMHO its plumbing.  Porcelain is used by a human.  Plumbing is the
> bits needed to make human interfaces.

Shawn is right.

I wouldn't be taking this patch to add a new command, but I suspect that
this could be an option to rev-parse that is similar to --symbolic.

Teach SHOW_SYMBOLIC_SHORTEST to builtin-rev-parse.c::show_rev(), teach the
parser cmd_rev_parse() a new option --symbolic-abbrev and you are done,
right?

By the way, I found it amusing to see Cc: lines _after_ three dashes to
control send-email --- nice trick I didn't think of ;-)
