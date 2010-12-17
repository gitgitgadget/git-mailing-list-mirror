From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Thu, 16 Dec 2010 19:45:39 -0600
Message-ID: <20101217014539.GA6775@burratino>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>
To: Ken Brownfield <krb@irridia.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 02:46:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTPOY-00061D-TG
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 02:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab0LQBqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 20:46:01 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:42753 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab0LQBqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 20:46:00 -0500
Received: by gxk19 with SMTP id 19so104465gxk.11
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 17:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AjRcdJ+2xqhrbTeEMkmj3RMaUMvA/QpthD5O2mft7Fs=;
        b=mdze0vtPiXH9fLbJ2/LisngkyTsQ48iJbnriNqvmObozg/TkDdNUW7KOGgovv9W/Eb
         w5obG9vsbnomWIZi8PUHOF8qdfLd9RmUOAffsiYDypYSqSwI6dvAkni548ZrYVyAPfsx
         ba/R/nkzDy2R9Qx46QK6bOA8i9AYY6H1OOsBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vQji1DfzQM5YuCA2Z5mR8/ECsJZoBdI8o82Il75UstyESCpwTTls+34GtzQJE6GvK/
         qjhf+y2Dp2g5WZYqeJet9n5GP40lCjkZO6RItYdNqywkAN4MisY9hSSCNG9OdkogBUsp
         Kg6w/vXgaoiAB4dRjewmJp0tbRPbKYXYurNsc=
Received: by 10.150.50.18 with SMTP id x18mr1884226ybx.350.1292550358009;
        Thu, 16 Dec 2010 17:45:58 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id r31sm491487yhc.24.2010.12.16.17.45.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 17:45:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163849>

Hi Ken,

Ken Brownfield wrote:

> Is there a way to apply the optimizations mentioned in that old
> thread to the code paths used by git-filter-branch (mainly git-read
> and git-rm, seemingly), or is there another way to investigate and
> improve the performance of the filter?

Which old thread?

You might be able to get faster results using the approach of [1]
(using "git cat-file --batch-check" to collect the trees you want
and "git fast-import" to paste them together), which avoids unpacking
trees when not needed.

Hope that helps,
Jonathan

[1] http://repo.or.cz/w/git/barrbrain/github.git/commitdiff/db-svn-filter-root
