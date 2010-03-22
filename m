From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Mon, 22 Mar 2010 07:46:34 -0500
Message-ID: <953BEDE2-1A17-49EA-BEC5-D198DBB1FF23@pobox.com>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com> 
 <20100321171431.GE2557@m62s10.vlinux.de>
 <7vd3yxqxdj.fsf@alter.siamese.dyndns.org>
 <55bacdd31003211415k79b7a039n3f19eb95eefcad43@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 13:46:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nth1t-0003Dc-UX
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 13:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab0CVMqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 08:46:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550Ab0CVMqo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 08:46:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC01CA42BA;
	Mon, 22 Mar 2010 08:46:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; s=sasl; bh=3vpL
	MHuhYrspP3HIiCeiy1VJ4Co=; b=fmAeUM8mzO1Jm99Tba7Ie/qzWxW7cKWCP6F0
	MTONc5wZwoKGz4cI+PblV1lKSg/b5lHuXihY8A6YptumMS7+OEbIaQsWTH6NPTyP
	+qtCyEfPbJWQ2dgvXxgAdHrLxs3wslk3n/ilbB8txK4ZmYaLcxlV56fb7WX+GOdj
	KtSYuo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; q=dns; s=sasl; b=
	rGXlEczm12YdSYL4X2Y5bL90JkvOny2f8Xw5JtI6Ff/0XmbUfN1cNXdnzueO2r/y
	Kj4i6r+8i773mM/2pp2b3miWT9OArqDFW3tKw5ZTUF7bWUfCCWhDoVNI510nUvJz
	5AHzXYCgUR2l2AfBBdxMR+qmj0Aimn2U4CgzrH8FPxE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80AD7A42B9;
	Mon, 22 Mar 2010 08:46:40 -0400 (EDT)
Received: from [192.168.1.241] (unknown [75.53.42.110]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5593CA42B6; Mon, 22 Mar
 2010 08:46:36 -0400 (EDT)
In-Reply-To: <55bacdd31003211415k79b7a039n3f19eb95eefcad43@mail.gmail.com>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: F6200E8C-35B0-11DF-B9C8-D033EE7EF46B-07245699!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142927>

2010/3/21 Junio C Hamano <gitster@pobox.com>:
> The main point of the feature is not the emptyness of the resulting  
> tree
> (it is merely one possible outcome), but is the lack of parents in the
> resulting commit.  So I would recommend against --empty.  --root  
> might be
> a good synonym, though, and we _do_ already use that word for that  
> purpose
> in some commands (e.g. "log --root").

On 2010 Mar 21, at 16:15, Erick Mattos wrote:
> --root could be a synonym but the reason I haven't chosen it was the
> fact that it could mislead people to think the functionality will do
> something with/based on the first commit of the actual branch,
> subjectively thinking "THE ROOT".

The existing uses of --root are close to, but not identical to this  
proposed usage. The existing uses all relate to handling the already  
created root commit(s) of a commit/branch/repository. This proposed  
usage relates to the yet to be created first commit on the new  
branch. It is possible to use the "already created" interpretation in  
this context (create a new branch based on the root commits of the  
specified commits), but it really does not make much sense. Still,  
qualifying "root" might help prevent some confusion:

     --new-root
     --fresh-root
     --root-branch?

     --new-history
     --fresh-history
     --fresh-branch

Logically, both --orphan and --root are descriptions of the commit  
that will _eventually_ be stored under the branch, but not  
descriptions of the transient state of the branch itself. This state  
is described in a few error/warning messages as "not yet born" or  
"unborn" (checkout, pull, fsck). It seems to be an unofficial term  
though (or maybe just unimportant) since it is not otherwise  
documented (it is not in the glossary, but it does appear in the  
release notes a few times). So with some weight of existing  
terminology behind it:

     --unborn

--no-parent was mentioned elsewhere in the thread, but it suffers  
from looking like a negation of a potential --parent option. Though  
much longer, --without- does not suffer this same problem.

     --without-parents
     --without-history
     --ahistorically    (probably the non-standard prefix is too  
"native")

     --ex-nihilo        (just kidding?)

-- 
Chris
