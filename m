From: "Elijah Newren" <newren@gmail.com>
Subject: Re: [BUG?]: unpack-file behavior for blobs corresponding to symlinks
Date: Fri, 19 Sep 2008 08:55:36 -0600
Message-ID: <51419b2c0809190755l2aa01558l30e07c4141f8d4e0@mail.gmail.com>
References: <51419b2c0809190731j5a77b8ccmba2feecb9c44cc1c@mail.gmail.com>
	 <237967ef0809190751k38defaabk9efc74711f7c63c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 16:57:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KghPc-00088l-4I
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 16:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYISOzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 10:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbYISOzj
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 10:55:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:28153 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbYISOzh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 10:55:37 -0400
Received: by rv-out-0506.google.com with SMTP id k40so478838rvb.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=O/b8lyqo6hoEwh+b72Y5V7pGFHajKEtP4/cBJxNFXEI=;
        b=M0Wbq1bExuwGpb3XdMRZ5AJyk6YQPs5fgc9pnlPX+DFCksviG56csv1mwgE0q/FvBQ
         UqhVXahlwM0OVMplIhHy44fwQi+qhcl/UeMZ5yp28WQE1spHTTb8nfVqlsEUG5PzIHPt
         KCXQRONHoLPVtynHlbarZ0cwNUtNTSz/0QoPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=d8iHfeyJ+P5HWZsEYc+0OnxD0Y7fMH4HCxkPOPsQ+kUYClJmVnDb5bme0g/mQucP2k
         SxhffHHPsIVIRznD9F9OkuLTgSO+FOftqBNEGeaFSezjmFgyLFfonI0hvamWWhLS1Slh
         xR4ioTqYRsvgF4FH0DAhAAMdfLR7DjThkz2bI=
Received: by 10.141.193.1 with SMTP id v1mr111737rvp.73.1221836137064;
        Fri, 19 Sep 2008 07:55:37 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Fri, 19 Sep 2008 07:55:36 -0700 (PDT)
In-Reply-To: <237967ef0809190751k38defaabk9efc74711f7c63c4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96293>

On Fri, Sep 19, 2008 at 8:51 AM, Mikael Magnusson <mikachu@gmail.com> wrote:
> This is not a bug. The type of a file is in the tree, not the blob, see:
>
> % echo -n foo > file
> % ln -s foo symlink
> % git add file symlink
> % git commit
> Created initial commit 31ad9b0 on master: file and symlink
>  2 files changed, 2 insertions(+), 0 deletions(-)
>  create mode 100644 file
>  create mode 120000 symlink
> % git ls-tree HEAD
> 100644 blob 19102815663d23f8b75a47e7a01965dcdc96468c    file
> 120000 blob 19102815663d23f8b75a47e7a01965dcdc96468c    symlink

Good to know.  Given the mode (100644 or 120000) and the sha1sum, is
there a git command that will create-my-file for me, or do I need to
just use git unpack-file and add my own extra logic on top?

Thanks,
Elijah
