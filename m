From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: allow --graph and --show-linear-break used together
Date: Fri, 08 Apr 2016 10:11:14 -0700
Message-ID: <xmqqzit4vxe5.fsf@gitster.mtv.corp.google.com>
References: <3305f7dc-0044-41fe-8aab-ee800535d6e9@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jan =?utf-8?Q?Kundr=C3=A1t?= <jkt@kde.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 19:11:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoZwJ-0004hv-98
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 19:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255AbcDHRLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2016 13:11:18 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753723AbcDHRLR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2016 13:11:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1644A51A58;
	Fri,  8 Apr 2016 13:11:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1FN9KCsNOqZZ
	8689NBRZlXx8FCk=; b=YFNzFXlDjuw9FgrAf8zAxHOkjMACzWA3i1u+fChqSWfV
	+rRLYL3G0NUARc5OeoYjqnIrXischzfeeYKde9phvDvMTXkv24JIHc41+GjNA27i
	aRJSBv8Y1sM+RPGHmiFh/VGQCKJhup7ZapwQjyDKVJd/u9TS2Qbk6QEOf18bkvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hTQOuw
	M0SVpYDkTpUwCna/B+HssxtjbtJ4o9WLejhZOJmAfgBDyPkIkCzb03RpN7ZoRKnz
	fC+sve+JJup+iMFEpcS9PAp2cVT+UJMSoQQh9mF0QO2IQf8jn8r3EXuHP8OTcDJg
	NHp2Avu0usDTurCs3VtnAUcfFYDcAJL9hK9dE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0257051A57;
	Fri,  8 Apr 2016 13:11:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 769A951A55;
	Fri,  8 Apr 2016 13:11:15 -0400 (EDT)
In-Reply-To: <3305f7dc-0044-41fe-8aab-ee800535d6e9@kde.org> ("Jan
 =?utf-8?Q?Kundr=C3=A1t=22's?=
	message of "Fri, 08 Apr 2016 13:21:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E6EA59B6-FDAC-11E5-B07F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291045>

Jan Kundr=C3=A1t <jkt@kde.org> writes:

> this patch makes it possible to use --show-linear-break in `git log
> --graph --oneline --all`.

You have multiple roots, just like we would show the histories like
this:

    *     A
    |\
    | *   B
    | *   C (root)
    *    D
    *    E (another root)

teaching the "graph" code to show the history like this:

    *     B
    *     C (root)
      * D
     /
    *   E (another root)

would be more beneficial than using --show-linear-break and chopping
the graph, wouldn't it?
