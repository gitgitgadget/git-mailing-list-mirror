From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sun, 21 Mar 2010 22:32:56 -0700
Message-ID: <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
 <4BA544FC.7050007@gmail.com>
 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
 <4BA61CF9.7040104@gmail.com>
 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 06:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtaGv-0001Vx-46
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 06:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab0CVFdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 01:33:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab0CVFdq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 01:33:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B14AA4576;
	Mon, 22 Mar 2010 01:33:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pC9HE5dgdbt8vOurgg9i4Yu8peg=; b=IrGxq9
	2kLPb37v6uGlCp9/GM0SJKwmFv5qVSa29ODTVHF1pJPYTlZSr3xP2HpgDejCxcro
	LRGZdP5mMqjcu0nbHdh/7cIVerVsvghJnbbn64jzDOCc08cO0gAa3NnfJfvsq44C
	R2yherre57hzb1rBAcV2ml9CXIFSmsV4UnUQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PL9GMh7NhYxwOo6doAOSVUbbdWCj+d1w
	Ol5HRok5fDOiNUNjItZaJlgD4Hx+ZnizG3q7do1c/sZSuA6a6Xfg3FQidZGrQVO1
	GJXF5a5GTGR+yKOwlloyY4jECftDVaCLONvuTwJIjGReuXEHAqTs017zylC1o+w5
	72BIysck1mc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE014A4575;
	Mon, 22 Mar 2010 01:33:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C58BA4574; Mon, 22 Mar
 2010 01:33:24 -0400 (EDT)
In-Reply-To: <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
 (Bo Yang's message of "Mon\, 22 Mar 2010 12\:34\:26 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7908B110-3574-11DF-A4F9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142900>

Bo Yang <struggleyb.nku@gmail.com> writes:

> The 'blame' way is very good if we only support one line range. But if
> we want to support multiple line ranges, I don't think it is suitable
> for that case. Anyway, how can I specify multi-ranges which refers to
> multiple files at multiple revision and multiple line ranges using
> above syntax?

I would sort of see you may want to be able to say "explain lines 10 thru
15 of config.h and lines 100-115 of hello.c that appear in v1.2.0", but I
think it is a total nonsense to ask for "ll 10-15 of config.h in v1.2.0
and ll 110-115 of hello.c in v1.0.0".  After all they never existed in the
same revision (otherwise you would have said "ll 7-13 of config.h and ll
110-115 of hello.c that appear in v1.0.0").  So I would reject the
SVN-like "rev@" in the first place.

While I don't seriously buy "multiple files" either, if that is really
needed, I could be pursuaded with  "log -- path1:10-15 path2:1-7", or
"log -L path1:10-15 -Lpath2:1-7 -- path1 path2" or something similarly
ugly like these, but that is not how we generally name things, and it
probably shouldn't be a new option to "log" anymore.

On the other hand, multiple ranges in a single file is something that
may be quite reasonable, e.g.

  $ git log -L10-15 -L200-210 -- Makefile
  $ git log -L'*/^#ifdef WINDOWS/,/^#endif \/\* WINDOWS \/\*/' -- config.h

As I already said, I wouldn't be so worried about multiple-range feature,
but I would be worried about the usefulness of this feature, even for the
case to track a single range of a single file, starting from one given
revision.  When you want to know where the first few lines of Makefile
came from, and if blame says the first line came from 2731d048, that
really means that between the revision you started digging from and the
found revision, there is no commit that touched that particular line, but
equally importantly, that before that found revision, there wasn't a
corresponding line in that file---blame stopped exactly because there is
nobody before that found revision that the line can be blamed on.

So implementing "git log -L1,10 -- Makefile" might be just the matter of
doing something like:

 1. Run "git blame -L1,10 -- Makefile";
 2. Note the commits that appear in the output;
 3. Topologically sort these commits;
 4. Run "git show <the result of that toposort>"

which is not very satisfying.

And "git log -L1 -- Makefile" naturally degenerates into:

 1. Run "git blame -L1,1 -- Makefile";
 2. Note the commits that appear in the output;
 3. Run "git show <that commit>"

which is not just unsatisfying, but is almost boring.

I dunno.
