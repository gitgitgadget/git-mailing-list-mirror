From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git apply" can't add new files to repo ?
Date: Fri, 15 Jul 2011 12:39:30 -0700
Message-ID: <7vd3hb1ggd.fsf@alter.siamese.dyndns.org>
References: <CAAnh3_-ayozWnHR-ViJ3zjXQvPQA1kd9spGV_TEU=-kFzBytvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yang <teddyyyy123@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 21:39:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhoEb-0007FJ-E6
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 21:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab1GOTjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 15:39:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755644Ab1GOTjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 15:39:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 128FE481C;
	Fri, 15 Jul 2011 15:39:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jFvp1ixzt3/kExgSKEKtqgkI0TQ=; b=r4Wjrk
	i0Wo/mAIg06oVQElnszKbiOOUBlQwh5dssicnymOJjjzaObmNPyce2ub0FYmsGRs
	WQXSCs17ZOHmUVQiYE882JCyknjLiWpN7SU8R+aapt2FJHToqv6QKWI+nQDZ49QN
	a3/ex4MUGs5Pzl+XJopc0VPlDkDQcQthdIZWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aPAZUkP383R5WeQ+asObvO283PI/7dT7
	ehWIPrXYfQwHuKUBDlA5s8BByAjUGlVve5nHD3Uz63Vvbs+IWE7IEAxBUjFDLwYr
	JjK0vIZSPt4HlNXdtmXZ5sB6YQ0lqzTOlKsEZGRLluF77yatVWKfp2el7gt76dv8
	pbTqbaSptYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A644481B;
	Fri, 15 Jul 2011 15:39:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94EF1481A; Fri, 15 Jul 2011
 15:39:31 -0400 (EDT)
In-Reply-To: <CAAnh3_-ayozWnHR-ViJ3zjXQvPQA1kd9spGV_TEU=-kFzBytvw@mail.gmail.com> (Yang's
 message of "Fri, 15 Jul 2011 12:02:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 293106D0-AF1A-11E0-98CC-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177218>

Yang <teddyyyy123@gmail.com> writes:

> I created a patch by "git format-patch", and this patch includes some
> newly-added files.
>
> when I got back to the original branch, and apply this patch, the new
> files appear, but they are not
> added to git repository, so I have to manually find all the new files
> and do "git add" for each of them.

You are doing and thinking wrong.

$ git apply patch
$ git commit

would not add any new contents to existing paths either.

$ git apply --index patch
$ git commit

would be the way, but that is why we have "git am".
