From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: nested submodules get an absolute gitdir path
Date: Wed, 06 Apr 2016 08:02:27 -0700
Message-ID: <xmqqmvp6zsos.fsf@gitster.mtv.corp.google.com>
References: <CALoo-5WcdMNMcCW0EQv1VqkE5Ax7bMnvo2r7niYhYyMjA8c4wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Antti Halttunen <Antti.Halttunen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:02:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anoyb-00064F-KU
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 17:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbcDFPCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 11:02:32 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59025 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753215AbcDFPCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 11:02:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C03452C5C;
	Wed,  6 Apr 2016 11:02:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DAjUsS1YpSPh199+td5kA4ZYEMg=; b=e4PbUO
	AncDzq1p46D6SdVlV/Djg0oO+dfjVKQtwKOQAeI69Ba9+LY+C3jMrQiKZu77cFRS
	Xq0NFHvHD/SU4tsqob1Crq1Bnhw+qHNZ4XlAbegXxWePnHpPjKIPn4R0wMen+E/h
	EkEQ4sHIfGHH4+q+gAngXdHMBi85zmYT0hoCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k4RFG5qytl7ugxFXIzWYzQ6dS0tc2M+u
	Tvw6dnRV68QDmWFEgNBe8j65NynyiXxwPUvP8w4AGLP7CY4cVhPIniJSIraHAZ4e
	dfM0tMmAUwR/tI8xoTQFKBGP0G57ZsejcYh5iUAm/Ezz5L3zKR30ES604CULATcc
	uiPTRZXlGg0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E8C052C5A;
	Wed,  6 Apr 2016 11:02:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 97EC352C58;
	Wed,  6 Apr 2016 11:02:29 -0400 (EDT)
In-Reply-To: <CALoo-5WcdMNMcCW0EQv1VqkE5Ax7bMnvo2r7niYhYyMjA8c4wg@mail.gmail.com>
	(Antti Halttunen's message of "Wed, 6 Apr 2016 10:02:47 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 951DF5B6-FC08-11E5-BA4C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290842>

Antti Halttunen <Antti.Halttunen@iki.fi> writes:

> Starting with git v2.7.0,
>
> submodules two levels deep get a .git contents of:
>  gitdir: /absolute/path/name

I think that this is $gmane/290491

http://thread.gmane.org/gmane.comp.version-control.git/290491

and queued as sb/submodule-helper-clone-regression-fix topic,
currently included on the 'pu' branch.  Can you try it and see if it
fixes your issue?

Thanks.

>
> This breaks repos that are moved or copied:
>
> fatal: Not a git repository:
> /tmp/tmp.gIyxKWIC26/repo/.git/modules/sub/modules/sub
> fatal: 'git status --porcelain' failed in submodule sub
>
> The script https://gitlab.com/snippets/17301 reproduces the issue.
>
> git bisect points to commit ee8838d1.
>
> thanks,
