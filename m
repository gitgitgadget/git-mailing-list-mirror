From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: add `--shallow-submodules` flag
Date: Mon, 25 Apr 2016 15:37:38 -0700
Message-ID: <xmqqvb35iabx.fsf@gitster.mtv.corp.google.com>
References: <1461609054-17118-1-git-send-email-sbeller@google.com>
	<xmqqd1pdjt7m.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbPcefodLd4Jt4tvJJmHZXJGe-AMEgzREWZiUvNeciFSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:37:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aup8U-0000sF-EX
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 00:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbcDYWhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 18:37:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751146AbcDYWhl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 18:37:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EDB016B2D;
	Mon, 25 Apr 2016 18:37:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ALRvdMsj5vyNKzgqDIWDqGEnQDw=; b=mKqURz
	T9hYXYGmkR5z18LJXw9tDSlBittPpTSLxeIontjA4T6OMOR+egRdVcg/1MlVr7OL
	fc0UdAUZti7k1+i5neUZEH8Fy/fF9hUgi+ZanikDsq4o/t2SI7CC0g/7wa+qdYwS
	WnWaH+zfaLVAja/BDFB2XiCAviYWvqgfjW+C8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xUvLXLoysOCm54K7kIWsjXuJe4lwrWLh
	Yag7tY3nF/k5LBKg4NG2ZZKnBNaKoKSEkChX3zg0/ZAVUdTRrrX8w/TJd339h55b
	uPCF8arKIdCNGHC+MeFtAuTVuQ8X5NuTMo5CS2Tzb3mTrdVwF7GAI+5FDtVfaMqB
	nzAq1pURla8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4694516B2C;
	Mon, 25 Apr 2016 18:37:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5EE516B2B;
	Mon, 25 Apr 2016 18:37:39 -0400 (EDT)
In-Reply-To: <CAGZ79kbPcefodLd4Jt4tvJJmHZXJGe-AMEgzREWZiUvNeciFSQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 25 Apr 2016 14:25:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5106AD54-0B36-11E6-89EE-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292578>

Stefan Beller <sbeller@google.com> writes:

> I agree. How about `currentdir`, `testdir` or `testtop` instead?
> That is slightly longer than `D`, `here` or `top`, but is slightly more
> informative. $TRASH would also work for me.

I would not be happy to see a patch that adds yet another variable
that is never used so far, like currentdir, testdir, or testtop.

Among the ones I found that are already in use, $here is probably my
favourite, because it does _not_ have to be set to the top; it just
says "this is the directory my main focus is in".

Having said that, personally, I find $D (as long as D is in capital)
is distinctive and descriptive enough.
