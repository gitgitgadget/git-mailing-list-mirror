From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: allow to clone from .git file
Date: Mon, 22 Aug 2011 12:02:56 -0700
Message-ID: <7vbovhw9pb.fsf@alter.siamese.dyndns.org>
References: <1313927890-21227-1-git-send-email-pclouds@gmail.com>
 <7v7h66y4s5.fsf@alter.siamese.dyndns.org>
 <CACsJy8BaCwT+fd-KORsqXqQEtWZUpTDwgoSGU9+pMfNdero5=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 21:03:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvZmd-0003t0-Cv
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 21:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab1HVTDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 15:03:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316Ab1HVTDA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 15:03:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF3654795;
	Mon, 22 Aug 2011 15:02:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=818ZKh+WIC/u12l5RqLnXeL3lRY=; b=v2f0vf
	iaQfjpc7CdYVlcabU6NknxiWhM5VIBEEZCQgCi9WfInhVvLTjIRHIbsxdrEzxwEf
	bPwMP4pVMFYWNt9ugqxfzTpXwVPUT+fw00PVEEwGJrqnYNu4AuFmmfMM6sFL+FQa
	n2kAjQ9WKE0QbvJTCCk4ELX1D4fxCi+ExmUv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=koxZSon981I/7Wo9ktWik4WNIMLAjeuw
	a6RGiZFdd5Uf8MoRTegKWrmGg4OsdJBzCIK61G9pxlhVNdBsZaG7A/8L+hotc/GP
	j+DHRmhUNPYR8ENJHIsVfqocvCvkNe3WuhGrbOvduZ9zNgdWFO3pQH3RXAgdJoyc
	2KgimYdqY9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5BFB4794;
	Mon, 22 Aug 2011 15:02:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62E814793; Mon, 22 Aug 2011
 15:02:58 -0400 (EDT)
In-Reply-To: <CACsJy8BaCwT+fd-KORsqXqQEtWZUpTDwgoSGU9+pMfNdero5=Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 22 Aug 2011 10:08:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59A30CE2-CCF1-11E0-B36E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179880>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> Didn't somebody add "is this '.git' thing a valid git metadirectory?" API
>> quite recently for exactly this?
>>
>
> You mean resolve_gitdir() in abc0682 (rev-parse: add option
> --resolve-git-dir <path> - 2011-08-15)? That function would barf on a
> bundle file.

Well, then it has to be fixed, perhaps to return NULL instead as other
failure cases, as read_gitfile_GENTLY() should be gentle to the callers so
that they can notice error cases and deal with them themselves.
