From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] NetBSD 6?
Date: Wed, 02 Jan 2013 18:15:49 -0800
Message-ID: <7vd2xnypt6.fsf@alter.siamese.dyndns.org>
References: <7vd2xn18p5.fsf@alter.siamese.dyndns.org>
 <rmipq1numzj.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 03:16:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqaLt-0004js-8Z
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 03:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab3ACCPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 21:15:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35307 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762Ab3ACCPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 21:15:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52506AAE6;
	Wed,  2 Jan 2013 21:15:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GC07e/UR+zfyql/L5MnvDut+Fcc=; b=YAacrq
	MqcVEbVmGUGQrJoVHPs8a2ekbw1t8Ny8bzepbpwxnGRw4LapXq1SrsCkdo+pI70w
	h8gtlwh15hcSlw+6vRplJ8RdfbE8SeMQc+P5mgQJnx7c9F6jPyhfDlpVSQ2Iubn5
	uGipZ30AN8w35NVYIfS4GquDwE5iUufBFSJ8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BMxNzRhOfmkvd5bDgtEcbyW179Vqtxbi
	hhbPtc+hbCzvbQnkcS0V0F0iEi+/oBEM2bpqfEcLxeYrAWdKZvBFAHPOwGKpF7I2
	RyCW1suQxUZPu8RP29RXnVvZtYWfeEa860HY/4bvb929b2o99xaH9T8YaQ4MJm1K
	pM4rEXvEvMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34145AAE4;
	Wed,  2 Jan 2013 21:15:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F89BAAE1; Wed,  2 Jan 2013
 21:15:51 -0500 (EST)
In-Reply-To: <rmipq1numzj.fsf@fnord.ir.bbn.com> (Greg Troxel's message of
 "Wed, 02 Jan 2013 19:30:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EFD06F8-554B-11E2-9A22-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212567>

Greg Troxel <gdt@ir.bbn.com> writes:

> I realize a README.foo file for N different systems could be clutter,
> but having these checked in would provide the concise help that people
> on any of those platforms need.

Our Makefile documents knobs people on various platforms can tweak
(PYTHON_PATH and OLD_ICONV are two examples of them), sets default
values for them based on $(uname -S), then includes config.mak file
the user can optionally create to override these platform defaults.
This infrastructure is used across platforms, not just for NetBSD.

The part shown in the patch was to update the platform default for
NetBSD.  The setting we have been shipping in our Makefile seemed to
be different from what I needed on my NetBSD 6 install, and I was
wondering if we have no real users of Git on the platorm (which
would explain why we didn't get any complaints or patches to update
this part).  Or there are some optional packages all real NetBSD
users install, but being a NetBSD newbie I didn't, that makes the
values I showed in the patch inappropriate for them (e.g. Perhaps
there is a mechanism other than pkgsrc that installs perl and python
under /usr/bin?  Perhaps an optional libi18n package that gives
iconv(3) with new function signature?), in which case I definitely
should not apply that patch to my tree, as it would only be an
improvement for one person and a regression for existing users at
the same time.
