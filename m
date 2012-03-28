From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 12:54:38 -0700
Message-ID: <7v8vikv6v5.fsf@alter.siamese.dyndns.org>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
 <7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr>
 <4F73632E.1060408@ira.uka.de> <vpqk424zfb1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:54:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyxB-0003jZ-OF
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758582Ab2C1Tyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:54:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758501Ab2C1Tyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:54:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21E3C7BDC;
	Wed, 28 Mar 2012 15:54:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PTv4mk1Cnc8q4G4t62nmHjPmUK0=; b=GopSBc
	Re8tZY6NwvAzONLSGP5jFGmvXcPu2zxyXz2EVeJlmMlQ6ES2L1Jd3G2iyr622NQv
	YwHomvEZicmJOmEf6D18srdgvsdOWKRfuWi0UMfNebwTIe++NtKp+04bL7knZyFl
	IGrNpIFAa+eMOi+ebPvQAfE+pvrSFHrvbBQsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pafQUA6ZIq2snsBLT3XnTVIQGiiG+1Bo
	wH7siGRqsT7T8yB0A2qgOIb1UQ2+ggZX+LYNZPXPzAejFKsYeEft/3xIv2kzBQ4+
	o/+OHor5pa9wydijx+GJ8gvtThNDYVBsHbgjzXm7yhsPcqE8ReAN+kxQvMLixwoR
	bG+N8STC+qA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18AEC7BD2;
	Wed, 28 Mar 2012 15:54:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A22737BD1; Wed, 28 Mar 2012
 15:54:39 -0400 (EDT)
In-Reply-To: <vpqk424zfb1.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 28 Mar 2012 21:38:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA991114-790F-11E1-89E4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194178>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> And you miss the most usefull (to me at least): "choose the version in
> the worktree".

I tend to think that "add -p" whose sole purpose is to make partial commit
is fundamentally incompatible with "am", "merge" and (mostly) "rebase",
which you do not want to record partial commit.

When "rebase -i" or "cherry-pick" that is used for the purpose of
replaying only a part of a larger commit, letting "add -p" show the
difference between "HEAD" and the working tree version, and letting the
user pick hunks, would make a lot of sense, though.

For such an application, however, the user could first "reset $path" and
use "add -p" normally.
