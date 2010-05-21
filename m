From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH RFC] Add a config verbose option fetch and push
Date: Fri, 21 May 2010 17:10:22 +0000
Message-ID: <AANLkTil-PDpdkcJaJn2FUrJrSIJ6lP0OcvY5l7HRorsa@mail.gmail.com>
References: <4bf6b6f5.dd79dc0a.5533.2acd@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 19:10:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFVk5-0006lR-Ac
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 19:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934053Ab0EURKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 13:10:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52633 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934029Ab0EURKX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 13:10:23 -0400
Received: by iwn6 with SMTP id 6so1400311iwn.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=JFxRi82s8obrra9airK7VM5330Pi0embMCam+3BdHKU=;
        b=CbBeDS5PV9zBXGHCGEcungwU7dBZyjRG8F75L8aLtUqlAkkisLu4dVbr+Jjq/rNN8O
         HSrCJwzMKSqMFHObiMbKNTiCxfbM6H/38B7ipNiUWIfzUAM5ktbIg3hzTCopI/TgV/hV
         vN5H7AYTRCP+CAd/ch4A6KLO4k++02/WMZ2Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OhSyYhV0oP1jbTEa3jTcx5VxzqbS2YNmMwqf5jacXx8p1hvckjKHHdMiBbhwvu9Ozm
         qYpd+qRMpY8EW0wL5xL08AAgA2h8Tvbw+US9p7n+fMsAwFW+mctCAg2g7g59N42RBCIl
         4hXpAKFcD5OwQu4mCoKIT17cf7Dg66qz6KiO4=
Received: by 10.231.178.135 with SMTP id bm7mr1542749ibb.73.1274461822179; 
	Fri, 21 May 2010 10:10:22 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 21 May 2010 10:10:22 -0700 (PDT)
In-Reply-To: <4bf6b6f5.dd79dc0a.5533.2acd@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147486>

Since Peter Kjellerstedt wanted --ff-only, and you want --verbose. I
wonder whether a better solution wouldn't be to farm this
functionality out to the config parser.

I.e. you'd do something like:

    static struct option builtin_fetch_options[] = {
        OPT__PROGRAM_NAME("fetch"), /* this is new */
	    OPT__VERBOSITY(&verbosity),
    	OPT_BOOLEAN(0, "all", &all,
	    	    "fetch from all remotes"),
        ...

And then in your .gitconfig:

    [fetch "option"]
        verbose = 1

Is there any reason not to add such a general facility?
