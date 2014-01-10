From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH mm/mv-file-to-no-such-dir-with-slash] mv: let 'git mv file no-such-dir/' error out on Windows, too
Date: Fri, 10 Jan 2014 11:30:54 -0800
Message-ID: <xmqqd2jz8wi9.fsf@gitster.dls.corp.google.com>
References: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
	<52CD7DE8.6070101@kdbg.org>
	<xmqq7ga8aibn.fsf@gitster.dls.corp.google.com>
	<52D04856.9070005@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 10 20:31:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1hnT-0000A7-76
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 20:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbaAJTbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 14:31:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbaAJTbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 14:31:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE3B2617BB;
	Fri, 10 Jan 2014 14:31:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H8pmAOlvsedMbnZrT3fRW/iu+BI=; b=d6aMvl
	2vw8xHR1M+H+ca9O/IjVfTT7TUJWKgGSuMSfBLcow93gzJ/YJ6U5BSxHU6G3JFOZ
	DEwFpEz1cK77rXQrIeSCfo9Qvp2EP36T6aiJWqLAHbw9vXbxSNaAqpw7e2J3Zmfs
	kKZYX/pKuwh+cGIgf8BBgZkFD0+Llv4RznYHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p6SSCOnxGSq9+LRI34Qk4L0HsPTwaca3
	vKi4PLFYb1pu5W1oMW2AUf3yABYIKxB0mFtRPrEzbIo1IlLisDQiNbR59zlfvLme
	IKnti8zOXiBVFwOwaSscTNMtYHuc19L43NJfhqycPyXYfSVkFw3FGvvEv8WH5c/y
	S4zkJnuMOxk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85FCE617B9;
	Fri, 10 Jan 2014 14:31:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A7C7617B5;
	Fri, 10 Jan 2014 14:31:01 -0500 (EST)
In-Reply-To: <52D04856.9070005@kdbg.org> (Johannes Sixt's message of "Fri, 10
	Jan 2014 20:21:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD5FF72C-7A2D-11E3-96C5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240313>

Johannes Sixt <j6t@kdbg.org> writes:

> The file is renamed to no-such-dir without the slash at the end. The
> updated commit message would be:
>
> mv: let 'git mv file no-such-dir/' error out on Windows, too
>
> The previous commit c57f628 (mv: let 'git mv file no-such-dir/' error out)
> relies on that rename("src", "dst/") fails if directory dst does not
> exist (note the trailing slash). This does not work as expected on Windows:
> The rename() call does not fail, but renames src to dst (without the
> trailing slash). Insert an explicit check for this case to force an error.
>
> This changes the error message from
>
>    $ git mv file no-such-dir/
>    fatal: renaming 'file' failed: Not a directory
>
> to
>
>    $ git mv file no-such-dir/
>    fatal: destination directory does not exist, source=file, destination=no-such-dir/
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Thanks.
