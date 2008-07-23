From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 23 Jul 2008 14:33:54 -0400
Message-ID: <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com>
References: <alpine.DEB.1.00.0807222255450.8986@racer>
	 <7vy73tihl6.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807230203350.8986@racer>
	 <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807231817460.8986@racer>
	 <488772BC.80207@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Joshua Jensen" <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjAt-00051P-6M
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYGWSd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 14:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbYGWSd4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:33:56 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:1808 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbYGWSdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 14:33:55 -0400
Received: by yx-out-2324.google.com with SMTP id 8so449548yxm.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NKTUg9jJk6ekgp3F8NFW298KwwZXSBTeJutx9VsCvJk=;
        b=rLmSD7E8ItPRlOyTqZAPlVBep4zBgH3kGbpIP83I4Ywtcvbc7EAeeJTbFuDF5/eUzm
         0SFLchuomzWyoCHz6ajB6NiN6gGfRlo4sxRkgX3A8s6C0Axpqw5T43GM4ysCetoejlvp
         fYBJjW1ygFEPlx70120crUlU3h4QjAie7vsfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ryhzHK5zTHtprZDhLu28zPaeQoW1tqGpeGUovYrEpxOKhd8XIHbFnEpbiCRw5dTPpw
         WZfWGGrEyRAU5/C8SMjXDpj9YZn6iwETEvj4DhY+X7wHTw7DnHqt7YVd+T2q68MDpety
         3cIu1pZ2069ELJXRkD/5m0o4r7ttZ0NlK/q+M=
Received: by 10.150.122.13 with SMTP id u13mr612372ybc.63.1216838034346;
        Wed, 23 Jul 2008 11:33:54 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 23 Jul 2008 11:33:54 -0700 (PDT)
In-Reply-To: <488772BC.80207@workspacewhiz.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89733>

On 7/23/08, Joshua Jensen <jjensen@workspacewhiz.com> wrote:
>  There are certain file formats, such as a Visual Studio .sln file, that
> MUST be CRLF.  [...]

It seems like what people really want is some additional file attributes:

1. always CRLF on all platforms (eg. for .bat files)
2. always LF on all platforms (eg. for shell scripts and perl scripts)
3. just leave it alone no matter what (eg. for binary files)
4. convert line endings to LF on checkin, native on checkout (eg. for
most source files)

Where "native" is defined by some config option, but the choice of #1
through #4 is defined by .gitattributes.  Thus, the config option
affects only mode #4 (and perhaps the default mode, as it does now).

The current system works for #3.  With Dscho's patch, #4 works too.  I
think more kinds of per-file attributes are needed in order to get #1
and #2.

Avery
