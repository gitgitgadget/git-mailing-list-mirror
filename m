From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 13 Mar 2016 23:57:49 -0700
Message-ID: <xmqqk2l58s2a.fsf@gitster.mtv.corp.google.com>
References: <56E3BE3E.9070105@gmail.com>
	<1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sidhant Sharma <tigerkid001@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 07:57:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afMRy-0007ur-Jy
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 07:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130AbcCNG5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 02:57:55 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932252AbcCNG5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 02:57:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FC4746920;
	Mon, 14 Mar 2016 02:57:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EMe4xqP2ZWFaxLM53sv1Qk1ubi8=; b=UaDizH
	h2k2fXatLkvYRPEkJ2TF+0nv2tKJ0hVuV6DR+w6vaMYFonp6s/U928VwJiTjOcFn
	MdfXBH+dFZHxHJgKsV/PNiWo9k/qyVebLjK/Gau6XGPkXMp1UCxzmCLOVTPcAvRd
	HFP982jhDHgdEhu5FrCFAgS+WSzbRx3uoa9G0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fzSsFCiV9bp1ggqwll7tF5awUwGRb01u
	G9gF4h5gWw+CliRul/0t4HrEOCNGQ3SvXxwlugSrrAF/kNSdR//9kf6nPk0RpKTa
	XyKx6qZO2oHQ0pNBFn7XvxznnwFdgInPxm4VrHnLusF/gzICAjJ2zDXP7lVGhKlI
	nz18XWwyXYo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2654C4691F;
	Mon, 14 Mar 2016 02:57:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 93FB24691E;
	Mon, 14 Mar 2016 02:57:50 -0400 (EDT)
In-Reply-To: <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com> (Lars
	Schneider's message of "Sun, 13 Mar 2016 16:50:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 112B8100-E9B2-11E5-BF1F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288770>

Lars Schneider <larsxschneider@gmail.com> writes:

> I thought a while about this requirement and I wonder if a wrapper called 
> 'ggit' (guarded Git) could be a solution. The wrapper would pass all 
> command line arguments to 'git' and check for potentially destructive 
> commands. If such a command is detected then the user would see a warning.

I recall back in the days when people said that Hg's command set was
so much more pleasant to use that some people thought about building
Hg's command line UI on top of low level implementation of the Git's
data structure.  Even before that time, there was an effort "Cogito"
to build an alternate UI on top of Git core.  If "ggit" can be made
reasonably feature complete in such a way that it lets beginners do
all what they need to do, omitting many advanced/hairy features core
Git may let users use (i.e. making trade-off between power and risk
of misuse differently from core Git), that may be a reasonable way
to offer a "beginner mode".

The beauty of such an approach is that as long as "ggit" correctly
talks the same on-wire protocol when interacting with other people's
repositories, nobody needs to even know or care that you are using
"ggit" exclusively.  Two systems can talk without problems.

If "ggit" is made too limited, there is an issue.  Beginners may at
some point need to transition to the real thing to fully exploit the
power of Git, and they may need to unlearn "ggit" and learn Git.
This approach, if it wants to become successful in helping users,
would take quite a lot of thinking and work to avoid omitting too
much to necessitate users to migrate to Git.  But I can very well
imagine that a new "Cogito 2" project (I am not saying that the UI
Cogito tried to achieve were superiour or anything of that sort--I
just needed a name, and picked one name that came to my mind) may
get done by those who interact rarely with the core Git community
and may live as one of many independent and viable third-party
projects you find on GitHub.

There however are two questions I do not offhand have good answers
to: (1) if that kind of effort is of suitable size for GSoC, and (2)
if it is suitable to be supported by the Git project proper.
