From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] gitweb: Use GITWEB_CONFIG_SYSTEM even if GITWEB_CONFIG
 does exist
Date: Tue, 17 May 2011 10:28:00 -0700
Message-ID: <7v4o4tgrtr.fsf@alter.siamese.dyndns.org>
References: <201105142137.16541.jnareb@gmail.com>
 <20110514210603.GA11502@elie> <201105151153.08826.jnareb@gmail.com>
 <201105161153.24382.jnareb@gmail.com>
 <7v39kdj3hw.fsf@alter.siamese.dyndns.org>
 <1305645589.11864.20.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue May 17 19:28:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMO4E-0003Ri-KR
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 19:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab1EQR2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 13:28:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab1EQR2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 13:28:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF1C5502A;
	Tue, 17 May 2011 13:30:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C+FYz8pMYU4dm6u0k7GY7SS92Wo=; b=ybxy+p
	giCyl909icfeCPpQ3RdmkiFORDD+GJDIU/6X/35X/ZGLu6vhihNl6EksBwau6lsd
	0/iXjLjVBRgabEgRYOujcIwfGF0rAf5xBBM3/0vdAB8fp5JufWWOIZpoZdFReGLo
	wiZrbUx1YPnWnB7qnHiJjjh6Go6HARFoCeerw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bhBUBz8vblY8iJtF+V0GMKuERKVUu8Wu
	o3Hwct3ko8YbyGMSzzdTn9DFSbtoYQ39zHpnvamKt+Mag/o6p+cJlfgjeFR1C7wT
	5dK8YKTfj7KsAgCwieGu9zAj2TAd6gIeGpeP53EOtFgSvUHq8Atls+k+Psb/PK+A
	JH51YOmOgOE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E3115029;
	Tue, 17 May 2011 13:30:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A09EE5028; Tue, 17 May 2011
 13:30:09 -0400 (EDT)
In-Reply-To: <1305645589.11864.20.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Tue, 17 May 2011 11:19:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54E8E894-80AB-11E0-A0BB-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173815>

Drew Northup <drew.northup@maine.edu> writes:

> On Mon, 2011-05-16 at 22:32 -0700, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > This commit changes gitweb behavior so that configuration in
>> > per-instance configuration file can _override_ settings from
>> > system-wide configuration file.
>> >
>> > Note that strictly speaking it is backwards incompatible change.
>> 
>> I am not sure if we gain enough from this change.  As the system-wide one
>> can be arbitrarily overriden by per-instance one, the goal of this change
>> cannot be to make sure that the system administrator can enforce the
>> system wide policy over all the gitweb instances.
>
> Currently if there is a local configuration file
> _there_is_no_system-wide_policy_. That's the problem.

As I said, the patch does not solve "system-wide policy" problem at all,
as the per-instance one can override anything. You _could_ sell this as a
convenience feature to me, and I already agreed it would be one possible
way to make things convienent.

>> I think the goal is to let per-instance configuration have an easy way to
>> inherit from a common sane default, but if that is the case, wouldn't it
>> be a lot safer and more backward compatible way to just instruct people to
>> include that common default configuration at the beginning of per-instance
>> configuration file instead?  After all, you would need to give some advice
>> like this ...
>
> If that's currently being done anywhere this change will not cause any
> pain. If the default /etc/gitweb.conf contains a set of commented-out
> sample entries, as it should in the case of something like this, then
> there will be no problems.

I could easily imagine a site whose primary objective of it is to support
a specific project. It would be natural for the sysadm group to decide to
use /etc/gitweb.conf to customize its primary gitweb instance to suite the
the need of serving that project.

The sysadm group may allow its users who have their own side projects run
their own instances using per-instance configuration. These users would
have been happily using their gitweb instances, with the knowledge that
anything specific to the primary project of the site in /etc/gitweb.conf
would not affect their instances.

These are broken with this change, no? The users of instaweb is also
affected the same way.

Although I am sympathetic to the wish to have a common configuration that
is shared by all instances by default (or even make it mandatory), I am
just pointing out that there is a downside if you use /etc/gitweb.conf as
the common configuration that is read by all instances.

Would it be a workable solution to make any instance read a new file, say,
/etc/gitweb-shared.conf, if it exists at the beginning, and to leave
/etc/gitweb.conf as the fallback default that is only used when
per-instance configuration does not exist?

If somebody can come up with a mechanism to mark configuration variables
that are set in the common configuration file as "not overridable", a
better name of the common file would be gitweb-policy.conf, as it does
more than "shared" whose purpose is to give common sane default.

I can go either way.
