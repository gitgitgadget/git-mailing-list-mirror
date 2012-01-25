From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] git-p4: Add test case for complex branch import
Date: Tue, 24 Jan 2012 20:02:10 -0800
Message-ID: <7vwr8g1lbx.fsf@alter.siamese.dyndns.org>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
 <1327105292-30092-4-git-send-email-vitor.hda@gmail.com>
 <7vehutd59p.fsf@alter.siamese.dyndns.org>
 <CAOpHH-Wcf3innjA4LS0TMrLzEwbQzfZmHssxSBYvv4v7UMfi1w@mail.gmail.com>
 <CAOpHH-UxD37v7N3U9A0c_MnzSjOcF6eJCx2WdHRKf2CFoYy_tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 05:02:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpu3x-0004aj-KA
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 05:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab2AYECP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 23:02:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759Ab2AYECO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 23:02:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3F416135;
	Tue, 24 Jan 2012 23:02:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ywadYcomDl7L8X9WBxNdqQwuMqo=; b=XxIhzI
	fWPj0tcXa8zCP90lOpn9Zh/ACnIDn0ppPqGed0N6RTYEhGZGaATk45IQplzCrhWw
	1aniAa/LIowpWQzdb374RkrvHF9xizEEvo2Cbm1kmR5TspwGAAFYAYIWX0IvdNcT
	PJpOQH6GTeoCffyB3xRArFsRgQETl1+8YqglA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P7tzSlThKqtOc+l0fvXcCeoO7PSSv1FG
	f9WolTn81vhSSqV3fPFa5CxIXSrq6dphKF5wRz99j1AJtjogqAMEFXKu6nmH+CtO
	KUHmvFNkrAi5LH6L5eFKX8vF5AmmZBMwG/0fF1Nl0fuiTCrK7wafx+2537bP5nnX
	qTEPXkdYaqc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB9876134;
	Tue, 24 Jan 2012 23:02:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F9F76133; Tue, 24 Jan 2012
 23:02:12 -0500 (EST)
In-Reply-To: <CAOpHH-UxD37v7N3U9A0c_MnzSjOcF6eJCx2WdHRKf2CFoYy_tg@mail.gmail.com> (Vitor
 Antunes's message of "Wed, 25 Jan 2012 01:39:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C38F7B8-4709-11E1-AE2D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189095>

Vitor Antunes <vitor.hda@gmail.com> writes:

>>>> +             p4 submit -d "branch5"
>>>
>>> That's a strange quoting convention. Why are "branch4" and "branch5"
>>> enclosed in double quotes while "integrate" and "submit" aren't?
>>> (rhetorical: do not quote these branch names without a good reason).
>>
>> There is no reason that I can remember to have those enclosed in double
>> quotes. Will double check in my local branches at home tonight. Anyway,
>> expect a fix for this in v3.
>
> I now see why I added the quotes. The -d option is used to input the
> description of the commit, which can contain spaces and other special
> characters. Admittedly they are not required in this case, but from a
> consistency point of view I would prefer to keep them.

Hmm, the argument "branch5" made it look like it is the name of the branch
you are giving here. If it is supposed to be human-readable free-form text
description, I would prefer to see it as such, e.g.

	p4 submit -d "integrate changes on branch #1 to branch #5"

or something like that.
