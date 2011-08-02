From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] fast-import: check committer name more strictly
Date: Tue, 02 Aug 2011 10:01:44 -0700
Message-ID: <7v8vrbg32f.fsf@alter.siamese.dyndns.org>
References: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
 <1311831844-13123-4-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, SASAKI Suguru <sss.sonik@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 19:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoILn-0007Ru-NK
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 19:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab1HBRBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 13:01:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656Ab1HBRBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 13:01:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97F164F3C;
	Tue,  2 Aug 2011 13:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=qkA8skSH10fMKG/NJhpHcZjaYRM=; b=ZeUeJqdcg78dxhtRQYNH
	SrjGg2uN8MxIRfE52dfwNFEW30sYTH/dLIUWQ3poG221MAq3isi2HsFc91jtk+X5
	Gig1zy/fzMq1ip1qt9QlFxAys4iOs4Isq66jAkqAR5Kh/CXyjXAfkM61qyEvFpAR
	FZfZNkjSMItqgXSbvrXZNLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=g6Y4jSzN1c670YQ6XhrJYG+OA8gcTFotf+F4LzoN0Ap2Sb
	CIqZ5oYH23EXWqlmCDCzYmgC4Sio7l6lLwzVcVhj5uL/RovNcZhm8/GNaoZ+kJHN
	pC8neVvKy1Sf4GF64tVfFwfhG81Jm+Mc0UTlpUpEDdID+Oy7H9jBCrsKxPbRw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F88A4F3B;
	Tue,  2 Aug 2011 13:01:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E6734F3A; Tue,  2 Aug 2011
 13:01:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AB8452E-BD29-11E0-A764-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178484>

Dmitry Ivankov <divanorama@gmail.com> writes:

> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> ---

Please describe how you check this field "more strictly" in the body of
the log message, iow, against what rule you are validating, perhaps
something like:

 The identifier must be either "<address>" or "Name <address>" where
 neither address nor Name can contain '<' nor '>'; otherwise the input
 stream is rejected.

As fast-import is used to _create_ new objects, its input is a simple text
file that can be fixed-up as needed, it is a good idea to validate the
input more strictly and rejecting bad ones.
