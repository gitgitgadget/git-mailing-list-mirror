From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Documentation: replace [^~] with escapes everywhere
Date: Mon, 15 Sep 2008 19:56:48 -0400
Message-ID: <32541b130809151656n4f39018fu2045eb6280d6da00@mail.gmail.com>
References: <1221470398-8698-1-git-send-email-trast@student.ethz.ch>
	 <1221470398-8698-2-git-send-email-trast@student.ethz.ch>
	 <1221470398-8698-3-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 16 01:58:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfNx8-0007o6-5q
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 01:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbYIOX4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 19:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbYIOX4u
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 19:56:50 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:4350 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbYIOX4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 19:56:50 -0400
Received: by yw-out-2324.google.com with SMTP id 9so732953ywe.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 16:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=w9giZzGjcC8jS8D9+p4np7A8PvGgZZzO0RE9MkzHe/8=;
        b=ho+iCUZqaJJ4I0/FBa0fDJ5gOWPAbB8ua0vJtGvsnd1dveep9DYFsplpDaVuIj9nST
         YNBlLODf0n4Z2q0Owwm3X22nuG/l6MWQIjb6taj6AKVUbU3JiU8bpr6cWYzEgV0lUbmI
         wTZVB2BqIMBJ2xyK1WbMQhL+VUXxW1uSSSAoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=G3CXV2fVQzjNB1gDF5jfIPUDc+1CkaEF2FSDqYIKlWSB7NJkS6eNo+pUPBoljEZulb
         bn4JGOVnGPjEDiZCR6PMjooUxqbb310ce4AtoP0m78/zliPQG8YyMQDSc+wm/mzSChll
         nQZqJuYYRlHG2XwerjfOviCjw3GkA+OtpddPQ=
Received: by 10.150.182.16 with SMTP id e16mr374169ybf.148.1221523008879;
        Mon, 15 Sep 2008 16:56:48 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Mon, 15 Sep 2008 16:56:48 -0700 (PDT)
In-Reply-To: <1221470398-8698-3-git-send-email-trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95961>

On Mon, Sep 15, 2008 at 5:19 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> Replaces all ^ and ~ that are not part of a "literal" paragraph with
> {caret} and {tilde}.
>
> Tildes and carets are ordinarily used for ~sub~ and ^super^scripts.
> This only triggers if a suitable chunk of text is found within the
> current paragraph, so in most cases nothing happens (and the
> tilde/caret is taken literally).  However, it is a pitfall for anyone
> who later adds more text to the same paragraph, so we might as well do
> it right.

Rather than uglifying all the documentation to work around the syntax,
perhaps we just want to disable subscripts and superscripts
altogether?  I can't really imagine the git documentation needing
them.

To do so, we can add these lines to asciidoc.conf (I just did this on
another project yesterday, but I haven't tested in git.git):

[replacements]
# Disable superscripts.
\^(.+?)\^=^\1^
# Disable subscripts.
~(.+?)~=~\1~


(For reference, the regexes on the left side of the equal sign came
from a file in /etc/asciidoc somewhere.)

Have fun,

Avery
