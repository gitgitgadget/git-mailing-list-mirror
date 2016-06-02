From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2016, #09; Tue, 31) t1308 broken
Date: Thu, 02 Jun 2016 14:22:33 -0700
Message-ID: <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
	<712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 23:25:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8a4g-0002x3-4t
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 23:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbcFBVWi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 17:22:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932383AbcFBVWh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 17:22:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E19421C75;
	Thu,  2 Jun 2016 17:22:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Nd+KBKzolIOm
	gwuTeFqzcWOeq2Y=; b=wEu+dOL61uvzfR0pMG3fAAlJ3OkrcPageBP4wmoQiAJ7
	nexf/FC8LRV4+pM1ibQBoAdJpcf6WrnALTY3RANw6WX/+qgsMqBAikqoL5dUiSE0
	iNpUtEVBrv36NpSxY9Ft6jiTy43a8YtfisiBdnCGcFeB8K+9Bl2jjs5a/Zqj0OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MSPCnB
	dyJYqkyaZL7XrD1GR7SqIj1cGRmzev+HjbcJdyfDLBkhtXeLAWvemYqz7/rn45S/
	xuemW73YdcO4RnCjrYZHB8efyY2rxY7xnVCj7Y0mMl4Se66FztqxoiqV/wO5sc8m
	Ii6EnjAfgDY9gZ7HKRMp8H/1x8944jcLVPGjI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5627821C70;
	Thu,  2 Jun 2016 17:22:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D610C21C67;
	Thu,  2 Jun 2016 17:22:35 -0400 (EDT)
In-Reply-To: <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Thu, 2 Jun 2016 16:01:36
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 203F4BC8-2908-11E6-91B9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296237>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> It seams as  ./t1308-config-set.sh is broken,
> when the the directory is a soft link:
>
> -name=3D/home/tb/NoBackup/projects/git/git.pu/t/trash
> directory.t1308-config-set/.gitconfig
> +name=3D/home/tb/projects/git/git.pu/t/trash directory.t1308-config-s=
et/.gitconfig
>  scope=3Dglobal

It does seem that way.  Somebody is affected by $PWD when we should
be consistently using the physical / real path.

>
>  key=3Dfoo.bar
> not ok 28 - iteration shows correct origins
>
> I havent't digged further, too many conflicts in the config code, may=
 be
> somebody knows it directly ?
