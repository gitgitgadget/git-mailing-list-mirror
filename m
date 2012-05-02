From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] cmd_fetch_pack(): fix constness problem and memory
 leak
Date: Wed, 02 May 2012 10:14:15 -0700
Message-ID: <7vhavyijyw.fsf@alter.siamese.dyndns.org>
References: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu>
 <1335955259-15309-3-git-send-email-mhagger@alum.mit.edu>
 <CACsJy8AE7Y1Y5Drda39OfSKwTQN7oSSrb2Ai+jq_hi8XC4dtsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 19:14:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPd8A-0002Pb-KH
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 19:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026Ab2EBROS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 13:14:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690Ab2EBROR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 13:14:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20FD26FDF;
	Wed,  2 May 2012 13:14:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P5wHeoXBxKxc91//tlSYPuGbQWg=; b=bUjk3V
	pAuSl5Ngm39SNdvvPCvuo9o8LdjM+9gKceB8ON5lAV6JG2ZQe/HdpOdJ6b14UMAy
	xRI9pr7ixLc7qgaJSlFYmOVpWorMNmYIKiIJEuU5MOsXYaRt/1JkUoPI74QpctJy
	YGVQEVQ36fviSZuNfIVr3VJ58P0Sc22IZfHcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F461yWcA5APa60efg8A/N9lGEGY0mGwC
	zEhRI0i9y1fT34vM2otUdwQfIURZScvOUbzi6R2bWyEf9ttCgbO6wfWCPWFsn6Lp
	Xop5ihnuSPO/S+ELCvGGCyx77088rRm8m+YHYwW3BVdpQoy64+OloudFGSjSWQlD
	v5IBHPB4fH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 183296FDE;
	Wed,  2 May 2012 13:14:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C7646FDA; Wed,  2 May 2012
 13:14:16 -0400 (EDT)
In-Reply-To: <CACsJy8AE7Y1Y5Drda39OfSKwTQN7oSSrb2Ai+jq_hi8XC4dtsw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 2 May 2012 18:14:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F3F5940-947A-11E1-949B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196844>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Ugh, perhaps you can convert the above to parse_options() too while
> you're making changes in this part?

Please don't.  A parse-opt'ification is a very low priority change for a
command nobody runs from the command line, and is not worth the hassle of
having to deal with unnecessary merge conflicts.

Do so when the codebase around the area is otherwise quiet.
