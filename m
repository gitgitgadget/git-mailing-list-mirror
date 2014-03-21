From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Fri, 21 Mar 2014 07:12:40 +0100
Message-ID: <87txascc6f.fsf@fencepost.gnu.org>
References: <1395232712-6412-1-git-send-email-dak@gnu.org>
	<20140320234859.GD7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQuBa-0006Gr-C2
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbaCUHsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:48:01 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:41250 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768AbaCUHsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:48:00 -0400
Received: from localhost ([127.0.0.1]:40286 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WQuBL-00025N-DI; Fri, 21 Mar 2014 03:47:59 -0400
Received: by lola (Postfix, from userid 1000)
	id D0DFDE08C8; Fri, 21 Mar 2014 07:12:40 +0100 (CET)
In-Reply-To: <20140320234859.GD7774@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Mar 2014 19:48:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244674>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 19, 2014 at 01:38:32PM +0100, David Kastrup wrote:
>
>> The default of 16MiB causes serious thrashing for large delta chains
>> combined with large files.
>
> Does it make much sense to bump this without also bumping
> MAX_DELTA_CACHE in sha1_file.c? In my measurements of linux.git, bumping
> the memory limit did not help much without also bumping the number of
> slots.

In the cases I checked, bumping MAX_DELTA_CACHE did not help much.
Bumping it once to 512 could be a slight improvement; larger values then
caused performance to regress.

> I guess that just bumping the memory limit would help with repos which
> have deltas on large-ish files (whereas the kernel just has a lot of
> deltas on a lot of little directories),

Well, those were the most pathological for git-blame so I was somewhat
focused on them.

> but I'd be curious how much.

http://repo.or.cz/r/wortliste.git

consists basically of adding lines to a single alphabetically sorted
file wortliste of currently size 15MB.

-- 
David Kastrup
