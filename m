From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 09:45:02 -0700
Message-ID: <xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Durovec <jan.durovec@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:45:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asYm3-0006JX-Hx
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 18:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbcDSQpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 12:45:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754089AbcDSQpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 12:45:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A1C312926;
	Tue, 19 Apr 2016 12:45:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YXrYzbdbwvzFyWeg85Mu6yZoiZY=; b=RgOZhs
	ZhMbYoAVRO0da032mPxQWcwaQaF7vP8SPvH4SOp0D9FAkuvIbTRZO0mElu4XhQmV
	dcV3CBUrD/MZszUcCQVarHEioic8OpHMrcsAYqGNIfj0AfMMIPWtG2kZ6ZqvjRP8
	/m2xPntRkMCKYMuf7j+96GxhGOyH+ifXUdHTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EYwOgp7YcCVUxBFovK2m8sROnkWrDe+1
	BwyA1LKiypA1LYNjWvRCneEy+LmtkHbDHoDCFSK+NhU28J7sNHwMy4or5vjvlcs9
	h1umvm90No/L3+6TnG3w4YZHw9MzGt+5qRXlJXRdbTbRgPQ8LPskAnbqd3HZjBfZ
	VlRShIx1RwY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 46FC512925;
	Tue, 19 Apr 2016 12:45:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C58A812924;
	Tue, 19 Apr 2016 12:45:03 -0400 (EDT)
In-Reply-To: <CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	(Luke Diamand's message of "Tue, 19 Apr 2016 09:13:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10AAAF36-064E-11E6-9D2A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291879>

Luke Diamand <luke@diamand.org> writes:

>> I am not familiar with "Perforce jobs", but I assume that they are
>> always named as "job" + small non-negative integer in a dense way
>> and it is OK for this loop to always begin at 0 and immediately stop
>> when job + num does not exist (i.e. if job7 is missing, it is
>> guaranteed that we will not see job8).
>
> This is OK - P4 jobs have arbitrary names, but this code is just
> extracting an array of them from the commit by index.

Ah, thanks, that is what I was missing and this part of the code
makes perfect sense to me now.
