From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: consider only address in kill_some_child()
Date: Sat, 09 Jan 2010 09:20:05 -0800
Message-ID: <7vocl3ry9m.fsf@alter.siamese.dyndns.org>
References: <1263046408-2368-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 18:20:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTezB-0008A9-Fc
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 18:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196Ab0AIRUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 12:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263Ab0AIRUU
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 12:20:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab0AIRUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 12:20:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F8D08F91C;
	Sat,  9 Jan 2010 12:20:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UAqDFz7r2k6Fjg7RDQ1mhUWPdhQ=; b=bIpEPGjCfrdwphPwR7kG/34
	nfB7ZSePS07ZSsHXGAPJz5FfLKTlyr66j2PrLsdj4kncLM/Ms+3mtvgmdsjylWli
	d4V4DXwVg9cfFvz7eh6L7nGZRa9OrE1hqEPMkCNTWxSDhBsa4CU5y7x5w/oX5Wxe
	DQxVWHz5W+xB00KiaaxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uq7dg2CPRgLtq4srpNtZog6mdd++QpQnbANS19GQQDh5M+O8M
	S8cJMbuvKuueRs+ysQkOnUvak5jjwHWk2Z21pwQbvusyj1Qf+lUX8bUxVvJrwWMd
	FajgfIn4FDypqkY4mGTtEPw/mZIBaapiRov7wWJKwKAVUWY5Xcotwz4vlc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D26F8F91A;
	Sat,  9 Jan 2010 12:20:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B62E68F918; Sat,  9 Jan
 2010 12:20:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D8023E4-FD43-11DE-8454-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136534>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> kill_some_child() compares the entire sockaddr_storage structure (with
> the pad-bits zeroed out) when trying to find out if connections
> originate from the same host.  However, sockaddr_storage contains the
> port-number for the connection (which varies between connections), so
> the comparison always fails.
>
> Change the code so we only consider the host-address, by introducing the
> addrcmp()-function that inspects the address family and compare as
> appropriate.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---

Makes sense.
