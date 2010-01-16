From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] gitweb: Convert output to using indirect file handle
Date: Fri, 15 Jan 2010 16:58:06 -0800
Message-ID: <7vmy0eoogx.fsf@alter.siamese.dyndns.org>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-7-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-8-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
 <m3ljfydgmt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:00:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwzz-00058J-Nr
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758463Ab0APA6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758434Ab0APA6S
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:58:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758404Ab0APA6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:58:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB61B91169;
	Fri, 15 Jan 2010 19:58:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BnJgZt32QiiLGjvkxYmbMkkTqtg=; b=HWC/i0
	ijhi19ohx+UPKuZ5FmyCz+yPiuiTN42tqQNVIpum1L2RktbpcESAvDeduumABZB7
	QyhashLlcPu3f9DWSsc4LFhSBNV09kY0srwbgQqD/BlOrmVNlELP8UfO77kBRlKi
	3ouMgh5rtamAqeQBW5aLRNZCV9qw2ug3PbBsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UAkcWpnYLcWMLjbB0CnqJtpQOT8a/kjC
	YKIw9grUaeAKdYk894nijZU4Se+mEWKdBvaJpp9H/qmtSt0LhkRQ8yeuZ6JdCXKT
	atIaPBpR/IJwTKQLFfiajNcrhSyZUWEMpcrXqZ9nNrNoBVarF5ZB/R5Hml6wnfRW
	jRwQFrj01K8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C3C391168;
	Fri, 15 Jan 2010 19:58:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B825091166; Fri, 15 Jan
 2010 19:58:07 -0500 (EST)
In-Reply-To: <m3ljfydgmt.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri\, 15 Jan 2010 16\:43\:32 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37FCF536-023A-11DF-82AE-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137179>

Jakub Narebski <jnareb@gmail.com> writes:

> This means replacing
>
>   print <something>;
> by
>   print {$out} <something>;

Just out of curiosity, how is this different from

    print $out <something>;
