From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Convert diffcore-rename's rename_dst to the new
 sorted-array API.
Date: Fri, 10 Dec 2010 14:32:20 -0800
Message-ID: <7vsjy5b6ob.fsf@alter.siamese.dyndns.org>
References: <1291848695-24601-1-git-send-email-ydirson@altern.org>
 <1291848695-24601-3-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Dec 10 23:32:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRBVx-0000Cn-H5
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 23:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab0LJWc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 17:32:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab0LJWc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 17:32:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5928D3419;
	Fri, 10 Dec 2010 17:32:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TnHMmXXEE/gWhmgV6km9Z2OEz60=; b=yY7ILw
	s0SywGnsxex8bhfR1gWqvJcB7Ern9BzUBsLwt3u06MeuqnAB/1QRytXOcPK3CLuB
	NWkTtSy5Ny8AgzM4C6F6cbi6yDB7ZA8FtpG88LU6LsyIsxZ3r3oiTDdD9CjZQXSe
	KD6fXySdnR+3VmjWyxSBZcxe6icNXT3/FZMvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rrqar5u/ty7Bnh+jlW+eZI+TxepNEujo
	+hnkFD/bIdnIDAqYaZR341X2EBLKI7mrhLjxBaSUffQ/p1caJRBoPNdUeciNMtwC
	I8OS+V811XKIPzK7eCNfoUiOFuwdAWcPff/fMq/o06p51NiTh/xo0S4fsk/4D5dx
	FqbSXeMDKRg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 365693418;
	Fri, 10 Dec 2010 17:32:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5C0CB3415; Fri, 10 Dec 2010
 17:32:47 -0500 (EST)
In-Reply-To: <1291848695-24601-3-git-send-email-ydirson@altern.org> (Yann
 Dirson's message of "Wed\,  8 Dec 2010 23\:51\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B941070-04AD-11E0-B71F-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163444>

Separating "locate with 'please optionally create'" into "locate" and
"register" looks like the right thing to do to make the callers easier to
read.
