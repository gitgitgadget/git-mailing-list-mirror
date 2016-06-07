From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 07 Jun 2016 12:23:40 -0700
Message-ID: <xmqqinxkpzur.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
	<1456950761-19759-1-git-send-email-gitster@pobox.com>
	<1456950761-19759-5-git-send-email-gitster@pobox.com>
	<CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
	<CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
	<CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
	<CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
	<CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:26:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAMbL-0001JS-MP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 21:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbcFGTXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 15:23:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753912AbcFGTXn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 15:23:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 71D9D22297;
	Tue,  7 Jun 2016 15:23:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m2Y8AA/v7Pk6AYIEfxWwSILPSbw=; b=blKWHT
	5cGHl3VeUIgTniWdfhjS+HknGSCReHuyNWt5WkYZZqbv2ETsuEA+Fm2Cn26KUfsK
	zLMrTULZQlwFJi+LocFSUmL2MUJ8hqmTPrsyJJqt3tbODddEgeMnVFcHND3qOSjL
	ee0QlB1NVQgHsDU6jQk/DMTcWIXDtnrV9ETto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=leGqgIIc7pdjm3CXJfXd7aH6Uui+WBat
	Sbsm/4on0IE2i596GTxj4fgYfVh1oLvRGGWoNxlWgRKj72VSS3IC1cjZB92gdlQ3
	c8ZBKpTdDsveDx82dq6DkiI6M1vdoU+DTvOKm+qutlGESGXaGHC57vk0pdVOEIZC
	2YLeNUgQhXY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A48022296;
	Tue,  7 Jun 2016 15:23:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E200522295;
	Tue,  7 Jun 2016 15:23:41 -0400 (EDT)
In-Reply-To: <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 7 Jun 2016 10:46:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5825BADC-2CE5-11E6-B652-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296711>

Christian Couder <christian.couder@gmail.com> writes:

> Git can store its objects only in the form of loose objects in
> separate files or packed objects in a pack file.
> To be able to better handle some kind of objects, for example big
> blobs, it would be nice if Git could store its objects in other object
> databases (ODB).
>
> To do that, this patch series makes it possible to register commands,
> using "odb.<odbname>.command" config variables, to access external
> ODBs. Each specified command will then be called the following ways:

Hopefully it is done via a cheap RPC instead of forking/execing the
command for each and every object lookup.

>   - "<command> have": the command should output the sha1, size and
> type of all the objects the external ODB contains, one object per
> line.

Why size and type at this point is needed by the clients?  That is
more expensive to compute than just a bare list of object names.

>   - "<command> get <sha1>": the command should then read from the
> external ODB the content of the object corresponding to <sha1> and
> output it on stdout.

The type and size should be given at this point.

>   - "<command> put <sha1> <size> <type>": the command should then read
> from stdin an object and store it in the external ODB.

Is ODB required to sanity check that <sha1> matches what the data
hashes down to?

If this thing is primarily to offload large blobs, you might also
want not "get" but "checkout <sha1> <path>" to bypass Git entirely,
but I haven't thought it through.
