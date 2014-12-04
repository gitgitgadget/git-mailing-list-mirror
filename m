From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in reflog of length 0x2BFF
Date: Thu, 04 Dec 2014 12:18:05 -0800
Message-ID: <xmqqvblrrwxu.fsf@gitster.dls.corp.google.com>
References: <547C8610.8080301@cs.uni-saarland.de>
	<20141201233515.GV6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christoph Mallon <mallon@cs.uni-saarland.de>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 21:18:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwcqr-00025Q-Cb
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 21:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbaLDUSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 15:18:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753343AbaLDUSH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 15:18:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F5DA23D5D;
	Thu,  4 Dec 2014 15:18:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i3FlmOtvBBMo5bHU6evbswpZBYk=; b=Swwanl
	E1IjOKDG5zuNd9N9n9NSB66XZeL3V2zGWPT+JT59Fb4S6blxJkBe7IRCFXCdAUF6
	rWlEN5LpawPRiY5wYOjVlMmV8Fe43hVQaFcuayHYJBUtkadhxZZ8NkClIQuBSq3X
	mFkECnh8eQTW59gN5zEXpcrveWwgWUMpYi6PM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZUinqLaMuRg0a+D5EkGQMEDVSl1J7Y6q
	5UJbOOCbMfjphAs6gpUhT2OALccJNKjk2WJvTLqN5JCJCNZM8Ba4IYw4oikvAcsB
	u4x16Ynrc5F+7G3PcpTvAV1ZkSpURphb6E1m0FUbzjPhSw0MACp2rRqf9lAIKPZF
	UEVJ10aDoaE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25EE823D5C;
	Thu,  4 Dec 2014 15:18:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A87623D5A;
	Thu,  4 Dec 2014 15:18:06 -0500 (EST)
In-Reply-To: <20141201233515.GV6527@google.com> (Jonathan Nieder's message of
	"Mon, 1 Dec 2014 15:35:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A873F92C-7BF2-11E4-AAD7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260795>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Christoph Mallon wrote:
>
>> % git rev-parse 'master@{52}'
>> warning: Log for ref refs/heads/master has gap after Thu, 1 Jan 1970 00:00:01 +0000.
>> 0000000000000000000000000000000000000036
>
> Can you say more?  What output did you expect and how does this differ
> from it?
>
> I tried, with git 2.2.0,
>
> 	git init gitbug &&
> 	cd gitbug &&
> 	git commit --allow-empty -m a &&
> 	wget http://tron.yamagi.org/zeug/reflog.bad &&
> 	mv reflog.bad .git/logs/refs/heads/master &&
> 	sha1sum .git/logs/refs/heads/master &&
> 	git rev-parse 'master@{52}'
>
> The output:
>
>  9ffe44715d0e542a60916255f144c74e6760ffd0  .git/logs/refs/heads/master
>  0000000000000000000000000000000000000035
>
> Could you make a test script that illustrates and reproduces the
> problem?  I.e., a patch to a file like t/t1410-reflog.sh, such that
> if I run
>
> 	cd git
> 	make
> 	cd t
> 	./t1410-reflog.sh
>
> then I can reproduce the bug?

Amen to that.  I am getting the same thing.
