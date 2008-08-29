From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] diff: treat -crlf files as binary
Date: Fri, 29 Aug 2008 17:56:38 -0400
Message-ID: <32541b130808291456k3de953a2yd1e93bc27ad14293@mail.gmail.com>
References: <7vfxon4ikr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 23:57:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZByS-00025k-9P
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 23:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbYH2V4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 17:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbYH2V4k
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 17:56:40 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:47770 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYH2V4j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 17:56:39 -0400
Received: by yx-out-2324.google.com with SMTP id 8so586653yxm.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fFsccku1lFKJntmvk/Z6/cK3AdgFAIU+V4KysFGvD/E=;
        b=i7F5Awg6LSpn2av0vHQhLCW6BxAlycrK8APVA8yHe6Kvnii9ABG94p6LbMTIS8zjyf
         9y7tcB7XI7Oxna12N90qB9HhmemF2zkPyXq3Z00f5FXG2kKOgQvBsgxDFY5ObvuHd1m+
         Cg3CZImHPgfsBJXzLmmWe9B3HSq+EJ2ay3E6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iIsCVNlVYZdy75D3lvSBmBMUPfab+cOVIHoudggMWBEkDUzUhSeYz299CXvXxRUvDO
         lLm/tUbaLjuSs2wIPFMXT4S21jFEiFdT7oEIDTw9DULuqXugaLa867hDvB+C1UFZ/ScU
         0AIJ0xLr3VzVn4de0gZV+juEHy2kkizsK5igk=
Received: by 10.151.103.11 with SMTP id f11mr4912073ybm.190.1220046998570;
        Fri, 29 Aug 2008 14:56:38 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Fri, 29 Aug 2008 14:56:38 -0700 (PDT)
In-Reply-To: <7vfxon4ikr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94334>

On Fri, Aug 29, 2008 at 5:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The manual advertises that setting "crlf" attribute to false marks the
> file as binary.  We should pay attention to this condition in addition
> to the "do not diff" attribute (i.e. setting "diff" to false) when
> deciding not to show the textual diff.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Strictly speaking any change is backward incompatible, and this is
>   certainly one, but I do not think of a good use case to depend on the
>   previous behaviour, which was reported as a bug by my coworker.

I'm not sure this is a good idea.  In our repository, for example, we
have a few files that are strictly speaking "text" but absolutely,
positively must be CRLF on all platforms because the idiotic
proprietary parsers and generators that manipulate them need it to be
that way.

I think the bug is that "crlf=false" should not be considered the same
as "binary=true", which seems to be a bug in the documentation, not
the program.

Have fun,

Avery
