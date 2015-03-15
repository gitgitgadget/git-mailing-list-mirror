From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Sat, 14 Mar 2015 19:32:29 -0700
Message-ID: <xmqqy4mzuh1e.fsf@gitster.dls.corp.google.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
	<1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
	<CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com>
	<20150311220825.GB46326@vauxhall.crustytoothpaste.net>
	<xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com>
	<55016A3A.6010100@alum.mit.edu>
	<20150312104651.GF46326@vauxhall.crustytoothpaste.net>
	<CACsJy8AL0jGwzTfWDSszkvyqzNtPA7o7vQRT5NFaBYrVU02nOA@mail.gmail.com>
	<xmqqwq2m2hwf.fsf@gitster.dls.corp.google.com>
	<CACsJy8CMZbwyBayX-bbWmGwV=AWC000Yx6LfzOcB2irq2X6qHQ@mail.gmail.com>
	<xmqqwq2lzb6u.fsf@gitster.dls.corp.google.com>
	<CACsJy8BeFO3RQJ6pU5+q6E4n3A36X9PgYoi7xB_NQ4C_JYaP5w@mail.gmail.com>
	<xmqqbnjvw7c8.fsf@gitster.dls.corp.google.com>
	<CACsJy8CK=0QpsMpZKN6Js99xFRD6mpJW1id2BBQDMsV1DaHiPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 03:35:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWyP3-0001wL-2Y
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 03:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbbCOCcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 22:32:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751106AbbCOCcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 22:32:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81E6F4163A;
	Sat, 14 Mar 2015 22:32:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xyXOXtiezLCh0RhzX367t/JFLwk=; b=qpEcnq
	rK48YW8kX0RtKMjzXhCYn8d90nA1kfWl/37DVnlzr/PmLwPeG9AfjqEA9uTJ5KbU
	/zec846aeynvq07nhB6Jqtqt02h/VZrEhJuVRPqim6Z1sgJCgfjJ/8djgcKsm9Nj
	qKHcMc+B8w55Tgxe+jTaU9fUy41iTPK9JC7XU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qYBJWTDKsXt8oQ8ECDSFbeV/k/JoxY9H
	wvvP/0m3aAKe0qsDrbK44eG+x+Qyk5OdmruXiBQ7dOd07dI8uu107dMshZvXR7wQ
	A+WTePZH2pb5VmmnOruDZQBMVxZRXQui8rbKZgAGA2uC9a4LndZs6wpMslVEqN42
	Mea3qrQaPf4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A70F41639;
	Sat, 14 Mar 2015 22:32:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9DB341638;
	Sat, 14 Mar 2015 22:32:30 -0400 (EDT)
In-Reply-To: <CACsJy8CK=0QpsMpZKN6Js99xFRD6mpJW1id2BBQDMsV1DaHiPg@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 15 Mar 2015 07:17:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8795CDB2-CABB-11E4-8EF1-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265478>

Duy Nguyen <pclouds@gmail.com> writes:

> Notice that the first time pack->obj[] is filled using
> lookup_object(). So yes, the hash table has all the pointers that
> pack->obj[] has.

Are we talking about the same thing?

By "the hash table", I mean **obj_hash that is a hashtable that uses
<sha-1> form of identifier as the key.  So "the hash table has all
the pointers" sounds like all the objects you instantiate from a v4
packfile needs their object name known in the <sha-1> form anyway
when it gets instantiated (or more importantly, when you realize
there is another copy of it already in the **obj_hash hashtable, you
may have to free or refrain from creating it in the first place).

As long as we use **obj_hash hashtable as "all the objects this
process cares about in the world" and "struct object_id.hash" as the
key into it, I do not think <pack,nth> representation belongs to
that layer.

I do think <pack,nth> representation has its use as a short-cut
mechanism to reach an indirectly referenced object directly without
instantiating intermediate objects when dealing with an extended
SHA-1 expression (cf. "v1.0^0:t" example in a few messages
upthread).  I just think it does not belong to "struct object_id"
that are used to refer to in-core objects.
