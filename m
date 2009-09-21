From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-genrandom: ensure stdout is set to _O_BINARY on
 Windows
Date: Mon, 21 Sep 2009 00:36:34 -0700
Message-ID: <7vws3svjel.fsf@alter.siamese.dyndns.org>
References: <4AB72CA2.1020808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Li Frank <lznuaa@gmail.com>, msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 09:37:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpdSI-0006Ra-OE
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 09:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbZIUHgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 03:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbZIUHgs
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 03:36:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbZIUHgo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 03:36:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 514AE3A7B3;
	Mon, 21 Sep 2009 03:36:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QblWe5asW3ODPdh7SzQhToj5Xjs=; b=ewgNLd
	r8m1FUWF1za1EuhgW/oQ2ht1NW3HfGoVsfTpHA0/YDBS3+IWoiDAdRHXLQRj97uU
	l86/43oRAMUheoBlL1Rnu1eb0agil2lh7Tp5MG5kD+SJxPO5169s1svfDfaFLPB3
	mE7pzUspgHlZoXTu77yLEvXS2Erz9sfNgFyZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WHsindVChYEmLDlW9BORkKIM3reIPtod
	04c2DxkisXE4NzNg1FfVll50Y2NEY/3kQpYBWw2/y7I9os4mZsYF+Ba21nLsCqEU
	v1af4kTeIQ3GvKanTPYaey3plMMEUnPP7BUyjxzOBUhZ/1oqRHhgTikFqW5AduQg
	EWJzO3rhz98=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FA9F3A7B1;
	Mon, 21 Sep 2009 03:36:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AFBE3A7AF; Mon, 21 Sep
 2009 03:36:36 -0400 (EDT)
In-Reply-To: <4AB72CA2.1020808@viscovery.net> (Johannes Sixt's message of
 "Mon\, 21 Sep 2009 09\:34\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 81718CB4-A681-11DE-9AC1-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128868>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> Commit a6ca8c62 (Set _O_BINARY as default fmode for both MinGW and MSVC)
> removed the definition of _CRT_fmode from mingw.c. Before this commit,
> since test-genrandom is linked against libgit.a, the MinGW process
> initialization code would pick up that definition of _CRT_fmode, which was
> initialized to _O_BINARY. After this commit, however, text mode is used
> for std(in|out|err) because it is the default in absence of _CRT_fmode.
> In order to fix that, we must use git-compat-util.h, which overrides
> main() to set the mode to binary.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Unfortunately, this change in an updated patch 04/15 of the MSVC series
>  went to the Big Void. ;)

Thanks.
