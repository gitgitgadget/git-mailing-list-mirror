From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse-options: Add support for dumping out long
 options
Date: Sun, 15 Apr 2012 12:23:01 -0700
Message-ID: <7v39842416.fsf@alter.siamese.dyndns.org>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
 <1334140165-24958-2-git-send-email-bebarino@gmail.com>
 <20120411140651.GR2289@goldbirke> <4F868060.1000709@gmail.com>
 <20120415124919.GD2900@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org, felipe.contreras@gmail.com, jrnieder@gmail.com
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Apr 15 21:23:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJV2V-0002wf-2y
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869Ab2DOTXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 15:23:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab2DOTXD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 15:23:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FABD6C14;
	Sun, 15 Apr 2012 15:23:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mRZrbMzuAo4E
	nTokvooCdHKQnJ4=; b=SynQ/5iVJ6peKgpxhiRyfguZ1v4l2+4R5LG0jz8jQqVf
	EIgvEJkbZRtQd9nd4871kpP5e8z2GQwrFrjJ13vcQ/l78qeHl4HIUHFefRxTYhnW
	KDm8PDmS+O8Ao3aef93bQI0G8AcK3i/d0HvDoMkk9gX8F6Rkrv8RHsNlv1KIc0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RyK6Vo
	wcKIdYYx0vR3t5Gx+/zizAmbi0567Qdpk5q08rm906NUb5kuDh7eVwoYzDJBff7R
	Rmv2puAB1+STIeyHefhuyJrtxbVnG/AmRSsW1pcQStbwq3Csj/JbWp+KxdBhnbj0
	9Qj1gwigMXjrBGxrQeF7SpTUZfsrITGTU5swE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E4E6C13;
	Sun, 15 Apr 2012 15:23:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F027D6C12; Sun, 15 Apr 2012
 15:23:02 -0400 (EDT)
In-Reply-To: <20120415124919.GD2900@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of "Sun, 15 Apr 2012 14:49:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B8B0AD2-8730-11E1-BF83-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195575>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Parse options already has the PARSE_OPT_HIDDEN flag to omit an option
> from the default usage.  Your patch already respects that option, so
> e.g. 'git commit --<TAB>' won't offer '--allow-empty', which is meant
> for foreign SCM interface scripts.  This is good.
>
> However, '--force' is different,...

Don't we have enough bits in PARSE_OPT_* namespace so that we can spare
one for PARSE_OPT_OMIT_FROM_COMPLETION?
