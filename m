From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git alias and --help
Date: Fri, 28 Oct 2011 11:00:31 +0200
Message-ID: <4EAA6F2F.5020301@drmicha.warpmail.net>
References: <j8clg9$ldh$1@dough.gmane.org> <7vfwiexe6m.fsf@alter.siamese.dyndns.org> <7v8vo6xd4u.fsf@alter.siamese.dyndns.org> <buoty6t9937.fsf@dhlpc061.dev.necel.com> <7vvcr9wyje.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, Gelonida N <gelonida@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 11:01:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJiJC-00010N-3F
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 11:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586Ab1J1JAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 05:00:35 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51154 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750915Ab1J1JAe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 05:00:34 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2DCF020CA1;
	Fri, 28 Oct 2011 05:00:34 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 28 Oct 2011 05:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=yCRLR6B2aVxeNuDWqjjLHG
	v0lyo=; b=f1q+qacwQQFMsxaXQ+R9bufBgyW+CVhS04Y0gx0D/K6kvxjc3q4GUI
	LQcjtH1bq2DE9dbdVkUdYlbzarfE1267pASGKtV+032X/g4KnQoEWMUNcKhk7T/H
	LAbA/U443Ww7nRUSCQcISJobAhHfiuWbLXwaI2qi6juRsYjhpQz5I=
X-Sasl-enc: lAfgQT9+Rp6qtYxmtqNTvRbePuZ4EtsQQZ5rY/kz5RZW 1319792433
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 463AD40DE92;
	Fri, 28 Oct 2011 05:00:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7vvcr9wyje.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184343>

Junio C Hamano venit, vidit, dixit 28.10.2011 06:05:
> Miles Bader <miles@gnu.org> writes:
> 
>> Of course, that would be the wrong thing for somebody that just wants
>> to be reminded what an alias expands too, but my intuition is that
>> this is a very tiny minority compared to people that want to examine
>> the options for the underlying command...
> 
> And it is doubly wrong if help backend is configured to be anything but
> manpages, no?
> 
> As I said, you should be able to come up with a patch that detects and
> special cases the no frills case (replacement to single token) to get what
> you want.

But "help" is still too much to type for the OP ;) How about this in
your config:

[alias]
	h = help
	hh = "!sh -c 'a=$(git config --get alias.$1); : ${a:=$1}; git help
${a%% *}' -"

Ugly as hell, I know, and works only for aliases whose first word is the
name of a git command, as well as for non-aliases. Catching "!command"
type aliases is left as an exercise to the reader.

Michael
