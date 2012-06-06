From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] parse-options: introduce parse_subcommands
Date: Wed, 06 Jun 2012 10:26:12 -0700
Message-ID: <7vobowmjwr.fsf@alter.siamese.dyndns.org>
References: <1338802534-32394-1-git-send-email-artagnon@gmail.com>
 <7vlik3t3j2.fsf@alter.siamese.dyndns.org>
 <CALkWK0nuJ2VrAUD5PsfnZzO5yDgB+h4xn8g=CTqmUvJ8DOdPNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 19:26:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScJzw-0006YB-Iy
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 19:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539Ab2FFR0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 13:26:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757422Ab2FFR0P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 13:26:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F270801F;
	Wed,  6 Jun 2012 13:26:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SECK1G6S7ChZQLbgjTn7TuAB3sc=; b=gr8JPY
	A52hCOmc6CEdbd19txLNMGJ6Pr9qPVGi8TccutHfmqvKHKu0/KC4kr7uG7J/AKv4
	qJFeaZMKj3xdCt9gMs3ZGQ4toz/1aLa7y7g+FCjuw8yedWwZH/CIUUVBSdqFJh7/
	k/C5HtyRKvBdVXHtoK5OFZJRuc8J2bxcau8KY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kGCIJd62A9A72Ob5W3ur6vMvMO9KdGx7
	9cB69LnoBMytwHcX7RxIcAd9SnPbXdzOrDMkwN0ULJYbdu+jaEzi7o+HdSF6VcJ5
	Oiym2CueWHf9yJAf6BoIAFv+28ZNOM3R2F+ivysRmfnGjr0k45RaS+YnaurpzSO+
	VI42MEu0NBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55954801E;
	Wed,  6 Jun 2012 13:26:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9162801D; Wed,  6 Jun 2012
 13:26:13 -0400 (EDT)
In-Reply-To: <CALkWK0nuJ2VrAUD5PsfnZzO5yDgB+h4xn8g=CTqmUvJ8DOdPNQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 6 Jun 2012 19:40:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B737F5F4-AFFC-11E1-9BCE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199338>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> It looks like a static version of string_list_lookup() and does not
>> have much reason to tie it to "subcommand".
>
> How so?  I can use a string_list to keep subcommand->name and stuff
> the callback into util.  Where do I put subcommand->help then?

A string_list is a mapping from a string to an arbitrary piece of
data; there is nothing that stops you from placing a pointer to a
structure in its util field.

> I agree that there's no reason to tie it to subcommand though.

Yeah, if it were a generic API for a mapping from a string to an
arbitrary piece of data that is determined at compile time, it would
be a useful addition, and at that point, it is misleading to call
that a "parse-subcommand" API.  It is just a look-up mechansim in
a fixed table keyed by strings.
