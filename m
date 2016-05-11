From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Wed, 11 May 2016 16:48:40 -0700
Message-ID: <xmqqh9e4i2av.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<xmqq4ma5l526.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY3S6SmJOMQ7RAKw0yTvicY=Y1VRRGdm5uK9+Eb7W+Ykg@mail.gmail.com>
	<xmqqlh3gi2qr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 12 01:48:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0ds0-0000Vu-J6
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 01:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbcEKXso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 19:48:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751647AbcEKXso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 19:48:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B44A61A760;
	Wed, 11 May 2016 19:48:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h1SKETY4EfJjKWG+9O3VhTu7S8A=; b=mmwaOp
	EZEGjAzGto+TXdu2WjQU05stHsDNjpzmVbTeIMOkFgVSfHm8AQZH1iIA1+qPOvaF
	n4vJY+Ln8Iin75eTlzIHOP8HEqgVbNwTMOEWq5IzHO2GkutWExwrltOM+U1Bh3j+
	eDPrbLud04VOlYPgVGS8jIH6cscQTiAW4Q5T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tqvsg6KfFtFeS+UVhchExSKaa68gFBIr
	wMWpppmiyOEZ+/w+8p5UtBEC1UbSRkYjEqaqUvr6wqrBWXaD417GMIClBzgDnaEg
	FkVH7UUOFjHPrSCS9fMzXsKfUJZ+tI/1CSdS/Qp0JTMtpTE2AxY74bsqKz3ZVct7
	h7JDDemFvu8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A9AD21A75F;
	Wed, 11 May 2016 19:48:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17D3D1A75B;
	Wed, 11 May 2016 19:48:42 -0400 (EDT)
In-Reply-To: <xmqqlh3gi2qr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 11 May 2016 16:39:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E43CC696-17D2-11E6-B85A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294379>

Junio C Hamano <gitster@pobox.com> writes:

>>   git ls-files . :(file-size:>1024k)
>
> I somehow do not think this is a way normal people (read: end users)
> would want to interact with Git.  Pathspec is about "paths" and
> various ways to match them.  It is not about contents that happens
> to be currently named by that path.  Don't tie types or sizes to it.

To clarify, think what that non-pathspec means when used like this:

    $ git diff :(size>1M)
    $ git log --follow :(size>1M)

Which side of comparison does the "size" thing apply?  Either, both,
randomly?  More importantly, what use case of users do these
commands serve?

That is why I said that pathspec should never consider anything but
the pathname string you see.
