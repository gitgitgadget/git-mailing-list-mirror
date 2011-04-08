From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: rename per-item field has_wildcard to
 use_wildcard
Date: Fri, 08 Apr 2011 12:40:14 -0700
Message-ID: <7v62qo4jmp.fsf@alter.siamese.dyndns.org>
References: <7vr59gl581.fsf@alter.siamese.dyndns.org>
 <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com>
 <7vfwpvjobl.fsf@alter.siamese.dyndns.org>
 <4D9D9B60.4030404@drmicha.warpmail.net>
 <7vvcypeti4.fsf@alter.siamese.dyndns.org>
 <7vr59detcu.fsf@alter.siamese.dyndns.org>
 <4D9EC75F.1060901@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:40:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8HXk-0005rF-AG
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 21:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723Ab1DHTk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 15:40:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab1DHTk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 15:40:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B37A4C42;
	Fri,  8 Apr 2011 15:42:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aiCWQq8mWta7aVgwgA8aLyBJnQI=; b=jVTTLC
	eX4z5dsz9d1Zf8HXJgLCjip57G9a8IsBogV/Nn6kOlMgFYwaOe2vGolQ8kHalDwY
	03NqlSyemsDVBFfycKJ305s6vHvAf+msCocbr920Ud4qLGfq3rWUvVb7E0P98blB
	kLN1UGA5Ou/YYyXFN4JCyu85EO4LhgixMysF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UeVJJt2BewefmOsXajy7bYCWkGPopnv7
	ciodSvcHuU61fd8FGRVuAoaql0T55DtaY86Zy8Q23X5ZaAuL1rRyhEZUOuwTuWaO
	f1qRfa1vdjPGtd0wll53KpKEhaRqcMdXXfi2YsLavB5GIDZbOeEavs+2k6UAuHPA
	dBKL+sdeBSk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A69C4C3F;
	Fri,  8 Apr 2011 15:42:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3304D4C3E; Fri,  8 Apr 2011
 15:42:11 -0400 (EDT)
In-Reply-To: <4D9EC75F.1060901@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 08 Apr 2011 10:29:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4ED1F0A6-6218-11E0-843E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171148>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Maybe we can make the ":" literal
> when it can't be parsed, or make it do something (":/" as you
> suggested), because swallowing it and then doing nothing seems doubly bad.

Another possible tweak would be to make ":" without even any "pattern"
after it to become a no-element, in order to allow the same difference
between "git log" and "git log ." to be expressed from within a
subdirectory.

The difference matters when you have commits created with --allow-empty
that are discarded by path based history simplification.
