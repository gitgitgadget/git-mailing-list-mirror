From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit bug] git user settings not retrieved when launched for Windows explorer
Date: Tue, 7 Oct 2008 18:48:21 +0200
Message-ID: <e5bfff550810070948p6a9b2fdcq51f2b1580cef2f4e@mail.gmail.com>
References: <48EB10C8.4070009@lyx.org>
	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>
	 <48EB49B3.1090509@lyx.org>
	 <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
	 <48EB56BA.5020502@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 18:49:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnFkd-0006ag-AT
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 18:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbYJGQsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 12:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbYJGQsY
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 12:48:24 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:25973 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbYJGQsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 12:48:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2866214fkq.5
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Q56T4zDo7nT1jWptqp2spuMtj76+Uxsg+B6DVOuK/4g=;
        b=gNd7+963ugEJ9mbyMD1U4LNwUuAp1Mmu7y9ElHKkhy/rEB/d1ooKV1337JsBzPevkT
         faIgsMJ2Tdwmt6GcY4XEckBL5P7uDt40uTsWkjQ9eKqx9RFpbhM6ATkEJ92SrwByx0q/
         dsvezLwhaKLmLS4I+EfZB7paDVL7tWLuVoBrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bW5+shA+Hqq+kB9Brn+3VgieEF5jwBGCUGe9aPIYO40DQfeaNlqX/DhThtl9PD5tEz
         Mw36df+/nyuaf+4Hr3l8MN4t6SM7aoRp+edjfV2Wy+60gEGt9WxeOXpA7h3BA6QsCDEg
         RzWnofQXkujfx9TD0ePJXxuttt4k/U5Qu2uhk=
Received: by 10.181.37.11 with SMTP id p11mr5177293bkj.9.1223398101619;
        Tue, 07 Oct 2008 09:48:21 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Tue, 7 Oct 2008 09:48:21 -0700 (PDT)
In-Reply-To: <48EB56BA.5020502@lyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97725>

On Tue, Oct 7, 2008 at 2:31 PM, Abdelrazak Younes <younes@lyx.org> wrote:
>
> No, 'git config user.name' works fine in any directory, even on the naked
> Windows console (I mean without msys bash). So that must be something else.
> I've traced it down to
> MyProcess::on_finished().
>
>    isErrorExit =   (exitStatus != QProcess::NormalExit)
>                 || (exitCode != 0 && isWinShell)
>                 || !errorDesc.isEmpty()
>                 ||  canceling;
>
> At this point we have:
> exitStatus = NormalExit
> exitCode = 1
> isWinShell = false
> errorDesc.isEmpty() returns true
> canceling = false
>
> Which gives 'isErrorExit = false'. I wonder if the isWinShell test is
> correct?
>

Hi Abdel,

I would think it is correct to return isErrorExit == false

The problem is that it seems git config return empty data if run from
outside git directory...isn't it ?


Marco
