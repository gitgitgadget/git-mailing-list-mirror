From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cloning a namespace downloads all the objects
Date: Fri, 16 Nov 2012 08:43:13 -0800
Message-ID: <7vvcd57b32.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_hdsgXoPcSn__htpGCpmCsAGb9j+m+SvxtO_69eqC92gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 17:43:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZP0t-0008Ha-FE
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 17:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab2KPQnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 11:43:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782Ab2KPQnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 11:43:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E714EA35F;
	Fri, 16 Nov 2012 11:43:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AEDV8U3+FaRfsqgO6HEWBfnqW3k=; b=RVu5+8
	1UkFbyS2nw8LyQwF9sX0X9WxK0eOG2kt148/Xit8eLtkO4GOdaAI8VHcmky5XQYE
	ZOgnUUimC6ai/Qd7Cb1qcsDJJiBEKZizzQ5XhmN/S3EKgYqQpQYRco1PyzsDj2s1
	hUzAGkImhXXE+t5gseaunv2O3mbgT0eexNDcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uMIrxKmC3WAmyB3W1NMZlFjnjAo5sokW
	YghdwpgmZJC7/vIZKlDdN2J96QX1lam/gRxZ4KOx9IlECuEIO6M0rv98hqHz4vPi
	lp7MmamGiYANKnRQCrS+a/syuNqDFtOZya8PuyxnsKmYEzZcP7ZJFOs1Jv7v6NTb
	EzWvGjJHpD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9144A35D;
	Fri, 16 Nov 2012 11:43:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43C0DA35A; Fri, 16 Nov 2012
 11:43:15 -0500 (EST)
In-Reply-To: <CAMK1S_hdsgXoPcSn__htpGCpmCsAGb9j+m+SvxtO_69eqC92gA@mail.gmail.com> (Sitaram
 Chamarty's message of "Fri, 16 Nov 2012 22:04:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B79DE612-300C-11E2-ADA7-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209884>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Hi,
>
> I have a repo on a server, which contains, as namespaces, the contents
> of several different repos of varying sizes.  When I run a clone
> command for the smallest of the namespaces (I have a script that
> intercepts the clone and sets GIT_NAMESPACE appropriately), I get the
> correct set of refs, but *all* the objects from *all* the namespaces.
>
> And since no refs from the other namespaces have come down, a 'git gc
> --prune=now', run immediately after, reduces the size of
> ".git/objects" to the size I would expect for just that small
> namespace.
>
> In effect, it is bringing down data that is not reachable and will be
> wiped out on the next gc.
>
> Is this expected?

I do not think so.

This was done with a series between a1bea2c (ref namespaces:
infrastructure, 2011-07-05) and bf7930c (ref namespaces: tests,
2011-07-21); Josh, care to comment on and to look into it?
