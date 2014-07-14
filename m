From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon, 14 Jul 2014 15:16:04 -0700
Message-ID: <xmqq8unvy4bf.fsf@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<1405140276-32162-4-git-send-email-dturner@twitter.com>
	<CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
	<xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
	<53C41456.2000006@ramsay1.demon.co.uk>
	<xmqqvbqzygkm.fsf@gitster.dls.corp.google.com>
	<53C42453.1090109@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 15 00:16:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6oXh-0007Ag-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 00:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251AbaGNWQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 18:16:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61648 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757117AbaGNWQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 18:16:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ADF4027B26;
	Mon, 14 Jul 2014 18:15:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nz2ikKG+WGrKoPkzt5adiRPL35w=; b=YvXaO7
	QasBlZrBNhEteMl2T70pe9m/Hje9XKkHV21OT+z1Seckk/HsdCBM5Ar6mLYh23H6
	DEgMY0cPefj+wLgvXNsZrwPA8UqRI37ky6CdDHk/uTbZuzBFKu2izc8BEa4o0Szh
	qIHa3SpHLWFXPm4QeiUsannTyAD1LmckokZA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wH2R612nRYulPMj2IodrdqePfv5au4ty
	ODCrBNma/G90tLhqexYwtBn+R4qeUX6QeEOnrlxyPrPileeEK4SHGzFPWHfqfT1B
	/hstXrg221hiURz0F3mu1f5ZH5jekNBCYyqQ+fTs+Ds+ntVwPEpH5OAbrHxZK85M
	hRFiSYnllfw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A39E927B25;
	Mon, 14 Jul 2014 18:15:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2516B27B20;
	Mon, 14 Jul 2014 18:15:49 -0400 (EDT)
In-Reply-To: <53C42453.1090109@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 14 Jul 2014 19:41:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 68F90AF8-0BA4-11E4-9D66-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253542>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 14/07/14 18:51, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>> 
>>> that the merge commit 7608c87e fails. Looking at the details of the
>>> merge resolution, made me think of Duy's split index work.
>> 
>> Yes, there is a deliberately dropped hunk from dt/cache-tree-repair
>> in that merge, because the topic relied on being able to say "here
>> is the file descriptor, write the index to it", which no longer is
>> available with the split-index topic.
>
> Ah, OK. Sounds like everything is under control then.

Wasn't, but now I think it is ;-)

David, could you please double check the conflict resolution at
882426ea (Merge branch 'dt/cache-tree-repair' into jch, 2014-07-14),
at about the middle between master..pu?  By eyeballing

    git diff 882426ea^ 882426ea

we should see what your series would have done if it were based on
top of the nd/split-index topic.  The most iffy is the first hunk of
change to builtin/commit.c, which is more or less my rewrite of what
you did on top of 'master'.

The change to builtin/checkout.c also seems somewhat iffy in that we
treat the_index.cache_tree (aka "active_cache_tree") as if cache
trees are something we can manipulate independent of a particular
index_state (which has been the rule for a long time), even though
in the world order after nd/split-index topic, cache_tree_update()
can no longer be used on a cache-tree that is not associated to a
particular index_state.  It is not a problem with your series, but
comes from nd/split-index topic, and it might indicate a slight
unevenness of the API (i.e. we may want to either insist that the
public API to muck with a cache-tree outside cache-tree.c must be
accessed via an index-state and never via a bare cache-tree
structure, by insisting that cache_tree_fully_valid() to take a
pointer to an index-state as well; or we may want to go the other
way and allow API users to pass a bare cache-tree without the
index-state when the latter is not absolutely necessary, by changing
cache_tree_update() to take a cache-tree, not an index-state).
