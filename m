From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Mon, 3 Jul 2006 13:18:46 +0200
Message-ID: <e5bfff550607030418n6a46c0cdh1a95155e1feb4356@mail.gmail.com>
References: <e8954u$srh$1@sea.gmane.org>
	 <e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com>
	 <e89eqj$npu$1@sea.gmane.org>
	 <e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com>
	 <e89iql$42a$1@sea.gmane.org>
	 <e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com>
	 <7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 03 13:18:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxMS3-0007nn-7i
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 13:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWGCLSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 07:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWGCLSs
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 07:18:48 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:53377 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750925AbWGCLSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 07:18:47 -0400
Received: by py-out-1112.google.com with SMTP id c39so1274473pyd
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 04:18:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pDWBBgsHGzgOtVwleNseR2WRFO4uwLJCut+lEC6wUuhWQIKT8rCOCOFMhlZL6ch9gtBFN4hUwDwOwCyNTJD2MHaUWL6yhELu/0QisGyssUeDpGb/JAWt3i0a+TicMO1PDFvvhRbjFSzDcfcPgOSNpnSjQqGbdSoXK2ALTBVRsTU=
Received: by 10.35.88.18 with SMTP id q18mr797318pyl;
        Mon, 03 Jul 2006 04:18:46 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Mon, 3 Jul 2006 04:18:46 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23171>

On 7/3/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > When I need to modify the patch/revision before to import I usaually
> > drag&drop and then I call git-reset --soft, then I edit working
> > directory and commit again.
>
> These days, I tend to just let "am" or "pull" do its thing, edit
> working tree and retest, and run "commit --amend".  Before we
> added "commit --amend", I used to do soft reset and recommit
> like you described above.  One advantage of "commit --amend" is
> that it can even amend a merge, but I do not think it applies to
> what Jakub wants in this thread.
>

I cannot test your patch now, so I'm just guessing, what if we have a
series of patches?
Is it possible that for two patches A and B happens that

git-am A
git-am B
git-reset --soft HEAD^^

gives a different result then

git-am --fail A
git-am --fail B

As example, if B modify the same file of A then could happen that in
the latter case git-am --fail B stops with conflicts because the
working dir is not synced with the index (this happens only in the
latter case) ?

Put in other words, I don't know if the two procedures are
_equivalent_ because in the first case you operate under the
assumption that working dir and index are always synced before and
after to apply, in the second case this assumption is broken so I
don't know if this could have side effects.

      Marco
