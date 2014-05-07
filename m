From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge-recursive.c: Fix case-changing merge.
Date: Wed, 07 May 2014 13:53:25 -0700
Message-ID: <xmqqa9at8g56.fsf@gitster.dls.corp.google.com>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
	<1399417144-24864-1-git-send-email-dturner@twopensource.com>
	<xmqqd2fpbh9b.fsf@gitster.dls.corp.google.com>
	<20140507181355.GW9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dturner@twopensource.com, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:53:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8qM-0006aH-SK
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbaEGUxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:53:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59287 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbaEGUxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:53:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1461416534;
	Wed,  7 May 2014 16:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=13se8JryLRs4KBMsdf/kcjxbqg4=; b=eBrViH
	0RWOJGDwDBc/OeQnLqIWQAtTzfIWOic46X5VtYJae+gykqVCvq1Njjw3CJxUoo+r
	IyW/xB+ceTi9m7HrTrq29B3hyxWiHvUQdeNqw+TaeNCnUqErDf4hehhEwH7XbgoZ
	z16onPi9pD3nz0XjQ2fp650HWibUdD0fCa+0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fk6vvReUxgSPaPKwydRsrXO9tFBAVEPK
	hgageRRCrMsBCTADOLty8sb/r8LF9Ib1tDEaIje9+lHPXmNxdc4T/bkw5h3qYqC8
	imKRIjWEoBNmu8TljSrMh1uDzRF8y9dwVFWQs1KPpxjraLEcDBwFXhKSn5dCBp7P
	NUeAtfdCJ00=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0829816532;
	Wed,  7 May 2014 16:53:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 401EF16529;
	Wed,  7 May 2014 16:53:27 -0400 (EDT)
In-Reply-To: <20140507181355.GW9218@google.com> (Jonathan Nieder's message of
	"Wed, 7 May 2014 11:13:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A3496762-D629-11E3-BF99-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248373>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Please make it a habit to use "test -f" when you expect "the path
>> exists as a file", not merely "something exists there I do not care
>> if it is a file or a directory", for which "test -e" is perfectly
>> appropriate.
>
> Or, better in tests,
>
> 	test_path_is_file testcase
>
> which prints an error instead of just silently failing when
> the path is not a file.

Thanks, will tweak.
