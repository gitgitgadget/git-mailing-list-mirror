From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git ls-files and ignored directories
Date: Sun, 03 Jun 2012 15:24:38 -0700
Message-ID: <7vwr3ovxsp.fsf@alter.siamese.dyndns.org>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com>
 <20120531101451.C35C5B4C00D@dd24126.kasserver.com>
 <20120601093757.GE32340@sigill.intra.peff.net>
 <7vr4tz3tpw.fsf@alter.siamese.dyndns.org>
 <CACsJy8CqMudg=uKuDmRHoYAXhUoYhOp3V2ZLuKM8W5wWWE460w@mail.gmail.com>
 <4FC9F24D.7000306@phononoia.at> <7vr4txz5j9.fsf@alter.siamese.dyndns.org>
 <4FCB4E1E.2010907@phononoia.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>,
	git@vger.kernel.org
To: bilderbuchi@phononoia.at
X-From: git-owner@vger.kernel.org Mon Jun 04 00:24:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbJEC-0005Wi-RK
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 00:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab2FCWYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 18:24:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823Ab2FCWYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 18:24:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 606B28453;
	Sun,  3 Jun 2012 18:24:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0PDi+8hGaLKCGA+De5mgPK8sHkI=; b=szFQy3
	oTZqQzlzgMCWSji8PeXiAh2qg18J9WVtWAgKZ8fal383IwNupewP5f/ctZ/ykfBW
	42r5R/QodF9iZu93KCTwDL5yLGd4NL0Dg1ZSJomQi7lAlbnFqzGii+yGQkB+1Lo0
	DWISGcRV89OzPBv8EXSa8HrHnAohTswdiXyz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lWbmL/+G1qgzYcsGVinTastd5qyqaHdW
	RJyqrYqcT/RSOOo4rfLbOonlDwQxs86T0h5D/5l9Dle/JSA5tYMPMZRCNOjpC/73
	tx2ylKhL/61jOjzcR9ZSmmq+JGC3L6k9Mp2sd9bsnc6rovKcqc2F0PYSx8nmSOCK
	Uy3how44VvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5DF8452;
	Sun,  3 Jun 2012 18:24:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D41C58451; Sun,  3 Jun 2012
 18:24:44 -0400 (EDT)
In-Reply-To: <4FCB4E1E.2010907@phononoia.at> (Christoph Buchner's message of
 "Sun, 03 Jun 2012 13:44:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBCB7A68-ADCA-11E1-ACAE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199109>

Christoph Buchner <bilderbuchi@phononoia.at> writes:

[please do not top-post]

> On 06/03/2012 12:56 AM, Junio C Hamano wrote:
>
>> The patches are queued to 'pu'.  Do they fix your issue?
> 
> Yes they do.
> In my test repo, git compiled from current pu branch shows
> git ls-files --exclude-standard -i
> apps/devApps/projectGenerator/.svn/wrongly-committed-svn.txt
> apps/devApps/projectGenerator/some-wrong-file.txt
> while git 1.7.9.5 shows
> apps/devApps/projectGenerator/some-wrong-file.txt
>
> Thank you for fixing this! Which git release is planned to contain the
> fix (if that can be said yet)? I'm not familiar with your workflow..

As we are already in "regression fix only" phase, it won't be in the
upcoming 1.7.11 series, even though it may deserve to be in 1.7.11.2
maintenance release.

I see other uses of excluded() in builtin/add.c and unpack-trees.c;
these call sites need to be audited.

If they have the same problem, it probably is a good idea to convert
them to use path_excluded(), move the path_excluded() function and
its supporting infrastructure from builtin/ls-files.c to dir.c, and
make excluded() a file-static function to dir.c in order to avoid
similar problems in the future.  Or their use may be alright.

The work described in the previous paragraph preferrably should
happen before the change is shipped as part of any release.
