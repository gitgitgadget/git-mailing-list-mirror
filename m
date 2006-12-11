X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Tue, 12 Dec 2006 05:01:21 +0800
Message-ID: <4b3406f0612111301m302dfe3dm81b09a432e67163d@mail.gmail.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com>
	 <20061208203230.GA9193@sashak.voltaire.com>
	 <4b3406f0612091949qc75cb10x13f09e2017d71d91@mail.gmail.com>
	 <20061210114735.GA11107@sashak.voltaire.com>
	 <4b3406f0612111200o65352771r454d5ced0ac99f08@mail.gmail.com>
	 <20061211205006.GD1003@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 21:01:30 +0000 (UTC)
Cc: "Daniel Drake" <ddrake@brontes3d.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DzN33ASm42YfIudomZV06olt2Hdl087AMVHOOcMI7gTrxkM/MbpBw8hWucsgBlN2Sd+qAa5QT0bH8VL+ZjXLs4Gf3XtrmpvnvFlUbU/UjhZ2el0E8pRXc9H2AhVKGQeSGpvDwdrXIMK9hdYo01uZXMjoriXEF1mwHvd7qrtjugA=
In-Reply-To: <20061211205006.GD1003@sashak.voltaire.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34036>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtsH9-0006TW-AZ for gcvg-git@gmane.org; Mon, 11 Dec
 2006 22:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937672AbWLKVBY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 16:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937671AbWLKVBY
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 16:01:24 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:26865 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937670AbWLKVBX (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 16:01:23 -0500
Received: by an-out-0708.google.com with SMTP id b33so324202ana for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 13:01:23 -0800 (PST)
Received: by 10.78.149.15 with SMTP id w15mr2009442hud.1165870881963; Mon, 11
 Dec 2006 13:01:21 -0800 (PST)
Received: by 10.78.165.2 with HTTP; Mon, 11 Dec 2006 13:01:21 -0800 (PST)
To: "Sasha Khapyorsky" <sashak@voltaire.com>
Sender: git-owner@vger.kernel.org

$ cat svn2git-tortoisesvn.sh
#!/bin/sh

export LC_ALL=C
export WC_ROOT=/home/cauchy/wc/git
export REPO_NAME=tortoisesvn

echo "[`date`] Start import & pack ..."
mr=0
while [ $mr -le 9000 ]; do

    if test -f $WC_ROOT/$REPO_NAME/.git/SVN2GIT_HEAD; then
        echo "[`date`] clean up ..."
        cd $WC_ROOT/$REPO_NAME
        git-read-tree -m -u SVN2GIT_HEAD HEAD && rm -f .git/SVN2GIT_HEAD
        echo "[`date`] clean up finished"
    fi

    mr=$(($mr + 1000))
    echo "[`date`] Start import up to revison $mr ..."

    git-svnimport -v -i -r -o master -l $mr -C $WC_ROOT/$REPO_NAME
http://tortoisesvn.tigris.org/svn/tortoisesvn

    echo "[`date`] Finish import up to revison $mr"

    cd $WC_ROOT/$REPO_NAME && git-repack -a -d --window=64 --depth=64

    echo "[`date`] Finish repack revison $mr"
    cd $WC_ROOT/$REPO_NAME && find .git -name pack | xargs ls -l
done
echo "[`date`] Finished import & pack"


2006/12/12, Sasha Khapyorsky <sashak@voltaire.com>:
> On 04:00 Tue 12 Dec     , Dongsheng Song wrote:
> > Sorry, I assume you have see http://tortoisesvn.tigris.org/:
> >
> > username : guest
> > password : ""
>
> Thanks, I can grab svn log now. Which command line you are using?
>
> Sasha
