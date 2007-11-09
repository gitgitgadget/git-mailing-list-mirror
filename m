From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Fri, 9 Nov 2007 18:24:15 +1100
Message-ID: <ee77f5c20711082324s39a9d441tc05c5a27e6d39f3e@mail.gmail.com>
References: <11945685673280-git-send-email-dsymonds@gmail.com>
	 <11945685732608-git-send-email-dsymonds@gmail.com>
	 <47340895.6000403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 08:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqOEH-0003Xq-OL
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 08:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbXKIHYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 02:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbXKIHYQ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 02:24:16 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:34115 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbXKIHYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 02:24:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so392626rvb
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 23:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PwAzxRrd+WHVI50wqi3G0dUmC+lBcLxcZ2I6ami5KkM=;
        b=XKgdpwPHKJK2HcO9rAa/3ngOKD3U6ueT1XrLEUE0e/i+xGq0t5Fuwmt9XoEFDY2mmyIBY8sLAFjOGLDz6EXzOg/+L2X5EN6amxDpFCLDu+ofEEYxmF+Mdgo6GXIeU/J7oSCsOpgdioN/HsPNwTmY9GKt1mCM3DvhbXg6/m80mUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O3Is0YX67G0KdMDpDo2F00aXQPfUcrvXUZOChVMLFt0x3BmBoq4wUZhZya2wpi6c1oL+orKc5K3E3sdDf1zSzoMvzx8eDzdggwDf37kxZeo4yQ2gIbkRftBxARIa/9sPT2ETfwvDDSp9XZj8ZVsDBPco/14szKnvGEjXd6txOWo=
Received: by 10.141.20.7 with SMTP id x7mr790237rvi.1194593055155;
        Thu, 08 Nov 2007 23:24:15 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Thu, 8 Nov 2007 23:24:15 -0800 (PST)
In-Reply-To: <47340895.6000403@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64134>

On Nov 9, 2007 6:13 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> David Symonds schrieb:
> > +test_expect_success 'remove and restore with relative path' '
> > +
> > +     cd dir1 &&
> > +     rm ../file0 &&
> > +     git checkout HEAD -- ../file0 &&
> > +     test "base" = "$(cat ../file0)" &&
> > +     rm ../dir2/file2 &&
> > +     git checkout HEAD -- ../dir2/file2 &&
> > +     test "bonjour" = "$(cat ../dir2/file2)" &&
> > +     rm ../file0 ./file1 &&
> > +     git checkout HEAD -- .. &&
> > +     test "base" = "$(cat ../file0)" &&
> > +     test "hello" = "$(cat file1)" &&
> > +     cd -
>
> What if this test fails? Then the rest of the tests run from the wrong
> directory. You should put the test in parenthesis (and drop the cd -).

Looking at the existing tests which, when they change directories,
don't cd back to where they were; they "cd .." at the start of the
next test. I'll add a "cd .." to the relevant bits of my tests.


Dave.
