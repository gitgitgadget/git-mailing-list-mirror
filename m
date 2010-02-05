From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Fri, 05 Feb 2010 08:10:56 -0800
Message-ID: <7veikzfysv.fsf@alter.siamese.dyndns.org>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vaavo90ic.fsf@alter.siamese.dyndns.org>
 <cb7bb73a1002041538m64c6a6b3p5ee8bbaf0d78457@mail.gmail.com>
 <201002051136.43738.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 17:11:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdQm9-0002DP-Ap
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 17:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab0BEQLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 11:11:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab0BEQLO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 11:11:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AABF979DC;
	Fri,  5 Feb 2010 11:11:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pkeA0ktiyRW3iErJlNN9nfHHMUU=; b=TazRrI
	0H8exgel5MGGaZOPT1HA0dFzZFtyW3jnvS8glWPDy7/XUC6fWaB7xCrQ9sTH8YJM
	EBKu/h5bh2QTDlk9N42xpy5ZoQQqePQM/Hhm/XCf9HOUNfKjYDgoSkOpjVlidKna
	xa5lEx3iKUnwjnjwwoOgB2kY6zZFEsuQhuCM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oi9r42qoVPpxDVPbqsx41HaNG06HlVBh
	7WDMAI3VRYYo5DDlQqShNVxqXlq32h25xnH/X6MqOihPpLKQusN9/XzrkX37QOqK
	agLpB3XBSCJUql3urugA6AVj/ON6yGVG2PCSKp3iqcttpW9pUAf5/rlNHHmg9OMM
	IOHERvnxxWY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1836979DA;
	Fri,  5 Feb 2010 11:11:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5AC3979D7; Fri,  5 Feb
 2010 11:10:57 -0500 (EST)
In-Reply-To: <201002051136.43738.johan@herland.net> (Johan Herland's message
 of "Fri\, 05 Feb 2010 11\:36\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F91AC08-1271-11DF-BD35-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139053>

Johan Herland <johan@herland.net> writes:

> I already maintain a TODO list at the end of the cover letter to the notes 
> series. Here is a preview of it (I plan to send the next iteration of 
> jh/notes as soon as v1.7.0 is released):
> ...

Random additional thoughts.

* Futureproofing

We have to admit that our notes support, especially on the output side, is
still in its infancy.  We may want to advertise it as such -- highly
experimental and subject to change.

* format-patch

To add notes to format-patch output, we might want to do something like:

    $ git format-patch --notes-ref=commits --notes-ref=amlog -1

and produce:

    From 8bff7c5383ed833bd1df9c8d85c00a27af3e5b02 Mon Sep 17 00:00:00 2001
    From: Andrew Myrick <amyrick@apple.com>
    Date: Sat, 30 Jan 2010 03:14:22 +0000
    Subject: [PATCH] git-svn: persistent memoization
    X-Notes: pulled on Fri Feb 5 07:36:12 2010 -0800
     from git://git.bogomips.org/git-svn.git/
    X-Notes-amlog: <1264821262-28322-1-git-send-email-amyrick@apple.com>

    Make memoization of the svn:mergeinfo processing functions persistent with
    ...

Points to notice:

 - There is no point forcing users to spell "--notes-ref" parameter
   starting from refs/notes/; we should DWIM if they are missing;

 - We would want to allow more than one notes hierarchy specified. This
   would affect format_note() function---take list of struct notes_tree,
   perhaps;

 - Allow callers of tell format_note() to add the name of the notes
   hierarchy the note came from (or just always add it if it is not the
   default "refs/notes/commits").

 - For format-patch that produces a mbox output, the email header part may
   be a better place to put notes (obeying the usual "indent by one space
   to continue the line" convention).

* "log --format=%N" and "log --show-notes"

Currently %N expands to the hardcoded "log --show-notes" default format.
We can probably keep it that way.  When the user asked for a non default
notes hierarchy (i.e. other than refs/notes/commits), we may want to
adjust "Notes:" string to use "Notes-%s:" to show which hierarchy it came
from, and concatenate them together.

For "log --show-notes" output, we also might want to move the notes to the
header part like I illustrated above in format-patch output, instead of
"start with unindented Notes: and indented body at the end".  I.e. instead
of showing this:

    $ git log --notes-ref=amlog -1 4d0cc22
    commit 4d0cc2243778b38c3759c6a08f4f1ed64155a070
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Thu Feb 4 11:10:44 2010 -0800

        fast-import: count --max-pack-size in bytes

        Similar in spirit to 07cf0f2 (make --max-pack-size argument to 'git
        ...
        Acked-by: Nicolas Pitre <nico@fluxnic.net>

    Notes:
        <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>


show it like this:

    $ git log --notes-ref=amlog -1 4d0cc22
    commit 4d0cc2243778b38c3759c6a08f4f1ed64155a070
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Thu Feb 4 11:10:44 2010 -0800
    Notes-amlog: <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>

        fast-import: count --max-pack-size in bytes

        Similar in spirit to 07cf0f2 (make --max-pack-size argument to 'git
        ...
        Acked-by: Nicolas Pitre <nico@fluxnic.net>
