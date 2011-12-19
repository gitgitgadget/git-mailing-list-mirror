From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* How to generate pull-request with info of signed tag
Date: Mon, 19 Dec 2011 11:55:16 -0800
Message-ID: <7vobv4mj4r.fsf@alter.siamese.dyndns.org>
References: <874nx1korf.fsf@linux.vnet.ibm.com>
 <7vbor8jw0h.fsf@alter.siamese.dyndns.org> <871us3l45o.fsf@linux.vnet.ibm.com>
 <7viplfdlpb.fsf@alter.siamese.dyndns.org> <87iplch79e.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 20:55:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcjIy-0000g0-M1
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 20:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab1LSTzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 14:55:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812Ab1LSTzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 14:55:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23A7979C5;
	Mon, 19 Dec 2011 14:55:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9px6ZNpyam+a+E06/02qc57WVC4=; b=flA+bZ
	lRCyptQIxEoXLpj8ktsefrWeVCPKWt5nNOuVVbzfWAPoiE1dnS5N4Y7i5Ucp8PFd
	hJkVMIQxQEtvMM9G0GnSqcsRwSDj1tS2MMYRsSuLgjw64R7v5o+6Y3ig3nkQE+ZX
	DfFd3MbKZ5Un0fY5pOIV2TGDW+/2HEKaR4h3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XeIOa4HmMaSPkpyXYiEla6iKGgo6VvmA
	G+t8xtOEcAcI1vrB/9zrl0RWk8X/MDVehNQQAr0QANrO4Ikf0rbkwCZLmw5nZBWA
	Q5bSrXjQ1ZeyM771cA5xA9CyGhPDySKO3xo4rdbGNdkEPD1IW2kZdOAO2MNMqLt0
	9T0uhoHD+Ic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AE2279C4;
	Mon, 19 Dec 2011 14:55:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2AE479C3; Mon, 19 Dec 2011
 14:55:17 -0500 (EST)
In-Reply-To: <87iplch79e.fsf@linux.vnet.ibm.com> (Aneesh Kumar K. V.'s
 message of "Mon, 19 Dec 2011 21:40:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FF08948-2A7B-11E1-9C8B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187466>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> It would be nice to get the below working
>
> git fetch git-url tag remote-tag-name:local-namespace/tag-name

AFAIR "fetch tag $v" is a shorthand for "fetch refs/tags/$v:refs/tags/$"
invented back when Linus was the maintainer of Git. You can say

 $ git fetch $url refs/tags/remote-tag-name:refs/tags/whatever-tag-name-you-want

to rename their tag to whatever name in your local repository.

Come to think of it, the last patch I sent out on request pull was very
wrong.  The point of the recent change to allow you to pull this way
(notice the lack of "tag")

    $ git pull $url $signed_tag_name

is so that you do not have to contaminate your own ref namespace with tags
that are used to leave audit trails in the history graph.

> That way we can make sure before merging i can cut-paste that url and
> the local tag name i wish to store this to. And then do a git-merge.
