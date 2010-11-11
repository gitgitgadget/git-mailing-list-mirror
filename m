From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone / git pull to USB memory stick (FAT) and symlinks
Date: Thu, 11 Nov 2010 09:54:58 -0800
Message-ID: <7vk4kjhhjh.fsf@alter.siamese.dyndns.org>
References: <ibh605$adm$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 18:55:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbMs-0004Hr-L2
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 18:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab0KKRzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 12:55:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab0KKRzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 12:55:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C211372F;
	Thu, 11 Nov 2010 12:55:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wi/kLVkiALqWulh4+WY0G91AnHU=; b=D84UAB
	gM1sGEjUEV8dv2J6oXpi6ruWpSgGu5lvv9GdyV5BxRmrtrdJBxESEDpkk2U84IbJ
	/Kqh60EDXUzVI/LL1rinfIpZ6/z1L0wXJJMKoasQQbRAONUbCDjId7Gj6jmZfTb7
	rld/y3t1gzUbLrnZtozT4IDZZKf43Q044i6v8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wfMn/fnBcJixouIK1RrP0JdAwbXmVlLB
	OAIveIkk+X8AmAhkDCW7M3QB+1cuKS2KYYcCCR/fga3gXQ41XYvCbXHkK7d9rriZ
	AcyVuj3C5krO0+vO2suQRhPZ85mXg9u3skeKwvK4Anx8Xjzf8McCCbduBCIsnsD2
	Sfkud1OxA2w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF792372B;
	Thu, 11 Nov 2010 12:55:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0BB673728; Thu, 11 Nov 2010
 12:55:05 -0500 (EST)
In-Reply-To: <ibh605$adm$1@dough.gmane.org> (gelonida@gmail.com's message of
 "Thu\, 11 Nov 2010 17\:35\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2B93436-EDBC-11DF-943F-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161278>

Gelonida <gelonida@gmail.com> writes:

> I thought about cloning a remote git repository onto the stick
> and performing
> - regular pulls in order to update the USB stick
> - occasional pushes in orderto publish changes performed on the stick.

... missing is the reason why this is done to a USB memory stick.  More
specifically,...

> 1.) Ignore skip / symlinks
> 2.) Avoiding file permission issues: Is this sufficient

These become non-issues _if_ the reason you are putting this on an USB
stick is to safekeep and sneakernet the project data, and are not
interested in having a working tree on the stick, which I often find is
the use case after grilling people who ask about placing git repositories
on an USB stick.

And the commands to interact with such a repository without a working tree
are to "push" (into it), and "fetch" (from it).  IOW, you do not "pull"
into USB stick.

If you do need a working tree on the stick, and the stick has a FAT
derived filesystem (which would be the most common), then you would need

> git config --add core.fileMode false

and perhaps "core.symlinks false" also would help
