From: "Gustaf Hendeby" <hendeby@gmail.com>
Subject: Re: Difference in how "git status" and "git diff --name-only" lists filenames
Date: Thu, 6 Dec 2007 17:36:02 +0100
Message-ID: <bf7b2dda0712060836j530277d5x28fcb50a717f17e5@mail.gmail.com>
References: <bf7b2dda0712020604x209d6665i9ab58b32834b2cee@mail.gmail.com>
	 <7vodd9x7fu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 17:37:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0JiW-0003vR-9z
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 17:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbXLFQgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 11:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbXLFQgF
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 11:36:05 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:64571 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbXLFQgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 11:36:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so318605rvb
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 08:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PxzPFjNhhXK9gEPLMatk56h5oA5TY6guBkz3w++4ZaU=;
        b=F42UPgDOTtRH2dK1hkAqjqVmz3xRcee3vBbcnlE5EnVZPiMPWpfzxzW3nUe2omgBo6iYU9ocyVeKt2RzdIsYk3opE6Zlgxp35UyFp5oy2GzHCgvxxX2kKtEn+VgOZEW6whiehlsM74c8O0QSbZtQnKRDR/uCkNebsL7McjKt/Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=etePvDG7+vM/ibFR2IbiXr9EnQhQiny0WNAQQ9PasskS1/kS22QRGzMWN8UO2UgQTqL5bs4ZqYZPP8/baEmvPa500JnOT+9La5MaV10uAyQjsD3jXq6/BE7rBi3tpXfbRIxQtvKyxCpWDC3clLqv7hBX9unkg0uJvnSfoOWLiXw=
Received: by 10.141.21.19 with SMTP id y19mr2068034rvi.1196958962188;
        Thu, 06 Dec 2007 08:36:02 -0800 (PST)
Received: by 10.140.173.1 with HTTP; Thu, 6 Dec 2007 08:36:02 -0800 (PST)
In-Reply-To: <7vodd9x7fu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67302>

On Dec 2, 2007 7:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Gustaf Hendeby" <hendeby@gmail.com> writes:
> > A while ago 'git status' was patched to report relative pathnames.  (I
> > like that change it makes cut'n'paste easier.)  However, 'git diff
> > --name-only' and 'git diff --name-status' (other commands as well),
> > which gives in a sense similar output has not been changed the same
> > way.  Is this intentionally, or just because no one has stepped up and
> > provided a patch?  If the difference is to stay, maybe this should be
> > reflected in the help texts to avoid any confusion.
>
> The commands output from diff always talks about paths relative to the
> tree root, and scripts rely on it.  The recent change made exceptions to
> the status command.  I agree an additional documentation to git-status
> would be beneficial.
>
> Having said that, a switch --relative-name might be an option.  It could
> be argued that doing it the other way around (like --full-name option to
> ls-files does), defaulting to relative to cwd, would have been a getter
> approach if we were doing git from scratch, though.  We may still want
> to do so in the longer run, but that would be a huge interface change
> that would impact a lot of peoples' scripts.
>
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 8fd0fc6..b0cb6bc 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -40,6 +40,10 @@ OUTPUT
>  The output from this command is designed to be used as a commit
>  template comments, and all the output lines are prefixed with '#'.
>
> +The paths mentioned in the output, unlike many other git commands, are
> +made relative to the current directory, if you are working in a
> +subdirectory (this is on purpose, to help cutting and pasting).
> +
>
>  CONFIGURATION
>  -------------
>

Thank you for your timely answer and the good explanation.  Sorry for
my late response!  I think that the addition to the documentation that
you suggest sounds good, and would be useful.  Do you want me to do
anything else about this?

/Gustaf
