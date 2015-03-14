From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Sat, 14 Mar 2015 15:19:03 -0700
Message-ID: <xmqqbnjvw7c8.fsf@gitster.dls.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 23:19:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWuOm-0005ca-VI
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 23:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbbCNWTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 18:19:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751166AbbCNWTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 18:19:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A15863E85E;
	Sat, 14 Mar 2015 18:19:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gWA7cvuB9l75ukGz4tdyjPXSW5s=; b=bv2WL9
	C79c5ZvlTBErQVTpojRAJr9cvsuBTKm/zYG6umRL55gobR9Ze6oIglB4mPIfgGFE
	R3H0RlyiCm41Hy42YumHdWVcBSzpHL5c9q8rURBDOXZGm76T3oKOcAhN+BKmFUJf
	3TZZPiXgskQambMrew47BgLbEddl4E4Uq70qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C0cwkLvri+jZAAgEt4MQcG6jAXbeXF9w
	97LuvJbOZq3hyfK0SEQKWsPLsB5/EFxl0wlz9ngSTLXjbfCbpOh4mKPjpUrdEbIv
	2RDKnBwVccBjvdLYB9UYKV5l1bS+caerCFHzCmD83UtPHCbckgOSMpmECJmcEHQt
	G6fmfhuprgU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 993753E85D;
	Sat, 14 Mar 2015 18:19:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB1BA3E85C;
	Sat, 14 Mar 2015 18:19:04 -0400 (EDT)
In-Reply-To: <CACsJy8BeFO3RQJ6pU5+q6E4n3A36X9PgYoi7xB_NQ4C_JYaP5w@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 14 Mar 2015 18:49:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 20114C98-CA98-11E4-A1D7-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265464>

Duy Nguyen <pclouds@gmail.com> writes:

>> Anyway, wouldn't this be all academic?  I do not see how you would
>> keep the object name in the <pack, nth> format in-core, as the
>> obj_hash[] is a hashtable keyed by <sha-1>, and even when we switch
>> to a different hash, I cannot see how such a table to ensure the
>> singleton-ness of in-core objects can be keyed sometimes by <hash>
>> and by <pack, nth> in some other time.
>
> I'm implementing something to see how much we gain by avoiding object
> lookup. The current approach is having "struct object ** obj" in
> "struct packed_git", indexed by "nth". So when you have <pack, nth>
> and pack->obj[nth] is valid, you'll get to "struct object *" without
> hashing.

But do you realize that the hashtable serves two purposes?  Grab the
object from its name is one thing, and the other one I am not seeing
how you will make it work with "sometimes <sha-1> sometimes <pack,nth>"
is to ensure that we will have only one in-core copy for the same object.
We even walk the hashtable when we want to drop the flag bits from
all in-core objects, so even if you instanciated an in-core object
without going through the object name layer, the hashtable needs to
have a pointer to such a pointer, no?
