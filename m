From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash show: use default pretty format
Date: Thu, 12 Jan 2012 11:06:53 -0800
Message-ID: <7vy5tc210y.fsf@alter.siamese.dyndns.org>
References: <1326351953-3724-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:07:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlPzM-00059u-Bw
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 20:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab2ALTG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 14:06:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593Ab2ALTG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 14:06:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB90370DB;
	Thu, 12 Jan 2012 14:06:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PQALx2SbY+JrR1Q1uOYoZr//4oU=; b=eoPpKg
	gJXeNCwzMa7Jza5AiJ4gu5nKytfdGgk+nAc3n+rPqzaSAKgBlZgE3xRmUAe90koM
	8WTv9+aU6XxUnJ5NCAtZ+XH9pQ7y4Ilm1q1qQ3HClNTbwElzZEdZaSfM6CPBulln
	G9ha/UOc6jM/IqFm/Br+QePzbZC03yKe8M1tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yhlWCe3P6VS7ukvnkVpR5tjXXdR6E+UI
	/QBeGfpWTdDOG+b4WpGfO3ky6pCYY86essjxRyBhbbDoPxkh7dHiIvXL4quBgpfF
	SOUuEZymOHvnfEetoARumCk8Ow/rVfCqkr07/wuHL94bFIOmZQ2hP9YdF6DAViiQ
	hZ5S3Qs9Ldo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D279070DA;
	Thu, 12 Jan 2012 14:06:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44D9670D9; Thu, 12 Jan 2012
 14:06:55 -0500 (EST)
In-Reply-To: <1326351953-3724-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu, 12 Jan 2012 15:05:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97E5D85C-3D50-11E1-AC6D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188471>

Tay Ray Chuan <rctay89@gmail.com> writes:

> By default (ie. when stash show is invoked without any arguments), the
> diff stat of the stashed changes is displayed. Let git-diff decide the
> default pretty format to use.
>
> This gives git more consistency, as users who have set their
> pretty.format config would naturally expect `git-stash show` to display
> the diff in the same pretty format as the other diff-producing procelain
> like git-log and git-show.

A handful of issues:

 - The stash entries, unlike the usual commits you store on branches and
   inspect with "show", are designed to be quick escapes for emergency
   interruption, and "--stat" is a good default to remind the user what
   she was working on before she was interrupted _without_ scrolling the
   top of the screen away by showing the full diff.  Careful design
   decisions far outweigh mechanical application of "consistency for the
   sake of consistency".

 - What does "pretty.format" has anything to do with "stash"?

 - If it does, why doesn't the script read from it?

 - How does this justify the UI regression for people who are used to the
   good default "--stat" they have been seeing?
