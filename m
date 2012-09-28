From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/21] git p4: fix error message when "describe -s" fails
Date: Fri, 28 Sep 2012 12:02:33 -0700
Message-ID: <7vfw62klbx.fsf@alter.siamese.dyndns.org>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
 <1348833865-6093-5-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:19:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THg5r-0007tg-FF
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 21:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030924Ab2I1TTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 15:19:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031045Ab2I1TS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 15:18:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9634A8156;
	Fri, 28 Sep 2012 15:18:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=WaVpLuW1IaaRz74fI+rkXePEDDQ=; b=YRUslPEckWStWL/AU7x+
	ZmClHAB4RSPjLgDIO90Myev7Q0gx9sBnFoWPu5XMwdQO9Vs3tGRMT5F8zfVmybMa
	YCiW7Q1rtt+WKubbJPNrnAzDxkUBM0eFDDJoWl6kz4TXXzeGjAURv1xFjTx9nxei
	5hTB57mUXwAqYJujY4RzukY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mb+tMMmtPyZ56gfFDyqbsMzqkP6pXDKpERXVmQGW81ICuQ
	LzZUM2qiN930OMZL43tNj9C1DnzcoBqtO7rfy6ss1BeOLnZEJ6GQi+m414zP2Vm9
	n02hpQY2tEL2kzJxleemjcWUJ6e5cb/BHzgjWhrvaUGC43oQITOqT6zTzY5Po=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 848CE8155;
	Fri, 28 Sep 2012 15:18:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0360E8154; Fri, 28 Sep 2012
 15:18:27 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4832DC24-09A1-11E2-A081-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206600>

Pete Wyckoff <pw@padd.com> writes:

> The output was a bit nonsensical, including a bare %d.  Fix it
> to make it easier to understand.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>  git-p4.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index eef5c94..d7ee4b4 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2679,7 +2679,8 @@ class P4Sync(Command, P4UserMap):
>              if r.has_key('time'):
>                  newestTime = int(r['time'])
>          if newestTime is None:
> -            die("\"describe -s\" on newest change %d did not give a time")
> +            die("Output from \"describe -s\" on newest change %d did not give a time" %
> +                newestRevision)

Shouldn't it say "p4 describe -s"?

>          details["time"] = newestTime
>  
>          self.updateOptionDict(details)
