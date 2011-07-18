From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/48] t6036: criss-cross +
 rename/rename(1to2)/add-source + modify/modify
Date: Mon, 18 Jul 2011 16:38:40 -0700
Message-ID: <7vvcuzcg73.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-13-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:38:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixOh-0002xx-Gw
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab1GRXin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:38:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229Ab1GRXim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:38:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 347F241C7;
	Mon, 18 Jul 2011 19:38:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=FNfUk0NFcSJm0HRW3Ib8VDdwQg8=; b=gWWCR1QqefcIjvAXgOtt
	7kk6x4y05G/vI9HzLwQLu96H8Dc9QsCwh/PkaT8wtVPjEQ98D4kgYLiqyX4bNwYV
	8EOcxnFnzFTfMfi/dd7OeWSLQKq5laKk3zmnr45e646NgfWcTNT5zd0BozLOJtsB
	eR4Xr/p3CZvRdBG89+BMwbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dsmnoTO9AZES/Qs6PMIy/Fa6TPIoY6QekQ+Ma64mpztLVF
	vT0VlFJfvZjJM3A7Xpp2zy5xeBBOe9wb6NRFNz2+eIM1ypgjZhCEMDDALqhrkTU2
	8WbK/e69966texdXkMGrKvUaZGIU+gEowHswGt5ao8+H8aaBbRXeF58GZ9eFs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C1FC41C6;
	Mon, 18 Jul 2011 19:38:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B54F941C5; Mon, 18 Jul 2011
 19:38:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11C6A62E-B197-11E0-B13C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177419>

Elijah Newren <newren@gmail.com> writes:

> Now THAT's a corner case.
> ...
> +# criss-cross with rename/rename(1to2)/add-source + resolvable modify/modify:
> +#
> +#      B   D
> +#      o---o
> +#     / \ / \
> +#  A o   X   ? F
> +#     \ / \ /
> +#      o---o
> +#      C   E
> +#
> +#   Commit A: new file: a
> +#   Commit B: rename a->b
> +#   Commit C: rename a->c, add different a
> +#   Commit D: merge B&C, keeping b&c and (new) a modified at beginning
> +#   Commit E: merge B&C, keeping b&c and (new) a modified at end

THAT may be a corner case, but is it a useful corner case?  What on earth
the person who did D (or E) was thinking to keep both b and c that are
derived from A:a to begin with?

> +test_expect_failure 'correctly resolves criss-cross with rename/rename/add and modify/modify conflict' '

I won't repeat the same two comments here from reviews for the previous
patches.
