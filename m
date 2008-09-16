From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Documentation: replace [^~] with escapes everywhere
Date: Tue, 16 Sep 2008 11:58:58 -0400
Message-ID: <32541b130809160858k3c019f6pdc4831c831e22b55@mail.gmail.com>
References: <1221470398-8698-1-git-send-email-trast@student.ethz.ch>
	 <1221470398-8698-3-git-send-email-trast@student.ethz.ch>
	 <32541b130809151656n4f39018fu2045eb6280d6da00@mail.gmail.com>
	 <200809160205.23371.trast@student.ethz.ch>
	 <32541b130809151710j59963af9id84b3c1553ec738d@mail.gmail.com>
	 <7vy71s7b26.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Rast" <trast@student.ethz.ch>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 18:00:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfcyL-0008Mm-6O
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 18:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbYIPP7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 11:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754208AbYIPP7C
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 11:59:02 -0400
Received: from el-out-1112.google.com ([209.85.162.177]:12471 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYIPP7A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 11:59:00 -0400
Received: by el-out-1112.google.com with SMTP id z25so1095778ele.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8fkVz1t7/+338NBKbdRM2LOpQ+/tEPazUDa71MMC6g4=;
        b=nYOf9syS01K/EjRwDktfnI7/dKkOYSYQ0/KLu3NtELIrfxAfTV8bFUoMRuMS1rC96B
         LVIBra6wXw18X7VCXv0aTgaK5Dz5FwNDfswzoO6gA+MjM96lkAHfnc3/dtUF90LBrtZh
         dyK3hoPdvBVkqBK3WhlLnc2hNTpUCFolvmfNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H6mhMJ7fCGFI5jLHu0maq4daRD9EuHS6RNXvYTnfHYkMYdfnnqtwS4kP4W9bh5LIUB
         jJ6TtE2Pycw678V16cyrbqhKDGI6mFnmtzpRjaT9iI09rwIlRul+u8oLRp7dh215eHo2
         WksaCEBsoLKJVUGklibgEZp1zvS68IqP/mAu0=
Received: by 10.151.40.3 with SMTP id s3mr1699386ybj.238.1221580738333;
        Tue, 16 Sep 2008 08:58:58 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Tue, 16 Sep 2008 08:58:58 -0700 (PDT)
In-Reply-To: <7vy71s7b26.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96012>

On Tue, Sep 16, 2008 at 4:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sorry, but this unfortunately does not seem to help asciidoc 8.2.5 on FC9
> at all, which is the combination used at k.org machine that feeds the
> html/man branches to everybody else.
>
> asciidoc 7.1.2 on Deb does not have the problem in git-bundle.html to
> begin with, but it does have the same issue in git-show-ref.html, which
> the patch does fix.
>
> diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
> index 40d43b7..8fcdb54 100644
> --- a/Documentation/asciidoc.conf
> +++ b/Documentation/asciidoc.conf
> @@ -15,6 +15,12 @@ startsb=&#91;
>  endsb=&#93;
>  tilde=&#126;
>
> +[replacements]
> +# Disable superscripts.
> +\^(.+?)\^=^\1^
> +# Disable subscripts.
> +~(.+?)~=~\1~
> +
>  ifdef::backend-docbook[]
>  [linkgit-inlinemacro]
>  {0%{target}}

Hmm, browsing around through a newer asciidoc package from Ubuntu, it
appears that in asciidoc 8, those lines are in an
"ifdef::asciidoc7compatible[]" section.  But the quoting mechanism in
8 appears to be improved.

Perhaps a section like this (guessing from the new
/etc/asciidoc/asciidoc.conf) will do the job instead (or in addition,
if we're trying to support both versions):

[quotes]
^=
~=


HTH.  I don't have a real system with asciidoc 8 installed, and now's
not a good time to risk breaking my asciidoc setup, so I definitely
can't test the above.

Have fun,

Avery
