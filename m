From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] line-log: convert to using diff_tree_sha1()
Date: Thu, 06 Feb 2014 13:50:13 -0800
Message-ID: <xmqq8utnykq2.fsf@gitster.dls.corp.google.com>
References: <cover.1391619218.git.kirr@mns.spb.ru>
	<cover.1391619218.git.kirr@mns.spb.ru>
	<0df5c2e1e93e4873bf276f3f500109249fe1afee.1391619218.git.kirr@mns.spb.ru>
	<87wqh8arb2.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Feb 06 22:50:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBWq2-0002zU-90
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 22:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbaBFVuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 16:50:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbaBFVuV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 16:50:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7D2E6AB75;
	Thu,  6 Feb 2014 16:50:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PS3o8o9Ituqtv0hcBSxJ2pXWE3U=; b=AmP7Pq
	DFbjK/jptY0IziXhG+p8ZLYJbULB5bUgjpgIOZQVOJ9vYn5ad8BVzjRXz5xavXJ/
	6fqn7dZ2KR0M8TyhGmPasXmqekTZO8389L0WO6+IbtFicSN+aME+h2ZzmwIqME4s
	rgFNOTjPeeECP1TrB7snUP4Shgei81Jhw49o8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EP39JjcvvYjdK9dmCV8PejpQjM1GDiOG
	IAt8QcAipZN4xgRAeDbHueanvzGy7foFyW5Rr2g03qhkx+X6Fs5Dxd/S/20oEsXc
	MvfCg2rgIItnC2VGU0NNOcOw9qgjnWHDhREgXffnQeZyaIEA+p7QzhczMej9ptBg
	x8h6PlTk1Bo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D56556AB73;
	Thu,  6 Feb 2014 16:50:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5901C6AB69;
	Thu,  6 Feb 2014 16:50:16 -0500 (EST)
In-Reply-To: <87wqh8arb2.fsf@thomasrast.ch> (Thomas Rast's message of "Thu, 06
	Feb 2014 22:01:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AA174F7A-8F78-11E3-B492-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241746>

Thomas Rast <tr@thomasrast.ch> writes:

> Kirill Smelkov <kirr@mns.spb.ru> writes:
>
>> Since diff_tree_sha1() can now accept empty trees via NULL sha1, we
>> could just call it without manually reading trees into tree_desc and
>> duplicating code.
>>
>> Cc: Thomas Rast <tr@thomasrast.ch>
>> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
>> ---
>>  line-log.c | 26 ++------------------------
>>  1 file changed, 2 insertions(+), 24 deletions(-)
>
> You have to love a diffstat like that :-)
>
> Thanks.

Yes, indeed.  Thanks.
