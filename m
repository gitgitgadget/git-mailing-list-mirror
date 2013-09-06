From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] upload-pack: send the HEAD information
Date: Fri, 06 Sep 2013 12:54:06 -0700
Message-ID: <xmqqr4d1wwtd.fsf@gitster.dls.corp.google.com>
References: <20130906155204.GE12966@inner.h.apk.li>
	<20130906155608.GF12966@inner.h.apk.li>
	<xmqqsixhyhan.fsf@gitster.dls.corp.google.com>
	<20130906192918.GJ12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 06 21:54:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI26i-0006Xw-Mn
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 21:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab3IFTyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 15:54:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316Ab3IFTyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 15:54:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E46D03FCBB;
	Fri,  6 Sep 2013 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LzNtvA2KoYk1JYSVEWuZafUqZYw=; b=ZrCo64
	dsqQGdkpDTu4mAMKU2kPFx9ITMzYQhRL6O0u3SBICejzh9lPD66Yyrn7NLihgrKx
	S3XwoO+m9Pe9mnncHDqssbvJI6aYjLl8XXI6OcVlLhGKjcEkngoCco3HGiln8DU+
	wtBBHjIUcpuPVVzBdT02/EimSU2P2Sp86KO4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rh+oHF2AjRL6oLYeq3pWK9Oa3XnjSdYq
	QavdujqSfqFMkgCncFRpVyHIpK7YjksalzSAP9zzPOk6Rsn5p34avf+g7KmMloh9
	juIym46hIcbdk5LWAFEMjH98uaxsCAU+I9wmyDaA/FiRgtFmk9Kgzayn8vY99Wi8
	m6L60Qo4Hvk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D82343FCBA;
	Fri,  6 Sep 2013 19:54:11 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24D303FCB7;
	Fri,  6 Sep 2013 19:54:10 +0000 (UTC)
In-Reply-To: <20130906192918.GJ12966@inner.h.apk.li> (Andreas Krey's message
	of "Fri, 6 Sep 2013 21:29:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 18B99B9A-172E-11E3-BBAA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234092>

Andreas Krey <a.krey@gmx.de> writes:

> On Fri, 06 Sep 2013 10:46:24 +0000, Junio C Hamano wrote:
>> Andreas Krey <a.krey@gmx.de> writes:
>> 
> ...
>> reason later, on-the-wire format should be prepared to support such
>> later enhancement.  I think sending
>> 
>> 	symref=HEAD:refs/heads/master
>
> Mirco-bikeshed: Should that possibly be
>
>   symref:HEAD=refs/heads/master
>
> as then 'symref:HEAD' is a regular capability key?

I doubt that is a good change.

We haven't needed (and have refrained from adding) any capability
with an unknown name.  The variable part should go to the value
portion of the token.
