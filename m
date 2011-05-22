From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gate between git and mediawiki : remote-helpers
Date: Sun, 22 May 2011 12:31:27 -0700
Message-ID: <7vfwo6y1kg.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
 <BANLkTim+2Mv7bnfsNVAsn80MUx8-fjYZow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	"matthieu.moy" <matthieu.moy@grenoble-inp.fr>
To: Claire Fousse <claire.fousse@gmail.com>,
	Arnaud Lacurie <arnaud.lacurie@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 21:31:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOENY-00008H-JN
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 21:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab1EVTbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 15:31:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab1EVTbo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 15:31:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29E8C45EE;
	Sun, 22 May 2011 15:33:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TgmirCOgFyq68Xvkydbvfpx9y3I=; b=n97jXa
	NvJ6DK2iEAvecHkFpCisbu4DtnW7BdO5mppUuYuiETCv77dLPvOLcX6aS2EMFKC9
	ta+0TEqmJ9u8zqFKEObvf/odqTPwKi9Ye3lKIkLHxQf7OqMkaDK2jAETuDj8/pO0
	oAxZmxOrZLQyPoPNKUWeJqyvId0qhEmGfOQCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U7ARvBfS1UgKceU/xZjrAdofIOWD5SrB
	jpibNPLC4bZhd7whU4OmyaODNqf2IW1ou/G5h68R6Wg/XpEXouZ2YXELg0SZvxpG
	iVkrtjasRoUfZ+pyl8V0APlBlDPohFi6xzA6a443JujuQ7y7/4+vgbnU3vkARz7I
	3/IRsT6isY8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC4ED45EB;
	Sun, 22 May 2011 15:33:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 15A2F45E8; Sun, 22 May 2011
 15:33:35 -0400 (EDT)
In-Reply-To: <BANLkTim+2Mv7bnfsNVAsn80MUx8-fjYZow@mail.gmail.com> (Arnaud
 Lacurie's message of "Sun, 22 May 2011 19:58:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66EAC2DA-84AA-11E0-89E6-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174195>

Arnaud Lacurie <arnaud.lacurie@gmail.com> writes:

> This mail referred to that previous one :
> http://article.gmane.org/gmane.comp.version-control.git/173991
>
> 2011/5/22 Claire Fousse <claire.fousse@gmail.com>:
>> Hi,
>>
>> I'm a member of the team trying to establish a gate between mediawiki
>> powered wiki and git.
>>
>> We've tried several things which seems to work. However, it is
>> something like git-svn and would require some commands such as git-mw
>> to work. Is it recommended to use remote-helpers instead of that ?

I am not Matthew, but my gut feeling is that it largely depends on what
you are interacting with, and how you envision the result to be used in a
larger MediaWiki ecosystem.

In the case of SVN interoperability, there is an established community
that exchanges their work via:

	svn checkout svn://some.where.xz/project
        svn update
	svn commit

and although people on the git side can already participate with:

	git svn init svn://some.where.xz/project
        git svn rebase
        git svn dcommit

it is understandable that they wish to be able to say:

	git clone svn://some.where.xz/project
        git pull -s rebase
        git push

to make it feel more similar to the native git experience. Now, even if
there may be no "svn checkout/update/commit" equivalents in the workflow
of established MediaWiki users, it may be nice to be able to work with:

	git clone --vcs=mediawiki http://some.where.xz/wiki/
        git pull
        git push

>> There is one problem though : nobody wants to git clone the whole
>> Wikipedia for instance.

Then don't let them in your initial version. I do not see any problem in
that. People can gain experience with smaller projects, like so:

	git clone --vcs=mediawiki https://git.wiki.kernel.org/
        git pull
        git push

When we need narrow (in the tree dimention) or shallow (in the history
dimention) in either native or foreign transports, somebody would
eventually add proper support. Currently we do not do "narrow" even for
native transport (I have one cooking privately but it is progressing only
slowly, and I think there may be others who are interested in it).

I would suggest not to be worried too much about narrow/shallow in your
initial round.
