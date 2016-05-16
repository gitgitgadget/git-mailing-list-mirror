From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Mon, 16 May 2016 12:27:33 -0700
Message-ID: <xmqqvb2d247u.fsf@gitster.mtv.corp.google.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
	<xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZsVH3mE0zXu9wSWgit3QZ_CiKZqg-TQdyWnZw6D9=Cgw@mail.gmail.com>
	<xmqqlh393nuv.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbN_pzAVeAa-St_KRs60SbURTfKKP0v+do_+MK7orTkTg@mail.gmail.com>
	<xmqq8tz93kf9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaV+hQRn6ZraZcG9ZRp1XwPGrEFibBEX5qFJdWDCg0uxQ@mail.gmail.com>
	<xmqqzirp253d.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbLcRgM5PoTp7DA-c5DneAWJOxNwZVSMxU0LdVtuBfiRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 16 21:28:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2OBM-0005RK-U4
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 21:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbcEPT1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 15:27:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754474AbcEPT1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 15:27:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35A541C87D;
	Mon, 16 May 2016 15:27:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GS/n/lZbAaZMiDSjn6DWoLAF/4Q=; b=xDvQiK
	zWOetyevCCXLVS1EuxSa4Z3tdvXra22d/nKNrrZuNRwOAjVqbA4hP44VcwdeGUnD
	E4SNa8dtVQwENjsdQKGVkZxlhnthDfRoczBUpjNk65sRLU5c+ks5q8h9m11YCIJm
	nM7CnOU8NuneJTENK2NDw3aOJK9Vt7rwEU0Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AMhOaBsS79VnNuZe6vCC3V9nxGfa43v4
	UpVzaXO+24IYirBpf500Zu/YuOpuo6u5C0yIy7Oxk1QMPKNM1iZjxtpU7dnuF2mK
	ziUE43XumtP5LDlN+5Xwl7Qum4rF6i4eD5sTZInlkEk+6vkbO14Ychdg/L2Vj8ec
	WkEmfVk8sGc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AD681C87C;
	Mon, 16 May 2016 15:27:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9810F1C872;
	Mon, 16 May 2016 15:27:35 -0400 (EDT)
In-Reply-To: <CAGZ79kbLcRgM5PoTp7DA-c5DneAWJOxNwZVSMxU0LdVtuBfiRA@mail.gmail.com>
	(Stefan Beller's message of "Mon, 16 May 2016 12:12:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3E5AB8AA-1B9C-11E6-9D97-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294783>

Stefan Beller <sbeller@google.com> writes:

>     "Path '%s': Ignoring label set to false; This may behave
> differently in future versions of Git."

I agree that mentioning "ignoring" is good enough.  I think our
recent messages begin with lowercase, though.
