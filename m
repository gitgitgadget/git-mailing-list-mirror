From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Allowing push --dry-run through fetch url
Date: Tue, 29 Dec 2009 08:58:23 -0800
Message-ID: <7v1vidhg40.fsf@alter.siamese.dyndns.org>
References: <20091106073707.GA14881@glandium.org>
 <7vfx8s0yy1.fsf@alter.siamese.dyndns.org>
 <20091106095357.GA13389@glandium.org>
 <7vfx8obz2o.fsf@alter.siamese.dyndns.org>
 <20091229200517.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 17:58:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPfPE-0004fR-Qr
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 17:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbZL2Q6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 11:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbZL2Q6e
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 11:58:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZL2Q6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 11:58:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2488DABF70;
	Tue, 29 Dec 2009 11:58:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=XFVJTyaytwYRHEMTYE6x0mzw0OI=; b=eqSkE3exUEJwe87j7tR9sR9
	fwPKOBWoBcwZ218PvOISIc/+q4xZLGItbccvvPw4DVrjnCKxzuVT/S2CY6kaQuzX
	CoQ23kCfsoJ2dE+HdKA4lJ/3H0IpvQPKXqwJpeGx6wa4NSuH3aQzsyzAHbDJ0DcV
	Zvki1sS6yObTdq6oF3tA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=tJ16xPp9G/LNiZ4t3Jey4hAt5LA51yzLuvxk1atoU8ZEI60DC
	4s58HAP52DY7Vk7G8MXORrtRMnU7G7FMQ2lkv/jqmt7fVauDyMNr703nkoohArht
	XIN7W881JrKkuY+zZujxkOdJDjUqDg5MQRXc/ntq/6/3Xr6BPXfL3VgzH4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7E1E5ABF6F;
	Tue, 29 Dec 2009 11:58:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5079BABF6E; Tue, 29 Dec 2009
 11:58:25 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6389E788-F49B-11DE-9BE7-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135811>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?
>
> After discussing "git push --dry-run" that looks at URL used for
> fetching, because pushURL might require authentication, the
> maintainer recalls an earlier "git push --confirm" patch
>
> http://thread.gmane.org/gmane.comp.version-control.git/128426/focus=128429
>
> but nothing happens after that.

Your analysis is correct --- nothing happened after that ;-)

I think it is probably worthwhile to revisit Owen's patch, though.  Back
then I was worried too much about giving IDE authors (who need to scrape
the output and interact with the "confirm" interface) enough flexibility
and wanted to see an interface to allow plugging a more machine readable
interaction before proceeding, but I changed my mind.

We can have --confirm with two output styles, one that is for consumption
by human sitting in front of a terminal (and is prone to future UI
tinkering like coloring), and the other with machine readable interaction,
that is more or less frozen (or "extensible").  And it is perfectly Ok to
start only with the human readable one, clearly documented that it is not
(yet) for use by IDE via scraping.

But I won't be the person with the --confirm itch, so interested people
need to help to make that happen.

Thanks for a stream of reminders, by the way.
