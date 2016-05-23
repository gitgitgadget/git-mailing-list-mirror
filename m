From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_INDEX_FILE relative path breaks in subdir
Date: Mon, 23 May 2016 12:44:48 -0700
Message-ID: <xmqqtwho8spb.fsf@gitster.mtv.corp.google.com>
References: <20160517171836.GA12183@kitenet.net>
	<xmqqy478wptr.fsf@gitster.mtv.corp.google.com>
	<20160517182645.GA27396@kitenet.net>
	<20160522190404.GA20998@kitenet.net>
	<xmqqwpmkafmb.fsf@gitster.mtv.corp.google.com>
	<20160523172951.GA1184@kitenet.net>
	<xmqqiny4aaq9.fsf@gitster.mtv.corp.google.com>
	<20160523185258.GA10389@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Mon May 23 21:44:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vmb-0008Vy-U0
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbcEWToy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:44:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753195AbcEWTox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:44:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 813A91D4AB;
	Mon, 23 May 2016 15:44:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n+A5LPb8IokjNgL5mH/mqJLAs7c=; b=IiUmLH
	LMw4Pf12KFo3QfGpXQvCa9D7axmJwa+7DmKvyNEEDvrAbwP9l4AJVF4Nrr0mhR8w
	PC2pAmgbJ/EAAMMTlo5J09WjX08YjUc77JO3NOJrOynmjQ6qC58bRgFGWTmn09Db
	T4vieMf6mT54jVp2gkuhOpZNp4RAbNYreOKBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZO0E32QuACQcHMuoDNQsFNRCK/mEtG/m
	5pskXOulB9iS+7akm87ISCbGajP4ZZwU+KQkSTprKrdr+KvonfN3T7sAwQhnDUAs
	QTneiB3cqf8+QVybQp+L7ApzrAqRkoLbPTiK7RdWdKYG+TlT1p2YhiE6OwoIy6UZ
	ajUrVdBd2lw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 78E691D4AA;
	Mon, 23 May 2016 15:44:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D998C1D4A9;
	Mon, 23 May 2016 15:44:50 -0400 (EDT)
In-Reply-To: <20160523185258.GA10389@kitenet.net> (Joey Hess's message of
	"Mon, 23 May 2016 14:52:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D050B228-211E-11E6-B212-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295383>

Joey Hess <id@joeyh.name> writes:

>> I am not sure if relative to PWD is useful.  If it were relative to
>> either the GIT_DIR or the GIT_WORK_TREE, i.e. a fixed point, then
>> you can set and export GIT_INDEX_FILE and chdir around without
>> having to adjust it.  If it were relative to PWD, you would need to
>> adjust it every time you chdir, no?
>
> Good point, I had not considered this use case. Although if I set a
> long-term environment variable and expect to chdir around, well, that's
> what absolute paths are for. All my uses of GIT_INDEX_FILE
> are in short-term contexts where the program does not chdir.

Same to you.  I didn't consider a single-shot

	$ GIT_INDEX_FILE=./a-temporary-file-here git do something

It would be natural if we have that temporary file here where we
are in that use case.
