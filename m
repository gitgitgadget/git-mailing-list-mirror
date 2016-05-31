From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add without whitespace
Date: Tue, 31 May 2016 09:16:21 -0700
Message-ID: <xmqqvb1u5hka.fsf@gitster.mtv.corp.google.com>
References: <CAHd499Agn=vLBxDpHi2dy1HMy-_58PZGs7VNtFJnBfP5zXatTA@mail.gmail.com>
	<xmqqlh2r8ixu.fsf@gitster.mtv.corp.google.com>
	<CAHd499Drdt6GoScdksNNWLrsvG3Dex7fTYNhatL-qboCPW5RZQ@mail.gmail.com>
	<xmqq8tyr8aur.fsf@gitster.mtv.corp.google.com>
	<CAHd499AreoaqfCVGi6XiatiWQMzf+KqL=a+f3D8u53dNkg0tiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 18:16:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7mLH-00021P-1T
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 18:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbcEaQQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 12:16:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750744AbcEaQQY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 12:16:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 626091D447;
	Tue, 31 May 2016 12:16:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L07nARjoYxHmw2qWwAxUao/Na5E=; b=SjBsZl
	ukok2YjEptvKMLBkt+2nck/CZWH23DyRnleLPcZEZKQFCR4AVsiSWGXYxgqgk++N
	/BJZlJnjLepPhdxudXlBY1/pWlZuJQK5Atr4n5g4JyrghGAm6HS6ZFqmBUI863zj
	dp9ZTNY6+dAVTmoLsXFsf4j5HerbrE9EyVr50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWjw7JlT/eQ5igcjuSXU+tGoZn/hxSUY
	TkG3hDnAGDs28lS4Md/2piinplLsmJQJPDk27WO+PNbTXvi/kEd6KQEl055CSGfF
	QYRgiFrg8dL4X7Ze+XUCtz3Bh9sQek6HiIIDjUufW1d4ZsXv8Ana/N6dYdbpSvjr
	4Gt+uTF8JqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BCA11D446;
	Tue, 31 May 2016 12:16:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E99061D445;
	Tue, 31 May 2016 12:16:22 -0400 (EDT)
In-Reply-To: <CAHd499AreoaqfCVGi6XiatiWQMzf+KqL=a+f3D8u53dNkg0tiQ@mail.gmail.com>
	(Robert Dailey's message of "Tue, 31 May 2016 10:03:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 044E7600-274B-11E6-8A24-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295993>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> - Splitting whitespace & real changes to two commits is probably
> superfluous; my original goal was to make diffing the actual changes
> easier, but since 'git diff -w' exists this is moot.

Doing "whitespace clean-up" in a separate preparatory patch _is_ a
good practice.  I do not think either approach makes it harder to
do.  After all, if you had a real change on the same line that you
dropped a broken whitespace, e.g. (end-of-line shown with '$')

    -	if  (i==1) {  $
    +   if (j == 2) {$

both approaches would add the updated line.

The wsadd is about protecting _me_ from introducing new whitespace
breakages, not about helping me when fixing existing whitespace
breakages.  So from that point of view, that may not fit well to
what you are trying to do.
