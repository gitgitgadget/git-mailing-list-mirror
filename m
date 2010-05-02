From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] pretty: format aliases
Date: Sat, 01 May 2010 20:12:34 -0700
Message-ID: <7v39yb0zfh.fsf@alter.siamese.dyndns.org>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, raa.lkml@gmail.com,
	jrnieder@gmail.com
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 05:13:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Pcp-0004mW-QM
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 05:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab0EBDMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 23:12:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850Ab0EBDMt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 23:12:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D875AFFC0;
	Sat,  1 May 2010 23:12:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jOHFIL1rwDFyNtSPbHR6YeRasW8=; b=HH19Ly7fSiXZ3g5F8eJuz2e
	wz0/4RLrR8WxnX0Y2wNtEpA/zXY5iQ3oaxiD3Up0682E1zk6BS+cnPXO3FRESsRg
	KeylkaMQsRwqkvY1/1l9tf16ohGBu02ah2U48oa3CaG4YZIOFMQfcwML58DUK4Gs
	9o2jndZy6rma+kA0kIuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VugQ45572gedAYuFOVTySf+YBljcuX2dV///nkaYpqEdKarvO
	TGa1hay4GLlr2Sofnbjnru+pYMsgrCYMuSfubfPv+Ikumr7msayIfInqHriQH2Hc
	7fCyaVHCl1yHgzbl1PuDPqtOYl2JLSdHPjGvEQsZI0MuL4nS//Th7W2TTo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BEB2CAFFBE;
	Sat,  1 May 2010 23:12:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2263AFFBD; Sat,  1 May
 2010 23:12:35 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9203F5D2-5598-11DF-865C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146126>

Thanks.  Overall I like the direction this is going.

There however are too many style violations that I prefer not to fix
myself.

 * Format if/while/switch etc. like this:

	if (expression) {
        	statement;
                ...
	}

   not like this:

	if( expression ){
        	...

   - Have one SP between syntactic keyword and an open parenthesis;
   - Do not have extra SP before or after the expression inside
     parentheses;
   - Have one SP between a close parenthesis and an open brace.

 * do not initialise statics to 0 or NULL; e.g. not like
    
	static size_t commit_formats_len = 0;

   but like

	static size_t commit_formats_len;

 * Do not omit SP around operators.

	for (i = 0; i < builtin_formats_len; i++) {
        	...

   I.e. not like this:

	for (i=0; i<builtin_formats_len; i++) {
