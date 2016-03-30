From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Wed, 30 Mar 2016 10:13:56 -0700
Message-ID: <xmqqvb43ubvv.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
	<1458820579-31621-1-git-send-email-pclouds@gmail.com>
	<xmqq8u17akgn.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BtOR-0FNSP5cggAz=X3Vm-do_N4V-z7=tvW28p14FMkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Mehul Jain <mehul.jain2029@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:14:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJgy-0005K1-VW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbcC3ROA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:14:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753081AbcC3RN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:13:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A8A54FC86;
	Wed, 30 Mar 2016 13:13:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UY7SujrpkllYimeyQkeaGslUR/Q=; b=te1vgR
	xcS87fSNIopOATQ7R76Fq8VakNRIejMeFtMZaHuR/8u0IO5AB6NHqCQCplmar4XR
	0Wee08akfoS2+VRSkozolqjDnjKbkx/EwXt44roBx3Fcsl4GcTwVk8DHwY9Lx0Wk
	5b1cuS3QrErP9Lrh9qPQC04Y25Dvef4PFtxkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=usTdNHsY7T2skPiUfkYFk+DabEqm92oS
	KF96aP3IKVtmKWn+8Qxw4xWvgpwDTiYd/2Ylp3SO8FhGpDsNOGz3dgh8DBpgTkCt
	DnbAwavkP91GUwXT6f6B0L1Qu0FWVGDhBe0bwlvMtYinE5/smLoj8sBsM9WxQGYe
	zKy47akEnJU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 66E334FC85;
	Wed, 30 Mar 2016 13:13:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DB5024FC81;
	Wed, 30 Mar 2016 13:13:57 -0400 (EDT)
In-Reply-To: <CACsJy8BtOR-0FNSP5cggAz=X3Vm-do_N4V-z7=tvW28p14FMkw@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 30 Mar 2016 08:05:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA013CDE-F69A-11E5-B0CD-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290319>

Duy Nguyen <pclouds@gmail.com> writes:

> But your suggestion is good and I can't think of any better. We could
> introduce pathspec as ftiler after "--", but it does not look elegant,
> and it overlaps with --include/--exclude.

I was imagining that we would allow the magic pathspec syntax used
in --include/--exclude command line option parameter.  Nobody sane
uses glob special characters in their pathnames and those that do
deserve whatever breakage that comes to them.

> Perhaps we can start to warn people if --include is specified but has
> no effect for a cycle or two, then we can do as you suggested?

I do not think I'd be against going in that direction.
