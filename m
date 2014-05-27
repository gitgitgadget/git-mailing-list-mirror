From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 2/5] commit test: Change $PWD to $(pwd)
Date: Mon, 26 May 2014 23:14:48 -0700
Message-ID: <20140527061448.GA25927@hudson.localdomain>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
 <1401130586-93105-3-git-send-email-caleb@calebthompson.io>
 <538426D3.8090107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 27 08:15:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpAf3-00043s-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 08:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbaE0GOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 02:14:54 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34591 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbaE0GOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 02:14:53 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so8677981pbb.22
        for <git@vger.kernel.org>; Mon, 26 May 2014 23:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jnE2AaVpPJs3dcItRqD2lBn8I2683zwbe6hxt+H4Hxk=;
        b=D/KgoADdZF9087XtUN7GCiHQouRU6MSkV7mHgh5fMNiHc0/lsk9YQUR5VJwVzQTLLD
         wC8hXBA1c3tRfV2d7GKWZevBrzPX7ZKrYW7TUaFDbN+hPW/RI87RoPB0AFk9+FpoEOLP
         foT1+0PPtFI6Fo6V5uDVRoSbbMols3OLtbMuAULqD/lKbMID7zn+MRqhq2+pBkVWmx4R
         2BSNMfGOo+x3eGroPRMjcQOJT/a371Ug31O4soXbztDBfAQ8S/K8XghB8e59mlvk+Yio
         MdTRHm0FLKNs3mra0/u+rVFgoZfXKH1xaGbnhZqVnk/C6OkDCZFa6E7atKSLj7wjsl4P
         Shbg==
X-Received: by 10.68.227.4 with SMTP id rw4mr33427417pbc.3.1401171293479;
        Mon, 26 May 2014 23:14:53 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xz7sm68557655pac.3.2014.05.26.23.14.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 23:14:52 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 26 May 2014 23:14:48 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <538426D3.8090107@viscovery.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250143>

On Tue, May 27, 2014 at 07:46:59AM +0200, Johannes Sixt wrote:
> Am 5/26/2014 20:56, schrieb Caleb Thompson:
> > Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
> > ---
> >  t/t7507-commit-verbose.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> > index 6d778ed..3b06d73 100755
> > --- a/t/t7507-commit-verbose.sh
> > +++ b/t/t7507-commit-verbose.sh
> > @@ -8,7 +8,7 @@ cat >check-for-diff <<EOF
> >  exec grep '^diff --git' "\$1"
> >  EOF
> >  chmod +x check-for-diff
> > -test_set_editor "$PWD/check-for-diff"
> > +test_set_editor "$(pwd)/check-for-diff"
> >  
> >  cat >message <<'EOF'
> >  subject
> 
> Why? I see no benefit. Both $PWD and $(pwd) work fine everywhere,
> including Windows, and the former is faster, particularly on Windows.
> 
> -- Hannes

I don't know the technical details of why this change is needed.
But someone felt it was important enough to put in t/README.

  - When a test checks for an absolute path that a git command generated,
    construct the expected value using $(pwd) rather than $PWD,
    $TEST_DIRECTORY, or $TRASH_DIRECTORY. It makes a difference on
    Windows, where the shell (MSYS bash) mangles absolute path names.
    For details, see the commit message of 4114156ae9.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
