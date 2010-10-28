From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in
 git-status
Date: Thu, 28 Oct 2010 14:46:09 -0700
Message-ID: <7vaaly9eji.fsf@alter.siamese.dyndns.org>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-2-git-send-email-Matthieu.Moy@imag.fr>
 <20101028183513.GC14212@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 23:46:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBaIn-00007k-HV
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 23:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933812Ab0J1VqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 17:46:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230Ab0J1VqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 17:46:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1257F16D5;
	Thu, 28 Oct 2010 17:46:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZAY047mTvFL4HxFAEGoWqiDHI9g=; b=ad7Yak
	bV7/Gx2hSlelUVHfyqZWd307TUs0yGnYfhHbJ7INOPNm7b8Q1SChmCo48xErgZNo
	bMOGWoS7cZrFzNsg1f53N+bVmRVRaFynRYDUhbDx/zcOvre8Nlroros6EckBbymZ
	F+P80tl4MgJlaaWjmFE0AtUyp4Ssvjela1LqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KnhAd26MXIzFmEkzO2jdBi6DSWB5XHsf
	PXjLfpXKzw97U8Hygd64oP3/RuALOhbx6z/+6vMjMx1/wVitqZTEq0RtwONP15yy
	P0twsQZ6HtdcIIL3HhLeeIZWmV8Cy8cBQh7LrP2O51CZdWr+3pR4XiKjZ7LGz7CF
	cwePaRsQKIY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91A4816D4;
	Thu, 28 Oct 2010 17:46:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31BB816D3; Thu, 28 Oct
 2010 17:46:11 -0400 (EDT)
In-Reply-To: <20101028183513.GC14212@burratino> (Jonathan Nieder's message of
 "Thu\, 28 Oct 2010 13\:35\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB4672D0-E2DC-11DF-B874-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160231>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Result looks like:
>
>  # Changes to be committed:
>  #   (use "git reset HEAD <file>..." to unstage)
>  #
>  #       new file:   foo.c
>  #
>  # Changes not staged for commit:
>  #   (use "git add <file>..." to update what will be committed)
>  #   (use "git checkout -- <file>..." to discard changes in working directory)
>  #
>  #       modified:   foo.c
>  #
>  # Untracked files:
>  #   (use "git add <file>..." to include in what will be committed)
>  #
>  #       bar.c
>
> which is both clearer and more consistent.  So for what it's worth,
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Hmm, perhaps we'd want to restate the first one as well to read

    Changes staged for commit:
      (use "git reset HEAD <path>..." to unstage)

for consistency as well?

Listing by filename gives a false impression that we are talking about the
whole file contents, and looks a bit confusing until it is explained to
you why when the same file appears in both of the first two sections.
I've been wondering ever since this thread started if we can phrase it
better to make it even less confusing.  E.g.

    Files with changes to be committed:
        new file: foo.c
    Files with changes that won't be committed:
        modified: foo.c

might help reduce the confusion.

"Untracked files" section is about the whole file contents, and it can
stay as is.
