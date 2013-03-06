From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch --no-tags with and w/o --all
Date: Wed, 06 Mar 2013 13:56:01 -0800
Message-ID: <7vboawp4zy.fsf@alter.siamese.dyndns.org>
References: <1879950.i2j8pjGADy@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cristian Tibirna <ctibirna@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Wed Mar 06 22:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDMK8-0008Bf-MY
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab3CFV4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 16:56:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611Ab3CFV4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:56:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A913A514;
	Wed,  6 Mar 2013 16:56:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=POBhh4TEegCk0QPIGKzy7K0wdJI=; b=yiBNxL
	i2rolDcTrOYSsTGHAkWgd3LzBenpXAsQ0A1NxcBm6GigopFH6L/5vea9TgSs7HBa
	EHz5zdE/6tjaqWn1skkuXTtIfnhf3BDwmp1+5SfV8wVDxfILb4pjMWdEpTNYntId
	eTJx+It0D36x2QQqow3enlTElyY0z5bDJJJo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RA13WYEGDMk4gUM/9zyRdK1uA9vz5uc2
	7ibhD1kslp5o9ldAVpA11C5CkBStoOKra9LFatQn2QRBbE+stkHSYTvOqPuM0Wau
	Vj+XM3mAS/yg3lhwTSPJCUoMdZUsZbL6fcgQG8h3lKPSDSVrMcdoaKcO4qInFqXz
	hP1wGQ29Y98=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CE7FA512;
	Wed,  6 Mar 2013 16:56:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5751A510; Wed,  6 Mar 2013
 16:56:03 -0500 (EST)
In-Reply-To: <1879950.i2j8pjGADy@gandalf> (Cristian Tibirna's message of
 "Wed, 06 Mar 2013 16:33:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3E4F852-86A8-11E2-AAB7-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217555>

Cristian Tibirna <ctibirna@giref.ulaval.ca> writes:

> Hello
>
> $ git --version
> git version 1.7.10.4
>
> $ git fetch origin --no-tags
> does what it says
>
> $ git fetch --all --no-tags
> still gets all the tags from the remote.
>
> Is this known?

Because --all (or --multiple) to iterate through all remotes
does not pass accept any command line refspecs, using these options
with --no-tags and/or --tags should be diagnosed as an error, but it
appears that the error checking is not done.
