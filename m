From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Mon, 01 Jul 2013 15:05:12 -0700
Message-ID: <7vd2r2aq00.fsf@alter.siamese.dyndns.org>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
	<51A7A5F9.2030107@web.de> <7v61xwpct5.fsf@alter.siamese.dyndns.org>
	<51AD0A25.5080101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 02 00:13:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmLL-0005ln-JR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab3GAWMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:12:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755675Ab3GAWMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:12:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1BD12D378;
	Mon,  1 Jul 2013 22:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=rM9pPOPmp6nUY6BpCGCLMi2N6uQ=; b=OATPs/LBHKKm7Sym9fMU
	Br3sHQaLgsH1VrT1wLdOHMaLFF8UEXHub10XHHg3xCcVWBiwAATsUe+GxVuaGy9h
	sZzlPJgEfUvEzwMa8gVvfOL0rKmiPUkySipDv85o3GR52IgEtSYzmDo54fQcwHKN
	jTAZHTRZTSRMGQQbQBsSo9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=JyR6weyCSlUYiFApwVSvdZPnme+HuL2rKJXntCKl96yFoW
	kjXbBYbIYSsMCl/QQeP+eGlnuYAuJfjSaJmGG2LywbAxMVNC0sZV+xg+oF60pePa
	H5riwQeQt5FjjvF7YztLfXLGrfFVH2f4tpS4z+MU12rn/4eTiQm2xcNpn07D4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95DE82D377;
	Mon,  1 Jul 2013 22:12:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB6592D371;
	Mon,  1 Jul 2013 22:12:48 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D6C83D2-E29B-11E2-B7C8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229338>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 02.06.2013 20:50, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> 
>>> Am 30.05.2013 01:58, schrieb Junio C Hamano:
>>>> * jl/submodule-mv (2013-04-23) 5 commits
>>>>   (merged to 'next' on 2013-04-23 at c04f574)
>>>>  + submodule.c: duplicate real_path's return value
>>>>   (merged to 'next' on 2013-04-19 at 45ae3c9)
>>>>  + rm: delete .gitmodules entry of submodules removed from the work tree
>>>>  + Teach mv to update the path entry in .gitmodules for moved submodules
>>>>  + Teach mv to move submodules using a gitfile
>>>>  + Teach mv to move submodules together with their work trees
>>>>
>>>>  "git mv A B" when moving a submodule A does "the right thing",
>>>>  inclusing relocating its working tree and adjusting the paths in
>>>>  the .gitmodules file.
>
> <detailed discussion snipped>
>
>> So my gut feeling of the "fix" at this point in the evolution of the
>> program may be to error out with a message like "You have local
>> changes to .gitmodules; please stash it before moving or removing".
>
> Yeah, me too thinks that this is a sane short term solution (even
> though a "git submodule add" currently happily stages any unstaged
> modifications to the .gitmodules file too, that should not stop us
> from doing better for rm and mv ;-).
>
> And I also agree that in the long run the the git-config aware merge
> driver together with the 3-way merge of a modified .gitmodules file
> you described is the best solution. But I'd really like to complete
> the recursive update before tackling that, so for now I just added
> these two to the to-do list on my GitHub wiki page.
>
> I'll resubmit this series with the strlen() fix and the erroring out
> in case of unstaged modifications of the .gitmodules file as soon as
> I find some time.

Ping?

No need to hurry, but just to make sure this didn't disappear from
everybody's radar.

Thanks.
