From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/24] update-index: test the system before enabling untracked cache
Date: Thu, 22 Jan 2015 10:49:12 -0800
Message-ID: <xmqqfvb2tzvb.fsf@gitster.dls.corp.google.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
	<1421759013-8494-21-git-send-email-pclouds@gmail.com>
	<xmqqwq4gy1nq.fsf@gitster.dls.corp.google.com>
	<CACsJy8CDgUWEE=QKAgw4G8pgA-cOmLMs4sH67C47Ohd5XJQDNQ@mail.gmail.com>
	<xmqqvbk0vug9.fsf@gitster.dls.corp.google.com>
	<20150122102624.GA25892@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 19:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEMoj-0006Dd-6w
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 19:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbbAVStR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 13:49:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751841AbbAVStQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 13:49:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2852A312E8;
	Thu, 22 Jan 2015 13:49:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kMdwV1ut8elLpU+M9fj7MkoEF3Y=; b=N1+1YP
	e/dfuitcymg3b41SCYZlm9wF4DxjOSKbNcvVYnsAgcCxMNAzTREBKCJp/ZwudgkL
	+e9pn3BJ20Uas4JWj2B8xxu7jrrkRlbivYcIMX4niiPm4NYiDANdWArCZnhojPpw
	hZcyGgXH6wcM6oOPhCKlSrHs2pEkhXjf92e5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZsXt5m/sg03ikMTxURKGDZFWn6PJp7tX
	d28fUTvQRX+r2CM8ljRCaRRYb2tMGPMTjFq+GE3VS4RZWl7hK69bKwqV8rIEqMvg
	4cLXjaUqtTqOzqIIpf1EI8kz6K+i7tehSTsgNKpO9eqn8QEGdTjUGkQmGN2AFyS5
	e0SnKI2R0JE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DC8F312E7;
	Thu, 22 Jan 2015 13:49:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76CDA312E6;
	Thu, 22 Jan 2015 13:49:14 -0500 (EST)
In-Reply-To: <20150122102624.GA25892@lanh> (Duy Nguyen's message of "Thu, 22
	Jan 2015 17:26:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C921278-A267-11E4-BE45-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262855>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 21, 2015 at 10:51:02AM -0800, Junio C Hamano wrote:
>> >> It appears that this hijacks a fixed name dir-mtime-test at the root
>> >> level of every project managed by Git.  Is that intended?
>> >
>> > I did think about filename clash, but I chose a fixed name anyway for
>> > simplicity, otherwise we would need to reconstruct paths
>> > "dir-mtime-test/..." in many places.
>> 
>> If you stuff the name of test directory (default "dir-mtime-test")
>> in a strbuf and formulate test paths by chomping to the original and
>> then appending "/..." at the end, like your remove_test_directory()
>> already does, wouldn't that be sufficient?
>
> It looks actually good. How about this on top?

Yeah, looks cleaner.  I am not (yet) enthused by the intrusiveness
of the overall series, though.
